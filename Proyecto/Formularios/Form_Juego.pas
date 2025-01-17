unit Form_Juego;

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
  Lib_AuxJuego,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Imaging.jpeg, Vcl.Menus,
  Vcl.Imaging.GIFImg, Vcl.Grids;

type
  TF_Juego = class(TForm)
    Splitter1: TSplitter;
    Panel_JuegoGral: TPanel;
    Panel_EncabezadoJuego: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Lbl_nroPartida: TLabel;
    Panel15: TPanel;
    Label4: TLabel;
    Lbl_usuarioActual: TLabel;
    Panel16: TPanel;
    Label2: TLabel;
    Lbl_fechaActual: TLabel;
    Label3: TLabel;
    Lbl_horaActual: TLabel;
    Panel_Crupier: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel7: TPanel;
    Panel11: TPanel;
    Lbl_bolillaASalir: TLabel;
    Lbl_nroBolillaG: TLabel;
    Panel12: TPanel;
    Panel_NameTablero: TPanel;
    Label9: TLabel;
    menuFormJuego: TMainMenu;
    SALIR1: TMenuItem;
    Panel_Jugadores: TPanel;
    Panel18: TPanel;
    Label11: TLabel;
    Lbl_estadoJuego: TLabel;
    Label10: TLabel;
    Panel19: TPanel;
    Label12: TLabel;
    Lbl_saldoAcumulado: TLabel;
    Label14: TLabel;
    Panel20: TPanel;
    Label13: TLabel;
    Label15: TLabel;
    Lbl_ApuestaMax: TLabel;
    Panel21: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Lbl_ApuestaMin: TLabel;
    Panel23: TPanel;
    Label19: TLabel;
    Spbtn_haganApuestas: TSpeedButton;
    Spbtn_noVaMas: TSpeedButton;
    Spbtn_tirarBolilla: TSpeedButton;
    Spbtn_obsequiarCred: TSpeedButton;
    Spbtn_activarFicticios: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Spbtn_CrearPartida: TSpeedButton;
    Lbl_totalFicticios: TLabel;
    Lbl_cantFicticios: TLabel;
    Listarapuestas1: TMenuItem;
    Premiados1: TMenuItem;
    Spbtn_repartirPremios: TBitBtn;
    Spbtn_trampa: TSpeedButton;
    Panel13: TPanel;
    Spbtn_refresh: TSpeedButton;
    Spbtn_bloqDesbloq: TSpeedButton;
    Panel14: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Lbl_CantEnLinea: TLabel;
    Lbl_CantFictActivados: TLabel;
    panel_tablero: TPanel;
    tabla_Image0: TImage;
    tabla_Image6: TImage;
    tabla_Image15: TImage;
    tabla_Image21: TImage;
    tabla_Image12: TImage;
    tabla_Image18: TImage;
    tabla_Image9: TImage;
    tabla_Image24: TImage;
    tabla_Image27: TImage;
    tabla_Image30: TImage;
    tabla_Image33: TImage;
    tabla_Image36: TImage;
    tabla_ImageTerceraCol: TImage;
    tabla_Image2: TImage;
    tabla_Image5: TImage;
    tabla_Image8: TImage;
    tabla_Image11: TImage;
    tabla_Image14: TImage;
    tabla_Image17: TImage;
    tabla_Image20: TImage;
    tabla_Image23: TImage;
    tabla_Image26: TImage;
    tabla_Image29: TImage;
    tabla_Image32: TImage;
    tabla_Image35: TImage;
    tabla_Image4: TImage;
    tabla_Image7: TImage;
    tabla_Image10: TImage;
    tabla_Image13: TImage;
    tabla_Image16: TImage;
    tabla_Image19: TImage;
    tabla_Image22: TImage;
    tabla_Image25: TImage;
    tabla_Image28: TImage;
    tabla_Image31: TImage;
    tabla_Image34: TImage;
    tabla_ImageSegundaCol: TImage;
    tabla_ImagePrimeraCol: TImage;
    tabla_ImagePrimeros12: TImage;
    tabla_ImageSegundos12: TImage;
    tabla_ImageTerceros12: TImage;
    tabla_ImageRojo: TImage;
    tabla_ImageNegro: TImage;
    tabla_ImageImpares: TImage;
    tabla_Image_19a36: TImage;
    tabla_Image3: TImage;
    tabla_Image1: TImage;
    tabla_Image_1a18: TImage;
    tabla_ImagePares: TImage;
    Panel_Winner: TPanel;
    Timer_showWinner1: TTimer;
    Timer_showWinner2: TTimer;
    Timer_showWinner3: TTimer;
    Timer_showWinner4: TTimer;
    Timer_showLoser1: TTimer;
    Timer_showLoser2: TTimer;
    Timer_showLoser3: TTimer;
    Timer_showLoser4: TTimer;
    Timer_showWinner5: TTimer;
    Timer_showWinner6: TTimer;
    Timer_showLoser5: TTimer;
    Timer_showLoser6: TTimer;
    Panel_ShowWinner: TPanel;
    Label7: TLabel;
    Label18: TLabel;
    Lbl_montoWinner: TLabel;
    Label20: TLabel;
    Lbl_bolillaGWinner: TLabel;
    gifWinner: TImage;
    Btn_closePnelWinner: TBitBtn;
    Lbl_waiting: TLabel;
    Panel_Loser: TPanel;
    Label8: TLabel;
    Lbl_bolillaGLoser: TLabel;
    Label22: TLabel;
    Btn_closePnelLoser: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AutoSize_ImagenesTablero();
    procedure pantallaIniJuegoCrupier();
    procedure pantallaIniJuegoJugadores();
    procedure ListarPremiados(Nro_Jugada: Type_JUEGO.tClave);
    procedure ListandoApuestas();
    procedure Spbtn_bloqDesbloqClick(Sender: TObject);
    procedure Spbtn_obsequiarCredClick(Sender: TObject);
    procedure SALIR1Click(Sender: TObject);
    procedure TableroLegalSeleccionado(nomenclador:Type_APUESTA.tNomenclador;valor:Type_APUESTA.tNomenclador; nameOp:string);
    procedure TableroTrampaSeleccionado(num_bolilla:Type_JUEGO.tBolilla);
    procedure refrezcarPantallaNormalUser();
    procedure ActualizarFechaHora(var Lbl_fecha:TLabel; var Lbl_hora: TLabel);
    procedure tabla_Image3Click(Sender: TObject);
    procedure Spbtn_cancelarSelectTabClick(Sender: TObject);
    procedure tabla_Image1Click(Sender: TObject);
    procedure tabla_Image2Click(Sender: TObject);
    procedure tabla_Image4Click(Sender: TObject);
    procedure tabla_Image5Click(Sender: TObject);
    procedure tabla_Image6Click(Sender: TObject);
    procedure tabla_Image7Click(Sender: TObject);
    procedure tabla_Image8Click(Sender: TObject);
    procedure tabla_Image9Click(Sender: TObject);
    procedure tabla_Image10Click(Sender: TObject);
    procedure tabla_Image11Click(Sender: TObject);
    procedure tabla_Image12Click(Sender: TObject);
    procedure tabla_Image13Click(Sender: TObject);
    procedure tabla_Image14Click(Sender: TObject);
    procedure tabla_Image15Click(Sender: TObject);
    procedure tabla_Image16Click(Sender: TObject);
    procedure tabla_Image17Click(Sender: TObject);
    procedure tabla_Image18Click(Sender: TObject);
    procedure tabla_Image19Click(Sender: TObject);
    procedure tabla_Image20Click(Sender: TObject);
    procedure tabla_Image21Click(Sender: TObject);
    procedure tabla_Image22Click(Sender: TObject);
    procedure tabla_Image23Click(Sender: TObject);
    procedure tabla_Image24Click(Sender: TObject);
    procedure tabla_Image25Click(Sender: TObject);
    procedure tabla_Image26Click(Sender: TObject);
    procedure tabla_Image27Click(Sender: TObject);
    procedure tabla_Image28Click(Sender: TObject);
    procedure tabla_Image29Click(Sender: TObject);
    procedure tabla_Image30Click(Sender: TObject);
    procedure tabla_Image31Click(Sender: TObject);
    procedure tabla_Image32Click(Sender: TObject);
    procedure tabla_Image33Click(Sender: TObject);
    procedure tabla_Image34Click(Sender: TObject);
    procedure tabla_Image35Click(Sender: TObject);
    procedure tabla_Image36Click(Sender: TObject);
    procedure tabla_Image0Click(Sender: TObject);
    procedure tabla_ImageTerceraColClick(Sender: TObject);
    procedure tabla_ImageSegundaColClick(Sender: TObject);
    procedure tabla_ImagePrimeraColClick(Sender: TObject);
    procedure tabla_ImagePrimeros12Click(Sender: TObject);
    procedure tabla_ImageSegundos12Click(Sender: TObject);
    procedure tabla_ImageTerceros12Click(Sender: TObject);
    procedure tabla_Image_1a18Click(Sender: TObject);
    procedure tabla_ImageParesClick(Sender: TObject);
    procedure tabla_ImageImparesClick(Sender: TObject);
    procedure tabla_Image_19a36Click(Sender: TObject);
    procedure tabla_ImageRojoClick(Sender: TObject);
    procedure tabla_ImageNegroClick(Sender: TObject);
    procedure Spbtn_activarFicticiosClick(Sender: TObject);
    procedure Spbtn_CrearPartidaClick(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure Spbtn_haganApuestasClick(Sender: TObject);
    procedure Spbtn_noVaMasClick(Sender: TObject);
    procedure Spbtn_tirarBolillaClick(Sender: TObject);
    procedure Spbtn_trampaClick(Sender: TObject);
    procedure Spbtn_repartirPremiosClick(Sender: TObject);
    procedure ActiveBtnTrampa();
    procedure DesactiveBtnTrampa();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Listarapuestas1Click(Sender: TObject);
    //procedure SoloMostrarApuestas();
    procedure Premiados1Click(Sender: TObject);
    procedure SalirDelJuego();
    procedure Spbtn_refreshClick(Sender: TObject);
    procedure Timer_showWinner1Timer(Sender: TObject);
    procedure Timer_showWinner2Timer(Sender: TObject);
    procedure Timer_showWinner3Timer(Sender: TObject);
    procedure Timer_showWinner4Timer(Sender: TObject);
    procedure Timer_showLoser1Timer(Sender: TObject);
    procedure Timer_showLoser2Timer(Sender: TObject);
    procedure Timer_showLoser3Timer(Sender: TObject);
    procedure Timer_showLoser4Timer(Sender: TObject);
    procedure Btn_closePnelWinnerClick(Sender: TObject);
    procedure Btn_closePnelLoserClick(Sender: TObject);
    procedure Timer_showWinner5Timer(Sender: TObject);
    procedure Timer_showWinner6Timer(Sender: TObject);
    procedure Timer_showLoser5Timer(Sender: TObject);
    procedure Timer_showLoser6Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Juego: TF_Juego;
  Nomenclador: Type_APUESTA.tNomenclador;
  totalFicticios: Lib_Auxiliar.tCantidad;
  apuestaMax, apuestaMin: Type_JUEGO.tImporte;
  btnActiveNow:string;
  BtnTrampaIsActive: boolean;
  nameOp:string;
  valor: string;
  EstadoJuego: integer;
  SoloListar: boolean;
  ShowWinner: boolean;


implementation

uses
  Form_login, Form_Jugadores, Form_Croupier, Form_PanelCaseButtons, Form_Apostar, Form_PanelFicticios, Form_Premios;

{$R *.dfm}

{--------------------------------------------------------------------------------}

procedure TF_Juego.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_PanelFicticios.Close;
  F_PanelCaseButtons.Close;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.FormCreate(Sender: TObject);
begin
  apuestaMax:= ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA);
  apuestaMin:= ME_JUEGO.ApuestaMinima(ME_JUEGORULETA);

  Spbtn_bloqDesbloq.Caption:= '[ BLOQUEAR/' +#13+ 'DESBLOQUEAR ]';

  //generalidades de formulario
  self.Position := poScreenCenter;
  self.WindowState := wsMaximized;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.FormShow(Sender: TObject);
var
  i:integer;
begin
  Panel_Winner.Visible:= false;
  Panel_Loser.Visible:= false;
  Panel_ShowWinner.Visible:= false;
  //Si es croupier
  if (Form_login.AdminLog) then
    pantallaIniJuegoCrupier()
  else // si es jugador comun
    pantallaIniJuegoJugadores();
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Listarapuestas1Click(Sender: TObject);
  var
  exist: boolean;
  Nro_Jugada: Type_JUEGO.tClave;
begin
  SoloListar:= true;
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  Nro_Jugada:= Lbl_nroPartida.Caption;

  if not (ME_APUESTAS.MEVacio_Apuestas(ME_APUESTA)) then
  begin
    exist:= Lib_AuxJuego.ExistenApuestas_enEsteJuego(Nro_Jugada);

    if (exist) then
    begin
      F_Apostar.Show;
      F_Apostar.Lbl_ListaDeApuestas.Hide;
      F_Apostar.Lbl_SelectJugador.hide;
      F_Apostar.Lbl_ListaJugadores.Show;

      F_Apostar.Grid_ListaJugadores.Hide;
      F_Apostar.Panel_DatosApostar.hide;

      F_Apostar.Grid_ListaApuestas.Show;
      Lib_AuxJuego.limpiarGrid(F_Apostar.Grid_ListaApuestas);
      Lib_AuxJuego.EncabezadosComunApuestas(F_Apostar.Grid_ListaApuestas);
      F_Apostar.Grid_ListaApuestas.RowCount:=1;
      Lib_AuxJuego.Listado_GeneralApuestas(F_Apostar.Grid_ListaApuestas, Nro_Jugada);
      F_Apostar.Grid_ListaApuestas.FixedRows:=1;
    end
    else
      MessageDlg('No hay apuestas efectuadas en este juego!!',mtWarning, [mbOK], 0);
  end
  else
    MessageDlg('No hay apuestas efectuadas!!',mtWarning, [mbOK], 0);
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Premiados1Click(Sender: TObject);
var
  cantGanadores: tCantidad;
  Nro_Jugada: Type_JUEGO.tClave;
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  Nro_Jugada:= Lbl_nroPartida.Caption;
  cantGanadores:= 0;

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuegoRuleta);

  if (regJuegoRuleta.NroJugada = Nro_Jugada) then
  begin //Soy el croupier
      if (regJuegoRuleta.Estado = 4) then // (4) premios repartidos y fin de juego
      begin
        if not (ME_GANADORES.MeVacio_Ganadores(ME_GANADOR)) then
        begin
          Lib_AuxJuego.CantGanadores_EnUnaJugada(ME_GANADORES.Raiz(ME_GANADOR), Nro_Jugada, cantGanadores);
          if (cantGanadores>0) then
            listarPremiados(Nro_Jugada)
          else
            MessageDlg('NO HAY GANADORES!' + #13 + #13 +' No hay ganadores en la jugada Nro: ' +RegJuegoRuleta.NroJugada,mtInformation, [mbOK], 0);
        end
        else
          MessageDlg('NO HAY GANADORES!' + #13 + #13 +' No hay ganadores en la jugada Nro: ' +RegJuegoRuleta.NroJugada,mtInformation, [mbOK], 0);
      end
      else
        MessageDlg('EL JUEGO ESTA EN CURSO!' + #13 + #13 +' Una vez finalizado la partida podra listar los ganadores.',mtInformation, [mbOK], 0);
  end
  else //Soy jugador comun. El juego habia finalizado
    begin
        if not (ME_GANADORES.MeVacio_Ganadores(ME_GANADOR)) then
        begin
          Lib_AuxJuego.CantGanadores_EnUnaJugada(ME_GANADORES.Raiz(ME_GANADOR), Nro_Jugada, cantGanadores);
          if (cantGanadores>0) then
            listarPremiados(Nro_Jugada)
          else
            MessageDlg('NO HAY GANADORES!' + #13 + #13 +' No hay ganadores en la jugada Nro: ' +Nro_Jugada,mtInformation, [mbOK], 0);
        end
        else
          MessageDlg('NO HAY GANADORES!' + #13 + #13 +' No hay ganadores en la jugada Nro: ' +Nro_Jugada,mtInformation, [mbOK], 0);
    end;
end;
{------------------------------------------------------------------------------}

procedure TF_Juego.SALIR1Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUEGO.RegistroNulo(regJuegoRuleta);
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuegoRuleta);

    //Si el numero de jugada de la pantalla es distito a la ultima jugada significa que el jugador no esta jugando la partida actual. La partida que juga ya culmino. Puede salir
  if (Nro_Jugada <> regJuegoRuleta.NroJugada) then
      RegJuegoRuleta.estado:= 4;

  if (RegJuegoRuleta.Estado = 4) then
  begin
      Form_Juego.F_Juego.Close;

      if AdminLog then
        Form_Croupier.F_Croupier.Show
      else
        Form_Jugadores.F_Jugadores.Show;
  end
  else
    MessageDlg('No puede salir del juego hasta que el mismo haya finalizado!',mtWarning , [mbOK], 0)
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.ActiveBtnTrampa();
begin
  panel_tablero.Enabled:= true;
  tabla_ImagePrimeros12.Hide;
  tabla_ImageSegundos12.Hide;
  tabla_ImageTerceros12.Hide;
  tabla_ImageTerceraCol.Hide;
  tabla_ImageSegundaCol.Hide;
  tabla_ImagePrimeraCol.Hide;
  tabla_Image_1a18.Hide;
  tabla_ImagePares.Hide;
  tabla_ImageRojo.Hide;
  tabla_ImageNegro.Hide;
  tabla_ImageImpares.Hide;
  tabla_Image_19a36.Hide;
  panel_tablero.Enabled:=true;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.DesactiveBtnTrampa();
begin
  panel_tablero.Enabled:= false;
  tabla_ImagePrimeros12.show;
  tabla_ImageSegundos12.show;
  tabla_ImageTerceros12.show;
  tabla_ImageTerceraCol.show;
  tabla_ImageSegundaCol.show;
  tabla_ImagePrimeraCol.show;
  tabla_Image_1a18.show;
  tabla_ImagePares.show;
  tabla_ImageRojo.show;
  tabla_ImageNegro.show;
  tabla_ImageImpares.show;
  tabla_Image_19a36.show;
  panel_tablero.Enabled:=false;
end;


{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_cancelarSelectTabClick(Sender: TObject);
begin
  AutoSize_ImagenesTablero();

  panel_tablero.Enabled:= true;
  F_Apostar.Edit_nomenclador.Clear;
  F_Apostar.Edit_valor.Clear;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.SpeedButton12Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
  regBuscado: Type_JUEGO.TipoRegDatos;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR, posJugador, Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  if (regJugador.Bloqueado) then
  begin
    MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
    SalirDelJuego();
  end
  else
    begin
    //Si el numero de jugada de la pantalla es distito a la ultima jugada significa que el jugador no esta jugando la partida actual
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else
        refrezcarPantallaNormalUser();
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_CrearPartidaClick(Sender: TObject);
var
  i:integer;
  cantFictActivos, cantEnLinea: tCantidad;
  nroJugada: Type_JUEGO.tClave;
begin
 cantFictActivos:= 0;
 cantEnLinea:= 0;
 ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
 Lbl_nroBolillaG.Caption:= '--';
 Spbtn_CrearPartida.Enabled:= false;
 Spbtn_haganApuestas.Enabled:= true;
 Spbtn_activarFicticios.Enabled:= true;
 Spbtn_obsequiarCred.Enabled:= true;

 //Muestroa la cantidad de ficticios creados al ingresar al juego buscando el ultimo ficticio
 totalFicticios:= ME_JUGADORES.UltFicticio(ME_JUGADOR);
 Lbl_cantFicticios.Caption:= intTostr(totalFicticios);

  if ME_JUEGO.MEVacio(ME_JUEGORULETA) then
  begin //El ME_Juego esta vacio, inserto la primera jugada
    RegJuegoRuleta.NroJugada:=inttostr(1);
    RegJuegoRuleta.FechaHora:= Now();
    RegJuegoRuleta.Estado:= 0;
    RegJuegoRuleta.Bolilla:= Lib_Auxiliar.PosNula;
    ME_JUEGO.Insertar(ME_JUEGORULETA, RegJuegoRuleta);

    Lbl_cantFicticios.Show;
    Lbl_estadoJuego.Caption:='"Juego Creado"';
  end
  else
    begin //El ME_Juego no esta vacio. Solo sera posible si el estado es = 4 (premios repartidos y fin de juego)
      ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
      if (RegJuegoRuleta.Estado = 4) then
      begin
        //creo un nuevo RegJuegoRuleta y lo inserto
        RegJuegoRuleta.NroJugada:= intTostr(strToint(RegJuegoRuleta.NroJugada)+1);
        RegJuegoRuleta.FechaHora:= Now();
        RegJuegoRuleta.Estado:= 0;
        RegJuegoRuleta.Bolilla:= Lib_Auxiliar.PosNula;
        ME_JUEGO.Insertar(ME_JUEGORULETA, RegJuegoRuleta);

        Lbl_estadoJuego.Caption:='"Juego Creado"';
      end;
    end;

  //Muestro numero de partida luego de haber iniciado la partida
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
  Lbl_nroPartida.Caption:= RegJuegoRuleta.NroJugada;

  //Muestro la cantidad de ficticios activas. Al comienzo siempre sera cero, porque el croupier debera activarlos
  Lib_AuxJuego.Cant_FicticiosActivos(ME_JUGADORES.Raiz(ME_JUGADOR), cantFictActivos);
  F_Juego.Lbl_CantFictActivados.Caption:= intTostr(cantFictActivos);

  //Muestro la cantidad de jugadores que se unen a la partida y estaran en linea (activos) una vez creada la partida
  Lib_AuxJuego.Cant_JugadoresEnLinea(ME_JUGADORES.Raiz(ME_JUGADOR), cantEnLinea);
  F_Juego.Lbl_cantEnLinea.Caption:= intTostr(cantEnLinea); //menos el croupier
end;

{------------------------------------------------------------------------------}


procedure TF_Juego.Spbtn_haganApuestasClick(Sender: TObject);
var
  cantActivos: tCantidad;
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  cantActivos:= 0;

  Spbtn_haganApuestas.Enabled:=false;
  Spbtn_noVaMas.Enabled:=true;
  //habilito tablero para que lleven a cabo sus apuestas tanto crupier como usuario comun
  panel_tablero.Enabled:= true;

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
      if (RegJuegoRuleta.Estado = 0) then
      begin
        RegJuegoRuleta.NroJugada:= RegJuegoRuleta.NroJugada;
        RegJuegoRuleta.FechaHora:= Now();
        RegJuegoRuleta.Estado:= 1;
        RegJuegoRuleta.Bolilla:= Lib_Auxiliar.PosNula;
        ME_JUEGO.ModificoUltimo(ME_JUEGORULETA, RegJuegoRuleta);

        Lbl_estadoJuego.Caption:='"Hagan sus apuestas"';

        if (Spbtn_activarFicticios.Enabled = true) then
          Spbtn_activarFicticios.Enabled:=false;

        Spbtn_obsequiarCred.Enabled:=false;

        //Se llevaran a cabo las apuestas de los jugadores ficticios que esten activos
        Lib_AuxJuego.Cant_FicticiosActivos(ME_JUGADORES.Raiz(ME_JUGADOR),cantActivos);
        if (cantActivos > 0) then
          Lib_AuxJuego.Apuestas_JugadoresFicticios(ME_JUGADORES.Raiz(ME_JUGADOR), cantActivos);
      end;

end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_noVaMasClick(Sender: TObject);
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  Spbtn_noVaMas.Enabled:=false;
  Spbtn_bloqDesbloq.Enabled:= false;
  Spbtn_tirarBolilla.Enabled:=true;
  panel_tablero.Enabled:= false;

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
      if (RegJuegoRuleta.Estado = 1) then
      begin
        RegJuegoRuleta.NroJugada:= RegJuegoRuleta.NroJugada;
        RegJuegoRuleta.FechaHora:= Now();
        RegJuegoRuleta.Estado:= 2;
        RegJuegoRuleta.Bolilla:= Lib_Auxiliar.PosNula;
        ME_JUEGO.ModificoUltimo(ME_JUEGORULETA, RegJuegoRuleta);

        Lib_AuxJuego.MovimientoHaberApostadores();
        Lbl_estadoJuego.Caption:='"No va m�s"';

        Spbtn_obsequiarCred.Enabled:=false;
      end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_bloqDesbloqClick(Sender: TObject);
var
  Cant: tCantidad; // cantidad jugadores en general
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  Cant:= 0;
  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not(ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR)) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    begin
      F_PanelCaseButtons.MostrarEnGridJugadores();
    end
    else
      begin
        MessageDlg('No existen jugadores!!',mtWarning, [mbOK], 0);
        Form_Juego.F_Juego.Panel_JuegoGral.Enabled:= true;
      end;

  F_PanelCaseButtons.Panel_LockUnlock.Enabled:= true;
  F_PanelCaseButtons.Panel_LockUnlock.show;

  F_PanelCaseButtons.Panel_RegalarCredito.Enabled:= false;
  F_PanelCaseButtons.Panel_RegalarCredito.Hide;
  F_PanelCaseButtons.Lbl_regalarCred.Hide;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_activarFicticiosClick(Sender: TObject);
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  F_PanelFicticios.Show;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_obsequiarCredClick(Sender: TObject);
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  F_PanelCaseButtons.Show;
  F_PanelCaseButtons.Panel_LockUnlock.hide;
  F_PanelCaseButtons.Panel_LockUnlock.Enabled:= false;

  F_PanelCaseButtons.Panel_RegalarCredito.show;
  F_PanelCaseButtons.Panel_RegalarCredito.Enabled:= true;
  F_PanelCaseButtons.Lbl_bloquearDesbloquear.hide;
  F_PanelCaseButtons.Lbl_regalarCred.show;
  F_PanelCaseButtons.Edit_cantCredito.Enabled:= false;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_refreshClick(Sender: TObject);
var
  cantEnLinea: tCantidad;
begin
  cantEnLinea:= 0;
  //Actualizo fecha y hora a mostrar
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual);

  //Al refrezcar vuelvo a mostrar la cantidad de jugadores que se van uniendo a la partida y estaran en linea (activos) una vez creada la partida
  Lib_AuxJuego.Cant_JugadoresEnLinea(ME_JUGADORES.Raiz(ME_JUGADOR), cantEnLinea);
  F_Juego.Lbl_cantEnLinea.Caption:= intTostr(cantEnLinea); //menos el croupier
end;

procedure TF_Juego.Spbtn_repartirPremiosClick(Sender: TObject);
var
  cantGanadores: tCantidad;
  cantFictActivos: tCantidad;
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  cantFictActivos:= 0;
  cantGanadores:= 0;
  Spbtn_trampa.Enabled:=false;

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);

    if (RegJuegoRuleta.Estado = 3) then
    begin
        RegJuegoRuleta.NroJugada:= RegJuegoRuleta.NroJugada;
        RegJuegoRuleta.FechaHora:= Now();
        RegJuegoRuleta.Estado:= 4;
        RegJuegoRuleta.Bolilla:= RegJuegoRuleta.Bolilla;
        ME_JUEGO.ModificoUltimo(ME_JUEGORULETA, RegJuegoRuleta);

        //Reparto premio de los apostadores de la ultima jugada
        ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuegoRuleta);
        Lib_AuxJuego.repartirPremio_xJugada(ME_JUGADORES.Raiz(ME_JUGADOR), regJuegoRuleta.NroJugada);

        //Desactivo jugadores ficticios
        Lib_AuxJuego.Desactivar_JugadoresFicticios(ME_JUGADORES.Raiz(ME_JUGADOR));

        //Muestro cantidad de ficticios activos una vez culminada la partida. Siempre sera cero
        Lib_AuxJuego.Cant_FicticiosActivos(ME_JUGADORES.Raiz(ME_JUGADOR), cantFictActivos);
        F_Juego.Lbl_CantFictActivados.Caption:= intTostr(cantFictActivos);

        //Muestro la cantidad de ganadores si es que los hay para que luego pueda listarlo en el menu de arriba (Premiados)
        if not (ME_GANADORES.MeVacio_Ganadores(ME_GANADOR)) then
        begin
           Lib_AuxJuego.CantGanadores_EnUnaJugada(ME_GANADORES.Raiz(ME_GANADOR), RegJuegoRuleta.NroJugada,cantGanadores);
           if (cantGanadores>0) then
            MessageDlg('HAY ' +intTostr(cantGanadores)+ ' GANADORES EN JUGADA NRO ' +RegJuegoRuleta.NroJugada,mtInformation , [mbOK], 0)
           else
            MessageDlg('NO HAY GANADORES EN JUGADA NRO ' +RegJuegoRuleta.NroJugada,mtInformation , [mbOK], 0);
        end
        else
          MessageDlg('NO HAY GANADORES EN JUGADA NRO ' +RegJuegoRuleta.NroJugada,mtInformation , [mbOK], 0);

    end;

    //Invoco al procedimiento que va a mostrar la pantalla de inicio para el croupier una vez culminada una partida
    pantallaIniJuegoCrupier();
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_tirarBolillaClick(Sender: TObject);
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  Spbtn_tirarBolilla.Enabled:=false;
  Spbtn_repartirPremios.Enabled:=true;

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
    if (RegJuegoRuleta.Estado = 2) then
    begin
        RegJuegoRuleta.NroJugada:= RegJuegoRuleta.NroJugada;
        RegJuegoRuleta.FechaHora:= Now();
        RegJuegoRuleta.Estado:= 3;
        RegJuegoRuleta.Bolilla:= (random(36));
        ME_JUEGO.ModificoUltimo(ME_JUEGORULETA, RegJuegoRuleta);

        Lbl_estadoJuego.Caption:='"Bolilla tirada"';

        Lbl_nroBolillaG.Caption:= intTostr(RegJuegoRuleta.Bolilla);
        Spbtn_tirarBolilla.Enabled:= false;
        Spbtn_trampa.Enabled:=true;
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.Spbtn_trampaClick(Sender: TObject);
begin
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  MessageDlg('SELECCIONE NUMERO DE LA TABLA PARA HACER TRAMPA.',mtInformation , [mbOK], 0);
  BtnTrampaIsActive:=true;
  ActiveBtnTrampa();
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image0Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image0.Width := tabla_Image0.Width + 5;
  tabla_Image0.Height := tabla_Image0.Height + 25;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(0);
  nameOp:= intTostr(0);


  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(0)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image3Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image3.Width := tabla_Image3.Width + 5;
  tabla_Image3.Height := tabla_Image3.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(3);
  nameOp:= intTostr(3);

  //Si es el croupier y se activo el boton trampa, llamo a TableroTrampaSeleccionado parametrizando numero de bolilla a hacer trampa
  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(3)
  else //es el croupier o jugador comun que estan apostando
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image10Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image10.Width := tabla_Image10.Width + 5;
  tabla_Image10.Height := tabla_Image10.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(10);
  nameOp:= intTostr(10);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(10)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);


if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image11Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image11.Width := tabla_Image11.Width + 5;
  tabla_Image11.Height := tabla_Image11.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(11);
  nameOp:= intTostr(11);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(11)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image12Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image12.Width := tabla_Image12.Width + 5;
  tabla_Image12.Height := tabla_Image12.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(12);
  nameOp:= intTostr(12);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(12)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image13Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image13.Width := tabla_Image13.Width + 5;
  tabla_Image13.Height := tabla_Image13.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(13);
  nameOp:= intTostr(13);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(13)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image14Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image14.Width := tabla_Image14.Width + 5;
  tabla_Image14.Height := tabla_Image14.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(14);
  nameOp:= intTostr(14);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(14)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image15Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image15.Width := tabla_Image15.Width + 5;
  tabla_Image15.Height := tabla_Image15.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(15);
  nameOp:= intTostr(15);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(15)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image16Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image16.Width := tabla_Image16.Width + 5;
  tabla_Image16.Height := tabla_Image16.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(16);
  nameOp:= intTostr(16);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(16)
  else
    begin
      ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

     if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}
procedure TF_Juego.tabla_Image17Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image17.Width := tabla_Image17.Width + 5;
  tabla_Image17.Height := tabla_Image17.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(17);
  nameOp:= intTostr(17);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(17)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image18Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image18.Width := tabla_Image18.Width + 5;
  tabla_Image18.Height := tabla_Image18.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(18);
  nameOp:= intTostr(18);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(18)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image19Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image19.Width := tabla_Image19.Width + 5;
  tabla_Image19.Height := tabla_Image19.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(19);
  nameOp:= intTostr(19);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(19)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image1Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image1.Width := tabla_Image1.Width + 5;
  tabla_Image1.Height := tabla_Image1.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(1);
  nameOp:= intTostr(1);

  if (BtnTrampaIsActive) then
    TableroTrampaSeleccionado(1)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image20Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image20.Width := tabla_Image20.Width + 5;
  tabla_Image20.Height := tabla_Image20.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(20);
  nameOp:= intTostr(20);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(20)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}
procedure TF_Juego.tabla_Image21Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image21.Width := tabla_Image21.Width + 5;
  tabla_Image21.Height := tabla_Image21.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(21);
  nameOp:= intTostr(21);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(21)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

  if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image22Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image22.Width := tabla_Image22.Width + 5;
  tabla_Image22.Height := tabla_Image22.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(22);
  nameOp:= intTostr(22);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(22)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

  if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}
procedure TF_Juego.tabla_Image23Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image23.Width := tabla_Image23.Width + 5;
  tabla_Image23.Height := tabla_Image23.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(23);
  nameOp:= intTostr(23);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(23)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image24Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image24.Width := tabla_Image24.Width + 5;
  tabla_Image24.Height := tabla_Image24.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(24);
  nameOp:= intTostr(24);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(24)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image25Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;


  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image25.Width := tabla_Image25.Width + 5;
  tabla_Image25.Height := tabla_Image25.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(25);
  nameOp:= intTostr(25);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(25)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image26Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image26.Width := tabla_Image26.Width + 5;
  tabla_Image26.Height := tabla_Image26.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(26);
  nameOp:= intTostr(26);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(26)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image27Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image27.Width := tabla_Image27.Width + 5;
  tabla_Image27.Height := tabla_Image27.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(27);
  nameOp:= intTostr(27);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(27)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image28Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image28.Width := tabla_Image28.Width + 5;
  tabla_Image28.Height := tabla_Image28.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(28);
  nameOp:= intTostr(28);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(28)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image29Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image29.Width := tabla_Image29.Width + 5;
  tabla_Image29.Height := tabla_Image29.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(29);
  nameOp:= intTostr(29);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(29)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image2Click(Sender: TObject);
begin
  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image2.Width := tabla_Image2.Width + 5;
  tabla_Image2.Height := tabla_Image2.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(2);
  nameOp:= intTostr(2);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(2)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      if (RegJuegoRuleta.Estado = 1) then
        TableroLegalSeleccionado(Nomenclador,valor,nameOp)
      else
      begin
        F_Juego.panel_tablero.Enabled:=false;
        refrezcarPantallaNormalUser();
        AutoSize_ImagenesTablero();
      end;
    end
    else
      begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
      end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image30Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image30.Width := tabla_Image30.Width + 5;
  tabla_Image30.Height := tabla_Image30.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(30);
  nameOp:= intTostr(30);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(30)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image31Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image31.Width := tabla_Image31.Width + 5;
  tabla_Image31.Height := tabla_Image31.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(31);
  nameOp:= intTostr(31);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(31)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image32Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image32.Width := tabla_Image32.Width + 5;
  tabla_Image32.Height := tabla_Image32.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(32);
  nameOp:= intTostr(32);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(32)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image33Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image33.Width := tabla_Image33.Width + 5;
  tabla_Image33.Height := tabla_Image33.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(33);
  nameOp:= intTostr(33);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(33)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image34Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image34.Width := tabla_Image34.Width + 5;
  tabla_Image34.Height := tabla_Image34.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(34);
  nameOp:= intTostr(34);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(34)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image35Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image35.Width := tabla_Image35.Width + 5;
  tabla_Image35.Height := tabla_Image35.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(35);
  nameOp:= intTostr(35);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(35)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image36Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image36.Width := tabla_Image36.Width + 5;
  tabla_Image36.Height := tabla_Image36.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(36);
  nameOp:= intTostr(36);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(36)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image4Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image4.Width := tabla_Image4.Width + 5;
  tabla_Image4.Height := tabla_Image4.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(4);
  nameOp:= intTostr(4);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(4)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image5Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image5.Width := tabla_Image5.Width + 5;
  tabla_Image5.Height := tabla_Image5.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(5);
  nameOp:= intTostr(5);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(5)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image6Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image6.Width := tabla_Image6.Width + 5;
  tabla_Image6.Height := tabla_Image6.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(6);
  nameOp:= intTostr(6);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(6)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}


procedure TF_Juego.tabla_Image7Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image7.Width := tabla_Image7.Width + 5;
  tabla_Image7.Height := tabla_Image7.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(7);
  nameOp:= intTostr(7);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(7)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image8Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image8.Width := tabla_Image8.Width + 5;
  tabla_Image8.Height := tabla_Image8.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(8);
  nameOp:= intTostr(8);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(8)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image9Click(Sender: TObject);
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image9.Width := tabla_Image9.Width + 5;
  tabla_Image9.Height := tabla_Image9.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Pleno;
  valor:= intTostr(9);
  nameOp:= intTostr(9);

  if ((AdminLog) and (BtnTrampaIsActive)) then
    TableroTrampaSeleccionado(9)
  else
    begin
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
    end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImageImparesClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageImpares.Width := tabla_ImageImpares.Width + 5;
  tabla_ImageImpares.Height := tabla_ImageImpares.Height + 10;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_ParImpar;
  valor:= 'I';
  nameOp:= '"IMPARES"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImageNegroClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageNegro.Width := tabla_ImageNegro.Width + 5;
  tabla_ImageNegro.Height := tabla_ImageNegro.Height + 10;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Rojonegro;
  valor:= 'N';
  nameOp:= '"Negro"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImageParesClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImagePares.Width := tabla_ImagePares.Width + 5;
  tabla_ImagePares.Height := tabla_ImagePares.Height + 10;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_ParImpar;
  valor:= 'P';
  nameOp:= '"PARES"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImagePrimeraColClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImagePrimeraCol.Width := tabla_ImagePrimeraCol.Width + 5;
  tabla_ImagePrimeraCol.Height := tabla_ImagePrimeraCol.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Columna;
  valor:= intTostr(1);
  nameOp:= '"Primer columna"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end;
end;


{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImagePrimeros12Click(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImagePrimeros12.Width := tabla_ImagePrimeros12.Width + 20;
  tabla_ImagePrimeros12.Height := tabla_ImagePrimeros12.Height + 5;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Docena;
  valor:= intTostr(1);
  nameOp:= '"Primeros doce"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImageRojoClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageRojo.Width := tabla_ImageRojo.Width + 5;
  tabla_ImageRojo.Height := tabla_ImageRojo.Height + 10;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Rojonegro;
  valor:= 'R';
  nameOp:= '"Rojo"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImageSegundaColClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageSegundaCol.Width := tabla_ImageSegundaCol.Width + 5;
  tabla_ImageSegundaCol.Height := tabla_ImageSegundaCol.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Columna;
  valor:= intTostr(2);
  nameOp:= '"Segunda columna"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_ImageSegundos12Click(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageSegundos12.Width := tabla_ImageSegundos12.Width + 20;
  tabla_ImageSegundos12.Height := tabla_ImageSegundos12.Height + 5;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Docena;
  valor:= intTostr(2);
  nameOp:= '"Segundos doce"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end
end;

{------------------------------------------------------------------------------}


procedure TF_Juego.tabla_ImageTerceraColClick(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageTerceraCol.Width := tabla_ImageTerceraCol.Width + 5;
  tabla_ImageTerceraCol.Height := tabla_ImageTerceraCol.Height + 15;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_Columna;
  valor:= intTostr(3);
  nameOp:= '"Tercer columna"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

   if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end;
end;

{------------------------------------------------------------------------------}


procedure TF_Juego.tabla_ImageTerceros12Click(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_ImageTerceros12.Width := tabla_ImageTerceros12.Width + 20;
  tabla_ImageTerceros12.Height := tabla_ImageTerceros12.Height + 5;
  panel_tablero.Enabled:= false;


  Nomenclador:= Type_APUESTA.Nom_Docena;
  valor:= intTostr(3);
  nameOp:= '"Terceros doce"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}


procedure TF_Juego.tabla_Image_19a36Click(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image_19a36.Width := tabla_Image_19a36.Width + 5;
  tabla_Image_19a36.Height := tabla_Image_19a36.Height + 10;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_PasaFalta;
  valor:= 'F';
  nameOp:= '"Falta(19-36)"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}

procedure TF_Juego.tabla_Image_1a18Click(Sender: TObject);
//Esta casilla sera estar� disponible si se lleva a cabo una apuesta y no cuando hace trampa
var
  Nro_Jugada: Type_JUEGO.tClave;
begin
  Nro_Jugada:= Lbl_nroPartida.Caption;

  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Lbl_usuarioActual.Caption);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  tabla_Image_1a18.Width := tabla_Image_1a18.Width + 5;
  tabla_Image_1a18.Height := tabla_Image_1a18.Height + 10;
  panel_tablero.Enabled:= false;

  Nomenclador:= Type_APUESTA.Nom_PasaFalta;
  valor:= 'P';
  nameOp:= '"Pasa (1-18)"';


    ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);
    if not (regJugador.Bloqueado) then //si no esta bloqueado quien va a llevar a cabo la apuesta ...
    begin
      //Si la partida en la que se encuentra es ditinta a la partida que esta en curso
      if (Nro_Jugada <> RegJuegoRuleta.NroJugada) then
      begin
        //.. me fijo en que estado esta la jugada actual. Si el estado es igual a 0 (patida creada), lo invito a unirse a la nueva partida
        if (RegJuegoRuleta.Estado = 0) then
        begin
          if Lib_AuxJuego.Mensaje_Confirmacion('PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ' HA SIDO CREADA:' +#13+#13+'�Quiere unirse a la nueva partida?') then
          begin
            pantallaIniJuegoJugadores;
            refrezcarPantallaNormalUser();
          end;
        end
        else
          MessageDlg('SE ESTA JUGANDO PARTIDA NRO. ' +RegJuegoRuleta.NroJugada+ ':'+#13+#13+'Deber� esperar hasta que una nueva partida comience!',mtInformation , [mbOK], 0)
      end
      else //la partida que se encuentra en la misma que se esta jugando
      begin
        //si el estado del juego es = 1 (hagan sus apuestas)
        if (RegJuegoRuleta.Estado = 1) then
          TableroLegalSeleccionado(Nomenclador,valor,nameOp)
        else
        begin
          F_Juego.panel_tablero.Enabled:=false;
          refrezcarPantallaNormalUser();
          AutoSize_ImagenesTablero();
        end;
      end;
    end
    else
        begin
          MessageDlg('Lo siento, ha sido bloqueado!!' ,mtWarning , [mbOK], 0);
          SalirDelJuego();
        end

end;

{------------------------------------------------------------------------------}

//El tablero volvera a su tama�o original luego de que se haya efecuado un 'click'
Procedure TF_Juego.AutoSize_ImagenesTablero;
begin
  tabla_Image0.AutoSize := true;tabla_Image0.AutoSize := false;
  tabla_Image1.AutoSize := true;tabla_Image1.AutoSize := false;
  tabla_Image2.AutoSize := true;tabla_Image2.AutoSize := false;
  tabla_Image3.AutoSize := true;tabla_Image3.AutoSize := false;
  tabla_Image3.AutoSize := true;tabla_Image3.AutoSize := false;
  tabla_Image3.AutoSize := true;tabla_Image3.AutoSize := false;
  tabla_Image4.AutoSize := true;tabla_Image4.AutoSize := false;
  tabla_Image5.AutoSize := true;tabla_Image5.AutoSize := false;
  tabla_Image6.AutoSize := true;tabla_Image6.AutoSize := false;
  tabla_Image7.AutoSize := true;tabla_Image7.AutoSize := false;
  tabla_Image8.AutoSize := true;tabla_Image8.AutoSize := false;
  tabla_Image9.AutoSize := true;tabla_Image9.AutoSize := false;
  tabla_Image10.AutoSize := true;tabla_Image10.AutoSize := false;
  tabla_Image11.AutoSize := true;tabla_Image11.AutoSize := false;
  tabla_Image12.AutoSize := true;tabla_Image12.AutoSize := false;
  tabla_Image13.AutoSize := true;tabla_Image13.AutoSize := false;
  tabla_Image14.AutoSize := true;tabla_Image14.AutoSize := false;
  tabla_Image15.AutoSize := true;tabla_Image15.AutoSize := false;
  tabla_Image16.AutoSize := true;tabla_Image16.AutoSize := false;
  tabla_Image17.AutoSize := true;tabla_Image17.AutoSize := false;
  tabla_Image18.AutoSize := true;tabla_Image18.AutoSize := false;
  tabla_Image19.AutoSize := true;tabla_Image19.AutoSize := false;
  tabla_Image20.AutoSize := true;tabla_Image20.AutoSize := false;
  tabla_Image21.AutoSize := true;tabla_Image21.AutoSize := false;
  tabla_Image22.AutoSize := true;tabla_Image22.AutoSize := false;
  tabla_Image23.AutoSize := true;tabla_Image23.AutoSize := false;
  tabla_Image24.AutoSize := true;tabla_Image24.AutoSize := false;
  tabla_Image25.AutoSize := true;tabla_Image25.AutoSize := false;
  tabla_Image26.AutoSize := true;tabla_Image26.AutoSize := false;
  tabla_Image27.AutoSize := true;tabla_Image27.AutoSize := false;
  tabla_Image28.AutoSize := true;tabla_Image28.AutoSize := false;
  tabla_Image29.AutoSize := true;tabla_Image29.AutoSize := false;
  tabla_Image30.AutoSize := true;tabla_Image30.AutoSize := false;
  tabla_Image31.AutoSize := true;tabla_Image31.AutoSize := false;
  tabla_Image32.AutoSize := true;tabla_Image32.AutoSize := false;
  tabla_Image33.AutoSize := true;tabla_Image33.AutoSize := false;
  tabla_Image34.AutoSize := true;tabla_Image34.AutoSize := false;
  tabla_Image35.AutoSize := true;tabla_Image35.AutoSize := false;
  tabla_Image36.AutoSize := true;tabla_Image36.AutoSize := false;

  tabla_ImagePrimeraCol.AutoSize:= true;tabla_ImagePrimeraCol.AutoSize:= false;
  tabla_ImageSegundaCol.AutoSize:= true;tabla_ImageSegundaCol.AutoSize:= false;
  tabla_ImageTerceraCol.AutoSize:= true;tabla_ImageTerceraCol.AutoSize:= false;

  tabla_ImagePrimeros12.AutoSize:= true;tabla_ImagePrimeros12.AutoSize:= false;
  tabla_ImageSegundos12.AutoSize:= true;tabla_ImageSegundos12.AutoSize:= false;
  tabla_ImageTerceros12.AutoSize:= true;tabla_ImageTerceros12.AutoSize:= false;

  tabla_Image_1a18.AutoSize:= true;tabla_Image_1a18.AutoSize:= false;
  tabla_Image_19a36.AutoSize:= true;tabla_Image_19a36.AutoSize:= false;

  tabla_ImagePares.AutoSize:= true;tabla_ImagePares.AutoSize:= false;
  tabla_ImageImpares.AutoSize:= true;tabla_ImageImpares.AutoSize:= false;

  tabla_ImageRojo.AutoSize:= true;tabla_ImageRojo.AutoSize:= false;
  tabla_ImageNegro.AutoSize:= true;tabla_ImageNegro.AutoSize:= false;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Btn_closePnelLoserClick(Sender: TObject);
var
 i: integer; 
begin
  for i:=0 to menuFormJuego.Items.Count-1 do
    menuFormJuego.Items[I].Enabled:= true;

  //Un ves mostrado el panel de ganador o perdedor, dejo a usuario ver premios
   menuFormJuego.Items[2].Visible:= true;

  Panel_Jugadores.Enabled:= true;
  Panel_Winner.Visible:= false;
  Panel_Loser.Visible:= false;
  Panel_Winner.Color:= clRed;
  Lbl_waiting.Font.Color:= clBlack;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Btn_closePnelWinnerClick(Sender: TObject);
var
 i: integer; 
begin
   for i:=0 to menuFormJuego.Items.Count-1 do
    menuFormJuego.Items[I].Enabled:= true;

   Panel_Jugadores.Enabled:= true;
   Panel_Winner.Visible:= false;
   Panel_ShowWinner.Visible:= false;

   (gifWinner.Picture.Graphic as TGIFImage).Animate:= false;
   gifWinner.Visible:= false;
   Panel_Winner.Color:= clRed;
   Lbl_waiting.Font.Color:= clBlack;
end;

{--------------------------------------------------------------------------------}

Procedure TF_Juego.TableroLegalSeleccionado(nomenclador:Type_APUESTA.tNomenclador;valor:Type_APUESTA.tNomenclador; nameOp:string);
var
  Cant: tCantidad; // cantidad jugadores en general
  Cant_Desbloq: tCantidad; // cantidad de jugadores desbloqueados
  Cant_Activos: tCantidad; // cantidad de jugadores activos
begin
  Cant_Desbloq:= 0;
  Cant_Activos:= 0;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);
  Lib_AuxJuego.Cant_JugadoresDesbloqueados(ME_JUGADORES.Raiz(ME_JUGADOR), Cant_Desbloq);
  Lib_AuxJuego.Cant_JugadoresActivos(ME_JUGADORES.Raiz(ME_JUGADOR), Cant_Activos);


//Usuario comun
  if not (Form_login.AdminLog) then
  begin
    if Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere apostar por: '+nameOp+ ' ?') then
    begin
      SoloListar:= False; //
      F_Apostar.Show;

      F_Apostar.Lbl_SelectJugador.hide;
      F_Apostar.Lbl_ListaJugadores.hide;
      F_Apostar.Grid_ListaJugadores.hide;

      F_Apostar.Lbl_ListaDeApuestas.Show;
      F_Apostar.Grid_ListaApuestas.Show;

      F_Apostar.Panel_DatosApostar.show;
      F_Apostar.Edit_nomenclador.Text:= nomenclador;
      F_Apostar.Edit_valor.Text:=valor;
      F_Apostar.Edit_nameJugador.Text:= NickLogueado;
      Form_Apostar.F_Apostar.Edit_importe.SetFocus;

      F_Juego.ListandoApuestas();
    end
    else
      begin
        AutoSize_ImagenesTablero();
        panel_tablero.Enabled:= true;
      end;
  end
  else  //Croupier
    begin
        F_Apostar.Lbl_ListaJugadores.hide;
        F_Apostar.Lbl_ListaDeApuestas.hide;
        F_Apostar.Grid_ListaApuestas.hide
        ;
        F_Apostar.Lbl_SelectJugador.Show;
        F_Apostar.Grid_ListaJugadores.Show;

        F_Apostar.Edit_nameJugador.Clear;

        if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
        begin
        //Si al menos hay un jugador desbloqueado
          if (Cant_Desbloq >=1) then
          begin
          //Si hay jugadores activos
            if (Cant_Activos>=1) then
            begin
              if Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere apostar por: '+nameOp+ ' ?') then
              begin
                F_Apostar.Show;
                F_Apostar.Panel_DatosApostar.show;
                F_Apostar.Edit_nomenclador.Text:= nomenclador;
                F_Apostar.Edit_valor.Text:=valor;
                F_Apostar.ListandoJugadores();
              end;
            end
            else
              MessageDlg('No hay jugadores activos!',mtWarning, [mbOK], 0);
          end
          else
            MessageDlg('Existen jugadores, pero estan bloqueados',mtWarning, [mbOK], 0);
        end
        else
          MessageDlg('No existen jugadores!!',mtWarning, [mbOK], 0);

      AutoSize_ImagenesTablero();
      panel_tablero.Enabled:= true;
    end;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.TableroTrampaSeleccionado(num_bolilla:Type_JUEGO.tBolilla);
begin //Soy el Croupier y estoy haciendo trampa
  if Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere cometer trampa con la bolilla Nro: ' +intTostr(num_bolilla)+ ' ?') then
  begin
    Lbl_nroBolillaG.Caption:= intTostr(num_bolilla);
    Lbl_nroBolillaG.Font.Color:=clRed;
    Lbl_bolillaASalir.Font.Color:=clRed;
    Spbtn_trampa.Enabled:= false;

    //Se que estoy en estado 3 (bolilla tirada), actualizo regJuegoRuleta con la "bolilla ganadora trampa"
    ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
    RegJuegoRuleta.NroJugada:= RegJuegoRuleta.NroJugada;
    RegJuegoRuleta.FechaHora:= Now();
    RegJuegoRuleta.Estado:= RegJuegoRuleta.Estado;
    RegJuegoRuleta.Bolilla:= num_bolilla;
    ME_JUEGO.ModificoUltimo(ME_JUEGORULETA, RegJuegoRuleta);

    Spbtn_tirarBolilla.Enabled:=false;
    Spbtn_repartirPremios.Enabled:=true;

    BtnTrampaIsActive:= false;
    DesactiveBtnTrampa();
  end
  else
    begin
      panel_tablero.Enabled:= true;
      F_Apostar.Edit_nomenclador.Clear;
      F_Apostar.Edit_valor.Clear;
    end;

  AutoSize_ImagenesTablero();
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showWinner2Timer(Sender: TObject);
begin

  Timer_showWinner2.Enabled:= false;
  Panel_Winner.Visible:= true;
  Timer_showWinner3.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showWinner3Timer(Sender: TObject);
begin
  Timer_showWinner3.Enabled:= false;
  Panel_Winner.Visible:= false;
  Timer_showWinner4.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showWinner4Timer(Sender: TObject);
begin
  Timer_showWinner4.Enabled:= false;
  Panel_Winner.Visible:= true;
  Panel_Winner.Color:= clBlack;
  Lbl_waiting.Font.Color:= clRed;
  Lbl_waiting.Caption:= 'Aguarde ' +#13+ '  unos' +#13+ 'segundos ..';
  Timer_showWinner5.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showWinner5Timer(Sender: TObject);
begin
  Timer_showWinner5.Enabled:= false;
  Panel_Winner.Visible:= false;
  Timer_showWinner6.Enabled:= true; 
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showWinner6Timer(Sender: TObject);
begin
  Timer_showWinner6.Enabled:= false;
  Panel_Winner.Visible:= true;

  if (ShowWinner) then
  begin
    Panel_ShowWinner.Visible:= true;
    gifWinner.Visible:= true;
    (gifWinner.Picture.Graphic as TGIFImage).Animate:= true;
  end
  else
    Panel_Loser.Visible:= true;

  Lbl_saldoAcumulado.Show;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showLoser1Timer(Sender: TObject);
begin
  Timer_showLoser1.Enabled:= false;
  Panel_Loser.Visible:= false;

  Timer_showLoser2.Enabled:= true; 
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showLoser2Timer(Sender: TObject);
begin
  Panel_Loser.Visible:= true;
  Timer_showLoser2.Enabled:= false;

  Timer_showLoser3.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showLoser3Timer(Sender: TObject);
begin
  Timer_showLoser3.Enabled:= false;
  Panel_Loser.Visible:= false;

  Timer_showLoser4.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showLoser4Timer(Sender: TObject);
begin
  Timer_showLoser4.Enabled:= false;
  Panel_Loser.Visible:= true;
  Timer_showLoser5.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showLoser5Timer(Sender: TObject);
begin
  Timer_showLoser5.Enabled:= false;
  Panel_Loser.Visible:= false;
  Timer_showLoser6.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showLoser6Timer(Sender: TObject);
begin
  Timer_showLoser6.Enabled:= false;
  Panel_Loser.Visible:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.Timer_showWinner1Timer(Sender: TObject);
begin
  Timer_showWinner1.Enabled:= false;
  Timer_showWinner2.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_Juego.refrezcarPantallaNormalUser();
var
AuxRegJuego: Type_JUEGO.TipoRegDatos;
saldoActual: tImporte;
cant:tCantidad;
i: integer;

corte: boolean;
monto: tImporte;

begin
  //Actualizo fecha y hora a mostrar
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual);

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, AuxRegJuego);

  //Si el estado es mayor o 0(Juego creado), dejo a usuario ver todas las apuestas  que se estan llevando a cabo en la partida actual
  if (AuxRegJuego.estado>0) then
    menuFormJuego.Items[1].Visible:= true;

      CASE (AuxRegJuego.estado) of
      0:begin
         Lbl_estadoJuego.Caption:='"Juego Creado"';
         saldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regJugador.Nick);
         Lbl_saldoAcumulado.Caption:= '$ ' + inttostr(saldoAcumulado);
        end;//end estado=0
      1:begin
         Lbl_estadoJuego.Caption:='"Hagan sus apuestas"';
         panel_tablero.Enabled:= true;
         saldoActual:= F_Apostar.obtenerSaldoActualJugador(NickLogueado);
         F_Juego.Lbl_saldoAcumulado.Caption:= '$ ' + intTostr(saldoActual);
        end;//end estado=1
      2:begin
          Lbl_estadoJuego.Caption:='"No va m�s"';
          MessageDlg('Se han cerrado las apuestas!',mtInformation , [mbOK], 0);
          AutoSize_ImagenesTablero();
          saldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regJugador.Nick);
          Lbl_saldoAcumulado.Caption:= '$ ' + inttostr(saldoAcumulado);
        end;//end estado=2
      3:begin
          Lbl_estadoJuego.Caption:='"Bolilla tirada"';
          saldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regJugador.Nick);
          Lbl_saldoAcumulado.Caption:= '$ ' + inttostr(saldoAcumulado);
        end;//end estado=3
      4:begin
          monto:= 0;
          Lbl_estadoJuego.Caption:='"Premios repartidos y fin de juego"';
          saldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regJugador.Nick);
          Lbl_saldoAcumulado.Caption:= '$ ' + inttostr(saldoAcumulado);
          Lbl_saldoAcumulado.Hide;

         //Muestro formulario ganador
          Lib_AuxJuego.Premios_AcumuladosXJugadorUnaJugada(ME_GANADORES.Raiz(ME_GANADOR), regJugador.Nick, RegJuegoRuleta.NroJugada, monto);
          if (monto > 0) then
          begin
            ShowWinner:= true;
            Timer_showWinner1.Enabled:= true;
            Lbl_montoWinner.Caption:= intTostr(monto);
            Lbl_bolillaGWinner.Caption:= intTostr(AuxRegJuego.Bolilla);
          end
          else
            begin
              ShowWinner:= false;
              Timer_showWinner1.Enabled:= true;
              Lbl_bolillaGLoser.Caption:= intTostr(AuxRegJuego.Bolilla);
            end;
            Lbl_waiting.Caption:= 'Aguarde ' +#13+ '  unos' +#13+ 'segundos';

          //Deshabilito panel jugadores
          Panel_Jugadores.Enabled:= false;

          //Deshabilito menu principal del form_juego al usuario comun
          for i:=0 to menuFormJuego.Items.Count-1 do
            menuFormJuego.Items[I].Enabled:= false;

          
        end;//end estado=4
      end;//end CASE

      //consulto si el estado del juego es >= 2 para asegurarme que nadie puede apostar si el ya 'no va mas'
      if (AuxRegJuego.Estado>=2) then
      begin
        //Oculto tablero del jugador
        panel_tablero.Hide;
        Panel_NameTablero.Hide;
      end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.SalirDelJuego();
begin
 Form_Juego.F_Juego.close;
 Form_Jugadores.F_Jugadores.Show;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.pantallaIniJuegoCrupier();
begin
  panel_tablero.Enabled:= false;
  AutoSize_ImagenesTablero();
  Lbl_usuarioActual.Caption:= NickLogueado;
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar
  //--------------------------------
  Panel_Jugadores.Hide;
  Panel_Crupier.Show;
  F_Juego.Lbl_CantFictActivados.Caption:='--';;
  Lbl_cantFicticios.Caption:='--';
  Lbl_nroBolillaG.Caption:='--';
  //--------------------------------
  Spbtn_CrearPartida.Enabled:=true;
  Spbtn_bloqDesbloq.Enabled:= true;
  Spbtn_haganApuestas.Enabled:=false;
  Spbtn_noVaMas.Enabled:=false;
  Spbtn_tirarBolilla.Enabled:=false;
  Spbtn_repartirPremios.Enabled:=false;

  Spbtn_activarFicticios.Enabled:= false;
  Spbtn_obsequiarCred.Enabled:= false;
  Spbtn_trampa.Enabled:= false;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.pantallaIniJuegoJugadores();
var
  i:tPos;
begin
  panel_tablero.Enabled:= false;
  AutoSize_ImagenesTablero();
  Lbl_usuarioActual.Caption:= NickLogueado;
  ActualizarFechaHora(Lbl_fechaActual, Lbl_horaActual); //Actualizo fecha y hora a mostrar

  Panel_Crupier.hide;
  Panel_Jugadores.Show;
  ME_JUEGO.RegistroNulo(RegJuegoRuleta);
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta); //
  Lbl_nroPartida.Caption:= RegJuegoRuleta.NroJugada; //
  panel_tablero.Show;
  Panel_NameTablero.Show;
  Lbl_ApuestaMax.Caption:= '$ ' + intTostr(apuestaMax);
  Lbl_ApuestaMin.Caption:= '$ ' + intTostr(apuestaMin);

  menuFormJuego.Items[0].Visible:= true;
  menuFormJuego.Items[1].Visible:= false;
  menuFormJuego.Items[2].Visible:= false;
  //for i:=1 to menuFormJuego.Items.Count-1 do
  //  menuFormJuego.Items[i].Visible:= false;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.ListarPremiados(Nro_Jugada: Type_JUEGO.tClave);
begin
  ME_JUEGO.RegistroNulo(RegJuegoRuleta);
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, RegJuegoRuleta);

  Form_Premios.F_Premios.show;
  Lib_AuxJuego.limpiarGrid(F_Premios.Grid_Premiados);

  Lib_AuxJuego.EncabezadoGridPremios(F_Premios.Grid_Premiados);
  F_Premios.Grid_premiados.RowCount:=1;
  Lib_AuxJuego.Listado_Premios(ME_GANADORES.Raiz(ME_GANADOR), Nro_Jugada, F_Premios.Grid_Premiados);
  F_Premios.Grid_premiados.FixedRows:=1;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.ListandoApuestas();
begin
  Lib_AuxJuego.limpiarGrid(F_Apostar.Grid_ListaApuestas);
  F_Apostar.Grid_ListaApuestas.RowCount:=1;
  Lib_AuxJuego.EncabezadosComunApuestas(F_Apostar.Grid_ListaApuestas);

  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);

  if (Lib_AuxJuego.JugadorTieneApuestasEnPartida(RegJuegoRuleta.NroJugada, NickLogueado)) then
  begin
    F_Apostar.Grid_ListaApuestas.RowCount:=1;
    Lib_AuxJuego.Listado_ApuestasUnJugador(F_Apostar.Grid_ListaApuestas, RegJuegoRuleta.NroJugada, NickLogueado);
    //F_Apostar.Grid_ListaApuestas.FixedRows:=1;
  end;
end;

{------------------------------------------------------------------------------}

procedure TF_Juego.ActualizarFechaHora(var Lbl_fecha:TLabel; var Lbl_hora: TLabel);
begin
  Lbl_fecha.Caption:= datetostr(now);
  Lbl_hora.Caption:= timetostr(now);
end;


END.
