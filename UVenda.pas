unit UVenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Layouts, FMX.ListBox, FMX.ScrollBox, FMX.Memo;

type
  TFrmVenda = class(TForm)
    GroupBox1: TGroupBox;
    EditCodigo: TEdit;
    Label1: TLabel;
    EditQuantidade: TEdit;
    Label2: TLabel;
    EditVlUnitario: TEdit;
    Label3: TLabel;
    EditVltotal: TEdit;
    Label4: TLabel;
    RectItem: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Label5: TLabel;
    Label6: TLabel;
    EditCliente: TEdit;
    RectConfirma: TRectangle;
    RectCancela: TRectangle;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ListBoxCliente: TListBox;
    Label13: TLabel;
    ListBoxProduto: TListBox;
    ListBoxItens: TListBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EditClienteKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ListBoxClienteDblClick(Sender: TObject);
    procedure EditCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EditCodigoExit(Sender: TObject);
    procedure RectCancelaClick(Sender: TObject);
    procedure ListBoxProdutoDblClick(Sender: TObject);
    procedure EditQuantidadeEnter(Sender: TObject);
    procedure EditQuantidadeExit(Sender: TObject);
    procedure EditVlUnitarioTyping(Sender: TObject);
    procedure EditVltotalTyping(Sender: TObject);
    procedure RectConfirmaClick(Sender: TObject);
    procedure ListBoxItensClick(Sender: TObject);
  private
    procedure Insert_ItemVendas;
    procedure Insert_Venda;
    procedure LimpaCampos;
    procedure FinalizaVenda;
    procedure CancelVenda;
    procedure AtualizaVenda;
    { Private declarations }
  public
    { Public declarations }
    codItem: integer;
    idVenda: integer;
    vl_total: real;
    NomeCliente: string;
    id_cliente: integer;
  end;

var
  FrmVenda: TFrmVenda;

implementation

{$R *.fmx}

uses UDM, uFormat, UFinalizaVenda;

procedure TFrmVenda.EditCodigoExit(Sender: TObject);
begin
  dm.tabBusca.Open
    ('SELECT ID,descricao, valorvenda, estoque, estoqueminimo FROM produto ' +
    ' WHERE ' + ' codigobarra = ' + QuotedStr(EditCodigo.Text));

  if dm.tabBusca.RecordCount > 0 then
  begin
    Label11.Text := dm.tabBusca.FieldByName('descricao').AsString;
    codItem := StrToInt(dm.tabBusca.FieldByName('id').AsString);
    EditVlUnitario.Text := dm.tabBusca.FieldByName('valorvenda').AsString;
    EditQuantidade.SetFocus;
  end;

end;

procedure TFrmVenda.EditClienteKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  ListBoxCliente.Visible := True;
  ListBoxCliente.items.Clear;
  dm.tabBusca.Open('SELECT ID,Nome,Rua,CpfCnpj FROM pessoa ' + ' WHERE ' +
    ' Nome LIKE ' + QuotedStr('%' + EditCliente.Text + '%') +
    ' OR CpfCnpj LIKE ' + QuotedStr('%' + EditCliente.Text + '%'));
  ListBoxCliente.items.BeginUpdate;
  while not dm.tabBusca.Eof do
  begin
    ListBoxCliente.items.Add(dm.tabBusca.FieldByName('id').AsString + ' - ' +
      dm.tabBusca.FieldByName('Nome').AsString);
    dm.tabBusca.Next;
  end;
  ListBoxCliente.items.EndUpdate;
end;

procedure TFrmVenda.EditCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
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

procedure TFrmVenda.EditQuantidadeEnter(Sender: TObject);
begin
  ListBoxProduto.Visible := False;
  ListBoxCliente.Visible := False;
end;

procedure TFrmVenda.EditQuantidadeExit(Sender: TObject);
var
  vlr_totalitem: real;
begin
  if EditVlUnitario.Text <> EmptyStr then
  begin
    vlr_totalitem := StrToFloat(EditQuantidade.Text) *
      StrToFloat(EditVlUnitario.Text);
    EditVltotal.Text := FormatFloat('#0.00', vlr_totalitem);
  end
  else
  begin
    EditCodigo.SetFocus;
  end;
end;

procedure TFrmVenda.EditVltotalTyping(Sender: TObject);
begin
  Formatar(EditVltotal, Valor);
end;

procedure TFrmVenda.EditVlUnitarioTyping(Sender: TObject);
begin
  Formatar(EditVlUnitario, Valor);
end;

procedure TFrmVenda.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  case Key of
    vkF2:
      begin
        GroupBox1.Enabled := True;
        Insert_Venda;
      end;
    vkF3:
      begin
        CancelVenda;
      end;
    vkF8:
      begin
        Insert_ItemVendas;
        AtualizaVenda;
      end;
    vkF10:
      begin
        FinalizaVenda;
      end;
  end;
end;

procedure TFrmVenda.ListBoxClienteDblClick(Sender: TObject);
begin
  NomeCliente := ListBoxCliente.items[ListBoxCliente.ItemIndex];
  id_cliente := StrToInt(trim(Copy(NomeCliente, 0, Pos('-', NomeCliente) - 1)));
  EditCliente.Tag := id_cliente;
  EditCliente.Text := NomeCliente;
  ListBoxCliente.Visible := False;

  dm.FDQVenda.Edit;
  dm.FDQVendaID_PESSOA.AsInteger := id_cliente;
  dm.FDQVenda.Post;
  dm.FDConnection1.CommitRetaining;
  
  EditCodigo.SetFocus;
end;

procedure TFrmVenda.ListBoxItensClick(Sender: TObject);
var
  sql, nome, id: string;
begin
  nome := ListBoxItens.items[ListBoxItens.ItemIndex];
  id := trim(Copy(nome, 0, Pos('-', nome) - 1));
  sql := 'delete from venda_item where id =' + id;
  dm.FDConnection1.ExecSQL(sql);
  MessageDlg('Item excluido com sucesso!', TMsgDlgType.mtwarning,
    [TMsgDlgBtn.mbok], 0);
end;

procedure TFrmVenda.ListBoxProdutoDblClick(Sender: TObject);
var
  nome: string;
  id: string;
begin
  nome := ListBoxProduto.items[ListBoxProduto.ItemIndex];
  id := trim(Copy(nome, 0, Pos('-', nome) - 1));
  codItem := StrToInt(id);
  EditCodigo.Text := nome;
  Label11.Text := nome;
  ListBoxProduto.Visible := False;
  dm.FDQProdutos.Locate('id', StrToInt(id), []);
  EditVlUnitario.Text := dm.FDQProdutosVALORVENDA.AsString;
  EditQuantidade.SetFocus;
end;

procedure TFrmVenda.RectCancelaClick(Sender: TObject);
begin
  CancelVenda;
end;

procedure TFrmVenda.RectConfirmaClick(Sender: TObject);
begin
  Insert_ItemVendas;
  AtualizaVenda;
end;

procedure TFrmVenda.Insert_ItemVendas;
begin
  // dm.tabBusca.Open('SELECT id FROM venda order by id desc');
  EditCliente.Enabled := False;
  dm.FDQVendaItens.Append;
  // idVenda := StrToInt(dm.tabBusca.FieldByName('id').AsString);
  dm.FDQVendaItensID_VENDA.AsInteger := idVenda;
  dm.FDQVendaItensID_PRODUTO.AsInteger := codItem;
  dm.FDQVendaItensQTE_PRODUTO.AsFloat := StrToFloat(EditQuantidade.Text);
  dm.FDQVendaItensVLR_UNITARIO.AsFloat := StrToFloat(EditVlUnitario.Text);
  dm.FDQVendaItensVLR_TOTAL.AsFloat := StrToFloat(EditVltotal.Text);
  dm.FDQVendaItens.Post;
  dm.FDConnection1.CommitRetaining;
  LimpaCampos;
  EditCodigo.SetFocus;
end;

procedure TFrmVenda.Insert_Venda;
begin
  dm.tabBusca.Close;
  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura from caixa where status_caixa =''A'' ');

  if dm.tabBusca.RecordCount > 0 then
  begin
    ListBoxItens.Clear;
    EditCliente.Enabled := True;
    EditCliente.Text := EmptyStr;
    EditCliente.SetFocus;
    dm.FDQVenda.Append;
    dm.FDQVendaDATA.AsDateTime := date;
    dm.FDQVendaHORA.AsDateTime := Time;
    dm.FDQVendaID_CAIXA.AsInteger := dm.tabBusca.FieldByName('id').AsInteger;
    dm.FDQVenda.Post;
    dm.FDConnection1.CommitRetaining;
    idVenda := dm.FDQVendaID.AsInteger;
  end
  else
  begin
    MessageDlg('O caixa deve estar aberto para efetuar a venda',
      TMsgDlgType.mtwarning, [TMsgDlgBtn.mbok], 0);
    LimpaCampos;
    Exit;
  end;

end;

procedure TFrmVenda.LimpaCampos;
begin
  EditVltotal.Text := EmptyStr;
  EditCodigo.Text := EmptyStr;
  EditVlUnitario.Text := EmptyStr;
  Label11.Text := EmptyStr;
  Label10.Text := EmptyStr;
  Label11.Text := EmptyStr;
  ListBoxItens.Clear;
end;

procedure TFrmVenda.FinalizaVenda;
begin
  if not Assigned(FrmFinaliza) then
    Application.CreateForm(TFrmFinaliza, FrmFinaliza);
  FrmFinaliza.Show;
  LimpaCampos;
  GroupBox1.Enabled := False;
  EditCodigo.SetFocus;
end;

procedure TFrmVenda.CancelVenda;
var
  sql: string;
begin

  dm.tabBusca.Open('SELECT id, data, vlr_total FROM venda where id = ' +
    QuotedStr(IntToStr(idVenda)) + ' order by id desc');

  if dm.tabBusca.FieldByName('vlr_total').AsString = EmptyStr then
  begin
    sql := 'delete from venda_item where id_venda=' +
      QuotedStr(IntToStr(idVenda));
    dm.FDConnection1.ExecSQL(sql);
    sql := 'delete from venda where id=' + QuotedStr(IntToStr(idVenda));
    dm.FDConnection1.ExecSQL(sql);

    dm.FDQVendaItens.Cancel;
    dm.FDQVenda.Cancel;
    dm.FDConnection1.RollbackRetaining;
    GroupBox1.Enabled := False;
    LimpaCampos;
    MessageDlg('Venda Cancelada com sucesso!', TMsgDlgType.mtwarning,
      [TMsgDlgBtn.mbok], 0);
  end;

end;

procedure TFrmVenda.AtualizaVenda;
begin
  dm.tabBusca.Open('select vi.id, p.descricao,vi.vlr_total from venda_item vi '
    + ' inner join produto p on vi.id_produto=p.id' + ' where id_venda = ' +
    QuotedStr(IntToStr(idVenda)));
  ListBoxItens.items.BeginUpdate;
  ListBoxItens.Clear;
  while not dm.tabBusca.Eof do
  begin
    ListBoxItens.items.Add(dm.tabBusca.FieldByName('id').AsString + '-' +
      dm.tabBusca.FieldByName('descricao').AsString + '-' +
      dm.tabBusca.FieldByName('vlr_total').AsString);
    dm.tabBusca.Next;
  end;
  ListBoxItens.items.EndUpdate;
  dm.tabBusca.Open
    ('select sum(vlr_total)as valor from venda_item where id_venda= ' +
    QuotedStr(IntToStr(idVenda)));
  vl_total := dm.tabBusca.FieldByName('valor').AsFloat;
  Label10.Text := FormatFloat('R$ #,##0.00',
    dm.tabBusca.FieldByName('valor').AsFloat);
end;

end.
