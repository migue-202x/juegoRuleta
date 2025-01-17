unit LO_Hash;

{
'Tabla hash' contiene un archivo secuencial y fijo, donde se guardara en cada registro un registro control
que apuntara a la lista de Cuentas Corrientes.
'Tabla hash' guarda en cada posicion el registro control de todas las cuentas corrientes
de aquellos jugadores que coinciden en la misma posicion de la tabla hash, posicion dada por la funcion Hash

La funcion hash toma los 6 primeros caracteres del nick y los pasa a  mayuscula.
Se lleva a cabo la conversion de cada caracter a su ordinal.
Obtiene la suma de los tres primeros ordinales para luego restarlos con los proximos tres ordinales
El resultado de la funcion hash va a ir de un rango de minima posicion y maxima posicion declaradas como constantes
Minima posicion = 0
Maxima posicion = 126
}

interface

uses

Type_Hash, LO_ListaParcialDobleEnlace, Lib_Auxiliar, SysUtils, Math;

type

  tHash = file of LO_ListaParcialDobleEnlace.TipoRegControl; //Primero, Ultimo, Borrado

  Procedure Crear (var Me:tHash;Archivo: string; ruta:string);
  procedure Abrir (var Me: tHash);
  procedure Cerrar (var Me: tHash);
  procedure Destruir (var Me: tHash);
  procedure insertar(var me:tHash; reg:TipoRegControl;pos:tpos);
  procedure modificar(var me:tHash; reg:TipoRegControl;pos:tpos);
  procedure Capturar(var Me:tHash;pos:tPos; var Reg:TipoRegControl);
  function FuncionHash(Clave:tClaveHash): tPos;

implementation


{------------------------------------------------------------------------------}

//Creo estructura Hash
Procedure Crear (var Me:tHash;Archivo: string; ruta:string);
var
  RegHash:TipoRegControl;
  FaltaDatos:Boolean;
  i:tPos;
begin
  AssignFile (me,ruta+Archivo);
   {$I-}
  Reset(me); FaltaDatos:=(ioResult<>0);
  If (FaltaDatos) then
  begin
    Rewrite(me);

    //Inicializo registro Hash para insertar en la estructura secuencial y fija
    //desde la m�nima posicion hasta la m�xima
    LO_ListaParcialDobleEnlace.InicializarCabecera(RegHash);

    For i:=_MinPosHash to _MaxPosHash do
    Begin
     seek(me,i);
     write(me,RegHash);
    end;

    Close(me);
  end;
  {$i+}
end;

{------------------------------------------------------------------------------}

function FuncionHash(Clave:tClaveHash): tPos;

var
ValorCaracter, Resultado,i:integer;
ClaveMayuscula: string;
  Begin
    //nick pasado a  mayuscula
    ClaveMayuscula:= AnsiUpperCase(clave);

    Resultado:=0;

    //recorrido 6 veces. Desde el primer caracter hasta el sexto
    for i:=1 to 6 do
    begin
      ValorCaracter:=ord(ClaveMayuscula[i]);

      //suma de los tres primeros ordinales para luego restarlos con los proximos tres ordinales
      if (i<=3) then
       Resultado:=Resultado + ValorCaracter
       else
       Resultado:=Resultado - ValorCaracter;
    end;

    if Resultado < 0 then     //Si el resultado es negativo lo paso a positivo
     Resultado:= Resultado * (-1);

    FuncionHash:= Resultado;
  End;

{------------------------------------------------------------------------------}
  
procedure Abrir (var Me: tHash);
   begin
       reset(me);
   end;

{------------------------------------------------------------------------------}

  procedure Cerrar (var Me: tHash);
   begin
      close(me);
   end;

{------------------------------------------------------------------------------}

   procedure Destruir (var Me: tHash);
   begin
      erase(me);
   end;

{------------------------------------------------------------------------------}

 procedure insertar(var me:tHash; reg:TipoRegControl;pos:tpos);
  begin
    Seek(me,pos); write(me,reg);
  end;

{------------------------------------------------------------------------------}

 procedure Capturar(var Me:tHash; pos:tPos; var Reg:TipoRegControl);
  begin
    Seek(me,pos); read(me,Reg);
  end;

{------------------------------------------------------------------------------}
  procedure modificar(var me:tHash; reg:TipoRegControl; pos:tpos);
  begin
    Seek(Me,Pos); Write(Me,Reg);
  end;

{------------------------------------------------------------------------------}

END.

