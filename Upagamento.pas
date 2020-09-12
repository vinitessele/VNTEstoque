unit Upagamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListBox, FMX.Edit;

type
  TFrmPagamento = class(TForm)
    Rectangle3: TRectangle;
    Label5: TLabel;
    RectConfirma: TRectangle;
    Label9: TLabel;
    Label1: TLabel;
    EditValor: TEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    EditParcelas: TEdit;
    EditVlrParcela: TEdit;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    procedure GerarConta;
    procedure AtualizaEstoque;
    procedure FinalizaVenda;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPagamento: TFrmPagamento;

implementation

{$R *.fmx}

uses UDM, uFormat, UMenu, UEntradaProdutos;

procedure TFrmPagamento.ComboBox1Exit(Sender: TObject);
begin
  if ComboBox1.Items[ComboBox1.ItemIndex] = 'A prazo' then
  begin
    Label3.Visible := True;
    Label4.Visible := True;
    EditParcelas.Visible := True;
    EditVlrParcela.Visible := True;
  end
  else
  begin
    Label3.Visible := false;
    Label4.Visible := false;
    EditParcelas.Visible := false;
    EditVlrParcela.Visible := false;
  end;
end;

procedure TFrmPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  case Key of
    vkReturn:
      ShowMessage('Enter');
    vkF10:
      begin
        AtualizaEstoque;
        GerarConta;
       FinalizaVenda;
      end;
  end;
end;

procedure TFrmPagamento.FormShow(Sender: TObject);
begin
  EditValor.Text := FormatFloat('#,##0.00',
    FrmEntradaProdutos.vl_total);

  dm.FDQTpagamento.Open();
  while not dm.FDQTpagamento.Eof do
  begin
    ComboBox1.Items.Add(dm.FDQTpagamentoDESCRICAO.AsString);
    dm.FDQTpagamento.Next;
  end;
end;

procedure TFrmPagamento.AtualizaEstoque;
var
  id_produto: integer;
  qte_produto: real;
begin
  dm.tabBusca.Open
    ('select id_produto, qte_produto  from entrada_item where id_entrada=' +
    dm.FDQEntradaID.AsString);

  while not dm.tabBusca.Eof do
  begin
    id_produto := dm.tabBusca.FieldByName('id_produto').AsInteger;
    qte_produto := dm.tabBusca.FieldByName('qte_produto').AsFloat;
    dm.FDQProdutos.Locate('id', id_produto, []);

    if dm.FDQProdutosControleEstoque.AsString = 'S' then
    begin
      dm.FDQProdutos.Edit;
      dm.FDQProdutosESTOQUE.AsFloat := dm.FDQProdutosESTOQUE.AsFloat +
        qte_produto;
      dm.FDQProdutos.Post;
      dm.FDConnection1.CommitRetaining;
    end;
    dm.tabBusca.Next;
  end;

end;

procedure TFrmPagamento.GerarConta;
var
  I: integer;
  data_parcela: tdate;
  qte_parcela: integer;
begin
  qte_parcela := 0;

  dm.FDQTpagamento.Locate('descricao',
    ComboBox1.Items[ComboBox1.ItemIndex], []);

  if (EditParcelas.Text <> '') then
    qte_parcela := StrToInt(EditParcelas.Text);

  if qte_parcela > 0 then
  begin
    data_parcela := date;
    for I := 1 to StrToInt(EditParcelas.Text) do
    begin
      data_parcela := data_parcela + 31;
      dm.FDQconta.Append;
      dm.FDQcontaID_PESSOA.AsInteger := dm.FDQVendaID_PESSOA.AsInteger;
      dm.FDQcontaDOCUMENTO.AsInteger := dm.FDQVendaID.AsInteger;
      dm.FDQcontaDT_RECORD.AsDateTime := date;
      dm.FDQcontaTP_CONTA.AsString := 'D';
      dm.fdqcontaid_caixa.AsInteger := dm.FDQVendaID_CAIXA.AsInteger;
      dm.FDQcontaDT_VENDA.AsDateTime := dm.FDQVendaDATA.AsDateTime;
      dm.FDQcontaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
      dm.FDQcontaNR_parcela.AsInteger := I;
      dm.fdqcontastatus_conta.AsString := 'A';
      if EditVlrParcela.Text <> '' then
        dm.FDQcontaVLR_PARCELA.AsFloat := StrToFloat(EditVlrParcela.Text);
      dm.fdqcontaDT_vencimentoParcela.AsDateTime := data_parcela;
      dm.FDQconta.Post;
    end;
  end
  else
  begin
    dm.FDQconta.Append;
    dm.FDQcontaID_PESSOA.AsInteger := dm.FDQVendaID_PESSOA.AsInteger;
    dm.FDQcontaDOCUMENTO.AsInteger := dm.FDQVendaID.AsInteger;
    dm.FDQcontaDT_RECORD.AsDateTime := date;
    dm.fdqcontaid_caixa.AsInteger := dm.FDQVendaID_CAIXA.AsInteger;
    dm.FDQcontaDT_VENDA.AsDateTime := dm.FDQVendaDATA.AsDateTime;
    dm.FDQcontaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
    dm.FDQcontaVLR_PAGAMENTO.AsFloat := StrToFloat(EditValor.Text);
    dm.FDQcontaTP_CONTA.AsString := 'D';
    dm.fdqcontastatus_conta.AsString := 'L';
    dm.FDQcontaDT_PAGAMENTO.AsDateTime := date;
    dm.FDQconta.Post;
  end;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFrmPagamento.FinalizaVenda;
begin
  dm.FDQTpagamento.Locate('descricao',
    ComboBox1.Items[ComboBox1.ItemIndex], []);
  dm.FDQEntrada.Edit;
  dm.FDQEntradaID_TIPOPAGAMENTO.AsInteger := dm.FDQTpagamentoID.AsInteger;
  dm.FDQEntrada.Post;
  dm.FDConnection1.CommitRetaining;
  MessageDlg('Venda finalizada com sucesso!', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbok], 0);

  FrmPagamento.Close;
end;
end.
