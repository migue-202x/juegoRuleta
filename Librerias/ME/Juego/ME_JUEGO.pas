unit ME_JUEGO;

{
Este ME consta con un archivo de datos denominado RULETA.DAT organizado a trav�s de un
TDA Cola, donde se almacena los datos de cada jugada (NroJugada, FechaHora, Estado, Bolilla)
Tambi�n dispone de un archivo de control denominado RULETA.CON, donde se tiene control sobre el juego (maxima apuesta y minima apuesta)
Este ME al utilizar un TDA de colas, se inserta siempre al final, se elimina el primer elemento, y se captura al frente

Ya sea para UltimaJugada (que cicla hasta encontrar la ultima jugada) o ModificoUltimo(que modifica el ultimo registro con los
datos actuales de la jugada parametrizada) se insertar un registroBandera que permite ciclar y funcionar de corte sin
cambiar el orden de la cola
}


interface

Uses
  LO_Colas, LO_ListaSimpleEnlace, Type_JUEGO, Lib_Auxiliar, Dialogs, SysUtils;


Const
  _Directorio = 'Archivos\';
  _NombreArchDatos = 'RULETA.DAT';
  _NombreArchControl = 'RULETA.CON';
  _NombreArchColasDatos = 'COLASRULETA.DAT';
  _NombreArchColasControl = 'COLASRULETA.CON';

Type

	ME_RULETA = Record
                      E: LO_Colas.tCola;
				              D: Type_JUEGO.TipoArchivoDatos;
                      C: Type_JUEGO.tipoArchControlJuego;  //Control sobre el juego
			            End;


  Procedure CrearME (Var Me:ME_RULETA);
  procedure AbrirME (var Me:ME_RULETA);
  procedure CerrarME (var Me: ME_RULETA);
  procedure DestruirME (var Me: ME_RULETA);
  function MEVacio(var Me: ME_RULETA): Boolean;
  Procedure Insertar (Var Me: ME_RULETA; Reg: TipoRegDatos);
  Procedure Frente(Var Me: ME_RULETA; var regDat: TipoRegDatos );
  Procedure Decolar(Var Me: ME_RULETA );
  function Presente(var ME: ME_RULETA; reg: TipoRegDatos): Boolean ;
  procedure RegistroNulo(var Nulo:TipoRegDatos);
  function ClaveNula(var Me: ME_RULETA):TClave;
  function ApuestaMaxima(var Me: ME_RULETA):tImporte;
  function ApuestaMinima(var Me: ME_RULETA):tImporte;
  Procedure UltimaJugada(var Me:ME_RULETA; var reg:type_JUEGO.TipoRegDatos);
  procedure ModificoUltimo(Me: ME_RULETA; reg:type_JUEGO.TipoRegDatos);
  procedure Asignar(var Me:ME_RULETA);


implementation

{------------------------------------------------------------------------------}

Procedure CrearME (Var Me:ME_RULETA);
Var
	FaltaControl:Boolean;
	FaltaDatos:Boolean;
  rc:TipoRegControlJuego;
Begin
 AssignFile(Me.D,_Directorio+_NombreArchDatos);
  {$i-}
 Reset(Me.D);
 FaltaDatos:=(Ioresult<>0);

  If (FaltaDatos) then
  begin
   Rewrite(Me.D); Close(Me.D);
  end;

  AssignFile(Me.C,_Directorio+_NombreArchControl);
	{$i-}
	Reset(Me.C);
	FaltaControl:=(Ioresult<>0);
	If (FaltaControl) then
    begin
      Rewrite(Me.C);
       //Se incializan las variables de control
      Rc.MaximaApuesta:= Type_JUEGO.MaximaApuesta;
      Rc.MinimaApuesta := Type_JUEGO.MinimaApuesta;

      seek(Me.C,0); Write(Me.C,rc);

		  Close(Me.C);
      Close(Me.D);
    end;

 LO_Colas.CrearCola(Me.E, _NombreArchColasControl, _NombreArchColasDatos, _Directorio);
End;

{------------------------------------------------------------------------------}

procedure AbrirME (var Me:ME_RULETA);
var
  rc: TipoRegControlJuego;
begin
  Asignar(Me);
  reset(Me.D);
  reset(Me.C);
  LO_Colas.AbrirCola(Me.E);
end;

{------------------------------------------------------------------------------}

procedure CerrarME (var Me:ME_RULETA);
begin
  Close(Me.D);
  Close(Me.C);
  LO_Colas.CerrarCola(Me.E);
end;

{------------------------------------------------------------------------------}

procedure DestruirME (var Me:ME_RULETA);
begin
  Erase(Me.D);
  Erase(Me.C);
  LO_Colas.DestruirCola(Me.E);
end;

{------------------------------------------------------------------------------}

function Presente(var ME: ME_RULETA; reg: TipoRegDatos): Boolean ;
begin
//Busca si la jugada pasada en el reg esta en la cola
  presente:=  LO_Colas.Buscar(me.E, reg.NroJugada);
end;

{------------------------------------------------------------------------------}

function MEVacio(var Me:ME_RULETA): Boolean;
begin
  MEVacio:= LO_Colas.ColaVacia(Me.E);
end;

{------------------------------------------------------------------------------}

Procedure Insertar (Var Me: ME_RULETA; Reg: TipoRegDatos);
var
  RegET: LO_Colas.TipoRegDatos;
  RegControl: TipoRegControl;
begin
  //Se inserta al final del archivo
  RegET.PosEnDatos:= FileSize(Me.D);
  RegET.Clave:= (Reg.NroJugada);
  LO_Colas.Encolar(Me.E,RegET);
  Seek (Me.D,RegET.PosEnDatos); Write(Me.D,Reg);
end;
{------------------------------------------------------------------------------}

Procedure Frente(Var Me:ME_RULETA; var regDat: TipoRegDatos );
var
RegAux: LO_Colas.TipoRegDatos;
Begin
//Tomo el primer valor de la estructura
   LO_Colas.Frente(me.E,RegAux);
   seek(me.D,RegAux.PosEnDatos);
   read(me.D,regDat);
End;

{------------------------------------------------------------------------------}

Procedure Decolar(Var Me: ME_RULETA );
Begin
//Elimino el primer valor de la estructura
   LO_Colas.Decolar(me.E);
End;

{------------------------------------------------------------------------------}
//Inicializo el registro nulo que lo utilizo de bandera en la busqueda
procedure RegistroNulo(var Nulo:TipoRegDatos);
begin
  nulo.NroJugada:= Lib_Auxiliar.clavenula;
  nulo.Estado:= -1;
  nulo.bolilla:= -1;
end;

{------------------------------------------------------------------------------}

function ClaveNula(var Me:ME_RULETA):TClave;

begin
  //Devuelve la clave nula
  ClaveNula:=LO_Colas.ClaveNula(Me.E);
end;

{------------------------------------------------------------------------------}

function ApuestaMaxima(var Me:ME_RULETA):tImporte;
var
  RegControl: tiporegcontrolJuego;
begin
  //Devuelve el valor del importe de la apuesta maxima
  seek(me.C, 0); Read(me.C, RegControl);
  ApuestaMaxima:= regcontrol.MaximaApuesta;
end;

{------------------------------------------------------------------------------}

function ApuestaMinima(var Me:ME_RULETA):tImporte;
var
RegControl: tiporegcontroljuego;
begin
  //Devuelve el valor del importe de la apuesta minima
  seek(Me.C,0); Read(Me.C, RegControl);
  ApuestaMinima:= regcontrol.MinimaApuesta;
end;

{------------------------------------------------------------------------------}

//Devuelve el reg de la ultima jugada
Procedure UltimaJugada(var Me:ME_RULETA; var reg:type_JUEGO.TipoRegDatos);
var
regAux: TipoRegDatos;
regnulo: TipoRegDatos;
begin
  ME_JUEGO.RegistroNulo(regnulo);
  ME_JUEGO.Insertar(me, regnulo);
  ME_JUEGO.Frente(me,regAux);
  ME_JUEGO.Decolar(me);

  //Mientras no me encuentre con el RegBandera, que tiene como clave -1,
  //voy sobreescribiendo reg que pase por referencia hasta que el ciclo se encuentra de frente con el RegBandera y lo decole
  //Es asi que los valores que se guardaran en reg seran del ultimo registro de la cola
  while regAux.NroJugada<>ME_JUEGO.ClaveNula(me) do
  begin
    reg.NroJugada:= regAux.NroJugada;
    reg.FechaHora:= regAux.FechaHora;
    reg.Estado:=  regAux.Estado;
    reg.Bolilla:= regAux.Bolilla;

    ME_JUEGO.Insertar(me, regAux);
    ME_JUEGO.Frente(me,regAux);
    ME_JUEGO.Decolar(me);
  end;
end;

{------------------------------------------------------------------------------}
//Modifico el ultimo registro con los datos actuales de la jugada que le parametrizo en reg
procedure ModificoUltimo(Me: ME_RULETA; reg:type_JUEGO.TipoRegDatos);
var
regAux, regauxUltimo: TipoRegDatos;
regMod:TipoRegDatos;
regNulo: TipoRegDatos;
begin
if (Presente(me,reg)) then//el registro que le paso esta en la cola
    begin
      RegistroNulo(regnulo);
      Insertar(me, regnulo);
      Frente(me,regaux);
      Decolar(me);

      while regaux.NroJugada<>ClaveNula(me) do//me encontre el registro bandera
      begin
        if (regaux.NroJugada = reg.NroJugada) then
        begin
          regaux.FechaHora:= reg.FechaHora;
          regaux.Estado:= reg.Estado;
          regaux.Bolilla:= reg.Bolilla;

          Insertar(me,regaux);
          Frente(me,regaux);
          Decolar(me);
        end
        else
        begin //no es el registro que busco
          Insertar(me,regaux);
          Frente(me,regaux);
          Decolar(me);
        end;
      end;
    end;
end;

{------------------------------------------------------------------------------}

procedure Asignar(var Me:ME_RULETA);
begin
  AssignFile(Me.D, _Directorio + _NombreArchDatos);
  AssignFile(Me.C, _Directorio + _NombreArchControl);
  AssignFile(Me.E.D, _Directorio + _NombreArchColasDatos);
  AssignFile(Me.E.C, _Directorio + _NombreArchColasControl);
end;

END.

