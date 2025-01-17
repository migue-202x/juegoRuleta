unit ME_JUGADORES;

{
Consiga:

Tiene por objeto registrar a todos los jugadores de RuleTrucha
 El ME_JUGADORES contendr� los siguientes archivos:

 1a) El archivo JUGADORES.DAT, que se encuentran organizados a trav�s de un  �ndice de �rbol AVL,
    que contiene los datos del jugador

 2a) El archivo JUGADORES.CON, cabecera de Indice

 3a) El archivo JUGADORES.NTX, Indice
 }


interface

uses
  Lib_Auxiliar, LO_ArbolAVL, Type_JUGADOR,
  System.Math,System.SysUtils,Forms,Dialogs;

CONST

  _Directorio = 'Archivos\';
  _NombreArchivoDatos = 'JUGADORES.DAT';
  _NombreArchivoControl = 'JUGADORES.CON';
  _NombreArchivoIndice = 'JUGADORES.NTX';


TYPE

	ME_JUGADOR = Record
                  D: Type_JUGADOR.tArchDatos; //Archivo datos
                  I: LO_ArbolAVL.tArbol; //Archivo indice de datos
           End;

procedure CrearME_Jugadores (var Me: ME_JUGADOR); {1}
Procedure AbrirME_Jugadores(var Me:ME_JUGADOR); {2}
Procedure CerrarME_Jugadores(var Me:ME_JUGADOR); {3}
procedure DestruirME_Jugadores(var Me:ME_JUGADOR); {4}
Function MeVacio_Jugadores(var Me: ME_JUGADOR):Boolean; {5}
Procedure InsertarInfoME_Jugadores(var Me: ME_JUGADOR;Reg:tRegDatos;Pos:tPos); {6}
Procedure EliminarInfoME_Jugadores(var Me: ME_JUGADOR; Pos:tPos); {7}
Procedure ModificarInfoME_Jugadores(var Me: ME_JUGADOR; Reg:tRegDatos;Pos:tPos); {8}
Procedure CapturarInfoME_Jugadores(var Me: ME_JUGADOR; var Reg:tRegDatos; Pos:tPos); {9}
Function BuscarInfoME_Jugadores(Var Me:ME_JUGADOR; Var Pos:tPos; Clave:TClave):Boolean; {10}
function PosNula_Jugadores(Var Me:ME_JUGADOR):tPos; {11}
function ClaveNula_Jugadores(Var Me:ME_JUGADOR):tClave; {12}
function Raiz(var Me: ME_JUGADOR): tPos; {13}
function ProximoIzq(var Me: ME_JUGADOR; pos: tPos): tPos; {14}
function ProximoDer(var Me: ME_JUGADOR; pos: tPos): tPos; {15}
function UltFicticio (var Me: ME_JUGADOR): tCantidad; {16}
function Cantidad_Jugadores(var Me: ME_JUGADOR): tCantidad; {17}
function ObtenerNivel_enArbol(var Me:ME_JUGADOR; clave:tClave): tCantidad; {18}
procedure Asignar(var Me:ME_JUGADOR); {19}


implementation

{----------------------------------------(1)----------------------------------------}

procedure CrearME_Jugadores (var Me: ME_JUGADOR);
Var
	 ioD:integer;
begin
  assignFile (Me.D, _Directorio + _NombreArchivoDatos);
  {$i-}
  reset(Me.D); ioD:=IoResult; //Si IoResult es cero, la operacion es exitosa
  if (IoD<>0)then
    Rewrite(Me.D); Close(Me.D);
  {$I+}
  LO_ArbolAVL.CrearMe_Arbol(me.I,_NombreArchivoControl,_NombreArchivoIndice,_Directorio);
end;

{----------------------------------------(2)----------------------------------------}

Procedure AbrirME_Jugadores(var Me:ME_JUGADOR);
begin
  Asignar(Me);
  Reset(Me.D);
  LO_ArbolAVL.AbrirMe_Arbol(me.I);
end;

{----------------------------------------(3)----------------------------------------}

Procedure CerrarME_Jugadores(var Me:ME_JUGADOR);
begin
  Close(Me.D);
  LO_ArbolAVL.CerrarMe_Arbol(me.i);
end;


{----------------------------------------(4)----------------------------------------}

procedure DestruirME_Jugadores(var Me:ME_JUGADOR);
begin
  Erase(Me.D);
  LO_ArbolAVL.DestruirMe_Arbol(me.i);
end;

{----------------------------------------(5)----------------------------------------}

Function MeVacio_Jugadores(var Me: ME_JUGADOR):Boolean;
begin
  MeVacio_Jugadores:= LO_ArbolAVL.Arbol_Vacio(me.i);
end;

{----------------------------------------(6)----------------------------------------}

Procedure InsertarInfoME_Jugadores(var Me: ME_JUGADOR;Reg:tRegDatos;Pos:tPos);
Var
  Aux,RegPadre:tRegDatos;
  Rc:tControlArbol;
  PosenDatos:tPos;
  RegME: LO_ArbolAVL.tNodoIndice;
Begin
  PosenDatos:= filesize(Me.D);
  reg.Nick:=  UpperCase(Reg.Nick);
  RegME.PosenDatos:= PosenDatos;
  RegME.Clave:= Reg.Nick;
  LO_ArbolAVL.InsertarNodo_Arbol(Me.I,RegME,Pos, reg.TipoJugador);
  Seek (Me.D,RegME.PosEnDatos); Write(Me.D,Reg);
end;

{----------------------------------------(7)----------------------------------------}

Procedure EliminarInfoME_Jugadores(var Me: ME_JUGADOR; Pos:tPos);
begin
    //Elimina de la estructura el registro que esta en la posicion parametrizada
    LO_ArbolAVL.EliminarNodo_Arbol(me.I,pos);
end;

{----------------------------------------(8)----------------------------------------}

Procedure ModificarInfoME_Jugadores(var Me: ME_JUGADOR; Reg:tRegDatos; Pos:tPos);
var
  RE: LO_ArbolAVL.tNodoIndice;
  regAlm:tRegDatos;
begin
  //Se le pasa la posicion de la estructrura, trae el registro y sobreescribe el registro en el almacen de datos
  Seek(Me.I.D,pos); Read(Me.I.D,RE);
  Seek(Me.D,RE.PosEnDatos); Write(Me.D, Reg);
end;
{----------------------------------------(9)----------------------------------------}

Procedure CapturarInfoME_Jugadores(var Me: ME_JUGADOR; var Reg:tRegDatos; Pos:tPos);
var
  regIndice: LO_ArbolAVL.tNodoIndice;
begin
  //Se le pasa la posicion en arbol, trae el registro y con posEnDatos trae ese registro
  LO_ArbolAVL.CapturarNodo_Arbol(ME.I, regIndice, pos);
  Seek(Me.D, regIndice.posendatos);Read(Me.D, Reg);
end;
{----------------------------------------(10)----------------------------------------}

Function BuscarInfoME_Jugadores(Var Me:ME_JUGADOR; Var Pos:tPos; Clave:TClave):Boolean;
Begin
  //Busco en la arbol, si la clave esta devuelve la posicion donde se encuentra, sino devuelve la posicion donde deberia estar
   BuscarInfoME_Jugadores:= LO_ArbolAVL.BuscarNodo_Arbol(ME.i,clave, pos)
End;

{----------------------------------------(11)----------------------------------------}

function PosNula_Jugadores(Var Me:ME_JUGADOR):tPos;
begin
  PosNula_Jugadores:= LO_ArbolAVL.PosNula_Arbol(me.I);
end;

{----------------------------------------(12)----------------------------------------}

function ClaveNula_Jugadores(Var Me:ME_JUGADOR):tClave;
begin
  ClaveNula_Jugadores:= _clave_nula_archivo;
end;

{----------------------------------------(13)----------------------------------------}

function Raiz(var Me: ME_JUGADOR): tPos;
begin
  Raiz:= LO_ArbolAVL.Raiz_Arbol(me.I);
end;

{----------------------------------------(14)----------------------------------------}

function ProximoIzq(var Me: ME_JUGADOR; pos: tPos): tPos;
begin
  ProximoIzq:= LO_ArbolAVL.HijoIzq_Arbol(ME.I,pos);
end;

{----------------------------------------(15)----------------------------------------}

function ProximoDer(var Me: ME_JUGADOR; pos: tPos): tPos;
begin
  ProximoDer:= LO_ArbolAVL.HijoDer_Arbol(ME.I,pos);
end;


{----------------------------------------(16)----------------------------------------}

function UltFicticio (var Me: ME_JUGADOR): tCantidad;
begin
  UltFicticio:= LO_ArbolAVL.UltFicticio_Arbol(me.I);
end;

{----------------------------------------(17)----------------------------------------}

function Cantidad_Jugadores(var Me: ME_JUGADOR): tCantidad;
begin
  Cantidad_Jugadores:= LO_ArbolAVL.CantidadNodos_Arbol(me.I);
end;

{----------------------------------------(18)----------------------------------------}

function ObtenerNivel_enArbol(var Me:ME_JUGADOR; clave:tClave): tCantidad;
begin
  ObtenerNivel_enArbol:= LO_ArbolAVL.ObtenerNivel_Arbol(Me.i, clave);
end;

{----------------------------------------(19)----------------------------------------}

procedure Asignar(var Me:ME_JUGADOR);
begin
  AssignFile(me.D, _Directorio + _NombreArchivoDatos);
  AssignFile(me.I.C, _Directorio + _NombreArchivoControl);
  AssignFile(me.I.D, _Directorio + _NombreArchivoIndice);
end;


END.



