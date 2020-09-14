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
    procedure EditLocalizarKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ListBox1DblClick(Sender: TObject);
  private
    procedure LimpaCampos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.fmx}

uses UDM, Loading, uFormat;

procedure TFrmProdutos.EditLocalizarKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  ListBox1.Visible := True;
  ListBox1.items.Clear;
  dm.tabBusca.Open('SELECT ID,descricao FROM produto ' + ' WHERE ' +
    ' descricao LIKE ' + QuotedStr('%' + EditLocalizar.Text + '%') +
    ' OR codigobarra LIKE ' + QuotedStr('%' + EditLocalizar.Text + '%'));

  while not dm.tabBusca.Eof do
  begin
    ListBox1.items.Add(dm.tabBusca.FieldByName('descricao').AsString);
    dm.tabBusca.Next;
  end;

end;

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

    EditVlrVenda.Text := FormatFloat('#0.00',
      vlr + StrToFloat(EditVlrCompra.Text));;

  end;
end;

procedure TFrmProdutos.EditVlrVendaTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditVlrVenda, TFormato.Valor);
end;

procedure TFrmProdutos.ListBox1DblClick(Sender: TObject);
var
  nome, sql: string;
begin
  inherited;
  nome := ListBox1.items[ListBox1.ItemIndex];

  sql := 'select id, descricao, codigobarra, estoque, ' +
    ' estoqueminimo, valorcompra, valorvenda, ' +
    ' porcentagemlucro, unidademedia, observacoes,controleestoque' +
    ' from produto' + //
    ' where descricao =' + QuotedStr(nome);

  dm.tabBusca.Open(sql);

  EditId.Text := dm.tabBusca.FieldByName('id').AsString;
  EditDescricao.Text := dm.tabBusca.FieldByName('descricao').AsString;
  EditCodBarras.Text := dm.tabBusca.FieldByName('codigobarra').AsString;
  EditEstoque.Text := dm.tabBusca.FieldByName('estoque').AsString;
  EditEstoqueM.Text := dm.tabBusca.FieldByName('estoqueminimo').AsString;
  EditVlrCompra.Text := dm.tabBusca.FieldByName('valorcompra').AsString;
  EditVlrVenda.Text := dm.tabBusca.FieldByName('valorvenda').AsString;
  EditPercentLucro.Text := dm.tabBusca.FieldByName('porcentagemlucro').AsString;
  EditUnMedida.Text := dm.tabBusca.FieldByName('unidademedia').AsString;
  Memo1.Text := dm.tabBusca.FieldByName('observacoes').AsString;

  if dm.tabBusca.FieldByName('controleestoque').AsString = 'S' then
    CheckBox1.IsChecked := True
  else
    CheckBox1.IsChecked := false;

  ListBox1.Visible := false;
end;

procedure TFrmProdutos.LimpaCampos;
begin
  EditId.Text := EmptyStr;
  EditDescricao.Text := EmptyStr;
  EditCodBarras.Text := EmptyStr;
  EditEstoque.Text := EmptyStr;
  EditEstoqueM.Text := EmptyStr;
  EditVlrCompra.Text := EmptyStr;
  EditVlrVenda.Text := EmptyStr;
  EditPercentLucro.Text := EmptyStr;
  EditUnMedida.Text := EmptyStr;
  Memo1.Text := EmptyStr;
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
  GroupBox2.Enabled := false;
  dm.FDQProdutos.Cancel;
  dm.FDConnection1.RollbackRetaining;
  LimpaCampos;
end;

procedure TFrmProdutos.RectExclirClick(Sender: TObject);
begin
  GroupBox2.Enabled := false;
  dm.FDQProdutos.Delete;
  dm.FDConnection1.CommitRetaining;
  inherited;
end;

procedure TFrmProdutos.RectNovoClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := True;
  LimpaCampos;

  dm.FDQProdutos.Append;
  EditDescricao.SetFocus;
end;

procedure TFrmProdutos.RectSalvarClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := false;
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
