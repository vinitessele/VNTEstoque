unit UModelo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid;

type
  TFrmModelo = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    RectNovo: TRectangle;
    RectAlterar: TRectangle;
    RectCancelar: TRectangle;
    RectSalvar: TRectangle;
    RectExclir: TRectangle;
    RectpPesquisar: TRectangle;
    GroupBox1: TGroupBox;
    Grid1: TGrid;
    GroupBox2: TGroupBox;
    procedure RectSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmModelo: TFrmModelo;

implementation

{$R *.fmx}

procedure TFrmModelo.RectSalvarClick(Sender: TObject);
begin
  ShowMessage('Salvo com sucesso!');
end;

end.
