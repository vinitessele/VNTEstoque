unit UEntradaProdutos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, DB,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.Objects,
  FMX.Controls.Presentation, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.Grid.Style, FMX.Bind.Grid, Data.Bind.Grid,
  FMX.ScrollBox, FMX.Grid;

type
  TFrmEntradaProdutos = class(TFrmModelo)
    Label1: TLabel;
    EditID: TEdit;
    Label2: TLabel;
    EditFornecedor: TEdit;
    Label3: TLabel;
    EditData: TEdit;
    Label4: TLabel;
    EditVlrNota: TEdit;
    GroupBox1: TGroupBox;
    ListBoxFornecedor: TListBox;
    Label5: TLabel;
    EditCodigo: TEdit;
    EditQte: TEdit;
    Label6: TLabel;
    EditVlrUnitario: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditVlrTotal: TEdit;
    RectConfirma: TRectangle;
    Label9: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    Grid1: TGrid;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    ListBoxProduto: TListBox;
    Label10: TLabel;
    EditNota: TEdit;
    procedure EditFornecedorKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditDataTyping(Sender: TObject);
    procedure EditCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ListBoxProdutoDblClick(Sender: TObject);
    procedure ListBoxFornecedorDblClick(Sender: TObject);
    procedure RectNovoClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditVlrNotaEnter(Sender: TObject);
    procedure RectConfirmaClick(Sender: TObject);
    procedure EditVlrTotalEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EditLocalizarKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    procedure AdicionaProdutos;
    procedure LimpaCampos;
    { Private declarations }
  public
    { Public declarations }
    codItem: integer;
    IdVenda: integer;
    vl_total: real;
  end;

var
  FrmEntradaProdutos: TFrmEntradaProdutos;

implementation

{$R *.fmx}

uses UDM, UMenu, uFormat, Upagamento;

procedure TFrmEntradaProdutos.EditCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;

  ListBoxProduto.Visible := True;
  ListBoxProduto.Clear;
  dm.tabBusca.Open('SELECT ID,descricao FROM produto ' + ' WHERE ' +
    ' descricao LIKE ' + QuotedStr('%' + EditCodigo.Text + '%') +
    ' OR codigobarra LIKE ' + QuotedStr('%' + EditCodigo.Text + '%'));
  ListBoxProduto.items.BeginUpdate;
  while not dm.tabBusca.Eof do
  begin
    ListBoxProduto.items.Add(dm.tabBusca.FieldByName('id').AsString + ' - ' +
      dm.tabBusca.FieldByName('descricao').AsString);
    dm.tabBusca.Next;
  end;
  ListBoxProduto.items.EndUpdate;
end;

procedure TFrmEntradaProdutos.EditDataTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditData, Dt);
end;

procedure TFrmEntradaProdutos.EditFornecedorKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  sql: string;
begin
  inherited;
  ListBoxFornecedor.Visible := True;
  ListBoxFornecedor.items.Clear;

  sql := 'SELECT ID,Nome,Rua,CpfCnpj FROM pessoa WHERE TIPOUSUAIRO =''F''' +
    ' AND Nome LIKE ' + QuotedStr('%' + EditFornecedor.Text + '%') +
    ' OR CpfCnpj LIKE ' + QuotedStr('%' + EditFornecedor.Text + '%');

  dm.tabBusca.Open(sql);
  ListBoxFornecedor.items.BeginUpdate;
  while not dm.tabBusca.Eof do
  begin
    ListBoxFornecedor.items.Add(dm.tabBusca.FieldByName('id').AsString + ' - ' +
      dm.tabBusca.FieldByName('Nome').AsString);
    dm.tabBusca.Next;
  end;
  ListBoxFornecedor.items.EndUpdate;
end;

procedure TFrmEntradaProdutos.EditLocalizarKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  dm.tabBusca.Open('Select id, nr_nota from entrada ' + 'where nr_nota like ' +
    QuotedStr('%' + EditLocalizar.Text + '%'));
  ListBox1.Visible := True;
  ListBox1.items.Clear;
  while not dm.tabBusca.Eof do
  begin
    ListBox1.items.Add(dm.tabBusca.FieldByName('id').AsString + ' - ' +
      dm.tabBusca.FieldByName('nr_nota').AsString);
    dm.tabBusca.Next;
  end;
  ListBox1.items.EndUpdate;

end;

procedure TFrmEntradaProdutos.EditVlrNotaEnter(Sender: TObject);
begin
  inherited;
  ListBoxFornecedor.Visible := False;
end;

procedure TFrmEntradaProdutos.EditVlrTotalEnter(Sender: TObject);
var
  qte, vlrUnit, vlrTotal: real;
begin
  inherited;
  qte := StrToFloat(EditQte.Text);
  vlrUnit := StrToFloat(EditVlrUnitario.Text);
  vlrTotal := qte * vlrUnit;
  EditVlrTotal.Text := FormatFloat('#0.00',vlrTotal);
end;

procedure TFrmEntradaProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  case Key of
    vkF8:
      begin
        ListBoxProduto.Visible := False;
        ListBoxFornecedor.Visible := False;
        AdicionaProdutos;
        LimpaCampos;
      end;
  end;
end;

procedure TFrmEntradaProdutos.FormShow(Sender: TObject);
begin
  inherited;
  EditData.Text := DateToStr(date);
end;

procedure TFrmEntradaProdutos.ListBoxFornecedorDblClick(Sender: TObject);
var
  nome, id: string;
begin
  inherited;
  nome := ListBoxFornecedor.items[ListBoxFornecedor.ItemIndex];
  id := trim(Copy(nome, 0, Pos('-', nome) - 1));
  ListBoxFornecedor.Visible := False;
  EditFornecedor.Tag := StrToInt(id);
  EditFornecedor.Text := nome;
  ListBoxFornecedor.Visible := False;
end;

procedure TFrmEntradaProdutos.ListBoxProdutoDblClick(Sender: TObject);
var
  nome, id: string;
begin
  inherited;
  nome := ListBoxProduto.items[ListBoxProduto.ItemIndex];
  id := trim(Copy(nome, 0, Pos('-', nome) - 1));
  ListBoxProduto.Visible := False;
  EditCodigo.Tag := StrToInt(id);
  EditCodigo.Text := nome;
  ListBoxProduto.Visible := False;
end;

procedure TFrmEntradaProdutos.RectConfirmaClick(Sender: TObject);
begin
  inherited;
  ListBoxProduto.Visible := False;
  ListBoxFornecedor.Visible := False;
  AdicionaProdutos;
  LimpaCampos;
end;

procedure TFrmEntradaProdutos.AdicionaProdutos;
begin
  if (dm.FDQEntrada.State in [dsInsert, dsEdit]) then
  begin
    dm.FDQEntradaID_PESSOA.AsInteger := EditFornecedor.Tag;
    dm.FDQEntradaDATA.AsDateTime := StrToDate(EditData.Text);
    dm.FDQEntradaVLR_TOTAL.AsFloat := StrToFloat(EditVlrNota.Text);
    if EditNota.Text <> EmptyStr then
      dm.FDQEntradaNR_NOTA.AsInteger := StrToInt(EditNota.Text);
    dm.FDQEntrada.Post;
    dm.FDConnection1.CommitRetaining;
  end;

  dm.FDQEntradaItem.Append;
  dm.FDQEntradaItemID_ENTRADA.AsInteger := dm.FDQEntradaID.AsInteger;
  dm.FDQEntradaItemID_PRODUTO.AsInteger := EditCodigo.Tag;
  dm.FDQEntradaItemQTE_PRODUTO.AsFloat := StrToFloat(EditQte.Text);
  dm.FDQEntradaItemVLR_UNITARIO.AsFloat := StrToFloat(EditVlrUnitario.Text);
  dm.FDQEntradaItemVLR_TOTAL.AsFloat := StrToFloat(EditVlrTotal.Text);
  dm.FDQEntradaItem.Post;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFrmEntradaProdutos.LimpaCampos;
begin
  EditCodigo.Text := EmptyStr;
  EditQte.Text := EmptyStr;
  EditVlrUnitario.Text := EmptyStr;
  EditVlrTotal.Text := EmptyStr;
  EditCodigo.SetFocus;
end;

procedure TFrmEntradaProdutos.RectNovoClick(Sender: TObject);
begin
  inherited;

  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura from caixa where status_caixa =''A'' ');

  if dm.tabBusca.RecordCount > 0 then
  begin
    GroupBox2.Enabled := True;
    EditFornecedor.SetFocus;
    dm.FDQEntrada.Append;
    dm.FDQEntradaID_CAIXA.AsInteger := dm.tabBusca.FieldByName('id').AsInteger;
  end
  else
  begin
    MessageDlg('O caixa deve estar aberto para efetuar a venda',
      TMsgDlgType.mtwarning, [TMsgDlgBtn.mbok], 0);
    Exit;
  end;
end;

procedure TFrmEntradaProdutos.RectSalvarClick(Sender: TObject);
begin

  vl_total := StrToFloat(EditVlrNota.Text);
  if not Assigned(FrmPagamento) then
    Application.CreateForm(TFrmPagamento, FrmPagamento);
  FrmPagamento.Show;

  GroupBox2.Enabled := False;
  EditFornecedor.SetFocus;
  inherited;
end;

end.
