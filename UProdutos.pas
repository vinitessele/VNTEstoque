unit UProdutos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Objects,
  FMX.Controls.Presentation, FMX.Memo, FMX.Edit, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Controls,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, FMX.Layouts,
  FMX.Bind.Navigator, Data.Bind.Grid, Data.Bind.DBScope, FMX.ListBox;

type
  TFrmProdutos = class(TFrmModelo)
    EditId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditDescricao: TEdit;
    Label3: TLabel;
    EditCodBarras: TEdit;
    Label4: TLabel;
    EditEstoque: TEdit;
    Label5: TLabel;
    EditEstoqueM: TEdit;
    Label9: TLabel;
    EditVlrCompra: TEdit;
    Label6: TLabel;
    EditPercentLucro: TEdit;
    Label7: TLabel;
    EditUnMedida: TEdit;
    Label10: TLabel;
    EditVlrVenda: TEdit;
    Memo1: TMemo;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    procedure RectNovoClick(Sender: TObject);
    procedure RectAlterarClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure RectCancelarClick(Sender: TObject);
    procedure RectExclirClick(Sender: TObject);
    procedure EditVlrCompraTyping(Sender: TObject);
    procedure EditPercentLucroTyping(Sender: TObject);
    procedure EditVlrVendaTyping(Sender: TObject);
    procedure EditVlrVendaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.fmx}

uses UDM, Loading, uFormat;

procedure TFrmProdutos.EditPercentLucroTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditPercentLucro, TFormato.Valor);
end;

procedure TFrmProdutos.EditVlrCompraTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditVlrCompra, TFormato.Valor);
end;

procedure TFrmProdutos.EditVlrVendaEnter(Sender: TObject);
var
  vlrCompra, percent, vlr: real;
begin
  inherited;
  if (EditVlrCompra.Text <> '') and (EditPercentLucro.Text <> '') then
  begin
    vlrCompra := StrToFloat(EditVlrCompra.Text);
    percent := StrToFloat(EditPercentLucro.Text);
    vlr := vlrCompra * (percent / 100);

    EditVlrVenda.Text := FormatFloat('#,##0.00',
      vlr + StrToFloat(EditVlrCompra.Text));;

  end;
end;

procedure TFrmProdutos.EditVlrVendaTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditVlrVenda, TFormato.Valor);
end;

procedure TFrmProdutos.RectAlterarClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := True;
  dm.FDQProdutos.Edit;
  EditDescricao.SetFocus;
end;

procedure TFrmProdutos.RectCancelarClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := False;
  dm.FDQProdutos.Cancel;
  dm.FDConnection1.RollbackRetaining;
end;

procedure TFrmProdutos.RectExclirClick(Sender: TObject);
begin

  GroupBox2.Enabled := False;
  dm.FDQProdutos.Delete;
  dm.FDConnection1.CommitRetaining;
  inherited;
end;

procedure TFrmProdutos.RectNovoClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := True;
  dm.FDQProdutos.Append;
  EditDescricao.SetFocus;
end;

procedure TFrmProdutos.RectSalvarClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := False;
  dm.FDQProdutosDESCRICAO.AsString := EditDescricao.Text;
  dm.FDQProdutosDATACADASTRO.AsDateTime := date;
  dm.FDQProdutosCODIGOBARRA.AsString := EditCodBarras.Text;
  dm.FDQProdutosESTOQUE.AsString := EditEstoque.Text;
  dm.FDQProdutosESTOQUEMINIMO.AsString := EditEstoqueM.Text;
  dm.FDQProdutosVALORCOMPRA.AsString := EditVlrCompra.Text;
  dm.FDQProdutosVALORVENDA.AsString := EditVlrVenda.Text;
  dm.FDQProdutosPORCENTAGEMLUCRO.AsString := EditPercentLucro.Text;
  dm.FDQProdutosOBSERVACOES.AsString := Memo1.Text;
  if CheckBox1.IsChecked then
    dm.FDQProdutosCONTROLEESTOQUE.AsString := 'S'
  else
    dm.FDQProdutosCONTROLEESTOQUE.AsString := 'N';
  dm.FDQProdutos.Post;
  dm.FDConnection1.CommitRetaining;

end;

end.
