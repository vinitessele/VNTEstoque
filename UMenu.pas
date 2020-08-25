unit UMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.MultiView, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmMenu = class(TForm)
    ToolBar1: TToolBar;
    MultiView1: TMultiView;
    RectangleMenu: TRectangle;
    btnMenu: TSpeedButton;
    RectCadastrosClifor: TRectangle;
    RectProdutos: TRectangle;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label2: TLabel;
    RectLanctoEntrada: TRectangle;
    Image3: TImage;
    Label3: TLabel;
    RectVenda: TRectangle;
    Label4: TLabel;
    Image4: TImage;
    RectLanctoDespesas: TRectangle;
    Label5: TLabel;
    Image5: TImage;
    RectSair: TRectangle;
    Label6: TLabel;
    Image6: TImage;
    RectConfiguracao: TRectangle;
    Image7: TImage;
    Label7: TLabel;
    StatusBar1: TStatusBar;
    procedure btnMenuClick(Sender: TObject);
    procedure RectSairClick(Sender: TObject);
    procedure RectCadastrosCliforClick(Sender: TObject);
    procedure RectConfiguracaoClick(Sender: TObject);
    procedure RectLanctoDespesasClick(Sender: TObject);
    procedure RectLanctoEntradaClick(Sender: TObject);
    procedure RectProdutosClick(Sender: TObject);
    procedure RectVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.fmx}

uses UDM, UUsuario, UPessoa, UProdutos;

procedure TFrmMenu.btnMenuClick(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TFrmMenu.RectCadastrosCliforClick(Sender: TObject);
begin
  MultiView1.HideMaster;
  if not Assigned(FrmPessoa) then
    Application.CreateForm(TFrmPessoa, FrmPessoa);
  FrmPessoa.Show;
end;

procedure TFrmMenu.RectConfiguracaoClick(Sender: TObject);
begin
  MultiView1.HideMaster;
  if not Assigned(FrmUsuario) then
    Application.CreateForm(TFrmUsuario, FrmUsuario);
  FrmUsuario.Show;
end;

procedure TFrmMenu.RectLanctoDespesasClick(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TFrmMenu.RectLanctoEntradaClick(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TFrmMenu.RectProdutosClick(Sender: TObject);
begin
  MultiView1.HideMaster;
  if not Assigned(FrmProdutos) then
    Application.CreateForm(TFrmProdutos, FrmProdutos);
  FrmProdutos.Show;

end;

procedure TFrmMenu.RectSairClick(Sender: TObject);
begin
  Application.Terminated := True;
end;

procedure TFrmMenu.RectVendaClick(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

end.
