unit ME_GANADORES;

{
En este m�todo se recolectan los ganadores de cada juego y las jugadas ganadas de cada jugador
Cada nuevo ganador se inserta en el arbol
Con Hijo Medio se enganchan todas las jugadas (ganadoras) en las que intervino el jugador,
por ello hijo medio es un registro de control que apunta hacia
una lista parcial doble enlace donde se guardan estas jugadas ganadas por el jugador ganador.
Si el jugador ganador no esta en el arbol, se agrega como nodo en el arbol y se insertar en la lista
Si ya se encuentra en el arbol se inserta solo en la lista y se actualiza el registro de control
}

interface

Uses
  Lib_Auxiliar, LO_ArbolTrinario, LO_ListaParcialDobleEnlace, Type_GANADOR;

CONST
  _Directorio = 'Archivos\';
  _NombreArchivoDatos = 'GANADORES.DAT';
  _NombreArchControl_ArbolTrinario = 'GANADORES.CON';
  _NombreArchIndice_ArbolTrinario = 'GANADORES.NTX';
  _NombreListaIndiceDatos = 'INDICEGANADORES.IND';



TYPE
      regNodo = LO_ArbolTrinario.tNodoIndice;

      ME_GANADOR = Record
          Almacen: Type_GANADOR.TipoArchivoDatos;  //datos
          ListaIndiceAlmacen: LO_ListaParcialDobleEnlace.tLdParcial;//lista indice sobre archivo almacen de datos
          ArbolTri: LO_ArbolTrinario.tArbolTrinario; //estructura arbol
      end;


  procedure CrearME_Ganadores (var Me: ME_GANADOR); {1}
  Procedure AbrirME_Ganadores(var Me:ME_GANADOR); {2}
  Procedure CerrarME_Ganadores(var Me:ME_GANADOR); {3}
  Procedure DestruirME_Ganadores(var Me:ME_GANADOR); {4}
  Function MeVacio_Ganadores(var Me: ME_GANADOR):Boolean;  {5}
  Procedure InsertarInfoME_Ganadores(var Me: ME_GANADOR; RegAlm:Type_GANADOR.TipoRegDatos; Clave:tClave); {6}
  Procedure CapturarInfoME_Ganadores(var Me: ME_GANADOR; var nodo:LO_ArbolTrinario.tNodoIndice; Pos:TPos); {7}
  Function BuscarInfoME_Ganadores(Var Me:ME_GANADOR; Var Pos:TPos; Clave:TClave):Boolean; {8}
  function PosNula_Ganadores(Var Me:ME_GANADOR):TPos; {9}
  function ProximoIzq (var Me:ME_GANADOR; pos: TPos): TPos; {10}
  function ProximoDer (var Me:ME_GANADOR; pos: TPos): TPos; {11}
  function Raiz(var Me: ME_GANADOR): TPos; {12}
  function PrimerJugada_Ganador(var Me:ME_GANADOR; nodo:LO_ArbolTrinario.tNodoIndice):TPos; {13}
  function SiguienteJugada_Ganador(var Me:ME_GANADOR; pos:TPos): TPos; {14}
  procedure CapturarJugada_Ganador(var Me:ME_GANADOR; pos:TPos; var reg:Type_GANADOR.TipoRegDatos); {15}
  function Cantidad_Ganadores(var Me: ME_GANADOR): tCantidad; {16}
  function ObtenerNivel_enArbolTri(var Me:ME_GANADOR; clave:tClave): tCantidad; {17}
  procedure Asignar(var Me:ME_GANADOR); {18}

IMPLEMENTATION

{----------------------------------------(1)----------------------------------------}

procedure CrearME_Ganadores (var Me: ME_GANADOR);
var
  ioD:integer;
Begin
  assignFile (Me.Almacen, _Directorio + _NombreArchivoDatos);
  {$i-}
  reset(Me.Almacen); ioD:=IoResult; //Si IoResult es cero, la operacion es exitosa
  if (IoD<>0)then
    Rewrite(Me.Almacen);
    Close(Me.Almacen);
  {$I+}

  LO_ListaParcialDobleEnlace.CrearLdParcial(Me.ListaIndiceAlmacen,_NombreListaIndiceDatos,_Directorio);
  LO_ArbolTrinario.CrearMe_ArbolTri(Me.ArbolTri,_NombreArchControl_ArbolTrinario,_NombreArchIndice_ArbolTrinario,_Directorio);
end;

{----------------------------------------(2)----------------------------------------}

Procedure AbrirME_Ganadores(var Me:ME_GANADOR);
Begin
  Asignar(Me);
  reset(Me.Almacen);
  LO_ListaParcialDobleEnlace.AbrirLdParcial(Me.ListaIndiceAlmacen);
  LO_ArbolTrinario.AbrirMe_ArbolTri(Me.ArbolTri);
end;

{----------------------------------------(3)----------------------------------------}

Procedure CerrarME_Ganadores(var Me:ME_GANADOR);
Begin
  close(Me.Almacen);
  LO_ListaParcialDobleEnlace.CerrarLdParcial(Me.ListaIndiceAlmacen);
  LO_ArbolTrinario.CerrarMe_ArbolTri(Me.ArbolTri);
end;

{----------------------------------------(4)----------------------------------------}

Procedure DestruirME_Ganadores(var Me:ME_GANADOR);
Begin
  erase(Me.Almacen);
  LO_ListaParcialDobleEnlace.DestruirLdParcial(Me.ListaIndiceAlmacen);
  LO_ArbolTrinario.DestruirMe_ArbolTri(Me.ArbolTri);
end;

{----------------------------------------(5)----------------------------------------}

Function MeVacio_Ganadores(var Me: ME_GANADOR):Boolean;
begin
   MeVacio_Ganadores:= LO_ArbolTrinario.Arbol_Vacio(me.arbolTri);
end;


{----------------------------------------(6)----------------------------------------}

Procedure InsertarInfoME_Ganadores(var Me: ME_GANADOR; RegAlm:Type_GANADOR.TipoRegDatos; Clave:tClave);
var
   PosNodo, PosLista, PosFinalAlm: TPos;

   regIndAlm: LO_ListaParcialDobleEnlace.TipoRegDatos;
   RegDatos:Type_GANADOR.TipoRegDatos;

   nodo:LO_ArbolTrinario.tNodoIndice;

   regLista: LO_ListaParcialDobleEnlace.TipoRegDatos;
Begin

//Existe en arbol el jugador. Insertarmos Almacen, Lista y modificamos el hijo del medio del nodo
  if (LO_ArbolTrinario.BuscarNodo_ArbolTri(Me.ArbolTri,clave,PosNodo)) then
      begin
        //Caputuro nodo en arbol
        LO_ArbolTrinario.CapturarNodo_ArbolTri(Me.ArbolTri,nodo,PosNodo);

        //Busco la posicion en la lista indice datos e inserto en la lista Indice datos pasandole por parametro el regControl que es el campo HijoMedio
        LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(Me.ListaIndiceAlmacen, RegAlm.Nomenclador, PosLista, nodo.HijoMedio);

        //completo registro Lista
        regLista.PosEnDatos:= FileSize(me.Almacen);
        regLista.Clave:= RegAlm.Nomenclador;

        //Inserto en la Lista
        LO_ListaParcialDobleEnlace.InsertarInfo_LdParcial(Me.ListaIndiceAlmacen, regLista, PosLista, nodo.HijoMedio);

        //Inserto en el almacen de datos
        Seek (Me.Almacen,regLista.PosEnDatos);
        Write(Me.Almacen,RegAlm);

        //Busco la posicion nuevamente del arbol y lo modifico con campo HijoMedio actualizado
        LO_ArbolTrinario.BuscarNodo_ArbolTri(Me.ArbolTri,clave,PosNodo);
        LO_ArbolTrinario.ModificarNodo_ArbolTri(Me.ArbolTri,nodo,PosNodo);
      end
      else //No existe el nodo, entonces...
        begin
          //Inicializo la cabecera del hijo del medio
          LO_ListaParcialDobleEnlace.InicializarCabecera(nodo.HijoMedio);
          nodo.clave:=clave;

          //No existe en el �rbol el nodo, lo inserto
          LO_ArbolTrinario.InsertarNodo_ArbolTri(Me.ArbolTri,nodo,PosNodo);

          LO_ArbolTrinario.BuscarNodo_ArbolTri(Me.ArbolTri,nodo.clave,PosNodo);
          LO_ArbolTrinario.CapturarNodo_ArbolTri(Me.ArbolTri,nodo,PosNodo);

          //Busco la posicion en la lista
          LO_ListaParcialDobleEnlace.BuscarInfo_LdParcial(Me.ListaIndiceAlmacen, RegAlm.Nomenclador, PosLista, nodo.HijoMedio);

          //inserto la primer jugada ganada de un nuevo ganador

          //Le paso la posicion al registro de la Lista
          regLista.PosEnDatos:= FileSize(me.Almacen);
          regLista.Clave:= (RegAlm.Nomenclador);

          //Inserto en la estructura
          LO_ListaParcialDobleEnlace.InsertarInfo_LdParcial(Me.ListaIndiceAlmacen, regLista, PosLista, nodo.HijoMedio);

          //Inserto en el almacen de datos
          Seek (Me.Almacen,regLista.PosEnDatos);
          Write(Me.Almacen,RegAlm);

          //Busco la posicion nuevamente del arbol y lo modifico con campo HijoMedio actualizado
          LO_ArbolTrinario.BuscarNodo_ArbolTri(Me.ArbolTri,clave,PosNodo);
          LO_ArbolTrinario.ModificarNodo_ArbolTri(Me.ArbolTri,nodo,PosNodo);
        end;
end;


{----------------------------------------(7)----------------------------------------}

Procedure CapturarInfoME_Ganadores(var Me: ME_GANADOR; var nodo:LO_ArbolTrinario.tNodoIndice; Pos:TPos);
begin
   LO_ArbolTrinario.CapturarNodo_ArbolTri(me.ArbolTri, nodo, pos);
end;

{----------------------------------------(8)----------------------------------------}

Function BuscarInfoME_Ganadores(Var Me:ME_GANADOR; Var Pos:TPos; Clave:TClave):Boolean;

begin
   BuscarInfoME_Ganadores:= LO_ArbolTrinario.BuscarNodo_ArbolTri(me.ArbolTri,clave,pos);
end;

{----------------------------------------(9)----------------------------------------}

function PosNula_Ganadores(var Me:ME_GANADOR):TPos;
begin
  PosNula_Ganadores:= LO_ArbolTrinario.PosNula_ArbolTri(me.arbolTri);
end;

{----------------------------------------(10)----------------------------------------}

function Raiz (var Me: ME_GANADOR): TPos;
begin
  Raiz:= LO_ArbolTrinario.Raiz_ArbolTri(me.arbolTri);
end;


{----------------------------------------(11)----------------------------------------}

function PrimerJugada_Ganador(var Me:ME_GANADOR; nodo:LO_ArbolTrinario.tNodoIndice):TPos;
var
  pos: tpos;
begin
  LO_ArbolTrinario.BuscarNodo_ArbolTri(ME.ArbolTri, nodo.clave, pos);
  LO_ArbolTrinario.CapturarNodo_ArbolTri(ME.ArbolTri, nodo, pos);

  PrimerJugada_Ganador:= LO_ListaParcialDobleEnlace.Primero(ME.ListaIndiceAlmacen, nodo.HijoMedio);
end;

{----------------------------------------(12)----------------------------------------}

function SiguienteJugada_Ganador(var Me:ME_GANADOR; pos:TPos): TPos;
begin
  SiguienteJugada_Ganador:= LO_ListaParcialDobleEnlace.Proximo(ME.ListaIndiceAlmacen,pos);
end;

{----------------------------------------(13)----------------------------------------}

procedure CapturarJugada_Ganador(var Me:ME_GANADOR; pos:TPos; var reg:Type_GANADOR.TipoRegDatos);
begin
 Seek(Me.Almacen, pos);
 Read(Me.Almacen, reg);
end;

{----------------------------------------(14)----------------------------------------}

function ProximoIzq (var Me:ME_GANADOR; pos: TPos): TPos;
begin
  ProximoIzq:= LO_ArbolTrinario.HijoIzq_ArbolTri(Me.ArbolTri, pos);
end;

{----------------------------------------(15)----------------------------------------}

function ProximoDer (var Me:ME_GANADOR; pos: TPos): TPos;
begin
  ProximoDer:= LO_ArbolTrinario.HijoDer_ArbolTri(Me.ArbolTri, pos);
end;

{----------------------------------------(16)----------------------------------------}

function Cantidad_Ganadores(var Me: ME_GANADOR): tCantidad;
begin
  Cantidad_Ganadores:= LO_ArbolTrinario.CantidadNodos_Arbol(me.ArbolTri);
end;

{----------------------------------------(17)----------------------------------------}

function ObtenerNivel_enArbolTri(var Me:ME_GANADOR; clave:tClave): tCantidad;
begin
  ObtenerNivel_enArbolTri:= LO_ArbolTrinario.ObtenerNivel_ArbolTri(Me.ArbolTri, clave);
end;

{----------------------------------------(18)----------------------------------------}

procedure Asignar(var Me:ME_GANADOR);
begin
  AssignFile(Me.Almacen, _Directorio + _NombreArchivoDatos);
  AssignFile(me.ListaIndiceAlmacen.D, _Directorio + _NombreListaIndiceDatos);
  AssignFile(Me.ArbolTri.D, _Directorio + _NombreArchIndice_ArbolTrinario);
  AssignFile(Me.ArbolTri.C, _Directorio + _NombreArchControl_ArbolTrinario);
end;



END.

