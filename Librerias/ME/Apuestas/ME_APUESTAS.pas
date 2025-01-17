unit ME_APUESTAS;

{El ME APUESTAS guarda todas las apuestas efectuadas en el juego, tanto de jugadores reales como ficticios
Utiliza un TDA de lista doble}

interface

Uses
  Type_APUESTA, LO_ListaDobleEnlace, Lib_Auxiliar, Dialogs;

Const
  _Directorio = 'Archivos\';

  _NombreArchDatos = 'APUESTAS.DAT';
  _NombreArchApuestasLDDatos = 'APUESTASLD.DAT';
  _NombreArchApuestasLDControl = 'APUESTASLD.CON';

Type

          ME_APUESTA = Record
                      E:LO_ListaDobleEnlace.tListaDoble;
				              D:Type_APUESTA.TipoArchDatos;
			            End;

Procedure CrearME (Var Me:ME_APUESTA);
procedure AbrirME_Apuestas   (var Me: ME_APUESTA);
procedure CerrarME_Apuestas  (var Me: ME_APUESTA);
procedure DestruirME_Apuestas (var Me: ME_APUESTA);
function MEVacio_Apuestas(me:ME_APUESTA):boolean;
Procedure InsertarInfoME_Apuestas (var Me:ME_APUESTA; Reg:Type_APUESTA.TipoRegDatos;Pos:tPos);
procedure EliminarInfoME_Apuestas (var Me:ME_APUESTA; Pos:tPos);
procedure CapturarInfoME_Apuestas (var Me:ME_APUESTA; Pos:tPos; var Reg:Type_APUESTA.TipoRegDatos);
procedure ModificarInfoME_Apuestas (var Me:ME_APUESTA; Pos:tPos; Reg:Type_APUESTA.TipoRegDatos);
function PosNula_Apuestas (var Me:ME_APUESTA): tPos;
function ClaveNula_Apuestas(var Me:ME_APUESTA): tClave;
Function BuscarInfoME_Apuestas(var Me:ME_APUESTA;Clave:tClave;Var pos:tPos):Boolean;
function Primero (var Me:ME_APUESTA): tPos;
function Ultimo  (var Me:ME_APUESTA): tPos;
Function Anterior(var Me:ME_APUESTA; Pos:tPos):tPos;
function Proximo (var Me:ME_APUESTA; Pos:tPos):tPos;
function SaldoApuestasPartida (var Me:ME_APUESTA; Clave: tclave; Jugada: tClave): tImporte;
procedure Asignar(var Me:ME_APUESTA);



Implementation

{--------------------------------------------------------------------------------}

procedure Asignar(var Me:ME_APUESTA);
begin
  AssignFile(Me.D,_Directorio+_NombreArchDatos);
  AssignFile(Me.E.D,_Directorio+ _NombreArchApuestasLDDatos);
  AssignFile(Me.E.C,_Directorio+ _NombreArchApuestasLDControl);
end;

{--------------------------------------------------------------------------------}

Procedure CrearME (Var Me:ME_APUESTA);
Var
	FaltaControl:Boolean;
	FaltaDatos:Boolean;
  rc:TipoRegControl;
Begin
 AssignFile(Me.D,_Directorio+'APUESTAS.DAT');
  {$i-}
 Reset(Me.D);
 FaltaDatos:=(ioResult<>0);
 If (FaltaDatos) then
  begin
   Rewrite(Me.D); Close(Me.D);
  end;

 LO_ListaDobleEnlace.CrearLd(Me.E, 'APUESTASLD',_Directorio);

End;

{--------------------------------------------------------------------------------}

procedure AbrirME_Apuestas (var Me: ME_APUESTA);
begin
  Asignar(Me);
  reset (Me.D);
  LO_ListaDobleEnlace.AbrirLd(me.E);
end;

{--------------------------------------------------------------------------------}

procedure CerrarME_Apuestas  (var Me: ME_APUESTA);
begin
  Close (Me.D);
  LO_ListaDobleEnlace.CerrarLd(me.E)
end;

{--------------------------------------------------------------------------------}

procedure DestruirME_Apuestas (var Me: ME_APUESTA);
begin
  Erase (Me.D);
  LO_ListaDobleEnlace.DestruirLista(me.E);
end;

{--------------------------------------------------------------------------------}

function MEVacio_Apuestas(me:ME_APUESTA):boolean;
begin
 MEVacio_Apuestas:=  LO_ListaDobleEnlace.ListaVacia(me.E);
end;

{--------------------------------------------------------------------------------}

Procedure InsertarInfoME_Apuestas (var Me:ME_APUESTA; Reg:Type_APUESTA.TipoRegDatos;Pos:tPos);
var
  RegEst: LO_ListaDobleEnlace.TipoRegDatos;
  Raux,RauxAnt,RauxSig:TipoRegDatos;
  PosenDatos:TPos;
begin
  //obtengo final del archivo almacen donde se guardar� la apuesta
  PosenDatos:= filesize(Me.D);

  //se completa registro para insertar en la lista doble con  pos apuntando al registro en el almacen
  RegEst.PosenDatos:= PosenDatos;
  RegEst.Clave:= Reg.NroJugada;

  //inserto en lista doble
  LO_ListaDobleEnlace.Insertar(Me.E,RegEst,Pos);

  //grabo en almacen
  Seek (Me.D,RegEst.PosEnDatos); Write(Me.D,Reg);
end;

{--------------------------------------------------------------------------------}

procedure EliminarInfoME_Apuestas (var Me:ME_APUESTA; Pos:tPos);
begin
  LO_ListaDobleEnlace.Eliminar(me.E,pos);
end;

{--------------------------------------------------------------------------------}

procedure CapturarInfoME_Apuestas(var Me:ME_APUESTA; Pos:tPos; var Reg:Type_APUESTA.TipoRegDatos);
var
  RE: LO_ListaDobleEnlace.TipoRegDatos;
begin
  //Accediendo a la lista en la posicion parametrizada, obtengo la posicion en datos (posicion que corresponde al archivo almacen)
  LO_ListaDobleEnlace.Capturar(ME.E,Pos,RE);
  Seek(Me.D,RE.PosEnDatos); Read(Me.D,Reg);
end;

{--------------------------------------------------------------------------------}

procedure ModificarInfoME_Apuestas(var Me:ME_APUESTA; Pos:tPos; Reg:Type_APUESTA.TipoRegDatos);
var
  RE:LO_ListaDobleEnlace.TipoRegDatos;
begin
//Cuando se quiere modificar se pide la posicion de la estructura,
//se lee el registro de la estructura que trae la posicion en datos del alamcen con la informacion y ese registro sera modificado

  Seek(Me.E.D,pos);
  Read(Me.E.D,RE);

  Seek(Me.D,RE.PosEnDatos);
  Write(Me.D,Reg);
end;

{--------------------------------------------------------------------------------}

function Primero(var Me:ME_APUESTA):TPos;
var
Rc:TipoRegControl;
begin
  //Obtengo la posicion del primero que se encuentra en la estructura
  Primero:=LO_ListaDobleEnlace.primero(me.e)
end;

{--------------------------------------------------------------------------------}

function Ultimo (var Me:ME_APUESTA):TPos;
var
Rc:TipoRegControl;
begin
  //Obtengo la posicion del ultimo que se encuentra en la estructura
  Ultimo:=LO_ListaDobleEnlace.Ultimo(me.e);
end;

{--------------------------------------------------------------------------------}

function PosNula_Apuestas (var Me:ME_APUESTA): tPos;
begin
  //Obtengo la posicion nula de la estructura
  PosNula_Apuestas:=LO_ListaDobleEnlace.PosNula(me.e)
end;

{--------------------------------------------------------------------------------}

function ClaveNula_Apuestas(var Me:ME_APUESTA): tClave;
begin
  //Obtengo la clave nula de la estructura
  ClaveNula_Apuestas:=LO_ListaDobleEnlace.ClaveNula(me.e);
end;

{--------------------------------------------------------------------------------}

function Proximo(var Me:ME_APUESTA;Pos:TPos):TPos;
begin
  //Dada una posicion, obtengo la posicion del proximo que se encuentra en la estructura
  Proximo:=LO_ListaDobleEnlace.Proximo(me.e, Pos);
end;
{--------------------------------------------------------------------------------}

Function Anterior(var Me:ME_APUESTA;Pos:TPos):TPos;
begin
  //Dada una posicion, obtengo la posicion del anterior que se encuentra en la estructura
  Anterior:=LO_ListaDobleEnlace.Anterior(me.e, Pos);
end;

{--------------------------------------------------------------------------------}

Function BuscarInfoME_Apuestas(var Me:ME_APUESTA;Clave:tClave;Var pos:tPos):Boolean;
//Con la clave parametrizada se busca en la lista doble, si se encuentra devuelve la posicion sino
//la encuentra devuelve la posicion donde deberia estar esa clave
Begin
  BuscarInfoME_Apuestas:= LO_ListaDobleEnlace.Buscar(me.E,clave,pos);
End;

{--------------------------------------------------------------------------------}

//Dada una clave y un numero de jugada, obtengo el saldo total apostado por ese jugador en esa jugada
function SaldoApuestasPartida (var Me:ME_APUESTA; Clave: tclave; Jugada: tClave): tImporte;
var
i: tpos;
Reg: Type_APUESTA.TipoRegDatos;
Importe: tImporte;
begin
  Importe:= 0;
  i:= Primero(me);
  while i<>PosNula_Apuestas(me) do
  begin
    CapturarInfoME_Apuestas(me,i,Reg);

    if (reg.NroJugada= Jugada) and (reg.Nick=Clave) then
    begin
      Importe:=Importe+reg.Importe;
    end;
    i:= Proximo(me, i);
  end;

 SaldoApuestasPartida:= Importe;
end;

{--------------------------------------------------------------------------------}

END.
