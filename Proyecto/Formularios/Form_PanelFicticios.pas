unit Form_PanelFicticios;

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
  TF_PanelFicticios = class(TForm)
    Panel_Listado: TPanel;
    Panel_grid: TPanel;
    BitBtn1: TBitBtn;
    Panel_CrearFicticios: TPanel;
    Lbl_ActivarFicticios: TLabel;
    Btn_ActivarFicticios: TButton;
    Cbox_CantFicticios: TComboBox;
    Panel_FicticiosActivos: TPanel;
    Label2: TLabel;
    Grid_FicticiosActivos: TStringGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Grid_ListadoFicticios: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Grid_ListadoFicticiosDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    Procedure Listado_GeneralFicticios(RaizJugadores: Lib_Auxiliar.tPos);
    Procedure Listado_FicticiosActivos(RaizJugadores: Lib_Auxiliar.tPos);
    procedure Cbox_CantFicticiosSelect(Sender: TObject);
    procedure mostrarFicticiosEnGrid();
    procedure mostrarFicticiosActivosEnGrid();
    procedure Btn_ActivarFicticiosClick(Sender: TObject);
    procedure Grid_FicticiosActivosDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PanelFicticios: TF_PanelFicticios;
  contador:tCantidad;

implementation

uses
  Form_Juego, Form_Login, Form_Apostar;

{$R *.dfm}

{--------------------------------------------------------------------------------}

procedure TF_PanelFicticios.BitBtn1Click(Sender: TObject);
begin
  Form_Juego.F_Juego.Panel_JuegoGral.Enabled:=true;
  F_PanelFicticios.Close;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelFicticios.FormClose(Sender: TObject; var Action: TCloseAction);
var
  cantFictActivos: tCantidad;
begin
  cantFictActivos:= 0;
  F_Juego.Enabled:=true;
  totalFicticios:= ME_JUGADORES.UltFicticio(ME_JUGADOR);
  F_Juego.Lbl_cantFicticios.Caption:= intTostr(totalFicticios);

  Lib_AuxJuego.Cant_FicticiosActivos(ME_JUGADORES.Raiz(ME_JUGADOR), cantFictActivos);
  F_Juego.Lbl_CantFictActivados.Caption:= intTostr(cantFictActivos);
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelFicticios.FormCreate(Sender: TObject);
begin
  self.Position := poScreenCenter;
  Lbl_ActivarFicticios.Caption:= 'Seleccione ' + #10#13 + 'la cantidad ' + #10#13 + 'de ficticios ' + #10#13 + 'a activar: ';
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelFicticios.FormShow(Sender: TObject);
var
 i:integer;
begin
  F_Juego.Enabled:=false;
  mostrarFicticiosEnGrid();

  Panel_CrearFicticios.Show;
  Panel_FicticiosActivos.Hide;
end;

{--------------------------------------------------------------------------------}

procedure TF_PanelFicticios.Grid_FicticiosActivosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid) do
  begin
    if (ARow = 0)
    then
      begin
        Canvas.Brush.Color := clBtnFace;
        Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(Grid_FicticiosActivos.Cells[ACol,ARow]) + 1) div 2, Rect.Top + 2, Grid_FicticiosActivos.Cells[ACol,ARow]);
      end
    else
    begin
      Canvas.Font.Color := clblack;
      // Pinto el fondo segun elestado de la Atencion
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

procedure TF_PanelFicticios.Grid_ListadoFicticiosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid) do
  begin
    if (ARow = 0)
    then
      begin
        Canvas.Brush.Color := clBtnFace;
        Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(Grid_ListadoFicticios.Cells[ACol,ARow]) + 1) div 2, Rect.Top + 2, Grid_ListadoFicticios.Cells[ACol,ARow]);
      end
    else
    begin
      Canvas.Font.Color := clblack;
      // Pinto el fondo segun elestado de la Atencion
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

procedure TF_PanelFicticios.Btn_ActivarFicticiosClick(Sender: TObject);
var
  cantFict_Activar:tCantidad;
begin
  if Cbox_CantFicticios.ItemIndex <> Lib_Auxiliar.PosNula then
  begin
    cantFict_Activar:= strToint(Cbox_CantFicticios.Text);
    Lib_AuxJuego.Activar_JugadoresFicticios(Form_Login.ME_JUGADOR, cantFict_Activar);

    Panel_FicticiosActivos.Show;
    mostrarFicticiosActivosEnGrid();

    Cbox_CantFicticios.ItemIndex:= Lib_Auxiliar.PosNula;
    Panel_CrearFicticios.Hide;
    Form_Juego.F_Juego.Spbtn_activarFicticios.Enabled:=false;
  end
  else
    MessageDlg('Seleccione cantidad de jugadores a activar!',mtWarning , [mbOK], 0)
end;

{------------------------------------------------------------------------------}

procedure TF_PanelFicticios.Cbox_CantFicticiosSelect(Sender: TObject);
var
  op, cantCrear:integer;
  numFicticio:tCantidad;
  msjMostrar:string;
  cantFict_Activar, cantFict_Activos:tCantidad;
begin
  op:= strToint(Cbox_CantFicticios.Text);
  numFicticio:= ME_JUGADORES.UltFicticio(ME_JUGADOR);

  if (op > numFicticio)then
  begin
    cantCrear:= op - numFicticio;
    if (numFicticio <> 0) then
      msjMostrar:= 'Solo hay ' + intTostr(numFicticio) + ' jugadores ficticios creados.' + #13 + #13 +'�Quiere crear ' +intTostr(cantCrear)+ ' ficticios mas?'
    else
      msjMostrar:= 'No hay jugadores ficticios creados �Quiere crearlos?';
    if Lib_AuxJuego.Mensaje_Confirmacion(msjMostrar) then
    begin
      Lib_AuxJuego.Insertar_JugadoresFicticios(ME_JUGADOR, cantCrear);
      mostrarFicticiosEnGrid();
      cantFict_Activar:= strToint(Cbox_CantFicticios.Text);
      if Lib_AuxJuego.Mensaje_Confirmacion('�CONFIRMA QUE QUIERE ACTIVAR '+intTostr(cantFict_Activar)+' JUGADORES FICTICIOS?') then
      begin
        Lib_AuxJuego.Activar_JugadoresFicticios(Form_Login.ME_JUGADOR, cantFict_Activar);
        Panel_FicticiosActivos.Show;
        mostrarFicticiosActivosEnGrid();
        Cbox_CantFicticios.ItemIndex:= Lib_Auxiliar.PosNula;
        Panel_CrearFicticios.Hide;
        Form_Juego.F_Juego.Spbtn_activarFicticios.Enabled:=false;
      end;
    end;
  end;
end;


{<------------------------------------------------------------------------------}

Procedure TF_PanelFicticios.Listado_GeneralFicticios(RaizJugadores: Lib_Auxiliar.tPos);
var
RD:Type_JUGADOR.tRegDatos;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin

          ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

          if not (RD.TipoJugador)then ///  false: entonces es un ficticio
          begin
            Grid_ListadoFicticios.RowCount:= Grid_ListadoFicticios.RowCount + 1;
            {Agrego renglon}
            Grid_ListadoFicticios.Cells[0, Grid_ListadoFicticios.RowCount-1] := RD.Nick;
            Grid_ListadoFicticios.Cells[1, Grid_ListadoFicticios.RowCount-1] := RD.Nombre;
            Grid_ListadoFicticios.Cells[2, Grid_ListadoFicticios.RowCount-1] := RD.Apellido;

            if RD.TipoJugador then
            begin
              Grid_ListadoFicticios.Cells[3, Grid_ListadoFicticios.RowCount-1] :='Real';
            end
            else
              begin
                Grid_ListadoFicticios.Cells[3, Grid_ListadoFicticios.RowCount-1] :='Ficticio';
              end;

            if RD.Estado then
            begin
              Grid_ListadoFicticios.Cells[4, Grid_ListadoFicticios.RowCount-1] :='ACTIVO';
            end
            else
              begin
                Grid_ListadoFicticios.Cells[4, Grid_ListadoFicticios.RowCount-1] :='NO ACTIVO';
              end;

            saldoActual:= F_Apostar.obtenerSaldoActualJugador(RD.Nick);

            Grid_ListadoFicticios.Cells[5, Grid_ListadoFicticios.RowCount-1] := intTostr(saldoActual);
            Grid_ListadoFicticios.Cells[6, Grid_ListadoFicticios.RowCount-1] := datetimetostr(RD.Alta);

          end;
          Listado_GeneralFicticios(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores));
          Listado_GeneralFicticios(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores));
  end;
end;

{------------------------------------------------------------------------------}

Procedure TF_PanelFicticios.Listado_FicticiosActivos(RaizJugadores: Lib_Auxiliar.tPos);

var
RD:Type_JUGADOR.tRegDatos;
begin
  if (RaizJugadores<>Lib_Auxiliar.PosNula) then
  begin
          ME_JUGADORES.CapturarInfoME_Jugadores(ME_JUGADOR,RD,RaizJugadores);

          if not (RD.TipoJugador)then ///  false: entonces es un ficticio
          begin
            if (RD.Estado) then ///true: entonces esta activo
            begin
                Grid_FicticiosActivos.RowCount:= Grid_FicticiosActivos.RowCount + 1;
                {Agrego renglon}
                Grid_FicticiosActivos.Cells[0, Grid_FicticiosActivos.RowCount-1] := RD.Nick;
                Grid_FicticiosActivos.Cells[1, Grid_FicticiosActivos.RowCount-1] := RD.Nombre;
                Grid_FicticiosActivos.Cells[2, Grid_FicticiosActivos.RowCount-1] := RD.Apellido;

                if RD.TipoJugador then
                begin
                  Grid_FicticiosActivos.Cells[3, Grid_FicticiosActivos.RowCount-1] :='Real';
                end
                else
                  begin
                    Grid_FicticiosActivos.Cells[3, Grid_FicticiosActivos.RowCount-1] :='Ficticio';
                  end;

                 if RD.Estado then
                 begin
                    Grid_FicticiosActivos.Cells[4, Grid_FicticiosActivos.RowCount-1] :='ACTIVO';
                 end
                 else
                  begin
                    Grid_FicticiosActivos.Cells[4, Grid_FicticiosActivos.RowCount-1] :='NO ACTIVO';
                  end;

                saldoActual:= F_Apostar.obtenerSaldoActualJugador(RD.Nick);

                Grid_FicticiosActivos.Cells[5, Grid_FicticiosActivos.RowCount-1] := intTostr(saldoActual);
                Grid_FicticiosActivos.Cells[6, Grid_FicticiosActivos.RowCount-1] := datetimetostr(RD.Alta);
            end;
          end;
          Listado_FicticiosActivos(ME_JUGADORES.ProximoIzq(ME_JUGADOR,RaizJugadores));
          Listado_FicticiosActivos(ME_JUGADORES.ProximoDer(ME_JUGADOR,RaizJugadores));
  end;
end;

{------------------------------------------------------------------------------}

procedure TF_PanelFicticios.mostrarFicticiosActivosEnGrid();

begin
  Lib_AuxJuego.limpiarGrid(Grid_FicticiosActivos);
  Lib_AuxJuego.EncabezadosComunFicticios(Grid_FicticiosActivos);

  Grid_FicticiosActivos.RowCount:=1;
  Listado_FicticiosActivos(ME_JUGADORES.Raiz(ME_JUGADOR));
  Grid_FicticiosActivos.FixedRows:=1;
end;

{------------------------------------------------------------------------------}

procedure TF_PanelFicticios.mostrarFicticiosEnGrid();
var
  numFicticio: Lib_Auxiliar.tCantidad;
begin
  Lib_AuxJuego.limpiarGrid(Grid_ListadoFicticios);
  Lib_AuxJuego.EncabezadosComunFicticios(Grid_ListadoFicticios);

  numFicticio:= ME_JUGADORES.UltFicticio(ME_JUGADOR);
  if (numFicticio>0) then
  begin
    Grid_ListadoFicticios.RowCount:=1;
    Listado_GeneralFicticios(ME_JUGADORES.Raiz(ME_JUGADOR));
    Grid_ListadoFicticios.FixedRows:=1;
  end;
end;


END.
