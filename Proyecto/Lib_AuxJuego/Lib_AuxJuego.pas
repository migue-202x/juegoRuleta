unit Lib_AuxJuego;

interface
uses
  ME_JUGADORES,
  Type_JUGADOR,
  ME_CTACTE,
  Type_ALMACEN,
  ME_JUEGO,
  Type_JUEGO,
  ME_APUESTAS,
  Type_APUESTA,
  ME_GANADORES,
  Type_GANADOR,
  Lib_Auxiliar,
  SysUtils, Vcl.Dialogs, Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Math;

Const
  rutaIconoOjoCerrado = 'Imagenes\Icons\ojoCerrado.bmp';
  rutaIconoOjoAbierto = 'Imagenes\Icons\ojoAbierto.bmp';


//Consultas sobre rango de valores a la que puede llegar a pertenecer la bolilla ganadora. Si se encuentra devuelve true 
function IsIn_PrimeraColumna(BolillaGanadora: tBolilla): boolean;
function IsIn_SegundaColumna(BolillaGanadora: tBolilla): boolean;
function IsIn_TerceraColumna(BolillaGanadora: tBolilla): boolean;
function IsIn_PrimerDocena(BolillaGanadora: tbolilla): boolean;
function IsIn_SegundaDocena(BolillaGanadora: tbolilla): boolean;
function IsIn_TercerDocena(BolillaGanadora: tbolilla): boolean;
function IsIn_PASA(BolillaGanadora: tbolilla): boolean;
function IsIn_FALTA(BolillaGanadora: tbolilla): boolean;
function IsIn_PAR(BolillaGanadora: tbolilla): boolean;
function IsIn_IMPAR(BolillaGanadora: tbolilla): boolean;
function IsIn_ROJOS(BolillaGanadora: tbolilla): boolean;
function IsIn_NEGROS(BolillaGanadora: tbolilla): boolean;

//Procedimientos sobre ficticios  
Procedure Insertar_JugadoresFicticios(var Me: ME_JUGADORES.ME_JUGADOR; cant:tCantidad);
procedure Activar_JugadoresFicticios(var Me: ME_JUGADORES.ME_JUGADOR; cantFict_Activar:tCantidad);
procedure Desactivar_JugadoresFicticios(RaizJugadores: Lib_Auxiliar.tPos);
procedure Cant_FicticiosActivos(RaizJugadores: Lib_Auxiliar.tPos; var cant:tCantidad);
procedure Apuestas_JugadoresFicticios(RaizJugadores: Lib_Auxiliar.tPos; var cantFict_Activos:tCantidad);


//Generales
procedure Ini_Sesion (var Me: ME_JUGADORES.ME_JUGADOR; var regJugador: Type_JUGADOR.tRegDatos);
procedure Fin_Sesion (var Me: ME_JUGADORES.ME_JUGADOR; var regJugador: Type_JUGADOR.tRegDatos);
procedure repartirPremio_xJugada (RaizJugadores: Lib_Auxiliar.tPos; nroJugada: Type_JUEGO.tClave);
Function ExistenApuestas_enEsteJuego(Num_Jugada: Type_JUEGO.tClave):boolean;
Procedure CantGanadores_EnUnaJugada(RaizGanadores: Lib_Auxiliar.tPos; jugada: Type_JUEGO.TClave; var cantGanadores: tCantidad);
Procedure CantGanadores_xNomenclador(RaizGanadores: Lib_Auxiliar.tPos; nomenclador: tNomenclador; var cantGanadores: tCantidad);
Procedure MontoEnApuestaXPartida (NroJugada: Type_JUEGO.TClave; var montoTotalApuestas: tImporte);
Procedure MontoPremiosXPartida(RaizGanadores: Lib_Auxiliar.tPos; NroJugada: Type_JUEGO.TClave; var montoTotalPremios: tImporte);
Procedure Cant_RealesYFicticios_xPartida(RaizJugadores: Lib_Auxiliar.tPos; NroJugada: Type_JUEGO.TClave; var cantReales: tCantidad; var cantFicticios: tCantidad);
procedure ReordenarMasPremiados (var grid: TStringGrid; num:integer; cantFilas: integer);
Procedure MovimientoHaberApostadores();
procedure recuperarRegPartida (Nro_Jugada: Type_JUEGO.tClave; var regBuscado: Type_JUEGO.TipoRegDatos);
Procedure InsertoPremioUnGanador(regGanador: Type_GANADOR.TipoRegDatos; var regApuesta: Type_APUESTA.TipoRegDatos; tipoGanador: tNomenclador; Importe: tImporte);
Procedure MovimientoApuestaUnJugador(nick: tClave; regApuesta: Type_APUESTA.TipoRegDatos; apostado:tImporte; ImporteGanado: tImporte);
procedure ReordenarGridPorFecha (var grid: TStringGrid; cantFilas: integer);
procedure Cant_JugadoresEnLinea(RaizJugadores: Lib_Auxiliar.tPos; var cant:tCantidad);
Procedure CantidadJugadoresNuncaGanaron(RaizJugadores: Lib_Auxiliar.tPos; var cant: tCantidad);
Procedure Premios_AcumuladosXJugador(RaizGanadores: Lib_Auxiliar.tPos; Nick:Type_JUGADOR.tClave; var cantPremios: tCantidad; var Monto: tImporte);
Procedure Premios_AcumuladosXJugadorUnaJugada(RaizGanadores: Lib_Auxiliar.tPos; Nick:Type_JUGADOR.tClave; jugada: Type_JUEGO.TClave; var Monto: tImporte);
Function JugadorTieneApuestasEnPartida (NroJugada: Type_JUEGO.TClave; nick: Type_JUGADOR.tClave): boolean;
Procedure JugadorEsUnGanandor(pos:tPos; Nick: tClave; var esGanador: boolean);
Procedure EliminarApuestasUnJugador(Nick: tClave);
Procedure Cant_JugadoresDesbloqueados(RaizJugadores: Lib_Auxiliar.tPos; var cantDesbloq: Lib_Auxiliar.tCantidad);
Procedure Cant_JugadoresActivos(RaizJugadores: Lib_Auxiliar.tPos; var cantActivos: Lib_Auxiliar.tCantidad);

//Listados
Procedure ListadoGeneral_JugadoresEnGrid(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
Procedure Listado_JugadoresActivos(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
Procedure ListadoArbolGanadores(RaizGanadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
Procedure ListadoArbolJugadores(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
procedure ListadoPartidas (var grid: TStringGrid);
Procedure ListadoJugadoresNuncaGanaron(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
procedure ListadoCtaCte_deUnJugador(posListaParcial: tPos; Nick: tclave; var grid: TStringGrid);
Procedure ListadoPremiados_Nomenclador(RaizGanadores: Lib_Auxiliar.tPos; nomenclador: tNomenclador; var grid: TStringGrid);
Procedure ListadoMasPremiados(RaizGanadores: Lib_Auxiliar.tPos; var importe:tImporte; var grid: TStringGrid; var cantFilas: integer);
Procedure Listado_GeneralApuestas(var grid: TStringGrid; Nro_Jugada: Type_JUEGO.tClave);
Procedure Listado_ApuestasUnJugador(var grid: TStringGrid; Nro_Jugada: Type_JUEGO.tClave; nick: Type_JUGADOR.TClave);
Procedure Listado_Premios(RaizGanadores: Lib_Auxiliar.tPos; jugada: Type_JUEGO.TClave; var grid: TStringGrid);

//grid
function Mensaje_Confirmacion(Msje: String): boolean;
procedure limpiarGrid(grid: TStringGrid);
Procedure EncabezadoDetalladoJugadores (grid: TStringGrid);
Procedure EncabezadoArbolJugadores(grid: TStringGrid);
Procedure EncabezadoListadoPartidas(grid: TStringGrid);
Procedure EncabezadoJugadoresMasGanaron(grid: TStringGrid);
Procedure EncabezadoGanadoresXPremio(grid: TStringGrid);
Procedure EncabezadoFiltroCtaCte(grid: TStringGrid);
Procedure EncabezadosComunApuestas(grid: TStringGrid);
Procedure EncabezadosComunJugadores(grid: TStringGrid);
Procedure EncabezadoGridPremios(grid: TStringGrid);
Procedure EncabezadosComunFicticios(grid: TStringGrid);




IMPLEMENTATION

uses
  Form_Login;

{--------------------------------------------------------------------------------}
//Inserto cantidad parametrizada de jugadores ficticios
Procedure Insertar_JugadoresFicticios(var Me: ME_JUGADORES.ME_JUGADOR; cant:tCantidad);
var
 numFicticio: Lib_Auxiliar.tCantidad;
 posJugador: tpos;
 regJugador: type_JUGADOR.tRegDatos;
 RegCtaCte: Type_ALMACEN.tipoRegAlmacen;
 i: Integer;
 largo:integer;
 cadena:string;
 pad:char;

begin
pad:='0';
  for I := 1 to cant do
  begin
   //Cuando el croupier genera un nuevo jugador ficticio, se les asigna el nick
   //que surja de la combinaci�n "X_" + str (<ficticio>) completado con ceros la parte no significativa.
   //Por ejemplo: X_0001, X_0002, etc.
    numFicticio:= UltFicticio(Me) + 1;
    regJugador.Nick:= Lib_Auxiliar.Fict_IniNick + intTostr(numFicticio).PadLeft(4,pad);
    regJugador.Nombre:='N_Ficticio';
    regJugador.Apellido:='A_Ficticio';
    regJugador.Contrasenia:='';
    regJugador.Alta:= Now();
    regJugador.UltimaConexion:= Now();
    regJugador.TipoJugador:= false;
    regJugador.Estado:= false;
    regJugador.Bloqueado:= false;
    BuscarInfoME_Jugadores(Me,posJugador,regJugador.Nick);
    InsertarInfoME_Jugadores(Me,regJugador,posJugador);

    //Cargo datos de ctacte a ficticios
    RegCtaCte.Nick:= regJugador.Nick;
    RegCtaCte.FechaHora:= Now();
    RegCtaCte.Concepto:= Type_ALMACEN.tipoConceptos.Creacion_Cuenta;
    RegCtaCte.Debe:= ME_JUEGO.ApuestaMinima(Form_Login.ME_JUEGORULETA)*10;
    RegCtaCte.haber:= 0;
    RegCtaCte.saldo:= ME_JUEGO.ApuestaMinima(Form_Login.ME_JUEGORULETA)*10;
    //inserto cuenta corriente de ficticios
    ME_CTACTE.InsertarAlmacen(Form_Login.ME_CUENTACORRIENTE,RegCtaCte);
  end;
end;
{------------------------------------------------------------------------------}

procedure Activar_JugadoresFicticios(var Me: ME_JUGADORES.ME_JUGADOR; cantFict_Activar:tCantidad);
var
  RD:Type_JUGADOR.tRegDatos;
  CantFictio, esteFicticio:tCantidad;
  pad:char;
  estado:string;
begin
  Randomize;
  if cantFict_Activar>0 then
  begin
    //Nick random ficticio con el campo guardo en RC de ultimoFicticio
    pad:='0';
    CantFictio:= ME_JUGADORES.UltFicticio(ME_JUGADOR);
    esteFicticio:= random(CantFictio) + 1;
    RD.Nick:= Lib_Auxiliar.Fict_IniNick + intTostr(esteFicticio).PadLeft(4,pad);

    ME_JUGADORES.BuscarInfoME_Jugadores(Form_Login.ME_JUGADOR,posJugador,RD.Nick);
    ME_JUGADORES.CapturarInfoME_Jugadores(Form_Login.ME_JUGADOR,RD,posJugador);

    if (not RD.Estado)then
    begin
      RD.Nick:= RD.Nick;
      RD.Contrasenia:= RD.Contrasenia;
      RD.Nombre:= RD.Nombre;
      RD.Apellido:= RD.Apellido;
      RD.Alta:= RD.Alta;
      RD.UltimaConexion:= Now(); // �ltima conexi�n actual
      RD.Bloqueado:= RD.Bloqueado;
      RD.Estado:= true; // activo jugador ficticio

      ME_JUGADORES.ModificarInfoME_Jugadores(Form_Login.ME_JUGADOR, RD, posJugador);

      Activar_JugadoresFicticios(Form_Login.ME_JUGADOR, cantFict_Activar - 1);
    end
    else
      Activar_JugadoresFicticios(Form_Login.ME_JUGADOR, cantFict_Activar);
  end;
end;

{------------------------------------------------------------------------------}

procedure Desactivar_JugadoresFicticios(RaizJugadores: Lib_Auxiliar.tPos);
var
  RD:Type_JUGADOR.tRegDatos;
begin
 if (RaizJugadores<>Lib_Auxiliar.PosNula)then
 begin
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);
    if ((not RD.TipoJugador) and (RD.Estado)) then //ficticio y activo
    begin
      RD.Nick:= RD.Nick;
      RD.Contrasenia:= RD.Contrasenia;
      RD.Nombre:= RD.Nombre;
      RD.Apellido:= RD.Apellido;
      RD.Alta:= RD.Alta;
      RD.UltimaConexion:= Now(); // �ltima conexi�n actual
      RD.Bloqueado:= RD.Bloqueado;
      RD.Estado:= false; // desactivo jugador ficticio

      ME_JUGADORES.ModificarInfoME_Jugadores(Form_Login.ME_JUGADOR, RD, RaizJugadores);
    end;

  Desactivar_JugadoresFicticios(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores));
  Desactivar_JugadoresFicticios(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores));
 end;
end;

{------------------------------------------------------------------------------}

procedure Cant_FicticiosActivos(RaizJugadores: Lib_Auxiliar.tPos; var cant:tCantidad);
var
  RD:Type_JUGADOR.tRegDatos;
begin
 if (RaizJugadores<>Lib_Auxiliar.PosNula)then
 begin
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);
    if ((not RD.TipoJugador) and (RD.Estado)) then //ficticio y activo
      cant:= cant + 1;

  Cant_FicticiosActivos(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), cant);
  Cant_FicticiosActivos(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), cant);
 end;
end;

{------------------------------------------------------------------------------}

procedure Cant_JugadoresEnLinea(RaizJugadores: Lib_Auxiliar.tPos; var cant:tCantidad);
var
  RD:Type_JUGADOR.tRegDatos;
begin
 if (RaizJugadores<>Lib_Auxiliar.PosNula)then
 begin
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    if ((RD.TipoJugador) and (RD.Estado) and (RD.Nick<>'CROUPIER')) then //real, activo. CROUPIER no suma
      cant:= cant + 1;

  Cant_JugadoresEnLinea(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), cant);
  Cant_JugadoresEnLinea(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), cant);
 end;
end;

{------------------------------------------------------------------------------}

procedure Apuestas_JugadoresFicticios(RaizJugadores: Lib_Auxiliar.tPos; var cantFict_Activos:tCantidad);
var
  regJF, RD:Type_JUGADOR.tRegDatos; //registro Jugador Ficticio
  regAF: Type_APUESTA.TipoRegDatos; //registro Apuesta Ficticio
  regJuego: Type_JUEGO.TipoRegDatos;
  rNomenclador, rValor: integer; //nomenclador random, valor random
  posAlmacenFict: tPos;
  regAlmacenFict: Type_ALMACEN.tipoRegAlmacen;
  saldoFict, importeFict: tImporte;
  importeValido: boolean;
begin
 if (RaizJugadores<>Lib_Auxiliar.PosNula) then
 begin
  if (cantFict_Activos > 0) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    if ((not RD.TipoJugador) and (RD.Estado) and (not RD.Bloqueado)) then //ficticio, activo, no bloqueado
    begin
      Randomize;
      ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuego);
      regAF.NroJugada:= regJuego.NroJugada;
      regAF.Nick:= RD.Nick;

      rNomenclador:= random(6) + 1;

      CASE (rNomenclador) of
      1:begin // Pleno
        Randomize;
          regAF.Nomenclador:= type_APUESTA.Nom_Pleno;
          regAF.Valor:= inttostr(random(36));
        end;
      2:begin // Columna
        Randomize;
          regAF.Nomenclador:= type_APUESTA.Nom_Columna;
          rValor:= random(3) + 1;
          case (rValor) of
          1:regAF.Valor:= '1';
          2:regAF.Valor:= '2';
          3:regAF.Valor:= '3';
          end; //case rValor
        end;
      3:begin // Docena
        Randomize;
          regAF.Nomenclador:= type_APUESTA.Nom_Docena;
          rValor:= random(3) + 1;
          case (rValor) of
          1:regAF.Valor:= '1';
          2:regAF.Valor:= '2';
          3:regAF.Valor:= '3';
          end; //case rValor
        end;
      4:begin // Pasa o Falta
        Randomize;
          regAF.Nomenclador:= type_APUESTA.Nom_PasaFalta;
          rValor:= random(2) + 1;
          if (rValor = 1) then
            regAF.Valor:= 'P'
          else
            regAF.Valor:= 'F';
        end;
      5:begin // Par o Impar
        Randomize;
          regAF.Nomenclador:= type_APUESTA.Nom_ParImpar;
          rValor:= random(2) + 1;
          if (rValor = 1) then
            regAF.Valor:= 'P'
          else
            regAF.Valor:= 'I';
        end;
      6:begin //Rojo o Negro
        Randomize;
          regAF.Nomenclador:= type_APUESTA.Nom_Rojonegro;
          rValor:= random(2) + 1;
          if (rValor = 1) then
            regAF.Valor:= 'R'
          else
            regAF.Valor:= 'N';
        end;
      END;//case

      saldoFict:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, RD.Nick);

      //Si saldo de ficticio es mayor que la apuesta minina
      if (saldoFict >= ME_JUEGO.ApuestaMinima(ME_JUEGORULETA)) then
      begin
        Randomize;
      //busco un importe que sea un rango aleatorio que este entre la apuesta minima y la maxima permitida
        importeFict := RANDOMRANGE(ME_JUEGO.ApuestaMinima(ME_JUEGORULETA),ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA));

        importeValido:= false;
        while (not importeValido) do
        begin
          //El IMPORTE A APOSTAR del ficticio es valida si es menor o igual a su saldo, mayor o igual a la apuesta minima, menor o igual a la apueta maxima.
          if ((importeFict <= saldoFict) and (importeFict >= ME_JUEGO.ApuestaMinima(ME_JUEGORULETA)) and (importeFict <= ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA))) then
            importeValido:= true
          else
            //si el importe a apostar no es valido, busco de nuevo un rango que este entre la apuesta minima y la maxima permitida
            importeFict := RANDOMRANGE(ME_JUEGO.ApuestaMinima(ME_JUEGORULETA),ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA));
        end;//while

        regAF.Importe:= importeFict;
        ME_APUESTAS.InsertarInfoME_Apuestas(form_login.ME_APUESTA, regAF, ME_APUESTAS.PosNula_Apuestas(ME_APUESTA));

        cantFict_Activos:= cantFict_Activos-1;
      end;//If
    end;
  end;

  Apuestas_JugadoresFicticios(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), cantFict_Activos);
  Apuestas_JugadoresFicticios(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), cantFict_Activos);
 end;
end;

{------------------------------------------------------------------------------}

procedure repartirPremio_xJugada (RaizJugadores: Lib_Auxiliar.tPos; nroJugada: Type_JUEGO.tClave);
var
  i:tPos;
  regJugador, RD:Type_JUGADOR.tRegDatos;
  regJuego: Type_JUEGO.TipoRegDatos;
  regApuesta: Type_APUESTA.TipoRegDatos;
  regGanador: Type_GANADOR.TipoRegDatos;
  regCtaCte: Type_ALMACEN.tipoRegAlmacen;
  importe: tImporte;

begin
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuego);

  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    //capturo jugador para verificar si tiene alguna apuesta
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, RaizJugadores);

    i:= ME_APUESTAS.Primero(ME_APUESTA);

    while (i<>ME_APUESTAS.PosNula_Apuestas(ME_APUESTA)) do
    begin
      //capturo apuesta del jugador
      ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i, regApuesta);

       //si la apuesta apuesta es de la misma jugada y mismo jugador
      if ((regApuesta.NroJugada = regJuego.NroJugada) and (regApuesta.Nick = regJugador.Nick)) then
      begin //busco si coinciden sus apuestas con el resultado de la jugada
          if (regApuesta.Nomenclador = Type_APUESTA.Nom_Pleno) then //PLENO
          begin
            if (regApuesta.Valor = intTostr(regJuego.Bolilla)) then
            begin
              //Calculo el importe que gano el apostador en dicha jugada
              Importe:= regApuesta.Importe * type_GANADOR.Prem_Pleno;
              //Invoco a PremioAunGanador que completa el registro de ganador y lo inserta
              InsertoPremioUnGanador(regGanador, regApuesta, Type_APUESTA.Nom_Pleno, Importe);

              //Inserto movimiento de premio de un jugador en CtaCte
              MovimientoApuestaUnJugador(regJugador.Nick, regApuesta, regApuesta.Importe, Importe);
            end;
          end;

          if (regApuesta.Nomenclador = Type_APUESTA.Nom_Columna) then // COLUMNA
          begin
            if (((regApuesta.Valor = '1') and (IsIn_PrimeraColumna(regJuego.Bolilla))) or ((regApuesta.Valor = '2') and (IsIn_SegundaColumna(regJuego.Bolilla))) or ((regApuesta.Valor = '3') and (IsIn_TerceraColumna(regJuego.Bolilla)))) then
            begin
              //Calculo el importe que gano el apostador en dicha jugada
              Importe:= regApuesta.Importe * type_GANADOR.Prem_Columna;
              //Invoco a PremioAunGanador que completa el registro de ganador y lo inserta
              InsertoPremioUnGanador(regGanador, regApuesta, Type_APUESTA.Nom_Columna, Importe);

                //Inserto movimiento de premio de un jugador en CtaCte
              MovimientoApuestaUnJugador(regJugador.Nick, regApuesta, regApuesta.Importe, Importe);
            end;
          end;

          if (regApuesta.Nomenclador = Type_APUESTA.Nom_Docena) then // DOCENA
          begin
            if (((regApuesta.Valor = '1') and (IsIn_PrimerDocena(regJuego.Bolilla))) or ((regApuesta.Valor = '2') and (IsIn_SegundaDocena(regJuego.Bolilla))) or ((regApuesta.Valor = '3') and (IsIn_TercerDocena(regJuego.Bolilla)))) then
            begin
              //Calculo el importe que gano el apostador en dicha jugada
              Importe:= regApuesta.Importe * type_GANADOR.Prem_Docena;
              //Invoco a PremioAunGanador que completa el registro de ganador y lo inserta
              InsertoPremioUnGanador(regGanador, regApuesta, Type_APUESTA.Nom_Docena, Importe);

                 //Inserto movimiento de premio de un jugador en CtaCte
              MovimientoApuestaUnJugador(regJugador.Nick, regApuesta, regApuesta.Importe, Importe);
            end;
          end;

          if (regApuesta.Nomenclador = Type_APUESTA.Nom_PasaFalta) then // PASA-FALTA
          begin
            if (((regApuesta.Valor = 'P') and (IsIn_PASA(regJuego.Bolilla))) or ((regApuesta.Valor = 'F') and (IsIn_FALTA(regJuego.Bolilla)))) then
            begin
              //Calculo el importe que gano el apostador en dicha jugada
              Importe:= regApuesta.Importe * type_GANADOR.Prem_PasaFalta;
              //Invoco a PremioAunGanador que completa el registro de ganador y lo inserta
              InsertoPremioUnGanador(regGanador, regApuesta, Type_APUESTA.Nom_PasaFalta, Importe);

                //Inserto movimiento de premio de un jugador en CtaCte
              MovimientoApuestaUnJugador(regJugador.Nick, regApuesta, regApuesta.Importe, Importe);
            end;
          end;

          if (regApuesta.Nomenclador = Type_APUESTA.Nom_ParImpar) then // PAR-IMPAR
          begin
            if (((regApuesta.Valor = 'P') and (IsIn_PAR(regJuego.Bolilla))) or ((regApuesta.Valor = 'I') and (IsIn_IMPAR(regJuego.Bolilla)))) then
            begin
               //Calculo el importe que gano el apostador en dicha jugada
              Importe:= regApuesta.Importe * type_GANADOR.Prem_ParImpar;
              //Invoco a PremioAunGanador que completa el registro de ganador y lo inserta
              InsertoPremioUnGanador(regGanador, regApuesta, Type_APUESTA.Nom_ParImpar, Importe);

              //Inserto movimiento de premio de un jugador en CtaCte
              MovimientoApuestaUnJugador(regJugador.Nick, regApuesta, regApuesta.Importe, Importe);
            end;
          end;

          if (regApuesta.Nomenclador = Type_APUESTA.Nom_Rojonegro) then // ROJO-NEGRO
          begin
            if (((regApuesta.Valor = 'R') and (IsIn_ROJOS(regJuego.Bolilla))) or ((regApuesta.Valor = 'N') and (IsIn_NEGROS(regJuego.Bolilla)))) then
            begin
               //Calculo el importe que gano el apostador en dicha jugada
              Importe:= regApuesta.Importe * type_GANADOR.Prem_Rojonegro;
              //Invoco a PremioAunGanador que completa el registro de ganador y lo inserta
              InsertoPremioUnGanador(regGanador, regApuesta, Type_APUESTA.Nom_Rojonegro, Importe);

              //Inserto movimiento de premio de un jugador en CtaCte
              MovimientoApuestaUnJugador(regJugador.Nick, regApuesta, regApuesta.Importe, Importe);
            end;
          end;

          //Si la bola cae sobre el cero los jugadores que hicieron apuestas sencillas (rojo/negro, par/impar, pasa/falta)
          //recuperan la mitad de su apuesta y pierden la otra mitad.
          if ((regApuesta.Nomenclador = Type_APUESTA.Nom_Columna)AND (regJuego.Bolilla = 0)) or
            ((regApuesta.Nomenclador = Type_APUESTA.Nom_Docena) AND (regJuego.Bolilla = 0)) or
            ((regApuesta.Nomenclador = Type_APUESTA.Nom_PasaFalta) AND (regJuego.Bolilla = 0)) or
            ((regApuesta.Nomenclador = Type_APUESTA.Nom_ParImpar) AND (regJuego.Bolilla = 0)) or
            ((regApuesta.Nomenclador = Type_APUESTA.Nom_Rojonegro) AND (regJuego.Bolilla = 0))then
            begin
              //completo registro de ganador
              regGanador.Nomenclador:= regApuesta.Nomenclador;
              regGanador.Numero:= strToint('0');
              regGanador.NroJugada:= strToint(regApuesta.NroJugada);
              regGanador.Importe:= round(regApuesta.Importe*type_GANADOR.Prem_Cero);
              //Inserto ganador
              ME_GANADORES.InsertarInfoME_Ganadores(ME_GANADOR,regGanador, regApuesta.Nick);

              //Completo registro movimiento en CtaCte
              regCtaCte.Nick:= regJugador.Nick;
              regCtaCte.FechaHora:= Now();
              regCtaCte.Concepto:= Type_ALMACEN._PremioJuego + regApuesta.NroJugada;
              regCtaCte.Debe:= regGanador.Importe;
              regCtaCte.haber:= 0;
              regCtaCte.saldo:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regApuesta.Nick) + regGanador.Importe;
              //Inserto movimiento en CtaCte
              ME_CTACTE.InsertarAlmacen(ME_CUENTACORRIENTE, regCtaCte);
            end;
      end;

      i:= ME_APUESTAS.Proximo(ME_APUESTA, i)
    end;//while

    repartirPremio_xJugada(ME_JUGADORES.ProximoIzq(ME_JUGADOR, RaizJugadores), nroJugada);
    repartirPremio_xJugada(ME_JUGADORES.ProximoDer(ME_JUGADOR, RaizJugadores), nroJugada);
  end;
end;

{------------------------------------------------------------------------------}

function IsIn_PrimeraColumna(BolillaGanadora: tBolilla): boolean;
begin
  IsIn_PrimeraColumna:= (BolillaGanadora = 1) or  (BolillaGanadora = 4) or (BolillaGanadora = 7)
      or (BolillaGanadora = 10) or (BolillaGanadora = 13) or (BolillaGanadora = 16) or (BolillaGanadora = 19)
      or (BolillaGanadora = 22)  or (BolillaGanadora = 25) or (BolillaGanadora = 28) or (BolillaGanadora = 31) or (BolillaGanadora = 34);
end;

{------------------------------------------------------------------------------}

function IsIn_SegundaColumna(BolillaGanadora: tBolilla): boolean;
begin
  IsIn_SegundaColumna:= (BolillaGanadora = 2) or  (BolillaGanadora = 5) or (BolillaGanadora = 8)
      or (BolillaGanadora = 11) or (BolillaGanadora = 14) or (BolillaGanadora = 17) or (BolillaGanadora = 20)
      or (BolillaGanadora = 23)  or (BolillaGanadora = 26) or (BolillaGanadora = 29) or (BolillaGanadora = 32) or (BolillaGanadora = 35);
end;

{------------------------------------------------------------------------------}

function IsIn_TerceraColumna(BolillaGanadora: tBolilla): boolean;
begin
  IsIn_TerceraColumna:= (BolillaGanadora = 3) or  (BolillaGanadora = 6) or (BolillaGanadora = 9)
      or (BolillaGanadora = 12) or (BolillaGanadora = 15) or (BolillaGanadora = 18) or (BolillaGanadora = 21)
      or (BolillaGanadora = 24)  or (BolillaGanadora = 27) or (BolillaGanadora = 30) or (BolillaGanadora = 33) or (BolillaGanadora = 36);
end;

{------------------------------------------------------------------------------}

function IsIn_PrimerDocena(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_PrimerDocena:= (BolillaGanadora>=1) and (BolillaGanadora<=12);
end;

{------------------------------------------------------------------------------}

function IsIn_SegundaDocena(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_SegundaDocena:= (BolillaGanadora>=13) and (BolillaGanadora<=24);
end;

{------------------------------------------------------------------------------}

function IsIn_TercerDocena(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_TercerDocena:= (BolillaGanadora>=25) and (BolillaGanadora<=38);
end;

{------------------------------------------------------------------------------}


function IsIn_PASA(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_PASA:= (BolillaGanadora>0) and (BolillaGanadora<=18);
end;

{------------------------------------------------------------------------------}

function IsIn_FALTA(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_FALTA:= (BolillaGanadora>18) and (BolillaGanadora<=38);
end;

{------------------------------------------------------------------------------}

function IsIn_PAR(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_PAR:= (BolillaGanadora = 2) or  (BolillaGanadora = 4) or (BolillaGanadora = 6)
      or (BolillaGanadora = 8) or (BolillaGanadora = 10) or (BolillaGanadora = 12) or (BolillaGanadora = 14)
      or (BolillaGanadora = 16)  or (BolillaGanadora = 18) or (BolillaGanadora = 20) or (BolillaGanadora = 22) or (BolillaGanadora = 24)
      or (BolillaGanadora = 26)  or (BolillaGanadora = 28) or (BolillaGanadora = 30) or (BolillaGanadora = 32) or (BolillaGanadora = 34)
      or (BolillaGanadora = 36);
end;

{------------------------------------------------------------------------------}

function IsIn_IMPAR(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_IMPAR:= (BolillaGanadora = 1) or  (BolillaGanadora = 3) or (BolillaGanadora = 5)
      or (BolillaGanadora = 7) or (BolillaGanadora = 9) or (BolillaGanadora = 11) or (BolillaGanadora = 13)
      or (BolillaGanadora = 15)  or (BolillaGanadora = 17) or (BolillaGanadora = 19) or (BolillaGanadora = 21) or (BolillaGanadora = 23)
      or (BolillaGanadora = 25)  or (BolillaGanadora = 27) or (BolillaGanadora = 29) or (BolillaGanadora = 31) or (BolillaGanadora = 33)
      or (BolillaGanadora = 35);
end;

{------------------------------------------------------------------------------}

//1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36 (rojos)

function IsIn_ROJOS(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_ROJOS:= (BolillaGanadora = 1) or  (BolillaGanadora = 3) or (BolillaGanadora = 5)
      or (BolillaGanadora = 7) or (BolillaGanadora = 9) or (BolillaGanadora = 12) or (BolillaGanadora = 14)
      or (BolillaGanadora = 16)  or (BolillaGanadora = 18) or (BolillaGanadora = 19) or (BolillaGanadora = 21) or (BolillaGanadora = 23)
      or (BolillaGanadora = 25)  or (BolillaGanadora = 27) or (BolillaGanadora = 30) or (BolillaGanadora = 32) or (BolillaGanadora = 34)
      or (BolillaGanadora = 36);
end;

{------------------------------------------------------------------------------}

//2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35 (negros)

function IsIn_NEGROS(BolillaGanadora: tbolilla): boolean;
begin
  IsIn_NEGROS:= (BolillaGanadora = 2) or  (BolillaGanadora = 4) or (BolillaGanadora = 6)
      or (BolillaGanadora = 8) or (BolillaGanadora = 10) or (BolillaGanadora = 11) or (BolillaGanadora = 13)
      or (BolillaGanadora = 15)  or (BolillaGanadora = 17) or (BolillaGanadora = 20) or (BolillaGanadora = 22) or (BolillaGanadora = 24)
      or (BolillaGanadora = 26)  or (BolillaGanadora = 28) or (BolillaGanadora = 29) or (BolillaGanadora = 31) or (BolillaGanadora = 33)
      or (BolillaGanadora = 35);
end;

{------------------------------------------------------------------------------}

Function ExistenApuestas_enEsteJuego(Num_Jugada: Type_JUEGO.tClave):boolean;
var
  i:tPos;
  encontre:boolean;
begin
  encontre:= false;
  i:= ME_APUESTAS.Primero(ME_APUESTA);
        while ((i<>ME_APUESTAS.PosNula_Apuestas(ME_APUESTA)) and (not encontre)) do
        begin
          ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i,regApuesta);

          if (regApuesta.NroJugada = Num_Jugada) then
          begin
            encontre:= true;
            ExistenApuestas_enEsteJuego:= true;
          end
          else
            i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
        END; //while
end;

{------------------------------------------------------------------------------}

Procedure CantGanadores_EnUnaJugada(RaizGanadores: Lib_Auxiliar.tPos; jugada: Type_JUEGO.TClave; var cantGanadores: tCantidad);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);

    while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
    begin
      ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);

      if (intTostr(RegAlmacen.NroJugada) = jugada)  then
        cantGanadores:= cantGanadores + 1;

      i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
    end; //while

    CantGanadores_EnUnaJugada(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), jugada, cantGanadores);
    CantGanadores_EnUnaJugada(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), jugada, cantGanadores);
  end;
end;

{------------------------------------------------------------------------------}

Procedure CantGanadores_xNomenclador(RaizGanadores: Lib_Auxiliar.tPos; nomenclador: tNomenclador; var cantGanadores: tCantidad);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);

    while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
    begin
      ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);

      if (RegAlmacen.Nomenclador = nomenclador)  then
        cantGanadores:= cantGanadores + 1;

      i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
    end; //while

    CantGanadores_xNomenclador(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), nomenclador, cantGanadores);
    CantGanadores_xNomenclador(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), nomenclador, cantGanadores);
  end;
end;

{--------------------------------------------------------------------------------}

 procedure MontoEnApuestaXPartida (NroJugada: Type_JUEGO.TClave; var montoTotalApuestas: tImporte);
 var
 i: tpos;
 regApuesta: Type_APUESTA.TipoRegDatos;
 begin
  montoTotalApuestas:= 0;

    i:= ME_APUESTAS.Primero(ME_APUESTA);

     while i<>ME_APUESTAS.PosNula_Apuestas(ME_APUESTA) do
     begin
       ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i,regApuesta);

       if (regapuesta.NroJugada= nrojugada) then //pregunto si es la misma jugada que le paso
          montoTotalApuestas:= montoTotalApuestas + regapuesta.Importe;  //voy juntando el dinero de la partida

      i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
     end;
 end;

{--------------------------------------------------------------------------------}

procedure MontoPremiosXPartida(RaizGanadores: Lib_Auxiliar.tPos; NroJugada: Type_JUEGO.TClave; var montoTotalPremios: tImporte);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);

    while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
    begin
      ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);

      if (intTostr(RegAlmacen.NroJugada) = NroJugada)  then
        montoTotalPremios:= montoTotalPremios + RegAlmacen.Importe;
        
      i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
    end; //while

    MontoPremiosXPartida(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), NroJugada, montoTotalPremios);
    MontoPremiosXPartida(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), NroJugada, montoTotalPremios);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure Cant_RealesYFicticios_xPartida(RaizJugadores: Lib_Auxiliar.tPos; NroJugada: Type_JUEGO.TClave; var cantReales: tCantidad; var cantFicticios: tCantidad);
var
RD:Type_JUGADOR.tRegDatos;
i: tPos;
enc: boolean;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    enc:= false;
    i:= ME_APUESTAS.Primero(ME_APUESTA);
    while i<>ME_APUESTAS.PosNula_Apuestas(ME_aPUESTA) do
    begin
       ME_APUESTAS.CapturarInfoME_Apuestas(ME_aPUESTA,i,regApuesta);

       if (regApuesta.NroJugada = NroJugada) and (regApuesta.Nick = RD.Nick) and not(enc) then
       begin
        if RD.TipoJugador then
          cantReales:= cantReales + 1
        else
          cantFicticios:= cantFicticios + 1;

       enc:= true;
       end;
      i:= ME_APUESTAS.Proximo(ME_aPUESTA,i);
     end; //while

    Cant_RealesYFicticios_xPartida(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), NroJugada, cantReales, cantFicticios);
    Cant_RealesYFicticios_xPartida(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), NroJugada, cantReales, cantFicticios);
  end;
end;


{--------------------------------------------------------------------------------}

Procedure JugadorEsUnGanandor(pos:tPos; Nick: tClave; var esGanador: boolean);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (pos<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, pos);
    if (RegNodoGanador.clave = Nick) then
      esGanador:=true;

    JugadorEsUnGanandor(ME_GANADORES.ProximoIzq(ME_GANADOR, pos), Nick, esGanador);
    JugadorEsUnGanandor(ME_GANADORES.ProximoDer(ME_GANADOR, pos), Nick, esGanador);
  end;
end;

{--------------------------------------------------------------------------------}

procedure ReordenarMasPremiados (var grid: TStringGrid; num:integer; cantFilas: integer);
var
i, j, saldoA, saldoB: integer;
nickA, nickB: Lib_Auxiliar.tClave;
begin
   for I := 1 to cantFilas-1 do
       for j := 1 to cantFilas-1 do
       begin
         SaldoA:= strtoint(grid.Cells[1,i]);
         SaldoB:= strtoint(grid.Cells[1,j]);
         NickA:=  grid.Cells [0,i];
         NickB:=  grid.Cells [0,j];
           if (saldoA>saldoB) then
           begin
              grid.Cells[1,i]:=inttostr(saldoB);
              grid.Cells[0,i]:=nickB;

              grid.Cells[1,j]:=inttostr(saldoA);
              grid.Cells[0,j]:=nickA;
           end;
       end;

    Grid.RowCount:= num + 1;
end;


{--------------------------------------------------------------------------------}

Procedure MovimientoHaberApostadores();
var
RegApuesta: type_APUESTA.TipoRegDatos;
RegCtaCte: Type_ALMACEN.tipoRegAlmacen;
i: tpos;
begin
  //Recorro el ME_APUESTAS capturando las apuestas de la ultima jugada e inserto movimientos del jugador con el importe apostado en su haber
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuegoRuleta);
  i:= ME_APUESTAS.Primero(ME_APUESTA);

    while i<> ME_APUESTAS.PosNula_Apuestas(ME_APUESTA) do
    begin

      ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i, regApuesta);

      if (regApuesta.NroJugada = regJuegoRuleta.NroJugada) then
      begin
        RegCtaCte.Nick:= Uppercase(regApuesta.Nick);
        RegCtaCte.FechaHora:= now();
        RegCtaCte.Concepto:= Type_ALMACEN.tipoConceptos.Numero_Apuesta + regJuegoRuleta.NroJugada;
        RegCtaCte.Debe:=  0;
        RegCtaCte.haber:= regApuesta.Importe;
        RegCtaCte.saldo:= (ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, Uppercase(regApuesta.Nick)) - regApuesta.Importe);
        ME_CTACTE.InsertarAlmacen(ME_CUENTACORRIENTE, RegCtaCte);
      end;

      i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
    end;
end;

{--------------------------------------------------------------------------------}

Procedure EliminarApuestasUnJugador(Nick: tClave);
var
RegApuesta: type_APUESTA.TipoRegDatos;
RegCtaCte: Type_ALMACEN.tipoRegAlmacen;
i: tpos;
begin
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuegoRuleta);
  i:= ME_APUESTAS.Primero(ME_APUESTA);

    while i<> ME_APUESTAS.PosNula_Apuestas(ME_APUESTA) do
    begin

      ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i, regApuesta);

      if (regApuesta.Nick = Nick) then
      begin
        if (regApuesta.NroJugada = regJuegoRuleta.NroJugada) then
          ME_APUESTAS.EliminarInfoME_Apuestas(ME_APUESTA,i);
      end;

      i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
    end;
end;

{--------------------------------------------------------------------------------}

Procedure Cant_JugadoresDesbloqueados(RaizJugadores: Lib_Auxiliar.tPos; var cantDesbloq: Lib_Auxiliar.tCantidad);
var
  RD:Type_JUGADOR.tRegDatos;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    if (RD.Nick <> 'CROUPIER') then
    begin
      if not (RD.Bloqueado) then
        cantDesbloq:= cantDesbloq + 1;
    end;
  Cant_JugadoresDesbloqueados(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), cantDesbloq);
  Cant_JugadoresDesbloqueados(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), cantDesbloq);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure Cant_JugadoresActivos(RaizJugadores: Lib_Auxiliar.tPos; var cantActivos: Lib_Auxiliar.tCantidad);
var
RD:Type_JUGADOR.tRegDatos;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    if (RD.Nick <> 'CROUPIER') and (RD.Estado) then //si no es el CROUPIER y esta activo...
      cantActivos:= cantActivos + 1;

  Cant_JugadoresActivos(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), cantActivos);
  Cant_JugadoresActivos(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), cantActivos);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure ListadoGeneral_JugadoresEnGrid(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
var
RD:Type_JUGADOR.tRegDatos;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    //Recursivo a la Izquierda
    ListadoGeneral_JugadoresEnGrid(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), grid);
     //Raiz
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);
    if (RD.Nick<>'CROUPIER') then
    begin
      grid.RowCount:= grid.RowCount + 1;

      grid.Cells[0, grid.RowCount-1] := RD.Nombre;

      grid.Cells[1, grid.RowCount-1] := RD.Apellido;

      grid.Cells[2, grid.RowCount-1] := RD.Nick;

      if RD.TipoJugador then
        grid.Cells[3, grid.RowCount-1] :='Real'
      else
          grid.Cells[3, grid.RowCount-1] :='Ficticio';

       if (RD.Bloqueado) then
        grid.Cells[4, grid.RowCount-1] :='Bloqueado'
      else
        grid.Cells[4, grid.RowCount-1] :='Desbloqueado';

      if (RD.Estado) then
        grid.Cells[5, grid.RowCount-1] :='SI'
      else
        grid.Cells[5, grid.RowCount-1] :='NO';

      grid.Cells[6, grid.RowCount-1] := datetimetostr(RD.Alta);
      grid.Cells[7, grid.RowCount-1] := datetimetostr(RD.UltimaConexion);

      grid.Cells[8, grid.RowCount-1]:= inttostr(ME_CTACTE.SaldoAcumulado(me_cuentacorriente,RD.Nick));

    end;
    //Recursivo a la Derecha
    ListadoGeneral_JugadoresEnGrid(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), grid);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure Listado_JugadoresActivos(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
var
RD:Type_JUGADOR.tRegDatos;

begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    if (RD.Nick <> 'CROUPIER') then
    begin
        if (RD.Estado) then
        begin
          Grid.RowCount:= Grid.RowCount + 1;

          Grid.Cells[0, Grid.RowCount-1] := RD.Nombre;

          Grid.Cells[1, Grid.RowCount-1] := RD.Apellido;

          Grid.Cells[2, Grid.RowCount-1] := RD.Nick;

          if (RD.TipoJugador) then
            Grid.Cells[3, Grid.RowCount-1] :='Real'
          else
            Grid.Cells[3, Grid.RowCount-1] :='Ficticio';

          if (RD.Bloqueado) then
            Grid.Cells[4, Grid.RowCount-1] :='BLOQUEADO'
          else
            Grid.Cells[4, Grid.RowCount-1] :='DESBLOQUEADO';

          if (RD.Estado) then
            Grid.Cells[5, Grid.RowCount-1] :='SI'
          else
            Grid.Cells[5, Grid.RowCount-1] :='NO';

          Grid.Cells[6, Grid.RowCount-1] := datetimetostr(RD.Alta);

          Grid.Cells[7, Grid.RowCount-1] := datetimetostr(RD.UltimaConexion);

          grid.Cells[8, grid.RowCount-1]:= inttostr(ME_CTACTE.SaldoAcumulado(me_cuentacorriente,RD.Nick));
        end;
    end;
    Listado_JugadoresActivos(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), grid);
    Listado_JugadoresActivos(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), grid);
  end;
end;

{--------------------------------------------------------------------------------}
Procedure ListadoArbolGanadores(RaizGanadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  //Recorrido alrbol Ganadores InOrden(Izq- Der- Raiz)
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    //Recursivo a la Izq
    ListadoArbolGanadores(ME_GANADORES.ProximoIzq(ME_GANADOR,RaizGanadores), grid);

    //Raiz
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);
    Grid.RowCount:= Grid.RowCount + 1;

    grid.Cells[0, grid.RowCount-1] := intTostr(ME_GANADORES.ObtenerNivel_enArbolTri(ME_GANADOR, RegNodoGanador.clave));
    grid.Cells[1, grid.RowCount-1] := RegNodoGanador.clave;

    //Recursivo a la Der
    ListadoArbolGanadores(ME_GANADORES.ProximoDer(ME_GANADOR,RaizGanadores), grid);

  end;
end;

{--------------------------------------------------------------------------------}

Procedure ListadoArbolJugadores(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
var
RD:Type_JUGADOR.tRegDatos;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
   //Recorrido alrbol Jugadores InOrden(Izq- Der- Raiz)
    //Recursivo Izq
    ListadoArbolJugadores(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), grid);

    //Raiz
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);
    grid.RowCount:= grid.RowCount + 1;

    grid.Cells[0, grid.RowCount-1] := intTostr(ME_JUGADORES.ObtenerNivel_enArbol(ME_JUGADOR, RD.nick));
    grid.Cells[1, grid.RowCount-1] := RD.nick;

    //Recursivo Der
    ListadoArbolJugadores(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), grid);
  end;
end;

{--------------------------------------------------------------------------------}

procedure ListadoPartidas (var grid: TStringGrid);
var
regPartida: Type_JUEGO.TipoRegDatos;
posPartida: tpos;
i: tpos;
regnulo: Type_JUEGO.TipoRegDatos;

cantReales: tCantidad;
cantFicticios: tCantidad;
montoTotalApuestas: tImporte;
montoTotalPremios: tImporte;
begin
  ME_JUEGO.RegistroNulo(regnulo);
  ME_JUEGO.Insertar(ME_JUEGORULETA, regnulo);
  ME_JUEGO.Frente(ME_JUEGORULETA,regPartida);
  ME_JUEGO.Decolar(ME_JUEGORULETA);

  while regpartida.NroJugada<>ME_JUEGO.ClaveNula(ME_JUEGORULETA) do
  begin
    montoTotalPremios:= 0;
    cantReales:= 0;
    cantFicticios:= 0;
    grid.RowCount:= grid.RowCount + 1;

    MontoEnApuestaXPartida(regpartida.NroJugada, montoTotalApuestas);
    MontoPremiosXPartida(ME_GANADORES.Raiz(ME_GANADOR), regpartida.NroJugada , montoTotalPremios);
    Cant_RealesYFicticios_xPartida(ME_JUGADORES.Raiz(ME_JUGADOR), regpartida.NroJugada, cantReales, cantFicticios);

    grid.Cells[0, grid.RowCount-1]:= regpartida.nrojugada;
    grid.Cells[1, grid.RowCount-1]:= datetimetostr(regPartida.FechaHora);;
    grid.Cells[2, grid.RowCount-1]:= inttostr(cantReales);
    grid.Cells[3, grid.RowCount-1]:= inttostr(cantFicticios);
    grid.Cells[4, grid.RowCount-1]:= inttostr(montoTotalApuestas);
    grid.Cells[5, grid.RowCount-1]:= inttostr(montoTotalPremios);
    grid.Cells[6, grid.RowCount-1]:= inttostr(regPartida.Bolilla);


    ME_JUEGO.Insertar(ME_JUEGORULETA, regPartida);
    ME_JUEGO.Frente(ME_JUEGORULETA,regPartida);
    ME_JUEGO.Decolar(ME_JUEGORULETA);
  end;
end;

{--------------------------------------------------------------------------------}


Procedure ListadoJugadoresNuncaGanaron(RaizJugadores: Lib_Auxiliar.tPos; var grid: TStringGrid);
var
RD:Type_JUGADOR.tRegDatos;
esGanador: boolean;
begin
  esGanador:= false;
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);
    if (RD.Nick<>'CROUPIER') then
    begin
      JugadorEsUnGanandor(ME_GANADORES.Raiz(ME_GANADOR), RD.Nick, esGanador);
      if not(esGanador) then
      begin
        grid.RowCount:= grid.RowCount + 1;

        grid.Cells[0, grid.RowCount-1] := RD.Nombre;

        grid.Cells[1, grid.RowCount-1] := RD.Apellido;

        grid.Cells[2, grid.RowCount-1] := RD.Nick;

        if RD.TipoJugador then
          grid.Cells[3, grid.RowCount-1] :='Real'
        else
            grid.Cells[3, grid.RowCount-1] :='Ficticio';

         if (RD.Bloqueado) then
          grid.Cells[4, grid.RowCount-1] :='Bloqueado'
        else
          grid.Cells[4, grid.RowCount-1] :='Desbloqueado';

        if (RD.Estado) then
          grid.Cells[5, grid.RowCount-1] :='SI'
        else
          grid.Cells[5, grid.RowCount-1] :='NO';

        grid.Cells[6, grid.RowCount-1] := datetimetostr(RD.Alta);
        grid.Cells[7, grid.RowCount-1] := datetimetostr(RD.UltimaConexion);

        grid.Cells[8, grid.RowCount-1]:= inttostr(ME_CTACTE.SaldoAcumulado(me_cuentacorriente,RD.Nick));

      end;
    end;
    ListadoJugadoresNuncaGanaron(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), grid);
    ListadoJugadoresNuncaGanaron(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), grid);
  end;
end;


{--------------------------------------------------------------------------------}
//Procedimiento recursivo donde muestra la cuenta corriente de un jugador de forma ordenada por fecha y hora
procedure ListadoCtaCte_deUnJugador(posListaParcial: tPos; Nick: tclave; var grid: TStringGrid);
var
i: tpos;
regAlm: Type_ALMACEN.tipoRegAlmacen;
begin
  i:= posListaParcial;

  If i<>ME_CTACTE.PosNula(ME_CUENTACORRIENTE) then
  begin
    ListadoCtaCte_deUnJugador(ME_CTACTE.ProximoEnLdParcial(ME_CUENTACORRIENTE,i), Nick, grid);

    ME_CTACTE.CapturarEnAlmacen(ME_CUENTACORRIENTE,i,regAlm);

    if (regAlm.Nick = Nick) then
    begin
      grid.RowCount:= grid.RowCount + 1;

      grid.Cells[0, grid.RowCount-1]:= regAlm.Nick;
      grid.Cells[1, grid.RowCount-1]:= datetimetostr(regAlm.FechaHora);
      grid.Cells[2, grid.RowCount-1]:= regAlm.Concepto;
      grid.Cells[3, grid.RowCount-1]:= inttostr(regAlm.Debe);
      grid.Cells[4, grid.RowCount-1]:= inttostr(regAlm.haber);
      grid.Cells[5, grid.RowCount-1]:= inttostr(regAlm.saldo);
    end;
  end;
end;

{--------------------------------------------------------------------------------}

procedure ReordenarGridPorFecha (var grid: TStringGrid; cantFilas: integer);
var
i, j, cant: integer;
saldo1, saldo2, debe1, debe2, haber1, haber2: integer;
nick1, nick2: Lib_Auxiliar.tClave;
concepto1, concepto2: string;
FechaHora1, FechaHora2: tDateTime;
begin
  showmessage(intTostr(cantFilas));

   for I := 1 to cantFilas - 1 do
   begin
       for j := 1 to cantFilas - 1 do
       begin
        Saldo1:= strtoint(grid.Cells[5,i]); Saldo2:= strtoint(grid.Cells[5,j]);
        Haber1:= strtoint(grid.Cells[4,i]); Haber2:= strtoint(grid.Cells[4,j]);
        Debe1:= strtoint(grid.Cells[3,i]); Debe2:= strtoint(grid.Cells[3,j]);
        Concepto1:= (grid.Cells[2,i]); Concepto2:=(grid.Cells[2,j]);
        FechaHora1:= strTodatetime(grid.Cells[1,i]); FechaHora2:= strTodatetime(grid.Cells[1,j]);
        Nick1:= grid.Cells [0,i]; Nick2:= grid.Cells [0,j];

        //Intercambio celdas
        grid.Cells[5,i]:= intTostr(Saldo2);
        grid.Cells[5,j]:= intTostr(Saldo1);

        grid.Cells[4,i]:= intTostr(Haber2);
        grid.Cells[4,j]:= intTostr(Haber1);

        grid.Cells[3,i]:= intTostr(Debe2);
        grid.Cells[3,j]:= intTostr(Debe1);

        grid.Cells[2,i]:= Concepto2;
        grid.Cells[2,j]:= Concepto1;

        grid.Cells[1,i]:= datetimetostr(FechaHora2);
        grid.Cells[1,j]:= datetimetostr(FechaHora1);

        grid.Cells[0,i]:= nick2;
        grid.Cells[0,j]:= nick1;

       end;
   end;

  grid.RowCount:= cantFilas + 1;
end;

{--------------------------------------------------------------------------------}

Procedure ListadoPremiados_Nomenclador(RaizGanadores: Lib_Auxiliar.tPos; nomenclador: tNomenclador; var grid: TStringGrid);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);

    while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
    begin
      ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);

      if (RegAlmacen.Nomenclador = nomenclador)  then
      begin
        Grid.RowCount:= Grid.RowCount + 1;

        Grid.Cells[0, Grid.RowCount-1] := RegNodoGanador.clave;
        Grid.Cells[1, Grid.RowCount-1] := intTostr(RegAlmacen.NroJugada);
        Grid.Cells[2, Grid.RowCount-1] := RegAlmacen.Nomenclador;
        Grid.Cells[3, Grid.RowCount-1] := intTostr(RegAlmacen.Numero);
        Grid.Cells[4, Grid.RowCount-1] := intTostr(RegAlmacen.Importe);
      end;
      i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
    end; //while

    ListadoPremiados_Nomenclador(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), nomenclador, grid);
    ListadoPremiados_Nomenclador(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), nomenclador, grid);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure ListadoMasPremiados(RaizGanadores: Lib_Auxiliar.tPos; var importe:tImporte; var grid: TStringGrid; var cantFilas: integer);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);

    while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
    begin
      ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);
      importe:= importe + RegAlmacen.Importe;
      i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
    end; //while

    cantFilas:= cantFilas + 1;
    Grid.RowCount:= Grid.RowCount + 1;
    Grid.Cells[0, Grid.RowCount-1] := RegNodoGanador.clave;
    Grid.Cells[1, Grid.RowCount-1] := intTostr(importe);

    ListadoMasPremiados(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), importe, grid, cantFilas);
    ListadoMasPremiados(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), importe, grid, cantFilas);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure Listado_GeneralApuestas(var grid: TStringGrid; Nro_Jugada: Type_JUEGO.tClave);
var
  i:tPos;
begin
  i:= ME_APUESTAS.Primero(ME_APUESTA);

        while i<>ME_APUESTAS.PosNula_Apuestas(ME_APUESTA) do
        begin
          ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i,regApuesta);

          if (regApuesta.NroJugada = Nro_Jugada) then
            begin
              grid.RowCount:= grid.RowCount + 1;
              {Agrego renglon}
              grid.Cells[0, grid.RowCount-1] := regApuesta.Nick;
              grid.Cells[1, grid.RowCount-1] := regApuesta.Nomenclador;
              grid.Cells[2, grid.RowCount-1] := regApuesta.Valor;
              grid.Cells[3, grid.RowCount-1] := intTostr(regApuesta.Importe);
            end;

         i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
        END; //while
end;

{--------------------------------------------------------------------------------}

Procedure Listado_ApuestasUnJugador(var grid: TStringGrid; Nro_Jugada: Type_JUEGO.tClave; nick: Type_JUGADOR.TClave);
var
  i:tPos;
begin
i:= ME_APUESTAS.Primero(ME_APUESTA);

  while i<>ME_APUESTAS.PosNula_Apuestas(ME_APUESTA) do
  begin
    ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i,regApuesta);
    if (regApuesta.NroJugada = Nro_Jugada) then
    begin
      if (regApuesta.Nick = nick) then
      begin
        grid.RowCount:= grid.RowCount + 1;
        {Agrego renglon}
        grid.Cells[0, grid.RowCount-1] := regApuesta.Nick;
        grid.Cells[1, grid.RowCount-1] := regApuesta.Nomenclador;
        grid.Cells[2, grid.RowCount-1] := regApuesta.Valor;
        grid.Cells[3, grid.RowCount-1] := intTostr(regApuesta.Importe);
      end;
    end;

   i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
  END; //while
end;

{--------------------------------------------------------------------------------}

Procedure Listado_Premios(RaizGanadores: Lib_Auxiliar.tPos; jugada: Type_JUEGO.TClave; var grid: TStringGrid);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);

    while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
    begin
      ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);

      if (intTostr(RegAlmacen.NroJugada) = jugada)  then
      begin
        grid.RowCount:= grid.RowCount + 1;
        grid.Cells[0, grid.RowCount-1] := RegNodoGanador.clave;
        grid.Cells[1, grid.RowCount-1] := RegAlmacen.Nomenclador;
        grid.Cells[2, grid.RowCount-1] := intTostr(RegAlmacen.Numero);
        grid.Cells[3, grid.RowCount-1] := intTostr(RegAlmacen.Importe);
      end;
      i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
    end; //while

    Listado_Premios(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), jugada, grid);
    Listado_Premios(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), jugada, grid);
  end;
end;

{--------------------------------------------------------------------------------}

procedure Ini_Sesion (var Me: ME_JUGADORES.ME_JUGADOR; var regJugador: Type_JUGADOR.tRegDatos);
var
  pos:tPos;
begin
  regJugador.UltimaConexion:= NOW();
  regJugador.Estado:= true;

  ME_JUGADORES.BuscarInfoME_Jugadores(Me, pos, regJugador.Nick);
  ME_JUGADORES.ModificarInfoME_Jugadores(Me, regJugador,pos);
end;

{--------------------------------------------------------------------------------}

procedure Fin_Sesion (var Me: ME_JUGADORES.ME_JUGADOR; var regJugador: Type_JUGADOR.tRegDatos);
var
  pos:tPos;
begin
  regJugador.UltimaConexion:= NOW();
  regJugador.Estado:= false;

  ME_JUGADORES.BuscarInfoME_Jugadores(Me, pos, regJugador.Nick);
  ME_JUGADORES.ModificarInfoME_Jugadores(Me, regJugador,pos);
end;


{--------------------------------------------------------------------------------}

procedure recuperarRegPartida (Nro_Jugada: Type_JUEGO.tClave; var regBuscado: Type_JUEGO.TipoRegDatos);
var
  regnulo, regPartida: Type_JUEGO.TipoRegDatos;
  corte: boolean;
begin
  ME_JUEGO.RegistroNulo(regnulo);
  ME_JUEGO.Insertar(ME_JUEGORULETA, regnulo);
  ME_JUEGO.Frente(ME_JUEGORULETA,regPartida);
  ME_JUEGO.Decolar(ME_JUEGORULETA);

  //Ciclo hasta que se encuentra con el regBandera
  while regPartida.NroJugada<>ME_JUEGO.ClaveNula(ME_JUEGORULETA) do
  begin
    //Si encontre el regustro de la jugada que busco, lo guardo en el registro parametrizado por referencia
    if Nro_Jugada = regPartida.NroJugada then
      regBuscado:= regPartida;

    ME_JUEGO.Insertar(ME_JUEGORULETA, regPartida);
    ME_JUEGO.Frente(ME_JUEGORULETA,regPartida);
    ME_JUEGO.Decolar(ME_JUEGORULETA);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure CantidadJugadoresNuncaGanaron(RaizJugadores: Lib_Auxiliar.tPos; var cant: tCantidad);
var
RD:Type_JUGADOR.tRegDatos;
esGanador: boolean;
begin
  esGanador:= false;
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);
    if (RD.Nick<>'CROUPIER') then
    begin
      JugadorEsUnGanandor(ME_GANADORES.Raiz(ME_GANADOR), RD.Nick, esGanador);
      if not(esGanador) then
        cant:= cant + 1;
    end;
    CantidadJugadoresNuncaGanaron(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores), cant);
    CantidadJugadoresNuncaGanaron(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores), cant);
  end;
end;

{--------------------------------------------------------------------------------}

Procedure InsertoPremioUnGanador(regGanador: Type_GANADOR.TipoRegDatos; var regApuesta: Type_APUESTA.TipoRegDatos; tipoGanador: tNomenclador; Importe: tImporte);
begin
  if (tipoGanador <> type_APUESTA.Nom_Pleno) then
    regApuesta.Valor:= '-1';

  regGanador.Nomenclador:= regApuesta.Nomenclador;
  regGanador.Numero:= strToint(regApuesta.Valor); //
  regGanador.NroJugada:= strToint(regApuesta.NroJugada);
  regGanador.Importe:= Importe; //
  //Inserto ganador
  ME_GANADORES.InsertarInfoME_Ganadores(ME_GANADOR,regGanador, regApuesta.Nick);
end;

{--------------------------------------------------------------------------------}

Procedure MovimientoApuestaUnJugador(nick: tClave; regApuesta: Type_APUESTA.TipoRegDatos; apostado:tImporte; ImporteGanado: tImporte);
begin
  //Completo registro movimiento en CtaCte
  regCtaCte.Nick:= nick;
  regCtaCte.FechaHora:= Now();
  regCtaCte.Concepto:= Type_ALMACEN._PremioJuego + regApuesta.NroJugada; //
  regCtaCte.Debe:= ImporteGanado + apostado;
  regCtaCte.haber:= 0;
  regCtaCte.saldo:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regApuesta.Nick) + regCtaCte.Debe;
  //Inserto movimiento en CtaCte
  ME_CTACTE.InsertarAlmacen(ME_CUENTACORRIENTE, regCtaCte);
end;

{--------------------------------------------------------------------------------}

Procedure Premios_AcumuladosXJugador(RaizGanadores: Lib_Auxiliar.tPos; Nick:Type_JUGADOR.tClave; var cantPremios: tCantidad; var Monto: tImporte);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    if (RegNodoGanador.clave = Nick) then
    begin
       i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);
        while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
        begin
          ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);
          Monto:= Monto + RegAlmacen.Importe;
          cantPremios:= cantPremios + 1;

          i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
        end; //while
    end;

    Premios_AcumuladosXJugador(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), Nick, cantPremios, Monto);
    Premios_AcumuladosXJugador(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), Nick, cantPremios, Monto);
  end;
end;

{------------------------------------------------------------------------------}

Procedure Premios_AcumuladosXJugadorUnaJugada(RaizGanadores: Lib_Auxiliar.tPos; Nick:Type_JUGADOR.tClave; jugada: Type_JUEGO.TClave; var Monto: tImporte);
var
RegNodoGanador: regNodo;
RegAlmacen: type_GANADOR.TipoRegDatos;
i: tPos;
begin
  if (RaizGanadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_GANADORES.CapturarInfoME_Ganadores(ME_GANADOR, RegNodoGanador, RaizGanadores);

    if (RegNodoGanador.clave = Nick) then
    begin
       i:= ME_GANADORES.PrimerJugada_Ganador(ME_GANADOR, RegNodoGanador);
        while i<> ME_GANADORES.PosNula_Ganadores(ME_GANADOR) do
        begin
          ME_GANADORES.CapturarJugada_Ganador(ME_GANADOR, i, RegAlmacen);
          if (intTostr(RegAlmacen.NroJugada) = jugada)  then
            Monto:= Monto + RegAlmacen.Importe;

          i:= ME_GANADORES.SiguienteJugada_Ganador(ME_GANADOR, i);
        end; //while
    end;

    Premios_AcumuladosXJugadorUnaJugada(ME_GANADORES.ProximoIzq(ME_GANADOR, RaizGanadores), Nick, jugada, Monto);
    Premios_AcumuladosXJugadorUnaJugada(ME_GANADORES.ProximoDer(ME_GANADOR, RaizGanadores), Nick, jugada, Monto);
  end;
end;

{--------------------------------------------------------------------------------}

 Function JugadorTieneApuestasEnPartida (NroJugada: Type_JUEGO.TClave; nick: Type_JUGADOR.tClave): boolean;
 var
 i: tpos;
 regApuesta: Type_APUESTA.TipoRegDatos;
 begin
    i:= ME_APUESTAS.Primero(ME_APUESTA);

     while i<>ME_APUESTAS.PosNula_Apuestas(ME_APUESTA) do
     begin
       ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA,i,regApuesta);

       if (regapuesta.NroJugada= nrojugada) then //pregunto si es la misma jugada que le paso
       begin
         if (regapuesta.Nick= nick) then //pregunto si es el jugador que le paso
          JugadorTieneApuestasEnPartida:= true;  
       end;

      i:= ME_APUESTAS.Proximo(ME_APUESTA,i);
     end;
 end;
 
{--------------------------------------------------------------------------------}

function Mensaje_Confirmacion(Msje: String): boolean;
begin
  if messagedlg(Msje, mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
    Mensaje_Confirmacion := true
  else
    Mensaje_Confirmacion := false;
end;

{------------------------------------------------------------------------------}

procedure limpiarGrid(grid: TStringGrid);
var
  i:integer;
begin
  with grid  do
    for i := 0 to RowCount - 1 do
      Rows[i].Clear;
end;

{------------------------------------------------------------------------------}

Procedure EncabezadoDetalladoJugadores(grid: TStringGrid);
Begin
  with grid do
  Begin
  //cambio el total de columnas
    grid.ColCount:= 9;
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxx');
    ColWidths[4] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxx');
    ColWidths[5] := Canvas.TextWidth('xxxxxxxxxx');
    ColWidths[6] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[7] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[8] := Canvas.TextWidth('xxxxxxxxxxxxx');
    Cells[0, 0] := 'NOMBRE';
    Cells[1, 0] := 'APELLIDO';
    Cells[2, 0] := 'NICK';
    Cells[3, 0] := 'TIPO';
    Cells[4, 0] := 'ESTADO';
    Cells[5, 0] := 'ACTIVO';
    Cells[6, 0] := 'FECHA ALTA';
    Cells[7, 0] := 'ULT. CONEXI�N';
    Cells[8, 0] := 'SALDO';
  End;
End;

{--------------------------------------------------------------------------------}

Procedure EncabezadoArbolJugadores(grid: TStringGrid);
Begin
  with grid do
  Begin
  //cambio el total de columnas
    grid.ColCount:= 2;
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'NIVEL';
    Cells[1, 0] := 'NICK';
  End;
End;

{--------------------------------------------------------------------------------}

Procedure EncabezadoListadoPartidas(grid: TStringGrid);
Begin
  with grid do
  Begin
  //cambio el total de columnas
    grid.ColCount:= 7;
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[4] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[5] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[6] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'NRO.PARTIDA';
    Cells[1, 0] := 'FECHA-HORA';
    Cells[2, 0] := 'TOTAL J.REALES';
    Cells[3, 0] := 'TOTAL J.FICTICIOS';
    Cells[4, 0] := '$ APOSTADO';
    Cells[5, 0] := '$ PREMIOS PAGADOS';
    Cells[6, 0] := 'NRO. BOLILLA';
  End;
End;

{--------------------------------------------------------------------------------}

Procedure EncabezadoJugadoresMasGanaron(grid: TStringGrid);
Begin
  with grid do
  Begin
  //cambio el total de columnas
    grid.ColCount:= 2;
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxx');
    Cells[0, 0] := 'NICK';
    Cells[1, 0] := 'SALDO';
  End;
End;

{--------------------------------------------------------------------------------}

Procedure EncabezadoGanadoresXPremio(grid: TStringGrid);
Begin
  with grid do
  Begin
  //cambio el total de columnas
    grid.ColCount:= 5;
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxx');
    ColWidths[4] := Canvas.TextWidth('xxxxxxxxxxxxxx');
    Cells[0, 0] := 'NICK';
    Cells[1, 0] := 'JUGADA';
    Cells[2, 0] := 'NOMENCLADOR';
    Cells[3, 0] := 'NUMERO';
    Cells[4, 0] := 'PREMIO';
  End;
End;

{--------------------------------------------------------------------------------}

Procedure EncabezadoFiltroCtaCte(grid: TStringGrid);
Begin
  with grid do
  Begin
  //cambio el total de columnas
    grid.ColCount:= 6;
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[4] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[5] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'NICK';
    Cells[1, 0] := 'FECHA/HR';
    Cells[2, 0] := 'CONCEPTO';
    Cells[3, 0] := 'DEBE';
    Cells[4, 0] := 'HABER';
    Cells[5, 0] := 'SALDO';
  End;
End;

{--------------------------------------------------------------------------------}

Procedure EncabezadosComunApuestas(grid: TStringGrid);
begin
  with grid do
  Begin
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'NICK';
    Cells[1, 0] := 'NOMENCLADOR';
    Cells[2, 0] := 'VALOR';
    Cells[3, 0] := 'IMPORTE';
  End;
end;

{--------------------------------------------------------------------------------}

Procedure EncabezadosComunJugadores(grid: TStringGrid);
Begin
  with grid do
  Begin
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[4] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[5] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'NICK';
    Cells[1, 0] := 'NOMBRE J.';
    Cells[2, 0] := 'APELLIDO J.';
    Cells[3, 0] := 'TIPO';
    Cells[4, 0] := 'BLOQUEADO';
    Cells[5, 0] := 'ULT. CONEXI�N';
  End;
End;

{------------------------------------------------------------------------------}

Procedure EncabezadoGridPremios(grid: TStringGrid);
begin
  with grid do
  Begin
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'JUGADOR';
    Cells[1, 0] := 'NOMENCLADOR';
    Cells[2, 0] := 'NUMERO';
    Cells[3, 0] := 'PREMIO';
  End;
end;

{------------------------------------------------------------------------------}

Procedure EncabezadosComunFicticios(grid: TStringGrid);
Begin
  with grid do
  Begin
  // T�tulo de las columnas
    ColWidths[0] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[1] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[2] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[3] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[4] := Canvas.TextWidth('xxxxxxxxxxxxxxxxx');
    ColWidths[5] := Canvas.TextWidth('xxxxxxxxxx');
    ColWidths[6] := Canvas.TextWidth('xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    Cells[0, 0] := 'NICK';
    Cells[1, 0] := 'NOMBRE J.';
    Cells[2, 0] := 'APELLIDO J.';
    Cells[3, 0] := 'TIPO';
    Cells[4, 0] := 'ESTADO';
    Cells[5, 0] := 'SALDO';
    Cells[6, 0] := 'ALTA';
  End;
End;


END.
