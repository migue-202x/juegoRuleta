unit Form_Login;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, jpeg, Vcl.Menus;

type
  TF_Login = class(TForm)
    Panel1: TPanel;
    PanelGeneral: TPanel;
    Label6: TLabel;
    PanelBotones1: TPanel;
    BtnLogin: TButton;
    BtnAltas: TButton;
    PanelFormulario: TPanel;
    Lab_apellido: TLabel;
    Lab_nombre: TLabel;
    Lab_contrasenia: TLabel;
    Lab_nick: TLabel;
    Txt_Nombre: TEdit;
    Txt_Contrasenia: TEdit;
    Txt_NICK: TEdit;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    Txt_Apellido: TEdit;
    Btn_HideShowContrasenia: TBitBtn;
    Menu_Login: TMainMenu;
    SALIR1: TMenuItem;
    Function CamposAltaOk():Boolean;
    Function  NickValido():Boolean;
    Function CamposLoginOk():Boolean;
    procedure Limpiar_Formulario();
    procedure show_apellidoNombre();
    procedure Pantalla_InicioLogin();
    procedure hide_apellidoNombre();
    procedure BtnLoginClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAltasClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEraseClick(Sender: TObject);
    procedure Txt_ContraseniaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Txt_NombreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Txt_NombreKeyPress(Sender: TObject; var Key: Char);
    procedure Txt_ApellidoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Btn_HideShowContraseniaClick(Sender: TObject);
    procedure Txt_NICKKeyPress(Sender: TObject; var Key: Char);
    procedure Txt_ContraseniaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SALIR1Click(Sender: TObject);




  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Login: TF_Login;
  Opcion: char;
  AdminLog : boolean; //si es el administrador quien se loguea es true
  NickLogueado : Type_JUGADOR.tClave;

  ME_JUGADOR:  ME_JUGADORES.ME_Jugador;
  regJugador: Type_JUGADOR.tRegDatos;
  posjugador: Lib_Auxiliar.tpos;

  ME_CUENTACORRIENTE: ME_CTACTE.ME_CUENTA;
  RegCtaCte: Type_ALMACEN.tipoRegAlmacen;
  posAlmacen: Lib_Auxiliar.tpos;
  saldoAcumulado: tImporte;

  ME_JUEGORULETA: ME_JUEGO.ME_RULETA;
  RegJuegoRuleta: Type_JUEGO.TipoRegDatos;

  ME_APUESTA: ME_APUESTAS.ME_APUESTA;
  RegApuesta: Type_APUESTA.TipoRegDatos;

  ME_GANADOR: ME_GANADORES.ME_GANADOR;
  RegGanador: Type_GANADOR.TipoRegDatos;





implementation

uses
  Form_Jugadores, Form_Croupier, Form_Juego;


{$R *.dfm}

{------------------------------------------------------------------------------}

procedure TF_Login.Btn_HideShowContraseniaClick(Sender: TObject);
begin
  if (Txt_Contrasenia.PasswordChar = #0) then
  begin
    Txt_Contrasenia.PasswordChar:='*';
    Btn_HideShowContrasenia.Glyph.LoadFromFile(Lib_AuxJuego.rutaIconoOjoAbierto);
  end
  else
  begin
    Txt_Contrasenia.PasswordChar:= #0;
    Btn_HideShowContrasenia.Glyph.LoadFromFile(Lib_AuxJuego.rutaIconoOjoCerrado);
  end;
end;

{------------------------------------------------------------------------------}

procedure TF_Login.BtnAltasClick(Sender: TObject);
begin
  Opcion:='B';
  BtnLogin.Enabled:=false;
  panelformulario.Enabled:= true;
  show_ApellidoNombre;
  Txt_NICK.SetFocus;
  Limpiar_Formulario;
end;

{------------------------------------------------------------------------------}

procedure TF_Login.BtnCancelarClick(Sender: TObject);
begin
  Btn_HideShowContrasenia.hide;
  hide_apellidoNombre;
  BtnLogin.Enabled:=true;
  BtnAltas.Enabled:=true;
  Limpiar_Formulario;
end;

{------------------------------------------------------------------------------}

procedure TF_Login.BtnLoginClick(Sender: TObject);
begin
  Opcion:='A';
  BtnAltas.Enabled:=false;
  panelformulario.Enabled:= true;
  Txt_NICK.Enabled:= true;
  Txt_Contrasenia.Enabled:= true;
  Txt_Nombre.Enabled:= true;
  Txt_Apellido.Enabled:= true;
  Txt_NICK.SetFocus;
  Limpiar_Formulario;
  hide_apellidoNombre;

  PanelFormulario.Enabled:= true;
end;

{------------------------------------------------------------------------------}

procedure TF_Login.BtnOkClick(Sender: TObject);
begin
  Btn_HideShowContrasenia.hide;
  NickLogueado:= Txt_NICK.Text;

case Opcion of
  'A': begin //LOGIN
      if (CamposLoginOk) then
      begin
        if not (ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,PosJugador,NickLogueado)) then
        begin //Nick incorrecto
          MessageDlg('Nick incorrecto',mtError , [mbOK], 0);
          Txt_NICK.Clear;
          Txt_CONTRASENIA.Clear;
          Txt_NICK.SetFocus;
        end
        else
          begin
            //capturo registro para comparar nick con su contrase�a
            ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,regJugador,PosJugador);

            if not (Txt_CONTRASENIA.Text = regJugador.Contrasenia) then
            begin //contrase�a incorrecta
              MessageDlg('La contrase�a no coincide con el Nick ingresado',mtError , [mbOK], 0);
              Txt_CONTRASENIA.Clear;
              Txt_CONTRASENIA.SetFocus;
            end
            else //Usuario logueado correctamente
              begin
              Form_Login.F_Login.hide;
                //Consulto si el jugador ya esta en el juego. Si esta activo, esta en el juego
                //if not (regJugador.Estado) then
                //begin //jugador no esta en el juego. Pregunto si es el crupier
                   if (regJugador.Nick = 'CROUPIER') then
                   begin //ADMINISTRADOR LOGUEADO...
                     AdminLog:=true;
                     Limpiar_Formulario;
                     Form_Croupier.F_Croupier.Show;
                   end
                   else  //USUARIO COMUN LOGUEADO...
                     begin
                      AdminLog:=false;
                      Form_Jugadores.F_Jugadores.Show;

                      //busco saldo acumulado del jugador logueado
                      saldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, regJugador.Nick);
                     end;
                     Lib_AuxJuego.Ini_Sesion(ME_JUGADOR, regJugador); //Inicio sesion, ya sea administrador o usuario com�n
                 {end;
                 else //jugador ya esta en el juego
                 begin
                    MessageDlg('El usuario ya esta en el juego',mtInformation , [mbOK], 0);
                    Limpiar_Formulario;
                    Txt_NICK.SetFocus;
                 end; }
              end; //fin usuario logueado correctamente
          end; //fin existe nick
      end //fin campos completados correctamente
      else
        MessageDlg('Debe completar todos los campos.',mtError , [mbOK], 0);
  end;
  'B': begin //ALTA
      if (CamposAltaOk) then
      begin
        if (NickValido) then
        begin
          if (ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,PosJugador, NickLogueado)) then
          begin //Nick en uso
            MessageDlg('Nick ya esta en uso. Intente con otro',mtConfirmation , [mbOK], 0);
            Txt_NICK.Clear;
            Txt_NICK.SetFocus;
          end
          else
          begin  //Inserto juegador
            regJugador.Nick:= NickLogueado;
            regJugador.Contrasenia:= Txt_Contrasenia.Text;
            regJugador.Apellido:= Txt_Apellido.Text;
            regJugador.Nombre:= Txt_Nombre.Text;
            regJugador.Alta:= now();
            regJugador.UltimaConexion:= now();
            regJugador.Bloqueado:= false;
            regJugador.Estado:= false;
            regJugador.TipoJugador:= true;
            ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR, PosJugador, regJugador.Nick);
            ME_JUGADORES.InsertarInfoME_Jugadores(ME_JUGADOR,regJugador,PosJugador);

            //Cargo datos de ctacte
            RegCtaCte.Nick:=regJugador.Nick;
            RegCtaCte.FechaHora:= Now();
            RegCtaCte.Concepto:= Type_ALMACEN.tipoConceptos.Creacion_Cuenta;
            RegCtaCte.Debe:= ME_JUEGO.ApuestaMinima(ME_JUEGORULETA)*15; //50*15 = 750
            RegCtaCte.haber:= 0;
            RegCtaCte.saldo:= RegCtaCte.Debe;//al crearse la cuenta se carga 15 veces la apuesta minima y se refleja en el saldo
            //inserto cuenta corriente
            ME_CTACTE.InsertarAlmacen(ME_CUENTACORRIENTE,RegCtaCte);

            MessageDlg('El usuario ha sido registrado!',mtConfirmation , [mbOK], 0);
            Limpiar_Formulario;
            hide_apellidoNombre;

            PanelFormulario.Enabled:=false;
            BtnLogin.Enabled:=true;
            BtnAltas.Enabled:=true;
            BtnLogin.SetFocus;
          end;
        end//NickValido
        else
        begin
          MessageDlg('NICK INV�LIDO!' + #13 + #13 +'Comienzo del Nick con "' + Lib_Auxiliar.Fict_IniNick + '"' + #13 + 'est� reservado solo para los ficticios!',mtWarning , [mbOK], 0);
          Txt_Nick.Clear;
          Txt_Nick.SetFocus;
        end;
      end //CamposAltaOk
      else
        MessageDlg('Debe completar todos los campos.',mtError , [mbOK], 0);
  end;//fin opcion B
end;//case
end;

{------------------------------------------------------------------------------}

procedure TF_Login.BtnEraseClick(Sender: TObject);
begin
  ME_JUGADORES.CerrarME_Jugadores(ME_JUGADOR);
  ME_JUGADORES.DestruirME_Jugadores(ME_JUGADOR);

  ME_CTACTE.CerrarMe_CtaCte(ME_CUENTACORRIENTE);
  ME_CTACTE.DestruirMe_CtaCte(ME_CUENTACORRIENTE);

  ME_JUEGO.CerrarME(ME_JUEGORULETA);
  ME_JUEGO.DestruirME(ME_JUEGORULETA);

  ME_APUESTAS.CerrarME_Apuestas(ME_APUESTA);
  ME_APUESTAS.DestruirME_Apuestas(ME_APUESTA);

  ME_GANADORES.CerrarME_Ganadores(ME_GANADOR);
  ME_GANADORES.DestruirME_Ganadores(ME_GANADOR);

end;

{------------------------------------------------------------------------------}

Function  TF_Login.CamposAltaOk():Boolean;
begin
  CamposAltaOk:= (Txt_Nombre.Text<>'')and(Txt_Contrasenia.Text<>'')and (Txt_NICK.Text<>'') and
                (Txt_Apellido.Text<>'');
end;

{------------------------------------------------------------------------------}

Function  TF_Login.NickValido():Boolean;
var
  comienzoNick: string[2];
begin
  comienzoNick:= copy(Txt_NICK.Text, 1, 2);
  NickValido:= (comienzoNick <> Lib_Auxiliar.Fict_IniNick);
end;

{------------------------------------------------------------------------------}

Function  TF_Login.CamposLoginOk():Boolean;
begin
  CamposLoginOk:= (Txt_NICK.Text<>'') and (Txt_Contrasenia.Text<>'');
end;

{------------------------------------------------------------------------------}


procedure TF_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ME_JUGADORES.CerrarME_Jugadores(ME_JUGADOR);
  ME_CTACTE.CerrarMe_CtaCte(ME_CUENTACORRIENTE);
  ME_JUEGO.CerrarME(ME_JUEGORULETA);
  ME_APUESTAS.CerrarME_Apuestas(ME_APUESTA);
  ME_GANADORES.CerrarME_Ganadores(ME_GANADOR);
end;

procedure TF_Login.FormCreate(Sender: TObject);
var
  regAuxJuego: TYPE_JUEGO.TipoRegDatos;
begin
  ME_JUGADORES.CrearME_Jugadores(ME_JUGADOR);
  ME_JUGADORES.AbrirME_Jugadores(ME_JUGADOR);

  ME_CTACTE.CrearMe_CtaCte(ME_CUENTACORRIENTE);
  ME_CTACTE.AbrirMe_CtaCte(ME_CUENTACORRIENTE);

  ME_JUEGO.CrearME(ME_JUEGORULETA);
  ME_JUEGO.AbrirME(ME_JUEGORULETA);

  ME_APUESTAS.CrearME(ME_APUESTA);
  ME_APUESTAS.AbrirME_Apuestas(ME_APUESTA);

  ME_GANADORES.CrearME_Ganadores(ME_GANADOR);
  ME_GANADORES.AbrirME_Ganadores(ME_GANADOR);

  if ME_JUGADORES.MeVacio_Jugadores(ME_JUGADOR) then
  begin
    regJugador.Nick:='CROUPIER';
    regJugador.Contrasenia:= 'MONDONGO';
    regJugador.Nombre:='Administrador';
    regJugador.Apellido:='Administrador';
    regJugador.Alta:=NOW();
    regJugador.UltimaConexion:=NOW();
    regJugador.Estado:=false;
    regJugador.TipoJugador:=true;

    ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,regJugador.Nick);
    ME_JUGADORES.InsertarInfoME_Jugadores(ME_JUGADOR,regJugador,PosJugador);
  end;

  //operaciones generales
  AdminLog:=false;
  hide_apellidoNombre;
  self.Position := poScreenCenter;
  self.WindowState := wsMaximized;
end;


{------------------------------------------------------------------------------}

procedure TF_Login.FormShow(Sender: TObject);
begin
  Pantalla_InicioLogin();

  ME_JUGADORES.AbrirME_Jugadores(ME_JUGADOR);
  ME_CTACTE.AbrirMe_CtaCte(ME_CUENTACORRIENTE);
  ME_JUEGO.AbrirME(ME_JUEGORULETA);
  ME_APUESTAS.AbrirME_Apuestas(ME_APUESTA);
  ME_GANADORES.AbrirME_Ganadores(ME_GANADOR);

end;

{------------------------------------------------------------------------------}

procedure TF_Login.Limpiar_Formulario();
begin
  Txt_NICK.Clear;
  Txt_Contrasenia.Clear;
  Txt_Nombre.Clear;
  Txt_Apellido.Clear;
end;
{------------------------------------------------------------------------------}

procedure TF_Login.show_apellidoNombre();
begin
  Lab_nombre.Visible:=true;
  Lab_apellido.Visible:=true;
  Txt_Nombre.Visible:=true;
  Txt_Apellido.Visible:=true;
  Lab_nombre.Show;
  Lab_apellido.Show;
  Txt_Nombre.Show;
  Txt_Apellido.Show;
end;

{-----------------------------------------------------------------------}

procedure TF_Login.Txt_ApellidoKeyPress(Sender: TObject; var Key: Char);
const
  CARAC_HABILITADOS = ['a'..'z', 'A'..'Z', #0..#27];//solo letras y tecla borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

{-----------------------------------------------------------------------}

procedure TF_Login.Txt_ContraseniaKeyPress(Sender: TObject; var Key: Char);
const
  CARAC_HABILITADOS = ['a'..'z', 'A'..'Z', '0'..'9', #0..#27];//solo letras, numero y borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

procedure TF_Login.Txt_ContraseniaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (length(Txt_NICK.Text)<6) then
  begin
    MessageDlg('Nick debe tener al menos 6 caracteres',mtConfirmation , [mbOK], 0);
    Txt_CONTRASENIA.Clear;
    Txt_NICK.Clear;
    Txt_NICK.SetFocus;
  end
  else
    Btn_HideShowContrasenia.show;
end;


{-----------------------------------------------------------------------}


procedure TF_Login.Txt_NICKKeyPress(Sender: TObject; var Key: Char);
const
  CARAC_HABILITADOS = ['a'..'z', 'A'..'Z', '0'..'9', #0..#27];//solo letras, numeros, signo punto, signo guion bajo y tecla borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

{-----------------------------------------------------------------------}

procedure TF_Login.Txt_NombreKeyPress(Sender: TObject; var Key: Char);
const
  CARAC_HABILITADOS = ['a'..'z', 'A'..'Z', #0..#27];//solo letras y tecla borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

{-----------------------------------------------------------------------}

Procedure TF_Login.Txt_NombreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (length(Txt_Contrasenia.Text)<4) then
  begin
    MessageDlg('La contrase�a debe tener 4 caracteres como minimo',mtConfirmation , [mbOK], 0);
    Txt_Contrasenia.Clear;
    Txt_Contrasenia.SetFocus;
  end;
end;

{-----------------------------------------------------------------------}

procedure TF_Login.hide_apellidoNombre();
begin
  Lab_nombre.Visible:=false;
  Lab_apellido.Visible:=false;
  Txt_Nombre.Visible:=false;
  Txt_Apellido.Visible:=false;
  Lab_nombre.Hide;
  Lab_apellido.Hide;
  Txt_Nombre.Hide;
  Txt_Apellido.Hide;
end;

{-----------------------------------------------------------------------}

procedure TF_Login.Pantalla_InicioLogin();
begin
  Form_Juego.F_Juego.Hide;
  Btn_HideShowContrasenia.Hide;
  BtnLogin.Enabled:= true;
  BtnAltas.Enabled:= true;
  PanelFormulario.Enabled:= false;
  Txt_NICK.Clear;
  Txt_Contrasenia.Clear;
  Txt_Nombre.Clear;
  Txt_Apellido.Clear;
end;

{-----------------------------------------------------------------------}

procedure TF_Login.SALIR1Click(Sender: TObject);
begin
  F_Login.Close;
end;


END.
