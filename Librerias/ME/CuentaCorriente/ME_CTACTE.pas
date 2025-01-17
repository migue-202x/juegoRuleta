

unit ME_CTACTE;

{

ME Cuenta Corriente utiliza:

1) Un archivo de datos donde se almacenan todos los movimientos de cada cuenta corriente

2) Una lista doble parcial que har� de indice sobre archivo almacen

3) Una tabla secuencial din�mica que har� de control sobre la lista parcial anterior mencionada

4) Una lista doble parcial de cuentas corrientes, que almacena todas las cuentas corrientes existentes y
que apunta a la tabla secuencial anterior mencionada.
Las cuentas corrientes son de los jugadores cuyos nicks coinciden con el mismo hash

5) Un archivo fijo (tabla hash) que tiene control sobre la lista cuentas corrientes anterior mencionada.
En este archivo se guardara en cada posicion un registro control que apuntara a la lista de Cuentas Corrientes.
Cada posicion del archivo contiene un registro control que corresponde a una lista de cuentas corrientes de aquellos jugadores que coinciden
en la misma posicion de la tabla hash, posicion dada por la funcion Hash

}


interface

uses
 SysUtils,
 Type_Hash, Type_ALMACEN, LO_Hash, LO_ListaParcialDobleEnlace, Lib_Auxiliar;

Const
  _Directorio = 'Archivos\';

  _NombreArch_TablaHash = 'CUENTA.DAT';
  _NombreArch_LDCtaCte = 'LISTACUENTAS.CTE';
  _NombreArch_TablaIndMov = 'CONTROLINDICE.COX';
  _NombreArch_LDIndMov = 'INDICEALMACEN.NTX';
  _NombreArch_Almacen = 'ALMACEN.DAT';



type


  tipoEstructura = record
            tablaHash: LO_Hash.tHash; //(5)
            ListaCtasCtes: LO_ListaParcialDobleEnlace.tLdParcial; //(4)
           end;

  tipoDatos = record
             tablaControlIndice:LO_ListaParcialDobleEnlace.TipoArchivoControl; //(3)
             ListaIndiceAlmacen:LO_ListaParcialDobleEnlace.tLdParcial; //(2)
             Almacen:Type_ALMACEN.tipoArchAlmacen; //(1)
           end;


  ME_CUENTA = record
            Estructura: tipoEstructura;
            Datos: tipoDatos;
           end;

  Procedure CrearMe_CtaCte (Var Me:ME_CUENTA);
  procedure AbrirMe_CtaCte       (var Me: ME_CUENTA);
  procedure CerrarMe_CtaCte      (var Me: ME_CUENTA);
  procedure DestruirMe_CtaCte (var Me: ME_CUENTA);
  Procedure InsertarCtaCte (var Me:ME_CUENTA; Clave:tClaveHash; var PosEnDatos:tPos);
  Function SaldoAcumulado (var me:ME_CUENTA; Clave: tclave): timporte;
  Procedure CapturarCtaCte(var Me:ME_CUENTA; Clave:tClaveHash; var Reg:tipoRegDatos);
  procedure CapturarAlmacen (var Me:ME_CUENTA; Pos:TPos; var Reg:TipoRegAlmacen);
  Procedure InsertarIndiceAlmacen(var Me:ME_CUENTA; Clave:tClaveHash; PosAlmacen:tPos);
  procedure CapturarTablaIndiceMov (var Me:ME_CUENTA; Pos:TPos; var Reg:TipoRegControl);
  procedure GrabarTablaIndiceMov (var Me:ME_CUENTA; Pos:TPos; Reg:TipoRegControl);
  Procedure InsertarAlmacen (var Me:ME_CUENTA; var RegAlmacen:tipoRegAlmacen);
  function PosNula (var Me:ME_CUENTA): TPos;
  function ProximoEnLdParcial (var Me:ME_CUENTA; Pos:TPos):TPos;
  Function PrimeroLdParcial(var Me:ME_CUENTA; Clave:tClaveHash):tPos;
  procedure CapturarEnAlmacen (var Me:ME_CUENTA; Pos:TPos; var Reg:TipoRegAlmacen);
  procedure Asignar(var Me:ME_CUENTA);


implementation

{------------------------------------------------------------------------------}

procedure Asignar(var Me:ME_CUENTA);
begin
  AssignFile(me.Estructura.tablaHash, _Directorio + _NombreArch_TablaHash);
  AssignFile(me.Estructura.ListaCtasCtes.D, _Directorio + _NombreArch_LDCtaCte);
  AssignFile(Me.Datos.tablaControlIndice, _Directorio + _NombreArch_TablaIndMov);
  AssignFile(me.Datos.ListaIndiceAlmacen.D, _Directorio + _NombreArch_LDIndMov);
  AssignFile(Me.Datos.Almacen, _Directorio + _NombreArch_Almacen);
end;

{------------------------------------------------------------------------------}

Procedure CrearMe_CtaCte (Var Me:ME_CUENTA);
Var
  FaltaAlmacen, FaltaIndice:Boolean;
Begin
  LO_Hash.Crear(Me.Estructura.tablaHash,_NombreArch_TablaHash,_Directorio);
  LO_ListaParcialDobleEnlace.CrearLdParcial(me.Estructura.ListaCtasCtes,_NombreArch_LDCtaCte,_Directorio);

  AssignFile(Me.Datos.tablaControlIndice,_Directorio + _NombreArch_TablaIndMov);//control indiceAlmacen
  {$i-}
  Reset(Me.Datos.tablaControlIndice);
  FaltaAlmacen:=(Ioresult<>0);
  If (FaltaAlmacen)  then
    begin
      Rewrite(Me.Datos.tablaControlIndice);
      close(me.Datos.tablaControlIndice);
    end;

    LO_ListaParcialDobleEnlace.CrearLdParcial(me.Datos.ListaIndiceAlmacen,_NombreArch_LDIndMov,_Directorio); //indiceAlmacen

    AssignFile(Me.Datos.Almacen,_Directorio + _NombreArch_Almacen);//datos almacen
    {$i-}
    Reset(Me.Datos.Almacen);
    FaltaAlmacen:=(Ioresult<>0);
    If (FaltaAlmacen)  then
      begin
        Rewrite(Me.Datos.Almacen);
        close(me.Datos.Almacen);
      end;
end;

{------------------------------------------------------------------------------}

procedure AbrirMe_CtaCte (var Me: ME_CUENTA);
begin
  Asignar(Me);
  LO_Hash.Abrir(Me.Estructura.tablaHash);
  LO_ListaParcialDobleEnlace.AbrirLDParcial(Me.Estructura.ListaCtasCtes);
  reset(me.Datos.tablaControlIndice);
  LO_ListaParcialDobleEnlace.AbrirLDParcial(me.Datos.ListaIndiceAlmacen);
  reset(me.Datos.Almacen);
end;

{------------------------------------------------------------------------------}

procedure CerrarMe_CtaCte (var Me: ME_CUENTA);
begin
  LO_Hash.Cerrar(Me.Estructura.tablaHash);
  LO_ListaParcialDobleEnlace.CerrarLDParcial(Me.Estructura.ListaCtasCtes);
  close(me.Datos.tablaControlIndice);
  LO_ListaParcialDobleEnlace.CerrarLDParcial(me.Datos.ListaIndiceAlmacen);
  close(me.Datos.Almacen);
end;

{------------------------------------------------------------------------------}

procedure DestruirMe_CtaCte  (var Me: ME_CUENTA);
begin
  LO_Hash.Destruir(Me.Estructura.tablaHash);
  LO_ListaParcialDobleEnlace.DestruirLdParcial(Me.Estructura.ListaCtasCtes);
  erase(me.Datos.tablaControlIndice);
  LO_ListaParcialDobleEnlace.DestruirLdParcial(me.Datos.ListaIndiceAlmacen);
  erase(me.Datos.Almacen);
end;

{------------------------------------------------------------------------------}

Procedure InsertarCtaCte (var Me:ME_CUENTA; Clave:tClaveHash; var PosEnDatos:tPos);
var
  RegHashControl:LO_ListaParcialDobleEnlace.TipoRegControl;
  RegCtaCte:LO_ListaParcialDobleEnlace.TipoRegDatos;
  posEnCtaCte, posClaveHash, pos, posLista, posUltimo:TPos;
  buscar:boolean;
  RegControlIndice:tipoRegControl;
begin
  RegCtaCte.Clave:=Clave;
  posClaveHash:=LO_Hash.FuncionHash(Clave);//Otengo posicion de la tabla Hash
  LO_Hash.Capturar(me.Estructura.tablaHash,posClaveHash,RegHashControl);//Obtengo contenido de la tabla Hash con la posicion parametrizada
  pos:=RegHashControl.primero;

  if (pos = Lib_Auxiliar.PosNula) then  //Si no existe el equipo
  begin
    LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(me.Estructura.ListaCtasCtes,Clave,PosLista, RegHashControl);
    //Antes de insertar RegCtaCte, voy a buscar su posEnTablaControlIndice (vengo de insertar un movimiento)
    posUltimo:=Filesize(me.Datos.tablaControlIndice);
    RegCtaCte.PosEnDatos:=posUltimo;
    PosEnDatos:=posUltimo;
    //-----------------------------------
    LO_ListaParcialDobleEnlace.InsertarInfo_LdParcial(me.Estructura.ListaCtasCtes,RegCtaCte,PosLista,RegHashControl);
    LO_Hash.modificar(me.Estructura.tablaHash, RegHashControl, posClaveHash);//actualizo cabecera tabla hash

    LO_ListaParcialDobleEnlace.InicializarCabecera(regControlIndice);
    GrabarTablaIndiceMov(me,posEnDatos,regControlIndice);

  end
  else //si no existe la CuentaCorriente...
      begin
          if not (LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(me.Estructura.ListaCtasCtes,Clave,PosLista, RegHashControl)) then
          begin
            buscar:=LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(me.Estructura.ListaCtasCtes,Clave,PosLista, RegHashControl);

            //Antes de insertar RegCtaCte ...
            posUltimo:=Filesize(me.Datos.tablaControlIndice);
            RegCtaCte.PosEnDatos:=posUltimo;
            PosEnDatos:=posUltimo;
            //...grabo registro en tabla indice de movimientos
            LO_ListaParcialDobleEnlace.InicializarCabecera(regControlIndice);
            GrabarTablaIndiceMov(me,posEnDatos,regControlIndice);

            LO_ListaParcialDobleEnlace.InsertarInfo_LdParcial(me.Estructura.ListaCtasCtes,RegCtaCte,PosLista,RegHashControl);
            LO_Hash.modificar(me.Estructura.tablaHash, RegHashControl, posClaveHash); //ACTUALIZO CABECERA TABLA HASH
          end
          else
              begin
                LO_ListaParcialDobleEnlace.CapturarInfo_LdParcial(me.Estructura.ListaCtasCtes,PosLista,RegCtaCte);
                PosEnDatos:=RegCtaCte.posEnDatos;
              end;
      end;
end;

{------------------------------------------------------------------------------}

Procedure InsertarAlmacen (var Me:ME_CUENTA; var RegAlmacen:tipoRegAlmacen);
var
  posAlmacen:tPos;
begin
  posAlmacen:=fileSize(me.Datos.Almacen);

  Seek(me.Datos.Almacen, PosAlmacen);
  write(me.Datos.Almacen, RegAlmacen);

  InsertarIndiceAlmacen(me, RegAlmacen.Nick, PosAlmacen);
end;

{------------------------------------------------------------------------------}

Procedure InsertarIndiceAlmacen(var Me:ME_CUENTA; Clave:tClaveHash; PosAlmacen:tPos);
var
  posEnDatos:tPos;
  PosLista:tPos;
  regCI, RegControlIndice:tipoRegControl;
  regIndiceAlmacen:tipoRegDatos;
begin
  //Invoco InsertarCtaCte por si no existe la cuenta. De todas formar me trae en PosEnDatos que le paso por referencia la posicion que apunta a la 'tabla indice movimientos'
  InsertarCtaCte(me, clave, posEnDatos);
  //Me paro en la tabla tablaControlIndice, y capturo ese registroControl
  CapturarTablaIndiceMov(me,posEnDatos,regControlIndice);
  //Preparo registro indice almacen antes de insertar
  regIndiceAlmacen.posEnDatos:=PosAlmacen;
  regIndiceAlmacen.Clave:=Clave;

  //Parametrizo en Buscar el registro control indice que esta en la tabla Indice Movimientos en esa posicion
  LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(me.Datos.ListaIndiceAlmacen,Clave,PosLista, RegControlIndice);
  LO_ListaParcialDobleEnlace.InsertarInfo_LdParcial(me.Datos.ListaIndiceAlmacen,regIndiceAlmacen,PosLista,RegControlIndice);

  //Actualizo cabecera tablba control indice
  GrabarTablaIndiceMov(me,posEnDatos,regControlIndice);
end;

{------------------------------------------------------------------------------}

Procedure CapturarCtaCte(var Me:ME_CUENTA; Clave:tClaveHash; var Reg:tipoRegDatos);
var
RegHashControl:LO_ListaParcialDobleEnlace.TipoRegControl;
posClaveHash, PosLista:TPos;

begin
  posClaveHash:=LO_Hash.FuncionHash(Clave);//Otengo posicion de la tabla Hash
  //capturo el registro control de la tabla hash
  LO_Hash.Capturar(me.Estructura.tablaHash,posClaveHash,RegHashControl);
  //Busco en 'lista doble parcial' parametrizando el registro control y capturo registro
  LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(me.Estructura.ListaCtasCtes,Clave,PosLista, RegHashControl);
  LO_ListaParcialDobleEnlace.CapturarInfo_LdParcial(me.Estructura.ListaCtasCtes,PosLista,Reg);
end;

{------------------------------------------------------------------------------}

procedure CapturarAlmacen (var Me:ME_CUENTA; Pos:TPos; var Reg:TipoRegAlmacen);
begin
    seek(me.Datos.Almacen,Pos);
    read(me.Datos.Almacen,Reg);
end;

{------------------------------------------------------------------------------}

//capturar registro en tabla indice de movimientos
procedure CapturarTablaIndiceMov (var Me:ME_CUENTA; Pos:TPos; var Reg:TipoRegControl);
begin
  seek(me.Datos.tablaControlIndice,pos);
  read(me.Datos.tablaControlIndice,Reg);
end;

{------------------------------------------------------------------------------}

//Grabo registro en tabla indice de movimientos
procedure GrabarTablaIndiceMov (var Me:ME_CUENTA; Pos:TPos; Reg:TipoRegControl);
var
  RegIndMov:tipoRegControl;
begin
  seek(me.Datos.tablaControlIndice,pos);
  write(me.Datos.tablaControlIndice,Reg);
end;

{------------------------------------------------------------------------------}

Function SaldoAcumulado  (var me:ME_CUENTA; Clave: tclave): timporte;
var
  debeacumulado, haberacumulado: timporte;
  regCtaCte,RegIndMovimiento:tipoRegDatos;
  pos,PosLista,i:Tpos;
  ClaveMayuscula:tClaveHash;
  regTablaIndice:tipoRegControl;
  RegAlm:TipoRegAlmacen;
begin
  ClaveMayuscula:= UpperCase(clave);
  CapturarCtaCte(me,ClaveMayuscula,regCtaCte);

  CapturarTablaIndiceMov(me,regCtaCte.PosEnDatos,regTablaIndice);

  i:=LO_ListaParcialDobleEnlace.Primero(me.Datos.ListaIndiceAlmacen, regTablaIndice);
  debeAcumulado:= 0;
  haberAcumulado:= 0;

  while (i<>Lib_Auxiliar.PosNula) do
  begin
      LO_ListaParcialDobleEnlace.CapturarInfo_LdParcial(me.Datos.ListaIndiceAlmacen,i,RegIndMovimiento);
      CapturarAlmacen(me,RegIndMovimiento.PosEnDatos,RegAlm);

      debeAcumulado:= debeAcumulado + RegAlm.Debe;
      haberAcumulado:= haberAcumulado + RegAlm.haber;

    i:=LO_ListaParcialDobleEnlace.Proximo(me.Datos.ListaIndiceAlmacen,i);
  end;
  SaldoAcumulado:= debeAcumulado-haberAcumulado;
end;

{------------------------------------------------------------------------------}

Procedure Capturar_InfoAlmacen(var Me:ME_CUENTA; Clave:tClaveHash; var RegAlm:TipoRegAlmacen);  ///
var
regCtaCte,RegIndMovimiento:tipoRegDatos;
ClaveMayuscula:tClaveHash;
regTablaIndice:tipoRegControl;
posLista:tPos;
begin
  ClaveMayuscula:= UpperCase(clave);
  CapturarCtaCte(me,ClaveMayuscula,regCtaCte);
  CapturarTablaIndiceMov(me,regCtaCte.PosEnDatos,regTablaIndice);
  LO_ListaParcialDobleEnlace.CapturarInfo_LdParcial(me.Datos.ListaIndiceAlmacen,posLista,RegIndMovimiento);
  CapturarAlmacen(me,RegIndMovimiento.PosEnDatos,RegAlm);
end;

{------------------------------------------------------------------------------}

Function PrimeroLdParcial(var Me:ME_CUENTA; Clave:tClaveHash):tPos;
var
regCtaCte,RegIndMovimiento:tipoRegDatos;
pos,PosLista,i:Tpos;
ClaveMayuscula:tClaveHash;
regTablaIndice:tipoRegControl;
RegAlm:TipoRegAlmacen;
begin
  ClaveMayuscula:= UpperCase(clave);
  CapturarCtaCte(me,ClaveMayuscula,regCtaCte);
  CapturarTablaIndiceMov(me,regCtaCte.PosEnDatos,regTablaIndice);

  PrimeroLdParcial:=LO_ListaParcialDobleEnlace.Primero(me.Datos.ListaIndiceAlmacen, regTablaIndice);
end;

{------------------------------------------------------------------------------}

procedure CapturarEnAlmacen (var Me:ME_CUENTA; Pos:TPos; var Reg:TipoRegAlmacen);
var
  RegIndMovimiento:tipoRegDatos;
begin
    LO_ListaParcialDobleEnlace.CapturarInfo_LdParcial(me.Datos.ListaIndiceAlmacen,pos,RegIndMovimiento);
    seek(me.Datos.Almacen,RegIndMovimiento.PosEnDatos);
    read(me.Datos.Almacen,Reg);
end;

{------------------------------------------------------------------------------}

function ProximoEnLdParcial (var Me:ME_CUENTA; Pos:TPos):TPos;
begin
  ProximoEnLdParcial:= LO_ListaParcialDobleEnlace.Proximo(me.Datos.ListaIndiceAlmacen,pos);
end;

{------------------------------------------------------------------------------}

function PosNula (var Me:ME_CUENTA): TPos;
begin
  PosNula:= Lib_Auxiliar.PosNula;
end;

{------------------------------------------------------------------------------}

END.





















