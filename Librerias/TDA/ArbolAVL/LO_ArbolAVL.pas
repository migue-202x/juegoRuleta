
unit LO_ArbolAVL;

{
Un �rbol AVL es aquel que por cada nodo la altura del sub�rbol izquierdo menos la altura del sub�rbol derecho difiera a lo sumo en 1
Antes de insertar hace un buscar, que sino encuentra la clave devuelvo posicion del padre
Es por eso que al insertar el pos parametrizado corresponde a la posicion fisica del padre y parado en el ve si corresponde que sea el hijo izquierdo o el hijo derecho
Una vez insertado el nodo, pregunto por el balanceo del �rbol.
Se pregunta por el balanceo de cada nodo desde el nodo padre del reci�n insertado hasta la ra�z
Un nodo esta balanceado si su factor de equilibrio es -1, 1 o 0.., teniendo presenete que el factor de equilibrio de un �rbol binario es la diferencia en altura entre los sub�rboles derecho e izquierdo.
Para ello la funcion 'factor de equilibrio' va a verificar que el nodo este equilibrado. Si un nodo esta desequilibrado, se invoca a �Caso Desquilibrio� donde verifica que tipo de rotaci�n se llevara a cabo para balancear dicho nodo
Si un nodo esta desequilibrado, se invoca a �Caso Desquilibrio� donde verifica que tipo de rotaci�n se llevara a cabo para balancear dicho nodo.
Si el factor de equilibrio del nodo desbalanceado es positivo, est� cargado a la izquierda..., se revisa con hijo izquierdo
Si el factor de equilibrio del hijo izquierdo es positivo, se lleva a cabo una RotacionSimpleDerecha sino una RotacionCompuestaDerecha

En el caso de que el factor de equilibrio del nodo desbalanceado es negativo, significa que est� cargado a la derecha...,
se revisa con hijo derecho. Si el factor de equilibrio del hijo derecho es positivo, se hace una RotacionCompuestaIzquierda sino
una RotacionSimpleIzquierda
}



interface

USES
   SysUtils, Lib_Auxiliar;

TYPE

  tNodoIndice = record
                  clave:tClave;
                  padre, hi, hd:tPos;
                  nivel:integer;
                  PosEnDatos:tPos;
                end;

	tControlArbol= record
                    Raiz,Borrados: tPos;
                    Cantidad, NivelMax: TCantidad;
                    ficticio: tCantidad;
                  end;


  tArchivoNodos= file of tNodoIndice;
  tArchivoControlArbol= file of tControlArbol;


  tArbol= record
                  D:tArchivoNodos;
                  C:tArchivoControlArbol;
                end;



  procedure CrearMe_Arbol (var Me:tArbol;
                         _NombreArchivoControl,_NombreArchivoIndice:String;
                         _Directorio:String); {1}
  Procedure AbrirMe_Arbol(var Me:tArbol); {2}
  Procedure CerrarMe_Arbol(var Me:tArbol); {3}
  Procedure DestruirMe_Arbol(var Me:tArbol); {4}
  Function Arbol_Vacio(var Me: tArbol):Boolean; {5}
  Procedure InsertarNodo_Arbol(var Me:tArbol; nodo:tNodoIndice;pos:tPos; tipo:boolean); {6}
  Procedure EliminarNodo_Arbol(var Me:tArbol; pos:tPos); {7}
  Procedure ModificarNodo_Arbol(var Me: tArbol; RegInd:tNodoIndice;Pos:tPos); {8}
  Function  BuscarNodo_Arbol (var Me:tArbol; clave:tClave;var pos:tPos):boolean; {9}
  Procedure CapturarNodo_Arbol(var Me: tArbol; var RegInd:tNodoIndice; Pos:tPos); {10}
  function PosNula_Arbol(Var Me:tArbol):tPos; {11}
  function Raiz_Arbol(var Me: tArbol): tPos; {12}
  Function Padre_Arbol(var Me: tArbol; var Reg: tNodoIndice): tPos; {13}
  function HijoDer_Arbol(var Me: tArbol; pos: tPos): tPos; {14}
  function HijoIzq_Arbol(var Me: tArbol; pos: tPos): tPos; {15}
  {---------------------------(BALANCEO)----------------------------------------}
  Procedure RotacionSimpleIzquierda(var me: tArbol; PosNodo: tPos); {16}
  Procedure RotacionSimpleDerecha(var me: tArbol; PosNodo: tPos); {17}
  Procedure RotacionCompuestaDerecha(var me: tArbol; PosNodo: tPos); {18}
  Procedure RotacionCompuestaIzquierda(var me: tArbol; PosNodo: tPos); {19}
  Function ProfundidadNodo_Arbol(me: tArbol; raiz: tPos): integer; {20}
  procedure ProfundidadTotal_Arbol(var me:tArbol; Raiz:tPos;  var Profundidad:tProfundidad); {21}
  Procedure CasoDesequilibrio_Arbol(me: tArbol; PosNodo: tPos); {22}
  Function FactorEquilibrio_Arbol(me: tArbol; PosNodo: tPos): integer; {23}

  Procedure DisminuirNiveles(var me: tArbol; raiz: tPos); {24}
  Procedure AumentarNiveles(var me: tArbol; raiz: tPos); {25}
  procedure Balancear_Arbol(var me: tArbol; Pos:tpos); {26}
  {-----------------------------------------------------------------------------}
  function UltFicticio_Arbol(var Me: tArbol): tCantidad; {27}
  function CantidadNodos_Arbol(var Me: tArbol): tCantidad; {28}
  function ObtenerNivel_Arbol(var Me:tArbol; clave:tClave): tCantidad; {29}


VAR
  Me: tArbol;


implementation

{----------------------------------------(1)----------------------------------------}

procedure CrearMe_Arbol (var Me:tArbol;
                       _NombreArchivoControl,_NombreArchivoIndice:String;
                       _Directorio:String);
Var
  ioC,ioD:integer;
  Rc: tControlArbol;

begin
  //AssignFile reemplaza el procedimiento Assign que estaba disponible en las primeras versiones de Delphi.
  assignFile (Me.C, _Directorio + _NombreArchivoControl);
  assignFile (Me.D, _Directorio + _NombreArchivoIndice);
  {$i-}
  reset(Me.C); ioC:=IoResult; //Si IoResult es cero, la operacion es exitosa
  reset(Me.D); ioD:=IoResult;

  if (IoC<>0) or (ioD<>0) then
  begin
    Rewrite(Me.C);
    ReWrite(Me.D);
    RC.Raiz:=Lib_Auxiliar.PosNula;
    RC.Borrados:=Lib_Auxiliar.PosNula;
    RC.ficticio:= Lib_Auxiliar.IniFicticios;
    Rc.Cantidad:= 0;
    Write(Me.C,RC);
  end;
  Close(Me.D);
  Close(Me.C);
  {$I+}
end;


{----------------------------------------(2)----------------------------------------}

procedure AbrirMe_Arbol(var Me:tArbol);
begin
  Reset(Me.C);
  Reset(Me.D);
end;

{----------------------------------------(3)----------------------------------------}

procedure CerrarMe_Arbol(var Me:tArbol);
begin
  Close(Me.D);
  Close(Me.C);
end;

{----------------------------------------(4)----------------------------------------}

procedure DestruirMe_Arbol(var Me:tArbol);
begin
  Erase(Me.D);
  Erase(Me.C);
end;

{----------------------------------------(5)----------------------------------------}

Function Arbol_Vacio(var Me: tArbol):Boolean;
var
  Rc:tControlArbol;
begin
  Seek(Me.C,0); Read(Me.c, Rc);
  Arbol_Vacio:=  (Rc.Raiz = Lib_Auxiliar.PosNula) ;
end;

{----------------------------------------(6)----------------------------------------}

Procedure InsertarNodo_Arbol(var Me:tArbol; nodo:tNodoIndice; pos:tPos; tipo:boolean);
  //Antes de insertar hace un buscar, que sino encuentra la clave devuelvo posicion del padre
  //Es por eso que al insertar el pos parametrizado corresponde a la posicion fisica del padre
  //y parado en el ve si corresponde que sea el hijo izquierdo o el hijo derecho
var
	posnueva:tPos;
	reg,rd:tNodoIndice;
	RC:tControlArbol;
begin
  seek(Me.C,0); read(Me.C,RC);

  if (RC.borrados = Lib_Auxiliar.PosNula) then //no hay borrados
  begin
    posnueva:=filesize(Me.D);
	end
  else //hay borrados
    begin
      Posnueva:= RC.Borrados;
      seek(Me.D,posnueva); read(Me.D,rD);
      RC.Borrados:= rD.hi;
	  end;
   //Grabo al final ...

   if (RC.Raiz=Lib_Auxiliar.PosNula) then//inserto en �rbol vacio
   begin
    RC.Raiz:= posnueva;
    nodo.padre:= Lib_Auxiliar.PosNula;
    nodo.hi:= Lib_Auxiliar.PosNula;
    nodo.hd:= Lib_Auxiliar.PosNula;
    nodo.nivel:= 1;
   end
   else //inserto como hoja
     begin
      seek(Me.D,pos); read(Me.D,reg);

      nodo.padre:= pos;
      nodo.hd:= Lib_Auxiliar.PosNula;
      nodo.hi:= Lib_Auxiliar.PosNula;
      nodo.nivel:= Reg.Nivel+1;

      //si la clave del nodo a insertar es menor a la clave del nodo padre,
      //entonces la posicion nueva la tendra su hijo izquierdo (su hijo izquierdo estar� al final f�sico)
      if (nodo.clave < reg.clave) then
      begin
        reg.hi:=posnueva;
      end
      else //la clave del nodo a insertar es mayor a la clave del nodo padre, entonces la posicion nueva la tendra su hijo derecho (su hijo derecho estar� al final f�sico)
        begin
          reg.hd:=posnueva;
        end;
        //grabo nodo padre con nodo hijo actualizado
        seek(Me.d,pos); write(Me.d,reg);
      end;

     //Si la profuncididad del nodo es mayor a la prfundidad en el control actualizo.
  If nodo.nivel > RC.NivelMax then
    RC.NivelMax := nodo.nivel;

  //si tipo (jugador) es true es real sino ficticio
  if not (tipo) then
    RC.ficticio:= RC.ficticio+1;

		rc.cantidad:=rc.cantidad+1;
    //se graba el elemento nuevo insertado en el archivo
		seek(Me.d,posnueva); write(Me.d,nodo);
    //se actualiza el registro control
		seek(Me.c,0); write(Me.c,rc);

    //invoco al balanceo del �rbol
    Balancear_Arbol(me, PosNueva);
end;



{----------------------------------------(7)----------------------------------------}
Procedure EliminarNodo_Arbol(var Me:tArbol; pos:tPos);
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

Procedure ModificarNodo_Arbol(var Me: tArbol; RegInd:tNodoIndice;Pos:tPos);
begin
  seek(Me.D,pos); write(Me.D,RegInd);
end;

{----------------------------------------(9)----------------------------------------}

Function  BuscarNodo_Arbol (var Me:tArbol; clave:tClave;var pos:tPos):boolean;
 //El buscar sino encuentra la clave devuelvo la posicion del padre
var
	reg:tNodoIndice;
	RC:tControlArbol;
	encont:boolean;
	posPadre:tpos;
begin
	seek(Me.c,0); read(Me.c,rc);
	pos:=rc.raiz;
  encont:=false;
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
	BuscarNodo_Arbol:=encont;
end;

{----------------------------------------(10)----------------------------------------}

Procedure CapturarNodo_Arbol(var Me: tArbol; var RegInd:tNodoIndice; Pos:tPos);
begin
  seek(Me.D,Pos);
  Read(Me.D,RegInd);
end;

{----------------------------------------(11)----------------------------------------}

function PosNula_Arbol(Var Me:tArbol):tPos;
begin
  PosNula_Arbol:= Lib_Auxiliar.PosNula;
end;

{----------------------------------------(12)----------------------------------------}

function Raiz_Arbol(var Me: tArbol): tPos;
var
  Rc: tControlArbol;
begin
  Seek(Me.c, 0);
  Read(Me.c, Rc);

  Raiz_Arbol:= Rc.Raiz;
end;

{----------------------------------------(13)----------------------------------------}

Function Padre_Arbol(var Me: tArbol; var Reg: tNodoIndice): tPos;
begin
 Padre_Arbol:= Reg.padre;
end;

{----------------------------------------(14)----------------------------------------}

function HijoDer_Arbol(var Me: tArbol; pos: tPos): tPos;
var
reg: tNodoIndice;
begin

  seek(me.D,pos);
  read(me.D,reg);

  HijoDer_Arbol:= reg.hd;
end;


{----------------------------------------(15)----------------------------------------}

function HijoIzq_Arbol(var Me: tArbol; pos: tPos): tPos;
var
reg: tNodoIndice;
begin

  seek(me.D,pos);
  read(me.D,reg);

  HijoIzq_Arbol:= reg.hi;

end;


{----------------------------------------(16)----------------------------------------}

//Rotacion en arbol tambien conocido como 'Rotacion Derecha-Derecha'
Procedure RotacionSimpleIzquierda (var me: tArbol; PosNodo: tPos);
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
Procedure RotacionSimpleDerecha(var me: tArbol; PosNodo: tPos);
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
  NodoAbajo.nivel:=NodoAbajo.nivel-1;
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
Procedure RotacionCompuestaDerecha(var me: tArbol; PosNodo: tPos);
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

  NodoArriba.padre:=NodoMedio.hd;
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

  DisminuirNiveles(me, NodoArriba.hi);
  AumentarNiveles(me, NodoArriba.hd);
  DisminuirNiveles(me, NodoMedio.hd);
end;


{----------------------------------------(19)----------------------------------------}

//Rotacion en arbol tambien conocido como 'Rotacion Derecha-Izquierda'
Procedure RotacionCompuestaIzquierda(var me: tArbol; PosNodo: tPos);
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

Function ProfundidadNodo_Arbol(me: tArbol; raiz: tPos): integer;
var
 Profundidad:tProfundidad;
 Nodo:tNodoIndice;
Begin
  //Dada una posici�n, devuelve la profundidad (nivel) en el que se encuentra
  Profundidad := 0;
  CapturarNodo_Arbol(me, nodo, raiz);
  ProfundidadTotal_Arbol(me, raiz, Profundidad);
  result := (Profundidad - nodo.nivel) + 1;
End;



{----------------------------------------(21)----------------------------------------}

procedure ProfundidadTotal_Arbol(var me:tArbol; Raiz:tPos; var Profundidad:tProfundidad);
var
 Nodo: tNodoIndice;
 begin
   If Raiz <> Lib_Auxiliar.PosNula then
    begin
    // Primero recursivo tendiendo a la Izquierda
    ProfundidadTotal_Arbol(me, HijoIzq_Arbol(me, raiz), Profundidad);
    // Recursividad tendiendo a la Derecha.
    ProfundidadTotal_Arbol(me, HijoDer_Arbol(me, raiz), Profundidad);

    // Guardo en Nodo el nodo indice.
    CapturarNodo_Arbol(me, nodo, raiz);

    If Nodo.nivel > Profundidad then
      Profundidad := Nodo.nivel;
    end;
 end;


{----------------------------------------(22)----------------------------------------}
{
Caso Desequilibrio:

Si un nodo esta desequilibrado, se invoca a �Caso Desquilibrio� donde verifica que tipo de rotaci�n se llevara a cabo para balancear dicho nodo.

Si el factor de equilibrio del nodo desbalanceado es positivo, est� cargado a la izquierda..., reviso con hijo izquierda
-	Si el factor de equilibrio del hijo izquierdo es positivo, hago una RotacionSimpleDerecha
Sino
-	hago una RotacionCompuestaDerecha


Si el factor de equilibrio del nodo desbalanceado es negativo, est� cargado a la derecha..., reviso con hijo derecho
-	Si el factor de equilibrio del hijo derecho es positivo, hago una RotacionCompuestaIzquierda
Sino
-	hago una RotacionSimpleIzquierda
}


Procedure CasoDesequilibrio_Arbol(me: tArbol; PosNodo: tPos);
var
  Nodo: tNodoIndice;
  begin
    CapturarNodo_Arbol(me, Nodo, PosNodo);

    //Si el factor de equilibrio es positivo, esta cargado a la izquierda..., reviso con hijo izquierdo
    If FactorEquilibrio_Arbol(me, PosNodo) >= 0 then
    begin
      If FactorEquilibrio_Arbol(me, Nodo.hi) >= 0 then //Si el factor de equilibrio del hijo izquierdo es positivo, hago una RotacionSimpleDerecha
        RotacionSimpleDerecha(me, PosNodo)
      else  //...si es negativo, hago una RotacionCompuestaDerecha
        RotacionCompuestaDerecha(me, PosNodo);
    end
    else //Si el factor de equilibrio es negativo, esta cargado a la derecha..., reviso con hijo derecho
     begin
      If FactorEquilibrio_Arbol(me, Nodo.hd) >= 0 then  //Si el factor de equilibrio del hijo derecho es positivo, hago una RotacionCompuestaIzquierda
        RotacionCompuestaIzquierda(me, PosNodo)
      else //...si es negativo, hago una RotacionSimpleIzquierda
        RotacionSimpleIzquierda(me, PosNodo);
     end;
  end;

{----------------------------------------(23)----------------------------------------}

Function FactorEquilibrio_Arbol(me: tArbol; PosNodo: tPos): integer;
var
  Nodo: tNodoIndice;
  Ti, Td: integer;
begin
  If PosNodo = Lib_Auxiliar.PosNula then
    FactorEquilibrio_Arbol := 0
  else
    begin
     //Guardo en Nodo el nodo indice.
     CapturarNodo_Arbol(me, Nodo, PosNodo);

      // Calculo la profundidad de ambos hijos.
      If Nodo.hi <> Lib_Auxiliar.PosNula then
        Ti := ProfundidadNodo_Arbol(me, Nodo.hi)
      else
        Ti := 0;

      if Nodo.hd <> Lib_Auxiliar.PosNula then
        Td := ProfundidadNodo_Arbol(me, Nodo.hd)
      else
        Td := 0;

      //cada nodo del arbol equilibrado (balanceado) tiene balance igual a 1, -1 o 0
      FactorEquilibrio_Arbol := Ti - Td;
    end;
end;


{----------------------------------------(24)----------------------------------------}


Procedure DisminuirNiveles(var me: tArbol; raiz: tPos);
var
  Nodo: tNodoIndice;
begin
  If raiz <> Lib_Auxiliar.PosNula then
  begin
  // Primero recursivo hacia la Izquierda
  DisminuirNiveles(me, HijoIzq_Arbol(me, raiz));
  CapturarNodo_Arbol(me, nodo, raiz);
  Nodo.nivel := Nodo.nivel - 1;
  seek(me.D, raiz);
  Write(me.D, Nodo);
  // Recursividad hacia la Derecha
  DisminuirNiveles(me, HijoDer_Arbol(me, raiz));
  end;
end;

{----------------------------------------(25)----------------------------------------}

Procedure AumentarNiveles(var me: tArbol; raiz: tPos);
var
  Nodo: tNodoIndice;
begin
  If raiz <> Lib_Auxiliar.PosNula then
   begin
    // Primero recursivo hacia la Izquierda
    AumentarNiveles(me, HijoIzq_Arbol(me, raiz));
    CapturarNodo_Arbol(me, nodo, raiz);
    Nodo.nivel := Nodo.nivel + 1;
    seek(me.D, raiz);
    Write(me.D, Nodo);
    // Recursividad hacia la Derecha.
    AumentarNiveles(me, HijoDer_Arbol(me, raiz));
   end;
end;


{----------------------------------------(26)----------------------------------------}
{
Balancear Arbol:

-	Una vez insertado el nodo, pregunto por el balanceo del �rbol.
-	Se pregunta por el balanceo de cada nodo desde el nodo padre del reci�n insertado hasta la ra�z
-	Un nodo esta balanceado si su factor de equilibrio es -1, 1 o 0.
-	El factor de equilibrio verifica que el nodo este equilibrado.
Para ello la funci�n captura el nodo y calcula la profundidad de ambos hijos
El nodo esta equilibrado si la altura del sub�rbol izquierdo menos la altura del sub�rbol derecho difiera a lo sumo en 1.
Si un nodo esta desequilibrado, se invoca a �Caso Desquilibrio� donde verifica que tipo de rotaci�n se llevara a cabo
para balancear dicho nodo
}
procedure Balancear_Arbol(var me: tArbol; Pos:tpos);
var
  Nodo: tNodoIndice;
  result:Integer;

  begin
    CapturarNodo_Arbol(me,Nodo,pos);
    pos:= Nodo.Padre;

    while (pos<>Lib_Auxiliar.PosNula) do
    begin
      Result := FactorEquilibrio_Arbol(me, Pos);

      //si result es negativo, entonces nodo cargado a la izquierda
      If Result < 0 then
        Result := Result * (-1);

      //El nodo esta balanceado cuando las alturas de sus dos subarboles (izquierdo y derecho) difiera�en a lo sumo en 1
      //Si la diferencia de la altura de los hijo izquierdo y derecho es mayor a 1, el arbol esta desbalanceado. Invoco a caso de desequilibrio
      If (Result > 1) then
        CasoDesequilibrio_Arbol(me,pos);

       CapturarNodo_Arbol(me,Nodo,pos);
       pos:= Nodo.Padre;
    end;
  end;


{----------------------------------------(27)----------------------------------------}

function UltFicticio_Arbol(var Me: tArbol): tCantidad;
var
  Rc: tControlArbol;
begin
  Seek(Me.c, 0); Read(Me.c, Rc);
  UltFicticio_Arbol:= Rc.ficticio;
end;

{----------------------------------------(28)----------------------------------------}

function CantidadNodos_Arbol(var Me: tArbol): tCantidad;
var
  Rc: tControlArbol;
begin
  Seek(Me.c, 0); Read(Me.c, Rc);
  CantidadNodos_Arbol:= Rc.Cantidad;
end;


{----------------------------------------(29)----------------------------------------}

function ObtenerNivel_Arbol(var Me:tArbol; clave:tClave):tCantidad;
var
  pos:tPos;
  Nodo: tNodoIndice;
 begin
   if BuscarNodo_Arbol(Me, clave, pos) then
    begin
      seek(me.D,pos); read(me.D,Nodo);
      ObtenerNivel_Arbol:=Nodo.Nivel;
    end;
 end;


END.


