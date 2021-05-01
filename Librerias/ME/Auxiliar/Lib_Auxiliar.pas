unit Lib_Auxiliar;

interface
uses
  Sysutils;

  Const

    ApuestaMaxima = 1000;
    ApuestaMinima = 50;
    PosNula = -1;
    IniFicticios = 0;
    ClaveNula ='';
    Fict_IniNick = 'X_';

  type
    tClave         = string[8];
    tPos           = longint;
    tNivel         = 0.. maxint;
    tProfundidad   = 0.. maxint;
    tCantidad      = 0.. maxint;


Implementation

END.
