unit UModelo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.Edit, FMX.Layouts, FMX.ListBox;

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
    GroupBox2: TGroupBox;
    EditLocalizar: TEdit;
    ListBox1: TListBox;
    procedure RectSalvarClick(Sender: TObject);
    procedure RectExclirClick(Sender: TObject);
    procedure RectpPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmModelo: TFrmModelo;

implementation

{$R *.fmx}

procedure TFrmModelo.FormShow(Sender: TObject);
begin
  EditLocalizar.Visible := false;
end;

procedure TFrmModelo.RectExclirClick(Sender: TObject);
begin
  ShowMessage('Excluido com sucesso!');
end;

procedure TFrmModelo.RectpPesquisarClick(Sender: TObject);
begin
  if EditLocalizar.Visible then
    EditLocalizar.Visible := false
  else
    EditLocalizar.Visible := True;
end;

procedure TFrmModelo.RectSalvarClick(Sender: TObject);
begin
  ShowMessage('Salvo com sucesso!');
end;

end.
