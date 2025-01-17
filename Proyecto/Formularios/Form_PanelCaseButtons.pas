
//Formulario que segun eliga el croupier puede ser para bloquear/ desbloquear u obsequiar cr�dito
unit Form_PanelCaseButtons;

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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TF_PanelCaseButtons = class(TForm)
    Panel_Listado: TPanel;
    Panel_RegalarCredito: TPanel;
    btn_okRegalarCredito: TBitBtn;
    Panel_grid: TPanel;
    Edit_cantCredito: TEdit;
    Lbl_cantCredito: TLabel;
    Lbl_bloquearDesbloquear: TLabel;
    Lbl_regalarCred: TLabel;
    Grid_ListadoJugadores: TStringGrid;
    Label1: TLabel;
    Edit_Jugador: TEdit;
    BitBtn1: TBitBtn;
    Panel_LockUnlock: TPanel;
    Label3: TLabel;
    btn_okLockUnlock: TBitBtn;
    Edit_NickJugador: TEdit;
    procedure limpiarGrid();
    procedure MostrarEnGridJugadores();
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Grid_ListadoJugadoresDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Grid_ListadoJugadoresClick(Sender: TObject);
    procedure btn_okRegalarCreditoClick(Sender: TObject);
    procedure Edit_cantCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure btn_okLockUnlockClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PanelCaseButtons: TF_PanelCaseButtons;

implementation

uses
  Form_login, Form_Juego, Form_Croupier;

{$R *.dfm}

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.BitBtn1Click(Sender: TObject);
begin
  Form_Juego.F_Juego.Panel_JuegoGral.Enabled:=true;
  F_PanelCaseButtons.Close;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not (F_Juego.Enabled) then
    F_Juego.Enabled:= true;

  if not (F_Croupier.Enabled) then
    F_Croupier.Enabled:= true;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.FormCreate(Sender: TObject);
begin
  self.Position := poScreenCenter;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.FormShow(Sender: TObject);
begin
  if (F_Juego.Enabled) then
    F_Juego.Enabled:= false;

  if (F_Croupier.Enabled) then
    F_Croupier.Enabled:= false;

  MostrarEnGridJugadores();
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.Grid_ListadoJugadoresClick(Sender: TObject);
begin
    if Grid_ListadoJugadores.Row <> 0
    then
    begin
      if (Panel_RegalarCredito.Enabled) then //Croupier va a regalar credito
      begin
      Edit_Jugador.Text := Grid_ListadoJugadores.Cells[2,Grid_ListadoJugadores.Row];
        if (Edit_Jugador.Text<>'') then
        begin
          Edit_cantCredito.Enabled:=true;
          Edit_cantCredito.SetFocus;
        end
        else
          Edit_cantCredito.Enabled:= false;
      end
      else //Croupier va a bloquear/ desbloquear
        Edit_NickJugador.Text := Grid_ListadoJugadores.Cells[2,Grid_ListadoJugadores.Row];
    end;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.Grid_ListadoJugadoresDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
with (Sender as TStringGrid) do
  begin
    if (ARow = 0)
    then
      begin
        Canvas.Brush.Color := clBtnFace;
        Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(Grid_ListadoJugadores.Cells[ACol,ARow]) + 1) div 2, Rect.Top + 2, Grid_ListadoJugadores.Cells[ACol,ARow]);
      end
    else
    begin
      Canvas.Font.Color := clblack;
      if  (ARow mod 2 = 0)
      then
        Canvas.Brush.Color := $00E1FFF9
      else
        Canvas.Brush.Color := $00FFEBDF;
      Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, cells[acol, arow]);
      Canvas.FrameRect(Rect);
    end;
  end;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.limpiarGrid();
var
  i:integer;
begin
  with Grid_ListadoJugadores  do
    for i := 0 to RowCount - 1 do
    Rows[i].Clear;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.btn_okLockUnlockClick(Sender: TObject);
var
  sMsj:string;
begin
  ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR, posJugador, Edit_NickJugador.Text);
  ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

  if (regJugador.Bloqueado) then
  begin
    sMsj:= 'desbloquear';
    regJugador.Nick:= regJugador.Nick;
    regJugador.Contrasenia:= regJugador.Contrasenia;
    regJugador.Nombre:= regJugador.Nombre;
    regJugador.Apellido:= regJugador.Apellido;
    regJugador.Alta:= regJugador.Alta;
    regJugador.UltimaConexion:= Now();
    regJugador.Bloqueado:= false; // desbloqueo jugador
    regJugador.Estado:= regJugador.Estado; // si lo desbloqueo, le doy el estado que ya tiene (desactivo)
  end
  else
    begin
      sMsj:= 'bloquear';
      regJugador.Nick:= regJugador.Nick;
      regJugador.Contrasenia:= regJugador.Contrasenia;
      regJugador.Nombre:= regJugador.Nombre;
      regJugador.Apellido:= regJugador.Apellido;
      regJugador.Alta:= regJugador.Alta;
      regJugador.UltimaConexion:= Now();
      regJugador.Bloqueado:= true; // bloqueo jugador
      regJugador.Estado:= false; // si lo bloqueo, lo desconecto
    end;

  if (Edit_NickJugador.Text<>'') then
  begin
    if Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere ' +sMsj+ ' a ' +Edit_NickJugador.Text + ' ?') then
    begin
      ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR, posJugador, Edit_NickJugador.Text);
      ME_JUGADORES.ModificarInfoME_Jugadores(ME_JUGADOR, regJugador, posJugador);

      //Elimino las apuestas efectuadas del jugador recientemente bloquado
      EliminarApuestasUnJugador(Edit_NickJugador.Text);

      MostrarEnGridJugadores();
    end;
  end
  else
    MessageDlg('Debe seleccionar un jugador de la lista!!',mtWarning , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.btn_okRegalarCreditoClick(Sender: TObject);
begin
  if (Edit_Jugador.Text<>'') then
  begin
    if (Edit_cantCredito.Text<>'') then
    begin
      if (strtoint(Edit_cantCredito.Text) >= ME_JUEGO.ApuestaMinima(ME_JUEGORULETA)) and (strtoint(Edit_cantCredito.Text) <= ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA)) then
      begin
        if Lib_AuxJuego.Mensaje_Confirmacion('�Seguro que quiere obsequiar $'+ Edit_cantCredito.Text +' a ' + Edit_Jugador.Text + ' ?') then
        begin
          regCtaCte.Nick:= Edit_Jugador.Text;
          regCtaCte.FechaHora:= Now();
          regCtaCte.Concepto:= Type_ALMACEN.tipoConceptos.Credito_Regalado;
          regCtaCte.Debe:= strToint(Edit_cantCredito.Text);
          regCtaCte.haber:= 0;
          regCtaCte.saldo:= regCtaCte.Debe + ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE, Edit_Jugador.Text);
          ME_CTACTE.InsertarAlmacen(ME_CUENTACORRIENTE, RegCtaCte);
          messagedlg('Cr�dito obsequiado con �xito!', mtInformation, [mbOk], 0);
          Edit_Jugador.Clear;
          Edit_cantCredito.Clear;
          MostrarEnGridJugadores();
        end;
      end
      else
        begin
          MessageDlg('El cr�dito minimo debe ser de $ ' +intTostr(ME_JUEGO.ApuestaMinima(ME_JUEGORULETA))+
                ', y el cr�dito m�ximo debe ser de $ ' +intTostr(ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA)),mtWarning, [mbOK], 0);
          Edit_cantCredito.Clear;
          Edit_cantCredito.SetFocus;
        end;

    end
    else
      begin
        MessageDlg('Debe ingresar cr�dito a obsequiar!',mtError , [mbOK], 0);
        Edit_cantCredito.SetFocus;
      end;
  end
  else
    MessageDlg('Debe seleccionar un jugador de la lista!',mtError , [mbOK], 0);
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.Edit_cantCreditoKeyPress(Sender: TObject;
  var Key: Char);
const
  CARAC_HABILITADOS = ['0'..'9', #0..#27];//solo numero y tecla borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

{------------------------------------------------------------------------------}

procedure TF_PanelCaseButtons.MostrarEnGridJugadores();
begin
  F_PanelCaseButtons.Show;
  Lib_AuxJuego.limpiarGrid(Grid_ListadoJugadores);
  Lib_AuxJuego.EncabezadoDetalladoJugadores(Grid_ListadoJugadores);
  Grid_ListadoJugadores.RowCount:=1;
  Lib_AuxJuego.ListadoGeneral_JugadoresEnGrid(ME_JUGADORES.Raiz(ME_JUGADOR), Grid_ListadoJugadores);
  Grid_ListadoJugadores.FixedRows:=1;
end;

{------------------------------------------------------------------------------}

END.
