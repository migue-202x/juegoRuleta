unit Form_Apostar;

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
  TF_Apostar = class(TForm)
    Panel_Listado: TPanel;
    Lbl_SelectJugador: TLabel;
    Panel_DatosApostar: TPanel;
    Lbl_nameJugador: TLabel;
    Edit_nameJugador: TEdit;
    btn_okeyApostar: TBitBtn;
    Panel_grid: TPanel;
    Lbl_nomenclador: TLabel;
    Edit_nomenclador: TEdit;
    Lbl_valor: TLabel;
    Edit_valor: TEdit;
    Lbl_importe: TLabel;
    Edit_importe: TEdit;
    Lbl_ListaDeApuestas: TLabel;
    Lbl_ListaJugadores: TLabel;
    Grid_ListaApuestas: TStringGrid;
    Grid_ListaJugadores: TStringGrid;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    Procedure Listado_GeneralJugadores(RaizJugadores: Lib_Auxiliar.tPos);
    Function obtenerSaldoActualJugador(clave:tClave):tImporte;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn_ListarJugadoresClick(Sender: TObject);
    procedure Grid_ListaApuestasClick(Sender: TObject);
    procedure Grid_ListaJugadoresDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Grid_ListaJugadoresClick(Sender: TObject);
    procedure btn_okeyApostarClick(Sender: TObject);
    procedure Edit_importeKeyPress(Sender: TObject; var Key: Char);
    procedure Grid_ListaApuestasDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ListandoJugadores();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Apostar: TF_Apostar;
  SaldoAcumulado, SaldoApuestas_EnPartida, saldoActual:tImporte;

implementation

uses
  Form_login, Form_Juego;

{$R *.dfm}

{--------------------------------------------------------------------------------}

procedure TF_Apostar.BitBtn1Click(Sender: TObject);
begin
  F_Apostar.Close;
end;

{--------------------------------------------------------------------------------}



procedure TF_Apostar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Juego.Enabled:= true;
  F_Juego.AutoSize_ImagenesTablero();
  F_Juego.panel_tablero.Enabled:= true;

  if ((not AdminLog) and (not SoloListar)) then
  begin
    saldoActual:= F_Apostar.obtenerSaldoActualJugador(NickLogueado);
    F_Juego.Lbl_saldoAcumulado.Caption:= '$ ' + intTostr(saldoActual);
  end;
end;

{--------------------------------------------------------------------------------}

procedure TF_Apostar.FormCreate(Sender: TObject);
begin
  self.Position := poScreenCenter;
end;

{--------------------------------------------------------------------------------}

procedure TF_Apostar.FormShow(Sender: TObject);
begin
  F_Juego.Enabled:= false;
  F_Apostar.Grid_ListaJugadores.RowCount:=1;
end;

{--------------------------------------------------------------------------------}

procedure TF_Apostar.Grid_ListaApuestasClick(Sender: TObject);
var
  i, posElim: tPos;
  Nick: type_JUGADOR.tClave;
  Importe: tImporte;
  enc: boolean;
begin
  enc:= false;
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA, regJuegoRuleta);

  if (not SoloListar) then
  begin
    //Si el estado es igual a 1 'hagan sus apuestas'
    if (regJuegoRuleta.Estado = 1) then
    begin
      if (Grid_ListaApuestas.Row <> 0) then
      begin
        Nick:= Grid_ListaApuestas.Cells[0, Grid_ListaApuestas.Row];
        Nomenclador:= Grid_ListaApuestas.Cells[1, Grid_ListaApuestas.Row];
        Valor:= Grid_ListaApuestas.Cells[2, Grid_ListaApuestas.Row];
        Importe:= strToint(Grid_ListaApuestas.Cells[3, Grid_ListaApuestas.Row]);

        i:= ME_APUESTAS.Primero(ME_APUESTA);
        while ((i <> ME_APUESTAS.PosNula_Apuestas(ME_APUESTA)) or (not enc)) do
        begin
          ME_APUESTAS.CapturarInfoME_Apuestas(ME_APUESTA, i, RegApuesta);
          if (RegApuesta.NroJugada = RegJuegoRuleta.NroJugada) and (RegApuesta.Nick = Nick) then
            if ((RegApuesta.Nomenclador = Nomenclador) and (RegApuesta.Valor = Valor) and (RegApuesta.Importe = Importe)) then
            begin
              enc:= true;
              posElim:= i;
            end;
          i:= ME_APUESTAS.Proximo(ME_APUESTA, i);
        end;//while

        if Lib_AuxJuego.Mensaje_Confirmacion('�Esta seguro que quiere eliminar la apuesta?') then
        begin
          ME_APUESTAS.EliminarInfoME_Apuestas(ME_APUESTA, posElim);
          F_Juego.ListandoApuestas();
        end;
      end;
    end;
  end;
end;

{--------------------------------------------------------------------------------}

procedure TF_Apostar.Grid_ListaApuestasDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid) do
    begin
      if (ARow = 0)
      then
        begin
          Canvas.Brush.Color := clBtnFace;
          Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(Grid_ListaApuestas.Cells[ACol,ARow]) + 1) div 2, Rect.Top + 2, Grid_ListaApuestas.Cells[ACol,ARow]);
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

procedure TF_Apostar.Grid_ListaJugadoresClick(Sender: TObject);
begin
  if (AdminLog) then
  begin
    if (Grid_ListaJugadores.Row <> 0) then
    begin
      Edit_nameJugador.Text := Grid_ListaJugadores.Cells[0,Grid_ListaJugadores.Row];
    end;

    if (Edit_nameJugador.Text<>'') then
    begin
      Edit_importe.Enabled:=true;
      Edit_importe.SetFocus;
    end
    else
      Edit_importe.Enabled:= false;
  end;
end;

{--------------------------------------------------------------------------------}

procedure TF_Apostar.Grid_ListaJugadoresDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
with (Sender as TStringGrid) do
  begin
    if (ARow = 0)
    then
      begin
        Canvas.Brush.Color := clBtnFace;
        Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(Grid_ListaJugadores.Cells[ACol,ARow]) + 1) div 2, Rect.Top + 2, Grid_ListaJugadores.Cells[ACol,ARow]);
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

{------------------------------------------------------------------------------}
procedure TF_Apostar.Btn_ListarJugadoresClick(Sender: TObject);
begin
  ListandoJugadores();
end;
{------------------------------------------------------------------------------}

procedure TF_Apostar.btn_okeyApostarClick(Sender: TObject);
begin
  if (Edit_nameJugador.Text<>'') then
  begin
      if (Edit_importe.Text<>'') then
      begin
        ME_JUGADORES.BuscarInfoME_Jugadores(ME_JUGADOR,posJugador,Edit_nameJugador.Text);
        ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,regJugador,posJugador);
        if not (regJugador.Bloqueado) then
        begin
          if (strToint(Edit_Importe.Text) >= ME_JUEGO.ApuestaMinima(ME_JUEGORULETA)) and (strToint(Edit_Importe.Text) <= ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA)) then
          begin
          ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);
          SaldoApuestas_EnPartida:= ME_APUESTAS.SaldoApuestasPartida(ME_APUESTA,Edit_nameJugador.Text,RegJuegoRuleta.NroJugada)+strToint(Edit_importe.Text);
          SaldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE,Edit_nameJugador.Text);

            if ((SaldoApuestas_EnPartida <= SaldoAcumulado)) then
            begin
              if (RegJuegoRuleta.Estado = 1) then
              begin //todo correcto para llevarse acabo la apuesta ...
                //acumulacionDeApuestas:= acumulacionDeApuestas + strToint(Edit_importe.Text);
                //Armo registroApusta para insertar la nueva apuesta
                regApuesta.NroJugada:= RegJuegoRuleta.NroJugada;
                regApuesta.Nick:= Edit_nameJugador.Text;
                regApuesta.Nomenclador:= Edit_nomenclador.Text;
                regApuesta.Valor:=Edit_valor.Text;
                regApuesta.Importe:= strToint(Edit_importe.Text);
                ME_APUESTAS.InsertarInfoME_Apuestas(ME_APUESTA,regApuesta,ME_APUESTAS.PosNula_Apuestas(ME_APUESTA));

               //Obtengo el sueldo actual del jugador que se vera reflejado en su cuenta cuando el estado sea "fin del juego"
               saldoActual:= obtenerSaldoActualJugador(Edit_nameJugador.Text);
               F_Juego.Lbl_saldoAcumulado.Caption:=intTostr(saldoActual);

               Edit_importe.Clear;
               Edit_importe.SetFocus;

               //Grilla apuestas
              Lib_AuxJuego.limpiarGrid(Grid_ListaApuestas);
              Lib_AuxJuego.EncabezadosComunApuestas(Grid_ListaApuestas);
              F_Apostar.Grid_ListaApuestas.RowCount:=1;
              Lib_AuxJuego.Listado_GeneralApuestas(Grid_ListaApuestas, RegJuegoRuleta.NroJugada);
              F_Apostar.Grid_ListaApuestas.FixedRows:=1;
             //-----------------------------------------------------------------------------------
              Form_Juego.F_Juego.AutoSize_ImagenesTablero();
              Form_Juego.F_Juego.panel_tablero.Enabled:= true;
              F_Apostar.Close;
              MessageDlg('Apuesta realizada con �xito!',mtInformation, [mbOK], 0);
              end
              else
                //doble validacion, ya el el boton para abrir form de apuestas estara deshabilitado si el tiempo de apostar culmino
                MessageDlg('Ya no se permite apuestas. Finalizo el tiempo de apostar',mtInformation, [mbOK], 0);
            end
            else
              begin
                MessageDlg('Su saldo no es suficiente para llevar a cabo la apuesta!',mtWarning, [mbOK], 0);
                Edit_importe.Clear;
                Edit_importe.SetFocus;
              end;
          end
          else
            begin
              MessageDlg('La apuesta minima permitida es de $ ' +intTostr(ME_JUEGO.ApuestaMinima(ME_JUEGORULETA))+
              ', y la apuesta maxima permitida es de $ ' +intTostr(ME_JUEGO.ApuestaMaxima(ME_JUEGORULETA)),mtWarning, [mbOK], 0);
              Edit_importe.Clear;
              Edit_importe.SetFocus;
            end;
        end
        else
          MessageDlg('El jugador se encuentra bloqueado!',mtWarning, [mbOK], 0);
      end
      else
        MessageDlg('Complete el importe a apostar!',mtWarning, [mbOK], 0);
      end
    else
      MessageDlg('Por favor, seleccione un jugador de la grilla!',mtWarning, [mbOK], 0);
end;

{------------------------------------------------------------------------------}

procedure TF_Apostar.Edit_importeKeyPress(Sender: TObject; var Key: Char);
const
  CARAC_HABILITADOS = ['0'..'9', #0..#27];//solo numero y tecla borrar
begin
  if not (Key IN CARAC_HABILITADOS) then
    Key:=#0; //la tecla vale null si presiona caracteres no habilitados
end;

{------------------------------------------------------------------------------}

Procedure TF_Apostar.Listado_GeneralJugadores(RaizJugadores: Lib_Auxiliar.tPos);
var
RD:Type_JUGADOR.tRegDatos;

begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
    ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

    if (RD.Nick <> 'ADMINISTRADOR') then
    BEGIN
      if not (RD.Bloqueado) then
      begin
        if (RD.Estado) then
        begin
          Grid_ListaJugadores.RowCount:= Grid_ListaJugadores.RowCount + 1;
          {Agrego renglon}
          Grid_ListaJugadores.Cells[0, Grid_ListaJugadores.RowCount-1] := RD.Nick;
          Grid_ListaJugadores.Cells[1, Grid_ListaJugadores.RowCount-1] := RD.Nombre;
          Grid_ListaJugadores.Cells[2, Grid_ListaJugadores.RowCount-1] := RD.Apellido;

          if RD.TipoJugador then
          begin
            Grid_ListaJugadores.Cells[3, Grid_ListaJugadores.RowCount-1] :='Real';
          end
          else
            begin
              Grid_ListaJugadores.Cells[3, Grid_ListaJugadores.RowCount-1] :='Ficticio';
            end;

          if RD.Bloqueado then
          begin
            Grid_ListaJugadores.Cells[4, Grid_ListaJugadores.RowCount-1] :='SI';
          end
          else
            begin
              Grid_ListaJugadores.Cells[4, Grid_ListaJugadores.RowCount-1] :='NO';
            end;
          Grid_ListaJugadores.Cells[5, Grid_ListaJugadores.RowCount-1] := datetimetostr(RD.UltimaConexion);
        end;
      end;
    END;
    Listado_GeneralJugadores(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores));
    Listado_GeneralJugadores(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores));
  end;
end;



{------------------------------------------------------------------------------}
//Obtengo el saldo que tiene el jugador mientras apuestas para mostrarlo. Se vera reflejado en la cuenta del jugador cuando
//es estado sea igual a 2 "no va mas".
Function TF_Apostar.obtenerSaldoActualJugador(clave:tClave):tImporte;
begin
  ME_JUEGO.UltimaJugada(ME_JUEGORULETA,RegJuegoRuleta);

  SaldoAcumulado:= ME_CTACTE.SaldoAcumulado(ME_CUENTACORRIENTE,clave);
  SaldoApuestas_EnPartida:= ME_APUESTAS.SaldoApuestasPartida(ME_APUESTA,clave, RegJuegoRuleta.NroJugada);

  obtenerSaldoActualJugador:= SaldoAcumulado - SaldoApuestas_EnPartida;
end;

{------------------------------------------------------------------------------}

procedure TF_Apostar.ListandoJugadores();
begin
  Lib_AuxJuego.limpiarGrid(Grid_ListaJugadores);
  Lib_AuxJuego.EncabezadosComunJugadores(Grid_ListaJugadores);
  F_Apostar.Grid_ListaJugadores.RowCount:=1;
  F_Apostar.Listado_GeneralJugadores(ME_JUGADORES.Raiz(ME_JUGADOR));
  F_Apostar.Grid_ListaJugadores.FixedRows:=1;
end;


END.
