unit UEntradaProdutos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.Objects,
  FMX.Controls.Presentation, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

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
    ListBoxProduto: TListBox;
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
    procedure EditFornecedorKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditDataTyping(Sender: TObject);
    procedure EditVlrNotaTyping(Sender: TObject);
    procedure EditCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ListBoxProdutoDblClick(Sender: TObject);
    procedure ListBoxFornecedorDblClick(Sender: TObject);
    procedure EditVlrUnitarioTyping(Sender: TObject);
    procedure EditVlrTotalTyping(Sender: TObject);
    procedure EditVlrTotalEnter(Sender: TObject);
    procedure RectNovoClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
  private
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
  dm.FDQEntradaID_PESSOA.AsInteger := EditFornecedor.Tag;
  dm.FDQEntradaDATA.AsDateTime := StrToDate(EditData.Text);
  dm.FDQEntradaVLR_TOTAL.AsFloat := StrToFloat(EditVlrTotal.Text);

  dm.FDQEntrada.Post;
  dm.FDConnection1.CommitRetaining;

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
begin
  inherited;
  ListBoxFornecedor.Visible := True;
  ListBoxFornecedor.items.Clear;
  dm.tabBusca.Open('SELECT ID,Nome,Rua,CpfCnpj FROM pessoa WHERE ' +
    ' TIPOUSUAIRO =''F'' and Nome LIKE ' + QuotedStr('%' + EditFornecedor.Text +
    '%') + ' OR CpfCnpj LIKE ' + QuotedStr('%' + EditFornecedor.Text + '%'));
  ListBoxFornecedor.items.BeginUpdate;
  while not dm.tabBusca.Eof do
  begin
    ListBoxFornecedor.items.Add(dm.tabBusca.FieldByName('id').AsString + ' - ' +
      dm.tabBusca.FieldByName('Nome').AsString);
    dm.tabBusca.Next;
  end;
  ListBoxFornecedor.items.EndUpdate;
end;

procedure TFrmEntradaProdutos.EditVlrNotaTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditVlrNota, Valor);
end;

procedure TFrmEntradaProdutos.EditVlrTotalEnter(Sender: TObject);
var
  qte, vlrUnit, vlrTotal: real;
begin
  inherited;
  qte := StrToFloat(EditQte.Text);
  vlrUnit := StrToFloat(EditVlrUnitario.Text);
  vlrTotal := qte * vlrUnit;
  EditVlrTotal.Text := FormatFloat('#,###0.00', vlrTotal);
end;

procedure TFrmEntradaProdutos.EditVlrTotalTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditVlrTotal, Valor);
end;

procedure TFrmEntradaProdutos.EditVlrUnitarioTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditVlrUnitario, Valor);
end;

procedure TFrmEntradaProdutos.ListBoxFornecedorDblClick(Sender: TObject);
var
  nome, id: string;
begin
  inherited;
  nome := ListBoxFornecedor.items[ListBoxFornecedor.ItemIndex];
  id := trim(Copy(nome, 0, Pos('-', nome) - 1));
  ListBoxFornecedor.Visible := false;
  EditFornecedor.Tag := StrToInt(id);
  EditFornecedor.Text := nome;

end;

procedure TFrmEntradaProdutos.ListBoxProdutoDblClick(Sender: TObject);
var
  nome, id: string;
begin
  inherited;
  nome := ListBoxProduto.items[ListBoxProduto.ItemIndex];
  id := trim(Copy(nome, 0, Pos('-', nome) - 1));
  ListBoxProduto.Visible := false;
  EditCodigo.Tag := StrToInt(id);
  EditCodigo.Text := nome;
end;

procedure TFrmEntradaProdutos.RectNovoClick(Sender: TObject);
begin
  inherited;
  EditFornecedor.SetFocus;
  dm.FDQEntrada.append;

end;

procedure TFrmEntradaProdutos.RectSalvarClick(Sender: TObject);
begin
  inherited;
  vl_total:= StrToFloat(EditVlrNota.Text);
  if not Assigned(FrmPagamento) then
    Application.CreateForm(TFrmPagamento, FrmPagamento);
  FrmPagamento.Show;

  GroupBox1.Enabled := false;
  EditFornecedor.SetFocus;
end;

end.
