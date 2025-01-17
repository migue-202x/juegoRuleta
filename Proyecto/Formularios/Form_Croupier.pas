unit Form_Croupier;

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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Imaging.jpeg;

type
  TF_Croupier = class(TForm)
    MainMenu1: TMainMenu;
    Juego1: TMenuItem;
    Listados1: TMenuItem;
    Bloquear1: TMenuItem;
    Activos1: TMenuItem;
    Jugarpartida1: TMenuItem;
    Listadograljugadores1: TMenuItem;
    Ganadoresdeterminadopremio1: TMenuItem;
    Jugadoresmasdineroganaron1: TMenuItem;
    Jugadoresquenuncaganaron1: TMenuItem;
    Listagraldepartidas1: TMenuItem;
    HerramientasdelME1: TMenuItem;
    Mostrararboljugadores1: TMenuItem;
    Mostrararbolganadores1: TMenuItem;
    Cerrarsesion1: TMenuItem;
    Crearficticios1: TMenuItem;
    Panel_CroupierGral: TPanel;
    Panel_CrearFicticios: TPanel;
    Label1: TLabel;
    Btn_crearFicticios: TButton;
    Bit_closeCrearFicticios: TBitBtn;
    Edit_cantFicticios: TEdit;
    Label2: TLabel;
    Fichaunjugador1: TMenuItem;
    Panel_EncabezadoCroupier: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Panel15: TPanel;
    Label4: TLabel;
    Lbl_nickCroupier: TLabel;
    Panel16: TPanel;
    Label5: TLabel;
    Lbl_fechaCroupier: TLabel;
    Label6: TLabel;
    Lbl_horaCroupier: TLabel;
    Img_fondoCroupier: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Cerrarsesion1Click(Sender: TObject);
    procedure Jugarpartida1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Crearficticios1Click(Sender: TObject);
    procedure Edit_cantFicticiosKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_crearFicticiosClick(Sender: TObject);
    procedure Bloquear1Click(Sender: TObject);
    procedure Listadograljugadores1Click(Sender: TObject);
    procedure Ganadoresdeterminadopremio1Click(Sender: TObject);
    procedure Jugadoresmasdineroganaron1Click(Sender: TObject);
    procedure Jugadoresquenuncaganaron1Click(Sender: TObject);
    procedure CtaCtedeunjugador1Click(Sender: TObject);
    procedure Listagraldepartidas1Click(Sender: TObject);
    procedure Mostrararboljugadores1Click(Sender: TObject);
    procedure Mostrararbolganadores1Click(Sender: TObject);
    procedure Activos1Click(Sender: TObject);
    procedure Bit_closeCrearFicticiosClick(Sender: TObject);
    procedure Fichaunjugador1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Croupier: TF_Croupier;

implementation

uses
   Form_Login, Form_Juego, Form_PanelCaseButtons, Form_Listados;

{$R *.dfm}

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Activos1Click(Sender: TObject);
var
  Cant: tCantidad; // cantidad jugadores en general
  Cant_Activos: tCantidad; // cantidad de jugadores activos
begin
  Panel_CrearFicticios.Hide;
  Form_Listados.opListado:= 9;

  cant:= 0;
  Cant_Activos:= 0;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);
  Lib_AuxJuego.Cant_JugadoresActivos(ME_JUGADORES.Raiz(ME_JUGADOR), Cant_Activos);

   if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
   begin
        //Si hay jugadores activos. Podria usar una funcion booleana. Pero la cantidad de activos la voy a necesitar para mostrar
      if (Cant_Activos>=1) then
        F_Listados.Show
      else
        MessageDlg('No hay jugadores activos!',mtWarning, [mbOK], 0);
    end
    else
      MessageDlg('No existen jugadores!!',mtWarning, [mbOK], 0);
end;

{------------------------------------------------------------------------------}

procedure TF_Croupier.Bit_closeCrearFicticiosClick(Sender: TObject);
begin
   Panel_CrearFicticios.Hide;
   Edit_cantFicticios.Clear;
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Bloquear1Click(Sender: TObject);
var
  Cant: tCantidad; // cantidad jugadores en general
begin
  Panel_CrearFicticios.Hide;
  Cant:= 0;
  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not(ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR)) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    begin
      F_PanelCaseButtons.MostrarEnGridJugadores();
    end
    else
      begin
        MessageDlg('No existen jugadores!!',mtWarning, [mbOK], 0);
        Form_Croupier.F_Croupier.Panel_CroupierGral.Enabled:= true;
      end;

  F_PanelCaseButtons.Panel_LockUnlock.Enabled:= true;
  F_PanelCaseButtons.Panel_LockUnlock.show;

  F_PanelCaseButtons.Panel_RegalarCredito.Enabled:= false;
  F_PanelCaseButtons.Panel_RegalarCredito.Hide;
  F_PanelCaseButtons.Lbl_regalarCred.Hide;
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Btn_crearFicticiosClick(Sender: TObject);
begin
  if(Edit_cantFicticios.Text <> '')then
  begin
    if Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere crear '+ Edit_cantFicticios.Text + ' ficticios?') then
    begin
      Lib_AuxJuego.Insertar_JugadoresFicticios(ME_JUGADOR, strToint(Edit_cantFicticios.Text));
      Edit_cantFicticios.Clear;
      Panel_CrearFicticios.Hide;
      MessageDlg(Edit_cantFicticios.Text + ' jugadores ficticios han sido creado con �xito.',mtConfirmation , [mbOK], 0);
    end
    else
    begin
      Edit_cantFicticios.SetFocus;
      Edit_cantFicticios.Clear;
    end;
  end
  else
    begin
      MessageDlg('Debe ingresar cantidad a crear.',mtWarning , [mbOK], 0);
      Edit_cantFicticios.SetFocus;
    end;
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Cerrarsesion1Click(Sender: TObject);
begin
  if (Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere cerrar sesi�n?')) then
  begin
    {CerrarSesion}
    Lib_AuxJuego.Fin_Sesion(ME_JUGADOR, regJugador);
    F_Croupier.Hide;
    Form_Login.F_Login.show;
  end;
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Crearficticios1Click(Sender: TObject);
begin
  Panel_CrearFicticios.Show;
  Edit_cantFicticios.SetFocus;
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.CtaCtedeunjugador1Click(Sender: TObject);
var
  cant:tCantidad;
begin
  cant:=0;
//-	Cuenta corriente de un Jugador
  Form_Listados.opListado:= 5;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    Form_Listados.F_Listados.Show
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Edit_cantFicticiosKeyPress(Sender: TObject;
  var Key: Char);
const
  CARAC_HABILITADOS = ['0'..'9', #0..#27];//solo letras y tecla borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

{--------------------------------------------------------------------------------}


procedure TF_Croupier.Fichaunjugador1Click(Sender: TObject);
var
  cant:tCantidad;
begin
  Panel_CrearFicticios.Hide;
  cant:=0;
//-	Ficha de un Jugador
  Form_Listados.opListado:= 5;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    Form_Listados.F_Listados.Show
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.FormCreate(Sender: TObject);
begin
  self.Position := poScreenCenter;
  self.WindowState := wsMaximized;
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.FormShow(Sender: TObject);
begin
  Panel_CrearFicticios.Hide;
  Lbl_nickCroupier.Caption:= NickLogueado;
  F_Juego.ActualizarFechaHora(Lbl_fechaCroupier, Lbl_horaCroupier); //Actualizo fecha y hora a mostrar
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Ganadoresdeterminadopremio1Click(Sender: TObject);
var
  cantJ:tCantidad;
begin
  Panel_CrearFicticios.Hide;
  cantJ:=0;
//-	Listado ganadores determinado premio
  Form_Listados.opListado:= 2;

  cantJ:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cantJ>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
  begin
    if not(ME_JUEGO.MEVacio(ME_JUEGORULETA)) then
    begin
      if not ME_GANADORES.MeVacio_Ganadores(ME_GANADOR) then
        Form_Listados.F_Listados.Show
      else
        MessageDlg('No existen ganadores!!',mtWarning , [mbOK], 0);
    end
    else
      MessageDlg('No se ha efectuado ninguna jugada a�n!!',mtWarning , [mbOK], 0);
  end
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Jugadoresmasdineroganaron1Click(Sender: TObject);
var
  cantJ: tCantidad; //cantidad jugadores
begin
  Panel_CrearFicticios.Hide;
  cantJ:=0;
//-	Listado de los jugadores que mas dinero ganaron
  Form_Listados.opListado:= 3;

  cantJ:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cantJ>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
  begin
    if not(ME_JUEGO.MEVacio(ME_JUEGORULETA)) then
    begin
      if not ME_GANADORES.MeVacio_Ganadores(ME_GANADOR) then
        Form_Listados.F_Listados.Show
      else
        MessageDlg('No existen ganadores!!',mtWarning , [mbOK], 0);
    end
    else
      MessageDlg('No se ha efectuado ninguna jugada a�n!!',mtWarning , [mbOK], 0);
  end
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Jugadoresquenuncaganaron1Click(Sender: TObject);
var
  cantJ:tCantidad;//cantidad jugadores
  cantJNG: tCantidad; //cantidad jugadores que nunca ganaron
begin
  Panel_CrearFicticios.Hide;
  cantJ:= 0;
  cantJNG:= 0;
//-	Listado de los jugadores que nunca ganaron apuestas.
  Form_Listados.opListado:= 4;

  cantJ:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);
  Lib_AuxJuego.CantidadJugadoresNuncaGanaron(ME_JUGADORES.Raiz(ME_JUGADOR), cantJNG);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cantJ>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
  begin
    if not(ME_JUEGO.MEVacio(ME_JUEGORULETA)) then
    begin
      if (cantJNG>0) then
        Form_Listados.F_Listados.Show
      else
        MessageDlg('No existen jugadores que no hayan perdido alguna apuesta!!',mtWarning , [mbOK], 0);
    end
    else
      MessageDlg('No se ha efectuado ninguna jugada a�n!!',mtWarning , [mbOK], 0);
  end
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Jugarpartida1Click(Sender: TObject);
begin
  //Msj de advertencia para que no se intente salir del juego si el mismo no esta en estado 4 (fin de juego y repartido los premios)
  MessageDlg('TENGA PRESENTE QUE: ' + #13 + #13 + ' Una vez seleccionado "CREAR PARTIDA NUEVA" solo podr� salir del juego cuando el mismo finalice',mtInformation , [mbOK], 0);
  F_Croupier.Hide;
  F_Juego.Show;
  F_Juego.pantallaIniJuegoCrupier();
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Listadograljugadores1Click(Sender: TObject);
var
  cant:tCantidad;
begin
  Panel_CrearFicticios.Hide;
  cant:=0;
//Listado General de Usuarios (jugadores). Debe incluir nombre, Nick, foto, clave, estado,  etc. de cada uno (l�nea por l�nea).
  Form_Listados.opListado:= 1;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    Form_Listados.F_Listados.Show
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;



{--------------------------------------------------------------------------------}

procedure TF_Croupier.Listagraldepartidas1Click(Sender: TObject);
var
  cant:tCantidad;
begin
  Panel_CrearFicticios.Hide;
  cant:=0;
//-	Listado general de las partidas
  Form_Listados.opListado:= 6;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
  begin
    if not(ME_JUEGO.MEVacio(ME_JUEGORULETA)) then
      Form_Listados.F_Listados.Show
    else
      MessageDlg('No se ha efectuado ninguna jugada a�n!!',mtWarning , [mbOK], 0);
  end
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Mostrararbolganadores1Click(Sender: TObject);
begin
//Voy a mostrar arbol de ganadores indicando el nick y nivel del mismo
  Panel_CrearFicticios.Hide;
  Form_Listados.opListado:= 8;

  if (not ME_GANADORES.MeVacio_Ganadores(ME_GANADOR)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    Form_Listados.F_Listados.Show
  else
    MessageDlg('No existen ganadores!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_Croupier.Mostrararboljugadores1Click(Sender: TObject);
var
  cant:tCantidad;
begin
  Panel_CrearFicticios.Hide;
  cant:=0;
//Voy a mostrar de jugadores indicando el nick y nivel del mismo
  Form_Listados.opListado:= 7;

  cant:= ME_JUGADORES.Cantidad_Jugadores(ME_JUGADOR);

  if (not ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) and (cant>1)) then //si cant es >1 entonces al menos hay un jugador que no es el administrador
    Form_Listados.F_Listados.Show
  else
    MessageDlg('No existen jugadores!!',mtWarning , [mbOK], 0);
end;


END.
