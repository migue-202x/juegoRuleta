
unit Type_Hash;

Interface

Uses
  Lib_Auxiliar;
const

  _MinPosHash = 0;
  _MaxPosHash = 126; //Segun la funcion hash a utilizar que da maximo 126 (ZZZ000)

type
 tClaveHash = String [8];
 tPosHash= _MinPosHash.._MaxPosHash;

implementation


end.



