unit LO_ArbolTrinario;

{
Con Hijo Medio se enganchan todas las jugadas (ganadoras) en las que intervino el jugador,
por ello hijo medio es un registro de control que apunta hacia
una lista parcial doble enlace donde se guardan estas jugadas ganadas por el jugador ganador.
Si el jugador ganador no esta en el arbol, se agrega como nodo en el arbol y se insertar en la lista
Si ya se encuentra en el arbol se inserta solo en la lista y se actualiza el registro de control
}

interface

Uses
  LO_ListaParcialDobleEnlace, Lib_Auxiliar;

TYPE
      tNodoIndice= record
            clave:tClave;
            padre, hi, hd:tPos;
            HijoMedio: LO_ListaParcialDobleEnlace.TipoRegControl; //Control de la lista parcial
            nivel: integer;
          End;

      tControlArbol=Record
                      Raiz,Borrados:TPos;
                      Cantidad, NivelMax: TCantidad;
                      End;

      tArchivoNodos=File of tNodoIndice;
      tArchivoControlArbol=File Of tControlArbol;


      tArbolTrinario= record
          D:tArchivoNodos;
          C:tArchivoControlArbol;
        end;


  procedure CrearMe_ArbolTri (var Me:tArbolTrinario;
                         _NombreArchivoControl,_NombreArchivoIndice:String;
                         _Directorio:String); {1*}
  Procedure AbrirMe_ArbolTri(var Me:tArbolTrinario); {2*}
  Procedure CerrarMe_ArbolTri(var Me:tArbolTrinario); {3*}
  Procedure DestruirMe_ArbolTri(var Me:tArbolTrinario); {4*}
  Function Arbol_Vacio(var Me: tArbolTrinario):Boolean; {5*}
  Procedure InsertarNodo_ArbolTri(var Me:tArbolTrinario; var nodo:tNodoIndice;pos:tPos); {6*}
  Procedure EliminarNodo_ArbolTri(var Me:tArbolTrinario; pos:tPos); {7*}
  Procedure ModificarNodo_ArbolTri(var Me: tArbolTrinario; RegInd:tNodoIndice;Pos:tPos); {8*}
  Function  BuscarNodo_ArbolTri (var Me:tArbolTrinario; clave:tClave;var pos:tPos):boolean; {9*}
  Procedure CapturarNodo_ArbolTri(var Me: tArbolTrinario; var RegInd:tNodoIndice; Pos:tPos); {10}
  function PosNula_ArbolTri(Var Me:tArbolTrinario):tPos; {11}
  function Raiz_ArbolTri(var Me: tArbolTrinario): tPos; {12}
  Function Padre_ArbolTri(var Me: tArbolTrinario; var Reg: tNodoIndice): tPos; {13}
  function HijoDer_ArbolTri(var Me: tArbolTrinario; pos: tPos): tPos; {14}
  function HijoIzq_ArbolTri(var Me: tArbolTrinario; pos: tPos): tPos; {15}
  {---------------------------(BALANCEO)----------------------------------------}
  Procedure RotacionSimpleIzquierda(var me: tArbolTrinario; PosNodo: tPos); {16}  //DerechaDerecha
  Procedure RotacionSimpleDerecha(var me: tArbolTrinario; PosNodo: tPos); {17}
  Procedure RotacionCompuestaDerecha(var me: tArbolTrinario; PosNodo: tPos); {18}
  Procedure RotacionCompuestaIzquierda(var me: tArbolTrinario; PosNodo: tPos); {19}
  Function ProfundidadNodo_ArbolTri(me: tArbolTrinario; raiz: tPos): integer; {20}
  procedure ProfundidadTotal_ArbolTri(var me:tArbolTrinario; Raiz:tPos;  var Profundidad:tProfundidad); {21}
  Procedure CasoDesequilibrio_ArbolTri(me: tArbolTrinario; PosNodo: tPos); {22}
  Function FactorEquilibrio_ArbolTri(me: tArbolTrinario; PosNodo: tPos): integer; {23}
  Procedure DisminuirNiveles(var me: tArbolTrinario; raiz: tPos); {24}
  Procedure AumentarNiveles(var me: tArbolTrinario; raiz: tPos); {25}
  procedure Balancear_ArbolTri(var me: tArbolTrinario; Pos:tpos); {26}
  {-----------------------------------------------------------------------------}
  function CantidadNodos_Arbol(var Me: tArbolTrinario): tCantidad; {27}
  function ObtenerNivel_ArbolTri(var Me: tArbolTrinario; clave:tClave):tCantidad; {28}



VAR
  Me: tArbolTrinario;


implementation

{----------------------------------------(1)----------------------------------------}

procedure CrearMe_ArbolTri (var Me:tArbolTrinario;
                       _NombreArchivoControl,_NombreArchivoIndice:String;
                       _Directorio:String);
Var
  ioC,ioI:integer;
  Rc: tControlArbol;

begin
  assignFile (Me.C, _Directorio + _NombreArchivoControl);
  assignFile (Me.D, _Directorio + _NombreArchivoIndice);
  {$i-}
  reset(Me.C); ioC:=IoResult; //Si IoResult es cero, la operacion es exitosa
  reset(Me.D); ioI:=IoResult;

  if (IoC<>0) or (ioI<>0) then
  begin
    Rewrite(Me.C);
    RC.Raiz:=Lib_Auxiliar.PosNula;
    RC.Borrados:=Lib_Auxiliar.PosNula;
    Rc.Cantidad:= 0;
    Write(Me.C,RC);
    ReWrite(Me.D);
  end;
  Close(Me.D);
  Close(Me.C);
  {$I+}
end;


{----------------------------------------(2)----------------------------------------}

procedure AbrirMe_ArbolTri(var Me:tArbolTrinario);
begin
  Reset(Me.C);
  Reset(Me.D);
end;

{----------------------------------------(3)----------------------------------------}

procedure CerrarMe_ArbolTri(var Me:tArbolTrinario);
begin
  Close(Me.D);
  Close(Me.C);
end;

{----------------------------------------(4)----------------------------------------}

procedure DestruirMe_ArbolTri(var Me:tArbolTrinario);
begin
  Erase(Me.D);
  Erase(Me.C);
end;

{----------------------------------------(5)----------------------------------------}

Function Arbol_Vacio(var Me: tArbolTrinario):Boolean;
var
  Rc:tControlArbol;
begin
  Seek(Me.C,0); Read(Me.c, Rc);
  Arbol_Vacio:=  (Rc.Raiz = Lib_Auxiliar.PosNula) ;
end;

{----------------------------------------(6)----------------------------------------}

Procedure InsertarNodo_ArbolTri(var Me:tArbolTrinario; var nodo:tNodoIndice;pos:tPos);//pos, posicion fisica de su padre
var
	posnueva:tPos;
	reg,rd:tNodoIndice;
	RC:tControlArbol;
  NodoMedio: boolean;
begin
  NodoMedio:= false;
  seek(Me.C,0); read(Me.C,RC);
  if RC.borrados=Lib_Auxiliar.PosNula then //No hay borrados
  begin
    posnueva:=filesize(Me.D);
	end
  else //Hay borrados
   begin
     Posnueva:=RC.Borrados;
     seek(Me.D,posnueva); read(Me.D,rD);
     RC.Borrados:=rD.hi;
	  end;

   if (RC.Raiz=Lib_Auxiliar.PosNula) then//Inserto En �rbol vacio
   begin
		nodo.padre:=Lib_Auxiliar.PosNula;
		nodo.hi:=Lib_Auxiliar.PosNula;
	  nodo.hd:=Lib_Auxiliar.PosNula;
    nodo.nivel:=1;
	  RC.Raiz:=posnueva;
   end
   //Grabamos al final
   else //Inserto como hoja
     begin
      seek(Me.D,pos); read(Me.D,reg); //leo el registro del padre
      nodo.padre:= pos;
      nodo.hd:= Lib_Auxiliar.PosNula;
      nodo.hi:= Lib_Auxiliar.PosNula;
      nodo.nivel:=Reg.Nivel+1;

      //Si el nodo a insertar es la misma que la de su padre, entonces significa que voy a insertar al medio
      if nodo.Clave = reg.Clave then
             NodoMedio:= true;
      if (nodo.clave<=reg.clave) then
      begin
        reg.hi:=posnueva;
      end
      else
        begin
          reg.hd:=posnueva;
        end;
        seek(Me.d,pos); write(Me.d,reg);
     end;

    if NodoMedio then   //actualizo las poosiciones del nodo que se va a insertar al medio
    begin
      posNueva:= pos;
      nodo.Hi:= reg.Hi;
      nodo.Hd:= reg.Hd;
      nodo.Padre:= reg.Padre;
      nodo.Nivel:= reg.Nivel;
      rc.Cantidad:= rc.Cantidad-1;
    end
    else  //Si no inserto al medio, entonces inicializo todas las posiciones
      begin
        LO_ListaParcialDobleEnlace.InicializarCabecera(nodo.HijoMedio);
        nodo.Hi:=Lib_Auxiliar.PosNula;
        nodo.Hd:=Lib_Auxiliar.PosNula;
      end;

     //Si la profuncididad del nodo es mayor a la prfundidad en el control actualizo.
  If nodo.nivel > RC.NivelMax then
    RC.NivelMax := nodo.nivel;

		rc.cantidad:=rc.cantidad+1;
		seek(Me.d,posnueva); write(Me.d,nodo); //se escribe el elemento en el archivo
		seek(Me.c,0); write(Me.c,rc);	// se actualiza el registro control

    //pregunto por el balanceo del �rbol
   Balancear_ArbolTri(me, PosNueva);
end;


{----------------------------------------(7)----------------------------------------}
Procedure EliminarNodo_ArbolTri(var Me:tArbolTrinario; pos:tPos);
var
	RD:tNodoIndice;
	RC:tControlArbol;
  rAux,RHD,RDP,RHI:tNodoIndice;
  posAux:tPos;

begin
	seek(Me.c,0); read(Me.c,rc);
	seek(Me.d,pos); read(Me.d,rd);   //Capturo el registro a eliminar

  //no tiene padre, no tiene hijos
	if (pos=rc.raiz) and (rd.hi=Lib_Auxiliar.PosNula) and (rd.hd=Lib_Auxiliar.PosNula) then
	begin
		Rc.Raiz:=Lib_Auxiliar.PosNula;
	end
	else
	  begin
		  if (rd.hi=Lib_Auxiliar.PosNula) and (rd.hd=Lib_Auxiliar.PosNula) then //Tiene padre, no tiene hijos. Eliminar de una hoja
		  begin
			  Seek(Me.D,rd.padre);read(Me.d,rdp);
        If rdp.hi=pos then
          rdp.hi:=Lib_Auxiliar.PosNula
        else
          rdp.hd:=Lib_Auxiliar.PosNula;

		    Seek(Me.d,rd.padre);write(Me.d,RDP);
    end
		else
		  begin
			  if (rd.hi <> Lib_Auxiliar.PosNula) and (rd.hd <> Lib_Auxiliar.PosNula) then //Caso general, tiene padre y tiene hijos...
			  begin
          If pos<>RC.raiz then //...no es raiz
          begin
            Seek(Me.d,rd.padre);read(Me.d,rdp);
            If rdp.hi=pos then
              rdp.hi:=rd.hd
            else
              rdp.hd:=rd.hd;

            Seek(Me.d,RD.padre);Write(Me.d,rdp);
        end
        else
          RC.raiz:=rd.hd;

        Seek(Me.d,rd.hd);read(Me.d,RHD);
        RHD.padre:=RD.padre;
        posAux:=RD.hd;
        rAux:=RHD;

        While rAux.hi<>Lib_Auxiliar.PosNula do
        begin
          Seek(Me.d,posAux);read(Me.d,RAux);
          If raux.hi<>Lib_Auxiliar.PosNula then
            posaux:=rAux.hi;
        end;

        Seek(Me.d,RD.hi);Read(Me.d,RHI);
        RHI.padre:=posAux;
        RAux.hi:=RD.hi;
        Seek(Me.d,RD.hi);Write(Me.d,RHI);
        Seek(Me.d,posAux);Write(Me.d,raux);
        If posAux<>RD.hd then
        begin
         Seek(Me.d,RD.hd);Write(Me.d,RHD);
        end;
 			end
      else
			  begin
          If pos<>RC.Raiz then
          begin
            Seek(Me.D,RD.padre);Read(Me.D,RDP);
            If RDP.hi=pos then
            begin
              If RD.hi=Lib_Auxiliar.PosNula then
              begin
                Rdp.hi:=RD.hd;
                Seek(Me.D,RD.hd);read(Me.d,RHD);
                RHD.padre:=RD.padre;
                Seek(Me.d,RD.hd);write(Me.d,RHD);
              end
              else
                begin
                  Rdp.hi:=RD.hi;
                  Seek(Me.D,RD.hi);read(Me.d,RHI);
                  RHI.padre:=RD.padre;
                  Seek(Me.d,RD.hi);write(Me.d,RHI);
                end
           end
           else
             If RD.hi=Lib_Auxiliar.PosNula then
              begin
                Rdp.hd:=RD.hd;
                Seek(Me.D,RD.hd);read(Me.d,RHD);
                RHD.padre:=RD.padre;
                Seek(Me.d,RD.hd);write(Me.d,RHD);
              end
              else
               begin
                Rdp.hd:=RD.hi;
                Seek(Me.D,RD.hi);read(Me.d,RHI);
                RHI.padre:=RD.padre;
                Seek(Me.d,RD.hi);write(Me.d,RHI);
               end;
          Seek(Me.d,rd.padre);write(Me.d,rdp);
        end
        else
          If RD.hi=Lib_Auxiliar.PosNula then
            RC.Raiz:=RD.hd
          else
            RC.raiz:=RD.hi;
			end;
		end;
	end;
  RD.hi:=RC.borrados;
  RD.hd:=RC.borrados;
	RC.borrados:=pos;
  RC.Cantidad:=RC.Cantidad-1;
  Seek(Me.c,0);write(Me.c,rc); //Grabo la cabecera de control
end;



{----------------------------------------(8)----------------------------------------}

Procedure ModificarNodo_ArbolTri(var Me: tArbolTrinario; RegInd:tNodoIndice;Pos:tPos);
begin
  seek(Me.D,pos); write(Me.D,RegInd);
end;

{----------------------------------------(9)----------------------------------------}

Function  BuscarNodo_ArbolTri (var Me:tArbolTrinario; clave:tClave;var pos:tPos):boolean; //Buscar iterativo
var
	reg:tNodoIndice;
	RC:tControlArbol;
	encont:boolean;
	posPadre:tpos;
begin
	seek(Me.c,0); read(Me.c,rc);
	pos:=rc.raiz; encont:=false;
	posPadre:=Lib_Auxiliar.PosNula;
	while (not encont) and (pos<>Lib_Auxiliar.PosNula) do
	begin
		seek(Me.d,pos); read(Me.d,reg);
		if (clave=reg.clave) then
		begin
			encont:=true;
		end
		else
		begin
			if (reg.clave>clave) then
			begin
				posPadre:=pos;
				pos:=reg.hi;
			end
			else
			begin
				posPadre:=pos;
				pos:=reg.hd;
			end;
		end;
	end;
	if (not encont) then
	begin
		pos:=posPadre;
	end;
	BuscarNodo_ArbolTri:=encont;
end;

{----------------------------------------(10)----------------------------------------}

Procedure CapturarNodo_ArbolTri(var Me: tArbolTrinario; var RegInd:tNodoIndice; Pos:tPos);
begin
  seek(Me.D,Pos); Read(Me.D,RegInd);
end;

{----------------------------------------(11)----------------------------------------}

function PosNula_ArbolTri(Var Me:tArbolTrinario):tPos;
begin
  PosNula_ArbolTri:= Lib_Auxiliar.PosNula;
end;


{----------------------------------------(12)----------------------------------------}

function Raiz_ArbolTri(var Me: tArbolTrinario): tPos;
var
  Rc: tControlArbol;
begin
  Seek(Me.c, 0); Read(Me.c, Rc);
  Raiz_ArbolTri:= Rc.Raiz;
end;

{----------------------------------------(13)----------------------------------------}

Function Padre_ArbolTri(var Me: tArbolTrinario; var Reg: tNodoIndice): tPos;
begin
 Padre_ArbolTri:= Reg.padre;
end;

{----------------------------------------(14)----------------------------------------}

function HijoDer_ArbolTri(var Me: tArbolTrinario; pos: tPos): tPos;
var
reg: tNodoIndice;
begin
  seek(me.D,pos); read(me.D,reg);
  HijoDer_ArbolTri:= reg.hd;
end;


{----------------------------------------(15)----------------------------------------}

function HijoIzq_ArbolTri(var Me: tArbolTrinario; pos: tPos): tPos;
var
reg: tNodoIndice;
begin
  seek(me.D,pos); read(me.D,reg);
  HijoIzq_ArbolTri:= reg.hi;
end;


{----------------------------------------(16)----------------------------------------}

//Rotacion en arbol tambien conocido como 'Rotacion Derecha-Derecha'
Procedure RotacionSimpleIzquierda (var me: tArbolTrinario; PosNodo: tPos);
Var
  NodoArriba,NodoAbajo,NodoAnterior:tNodoIndice;
  RC:tControlArbol;
  PosAux:tPos;
begin

  Seek (me.D,PosNodo); Read (me.D,NodoArriba);
  Seek (me.D,NodoArriba.hd); Read (me.D,NodoAbajo);
  Seek (me.C,0);Read(me.C,RC);

  //Cambio enlaces
  PosAux:=NodoAbajo.hi;
  NodoAbajo.padre:=NodoArriba.padre;
  NodoAbajo.hi:=PosNodo;
  NodoArriba.padre:=NodoArriba.hd;
  NodoArriba.hd := PosAux; ;

  //Si el desbalanceado no era ra�z
  If NodoAbajo.padre <> Lib_Auxiliar.PosNula then
  begin
    //Me paro en el padre del hijo desbalanceado, y le pongo como hijo al que era su nieto
    Seek (Me.D,NodoAbajo.padre); Read (Me.D,NodoAnterior);
    If NodoAnterior.hd = PosNodo then
      NodoAnterior.hd :=NodoArriba.padre
    Else
      NodoAnterior.hi :=NodoArriba.padre;
    Seek (Me.D,NodoAbajo.padre); Write (Me.D,NodoAnterior);
  end;

  //Cambio niveles
  NodoAbajo.nivel:=NodoAbajo.nivel-1;
  NodoArriba.nivel := NodoArriba.nivel+1;

  //Verifico que el del problema no haya sido la raiz
  //Anteriormeente a NodoArriba.padre le da NodoAbajo.hdecho. Por lo tanto, pone como nueva raiz
  //al hijo derecho del que estaba desbalanceado.
  If PosNodo=RC.Raiz then
    RC.raiz := NodoArriba.padre;

  Seek (Me.D,PosNodo); Write (Me.D,NodoArriba);
  Seek (Me.D,NodoArriba.padre); Write (Me.D,NodoAbajo);
  Seek (Me.C,0);Write(Me.C,RC);

  DisminuirNiveles(me, NodoAbajo.hd);
  AumentarNiveles(me, NodoArriba.hi);
end;


{----------------------------------------(17)----------------------------------------}

//Rotacion en arbol tambien conocido como 'Rotacion Izquierda-Izquierda'
Procedure RotacionSimpleDerecha(var me: tArbolTrinario; PosNodo: tPos);
Var
  NodoArriba,NodoAbajo,NodoAnterior:tNodoIndice;
  RC:tControlArbol;
  PosAux:tPos;
begin

  Seek (me.D,PosNodo); Read (me.D,NodoArriba);
  Seek (me.D,NodoArriba.hi); Read (me.D,NodoAbajo);
  Seek (me.C,0);Read(me.C,RC);

  {Cambio enlaces}
  PosAux:=NodoAbajo.hd;
  NodoAbajo.padre:=NodoArriba.padre;
  NodoAbajo.hd:=PosNodo;
  NodoArriba.padre:=NodoArriba.hi;
  NodoArriba.hi := PosAux; ;

  If NodoAbajo.padre <> Lib_Auxiliar.PosNula then
  begin
    Seek (Me.D,NodoAbajo.padre); Read (Me.D,NodoAnterior);
    If NodoAnterior.hd = PosNodo then
      NodoAnterior.hd :=NodoArriba.padre
    Else
      NodoAnterior.hi :=NodoArriba.padre;
    Seek (Me.D,NodoAbajo.padre); Write (Me.D,NodoAnterior);
  end;

  {Cambio el campo nivel}
  NodoAbajo.nivel:= NodoAbajo.nivel-1;
  NodoArriba.nivel := NodoArriba.nivel+1;

  {Verifico que el del drama no haya sido la raiz}
  If PosNodo=RC.Raiz then
    RC.raiz := NodoArriba.padre;

  Seek (Me.D,PosNodo); Write (Me.D,NodoArriba);
  Seek (Me.D,NodoArriba.padre); Write (Me.D,NodoAbajo);
  Seek (Me.C,0);Write(Me.C,RC);

  DisminuirNiveles(me, NodoAbajo.hi);
  AumentarNiveles(me, NodoArriba.hd);
end;



{----------------------------------------(18)----------------------------------------}

//Rotacion en arbol tambien conocido como 'Rotacion Izquierda-Derecha'
Procedure RotacionCompuestaDerecha(var me: tArbolTrinario; PosNodo: tPos);
Var
  NodoArriba,NodoMedio,NodoAbajo,NodoAnterior:tNodoIndice;
  RC:tControlArbol;
  PosAux,PosMedio,PosAbajo:tPos;
begin

  Seek (Me.D,PosNodo); Read (Me.D,NodoArriba);
  Seek (Me.D,NodoArriba.hi); Read (Me.D,NodoMedio);
  Seek (Me.D,NodoMedio.hd); Read (Me.D,NodoAbajo);
  Seek (Me.C,0);Read(Me.C,RC);

  PosMedio:=NodoArriba.hi;
  PosAbajo:=NodoMedio.hd;
  PosAux:=NodoArriba.padre;

  NodoArriba.padre:=NodoMedio.hd ;
  NodoArriba.hi:=NodoAbajo.hd;

  NodoMedio.padre:=NodoMedio.hd;
  NodoMedio.hd:= NodoAbajo.hi;

  NodoAbajo.padre:=PosAux;
  NodoAbajo.hd:=PosNodo;
  NodoAbajo.hi:=PosMedio;

  If NodoAbajo.padre <> Lib_Auxiliar.PosNula then
  begin
    Seek (Me.D,NodoAbajo.padre); Read (Me.D,NodoAnterior);
    If NodoAnterior.hd = PosNodo then
      NodoAnterior.hd :=PosAbajo
    Else
      NodoAnterior.hi :=PosAbajo;
    Seek(Me.D,NodoAbajo.padre); Write (Me.D,NodoAnterior);
  end;
  {Cambio el campo nivel}
  NodoAbajo.nivel:=NodoAbajo.nivel-2;
  NodoArriba.nivel:= NodoArriba.nivel+1;

  {Verifico que el del drama no haya sido la raiz}
  If PosNodo=RC.Raiz then
    RC.raiz := NodoArriba.padre;

  Seek (Me.D,PosNodo); write (Me.D,NodoArriba);
  Seek (Me.D,PosMedio); write (Me.D,NodoMedio);
  Seek (Me.D,PosAbajo); write (Me.D,NodoAbajo);
  Seek (Me.C,0); Write(Me.C,RC);

  DisminuirNiveles(me, NodoArriba.hi);
  AumentarNiveles(me, NodoArriba.hd);
  DisminuirNiveles(me, NodoMedio.hd);
end;


{----------------------------------------(19)----------------------------------------}

//Rotacion en arbol tambien conocido como 'Rotacion Derecha-Izquierda'
Procedure RotacionCompuestaIzquierda(var me: tArbolTrinario; PosNodo: tPos);
Var
  NodoArriba,NodoMedio,NodoAbajo,NodoAnterior:tNodoIndice;
  RC:tControlArbol;
  PosAux,PosMedio,PosAbajo:tPos;
begin

  Seek (Me.D,PosNodo); Read (Me.D,NodoArriba);
  Seek (Me.D,NodoArriba.hd); Read (Me.D,NodoMedio);
  Seek (Me.D,NodoMedio.hi); Read (Me.D,NodoAbajo);
  Seek (Me.C,0);Read(Me.C,RC);

  PosMedio:=NodoArriba.hd;
  PosAbajo:=NodoMedio.hi;
  PosAux:=NodoArriba.padre;

  NodoArriba.padre:=NodoMedio.hi;
  NodoArriba.hd:=NodoAbajo.hi;

  NodoMedio.padre:=NodoMedio.hi;
  NodoMedio.hi:= NodoAbajo.hd;

  NodoAbajo.padre:=PosAux;
  NodoAbajo.hi:=PosNodo;
  NodoAbajo.hd:=PosMedio;

  If NodoAbajo.padre <> Lib_Auxiliar.PosNula then
  begin
    Seek (Me.D,NodoAbajo.padre); Read (Me.D,NodoAnterior);
    If NodoAnterior.hd = PosNodo then
      NodoAnterior.hd :=PosAbajo
    Else
      NodoAnterior.hi :=PosAbajo;
    Seek (Me.D,NodoAbajo.padre); Write (Me.D,NodoAnterior);
  end;
  {Cambio el campo nivel}
  NodoAbajo.nivel:=NodoAbajo.nivel-2;
  NodoArriba.nivel:= NodoArriba.nivel+1;

  {Verifico que el del drama no haya sido la raiz}
  If PosNodo=RC.Raiz then
    RC.raiz := NodoArriba.padre;

  Seek (Me.D,PosNodo); write (Me.D,NodoArriba);
  Seek (Me.D,PosMedio); write (Me.D,NodoMedio);
  Seek (Me.D,PosAbajo); write (Me.D,NodoAbajo);
  Seek (Me.C,0);Write (Me.C,RC);

  DisminuirNiveles(me, NodoArriba.hd);
  AumentarNiveles(me, NodoArriba.hi);
  DisminuirNiveles(me, NodoMedio.hi);
end;

{----------------------------------------(20)----------------------------------------}

Function ProfundidadNodo_ArbolTri(me: tArbolTrinario; raiz: tPos): integer;
var
 Profundidad:tProfundidad;
 Nodo:tNodoIndice;
Begin
  //Dada una posici�n, devuelve la profundidad (nivel) en el que se encuentra}
  Profundidad := 0;
  CapturarNodo_ArbolTri(me, nodo, raiz);
  ProfundidadTotal_ArbolTri(me, raiz, Profundidad);
  result:= (Profundidad - nodo.nivel) + 1;
End;

{----------------------------------------(21)----------------------------------------}

procedure ProfundidadTotal_ArbolTri(var me:tArbolTrinario; Raiz:tPos;
  var Profundidad:tProfundidad);

var
 Nodo: tNodoIndice;

 begin
   If Raiz <> Lib_Auxiliar.PosNula then
    begin
    // Primero recursivo tendiendo a la Izquierda
    ProfundidadTotal_ArbolTri(me, HijoIzq_ArbolTri(me, raiz), Profundidad);
    // Recursividad tendiendo a la Derecha.
    ProfundidadTotal_ArbolTri(me, HijoDer_ArbolTri(me, raiz), Profundidad);

    // Guardo en Nodo el nodo indice.
    CapturarNodo_ArbolTri(me, nodo, raiz);

    If Nodo.nivel > Profundidad then
      Profundidad := Nodo.nivel;
    end;
 end;


{----------------------------------------(22)----------------------------------------}


Procedure CasoDesequilibrio_ArbolTri(me: tArbolTrinario; PosNodo: tPos);
var
  Nodo: tNodoIndice;
  begin

    CapturarNodo_ArbolTri(me, Nodo, PosNodo);

    If FactorEquilibrio_ArbolTri(me, PosNodo) >= 0 then
   //Si el factor de equilibrio es positivo, esta cargado a la izquierda..., reviso con hijo izquierda
    begin
      If FactorEquilibrio_ArbolTri(me, Nodo.hi) >= 0 then //Si el factor de equilibrio del hijo izq es positivo, hago una RotacionSimpleDerecha
        RotacionSimpleDerecha(me, PosNodo)
      Else  //...si es negativo, hago una RotacionCompuestaDerecha
        RotacionCompuestaDerecha(me, PosNodo);
    end
    else
     begin
      If FactorEquilibrio_ArbolTri(me, Nodo.hd) >= 0 then  //Si el factor de equilibrio del hijo der es positivo, hago una RotacionCompuestaIzquierda
       RotacionCompuestaIzquierda(me, PosNodo)
        else //...si es negativo, hago una RotacionSimpleIzquierda
         RotacionSimpleIzquierda(me, PosNodo);
     end;
  end;

{----------------------------------------(23)----------------------------------------}


Function FactorEquilibrio_ArbolTri(me: tArbolTrinario; PosNodo: tPos): integer;
var
  Nodo: tNodoIndice;
  Ti, Td: integer;
begin
  If PosNodo = Lib_Auxiliar.PosNula then
    FactorEquilibrio_ArbolTri := 0
  Else
  begin
    // Guardo en Nodo el nodo indice.
   CapturarNodo_ArbolTri(me, Nodo, PosNodo);

    // Calculo la profundidad de ambos hijos.
    If Nodo.hi <> Lib_Auxiliar.PosNula then
      Ti := ProfundidadNodo_ArbolTri(me, Nodo.hi)
    Else
      Ti := 0;
    If Nodo.hd <> Lib_Auxiliar.PosNula then
      Td := ProfundidadNodo_ArbolTri(me, Nodo.hd)
    Else
      Td := 0;

    {Factor_Equilibrio = La altura del subarbol derecho menos la altura del subarbol izquierdo para ese nodo
    dabe ser <=1 para estar equilibrado}
    FactorEquilibrio_ArbolTri := Ti - Td;
  end;
end;


{----------------------------------------(24)----------------------------------------}

Procedure DisminuirNiveles(var me: tArbolTrinario; raiz: tPos);
var
  Nodo: tNodoIndice;
begin
  If raiz <> Lib_Auxiliar.PosNula then
  begin
  // Primero recursivo hacia la Izquierda
  DisminuirNiveles(me, HijoIzq_ArbolTri(me, raiz));
  CapturarNodo_ArbolTri(me, nodo, raiz);
  Nodo.nivel := Nodo.nivel - 1;
  seek(me.D, raiz);
  Write(me.D, Nodo);
  // Recursividad hacia la Derecha
  DisminuirNiveles(me, HijoDer_ArbolTri(me, raiz));
  end;
end;

{----------------------------------------(25)----------------------------------------}

Procedure AumentarNiveles(var me: tArbolTrinario; raiz: tPos);
var
  Nodo: tNodoIndice;
begin
  If raiz <> Lib_Auxiliar.PosNula then
   begin
    // Primero recursivo hacia la Izquierda
    AumentarNiveles(me, HijoIzq_ArbolTri(me, raiz));
    CapturarNodo_ArbolTri(me, nodo, raiz);
    Nodo.nivel := Nodo.nivel + 1;
    seek(me.D, raiz);
    Write(me.D, Nodo);
    // Recursividad hacia la Derecha.
    AumentarNiveles(me, HijoDer_ArbolTri(me, raiz));
   end;
end;

{----------------------------------------(26)----------------------------------------}

procedure Balancear_ArbolTri(var me: tArbolTrinario; Pos:tpos);
var
  Nodo: tNodoIndice;
  result:Integer;

begin
  CapturarNodo_ArbolTri(me,Nodo,pos);
  pos:=Nodo.Padre;

  while (pos<>Lib_Auxiliar.PosNula) do
  Begin
    Result := FactorEquilibrio_ArbolTri(me, Pos);
    If Result < 0 then
      Result := Result * (-1);

    If (Result > 1) then
      CasoDesequilibrio_ArbolTri(me,pos);

     CapturarNodo_ArbolTri(me,Nodo,pos);
     pos:=Nodo.Padre;
   End;
end;

{----------------------------------------(27)----------------------------------------}

function CantidadNodos_Arbol(var Me: tArbolTrinario): tCantidad;
var
  Rc: tControlArbol;
begin
  Seek(Me.c, 0); Read(Me.c, Rc);
  CantidadNodos_Arbol:= Rc.Cantidad;
end;

{----------------------------------------(28)----------------------------------------}

function ObtenerNivel_ArbolTri(var Me: tArbolTrinario; clave:tClave):tCantidad;
var
  pos:tPos;
  Nodo: tNodoIndice;
begin
 if BuscarNodo_ArbolTri(Me, clave, pos) then
  begin
    seek(me.D,pos); read(me.D,Nodo);
    ObtenerNivel_ArbolTri:= Nodo.Nivel;
  end;
end;


END.


