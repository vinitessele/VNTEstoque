unit UFinalizaVenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListBox, FMX.Edit;

type
  TFrmFinaliza = class(TForm)
    Rectangle3: TRectangle;
    Label5: TLabel;
    ComboBox1: TComboBox;
    RectConfirma: TRectangle;
    Label9: TLabel;
    Label1: TLabel;
    EditValor: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditParcelas: TEdit;
    Label4: TLabel;
    EditVlrParcela: TEdit;
    Label6: TLabel;
    EditValorEntrada: TEdit;
    EditDinheiro: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditTroco: TEdit;
    procedure FormShow(Sender: TObject);
    procedure RectConfirmaClick(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EditValorEntradaTyping(Sender: TObject);
    procedure EditVlrParcelaEnter(Sender: TObject);
    procedure EditTrocoEnter(Sender: TObject);
    procedure EditDinheiroTyping(Sender: TObject);
    procedure EditValorTyping(Sender: TObject);
  private
    procedure FinalizaVenda;
    procedure GerarConta;
    procedure AtualizaEstoque;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFinaliza: TFrmFinaliza;

implementation

{$R *.fmx}

uses UDM, UMenu, UVenda, uFormat;

procedure TFrmFinaliza.ComboBox1Exit(Sender: TObject);
begin

  if ComboBox1.Items[ComboBox1.ItemIndex] = 'A prazo' then
  begin
    Label3.Visible := True;
    Label4.Visible := True;
    Label6.Visible := True;
    EditParcelas.Visible := True;
    EditVlrParcela.Visible := True;
    EditValorEntrada.Visible := True;
    EditDinheiro.Visible := false;
    EditTroco.Visible := false;
    Label7.Visible := false;
    Label8.Visible := false;
  end
  else if ComboBox1.Items[ComboBox1.ItemIndex] = 'Cartão' then
  begin
    Label3.Visible := True;
    Label4.Visible := True;
    Label6.Visible := True;
    EditParcelas.Visible := True;
    EditVlrParcela.Visible := True;
    EditValorEntrada.Visible := True;
    EditDinheiro.Visible := false;
    EditTroco.Visible := false;
    Label7.Visible := false;
    Label8.Visible := false;
  end
  else
  begin
    Label3.Visible := false;
    Label4.Visible := false;
    Label6.Visible := false;
    EditParcelas.Visible := false;
    EditVlrParcela.Visible := false;
    EditValorEntrada.Visible := false;
    EditDinheiro.Visible := True;
    EditTroco.Visible := True;
    Label7.Visible := True;
    Label8.Visible := True;
  end;
end;

procedure TFrmFinaliza.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrmFinaliza.EditDinheiroTyping(Sender: TObject);
begin
  Formatar(EditDinheiro, Valor);
end;

procedure TFrmFinaliza.EditTrocoEnter(Sender: TObject);
var
  vlr_dinheiro, vlr_troco, vlr_compra: real;
begin
  vlr_dinheiro := StrToFloat(EditDinheiro.Text);
  vlr_compra := StrToFloat(EditValor.Text);
  vlr_troco := vlr_dinheiro - vlr_compra;
  EditTroco.Text := FormatFloat('R$ #,##0.00', vlr_troco);
end;

procedure TFrmFinaliza.EditValorEntradaTyping(Sender: TObject);
begin
  Formatar(EditValorEntrada, Valor);
end;

procedure TFrmFinaliza.EditValorTyping(Sender: TObject);
begin
  Formatar(EditValor, Valor);
end;

procedure TFrmFinaliza.EditVlrParcelaEnter(Sender: TObject);
var
  vlr_parcela: real;
  vlr_entrada: real;
  qte_parcelas: integer;
begin
  vlr_entrada := 0;
  vlr_parcela := 0;
  qte_parcelas := 0;

  if EditValorEntrada.Text <> '' then
    vlr_entrada := StrToFloat(EditValorEntrada.Text);
  if EditParcelas.Text <> '' then
    qte_parcelas := StrToInt(EditParcelas.Text);

  vlr_parcela := (StrToFloat(EditValor.Text) - vlr_entrada) / qte_parcelas;

  EditVlrParcela.Text := FormatFloat('#0.00', vlr_parcela);
end;

procedure TFrmFinaliza.FinalizaVenda;
begin
  dm.FDQTpagamento.Locate('descricao',
    ComboBox1.Items[ComboBox1.ItemIndex], []);
  dm.FDQVenda.Edit;
  dm.FDQVendaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
  dm.FDQVendaID_TIPOPAGAMENTO.AsInteger := dm.FDQTpagamentoID.AsInteger;
  if dm.FDQTpagamentoDESCRICAO.AsString = 'A prazo' then
  begin
    dm.fdqvendaParcela.AsInteger := StrToInt(EditParcelas.Text);
  end;

  dm.FDQVenda.Post;
  dm.FDConnection1.CommitRetaining;
  MessageDlg('Venda finalizada com sucesso!', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbok], 0);

  FrmFinaliza.Close;
end;

procedure TFrmFinaliza.GerarConta;
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
    if EditValorEntrada.Text <> '' then
    begin
      dm.FDQconta.Append;
      dm.FDQcontaID_MOVIMENTACAO.AsInteger := dm.FDQVendaID.AsInteger;
      dm.FDQcontaID_PESSOA.AsInteger := dm.FDQVendaID_PESSOA.AsInteger;
      dm.FDQcontaDOCUMENTO.AsInteger := dm.FDQVendaID.AsInteger;
      dm.FDQcontaDT_RECORD.AsDateTime := date;
      dm.fdqcontaid_caixa.AsInteger := dm.FDQVendaID_CAIXA.AsInteger;
      dm.FDQcontaDT_VENDA.AsDateTime := dm.FDQVendaDATA.AsDateTime;
      dm.FDQcontaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
      dm.FDQcontaVLR_PAGAMENTO.AsFloat := StrToFloat(EditValorEntrada.Text);
      dm.FDQcontaTP_CONTA.AsString := 'R';
      dm.fdqcontastatus_conta.AsString := 'L';
      dm.FDQcontaDT_PAGAMENTO.AsDateTime := date;
      dm.fdqcontavlr_Entrada.AsFloat := StrToFloat(EditValorEntrada.Text);
      dm.FDQconta.Post;
    end;

    data_parcela := date;
    for I := 1 to StrToInt(EditParcelas.Text) do
    begin
      data_parcela := data_parcela + 31;
      dm.FDQconta.Append;
      dm.FDQcontaID_PESSOA.AsInteger := dm.FDQVendaID_PESSOA.AsInteger;
      dm.FDQcontaDOCUMENTO.AsInteger := dm.FDQVendaID.AsInteger;
      dm.FDQcontaDT_RECORD.AsDateTime := date;
      dm.FDQcontaTP_CONTA.AsString := 'R';
      dm.fdqcontaid_caixa.AsInteger := dm.FDQVendaID_CAIXA.AsInteger;
      dm.FDQcontaDT_VENDA.AsDateTime := dm.FDQVendaDATA.AsDateTime;
      dm.FDQcontaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
      dm.FDQcontaNR_parcela.AsInteger := I;
      dm.fdqcontastatus_conta.AsString := 'A';
      if EditVlrParcela.Text <> '' then
        dm.FDQcontaVLR_PARCELA.AsFloat := StrToFloat(EditVlrParcela.Text);
      dm.fdqcontaDT_vencimentoParcela.AsDateTime := data_parcela;
      if EditValorEntrada.Text <> '' then
        dm.fdqcontavlr_Entrada.AsFloat := StrToFloat(EditValorEntrada.Text);
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
    dm.FDQcontaTP_CONTA.AsString := 'R';
    dm.fdqcontastatus_conta.AsString := 'L';
    dm.FDQcontaDT_PAGAMENTO.AsDateTime := date;
    dm.FDQconta.Post;
  end;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFrmFinaliza.AtualizaEstoque;
var
  id_produto: integer;
  qte_produto: real;
begin

  dm.tabBusca.Open
    ('select id_produto, qte_produto  from venda_item where id_venda=' +
    dm.FDQVendaID.AsString);

  while not dm.tabBusca.Eof do
  begin
    id_produto := dm.tabBusca.FieldByName('id_produto').AsInteger;
    qte_produto := dm.tabBusca.FieldByName('qte_produto').AsFloat;
    dm.FDQProdutos.Locate('id', id_produto, []);
    if dm.FDQProdutosESTOQUEMINIMO.AsInteger > 0 then
    begin
      if dm.FDQProdutosESTOQUE.AsInteger <= dm.FDQProdutosESTOQUEMINIMO.AsInteger
      then
        MessageDlg('Produto atingiu o estoque mínimo cadastrado',
          TMsgDlgType.mtwarning, [TMsgDlgBtn.mbok], 0);
    end;

    if dm.FDQProdutosControleEstoque.AsString = 'S' then
    begin
      dm.FDQProdutos.Edit;
      dm.FDQProdutosESTOQUE.AsFloat := dm.FDQProdutosESTOQUE.AsFloat -
        qte_produto;
      dm.FDQProdutos.Post;
      dm.FDConnection1.CommitRetaining;
    end;
    dm.tabBusca.Next;
  end;

end;

procedure TFrmFinaliza.FormShow(Sender: TObject);
begin

  EditValor.Text := FormatFloat('#0.00', FrmVenda.vl_total);

  dm.FDQTpagamento.Open();
  while not dm.FDQTpagamento.Eof do
  begin
    ComboBox1.Items.Add(dm.FDQTpagamentoDESCRICAO.AsString);
    dm.FDQTpagamento.Next;
  end;
end;

procedure TFrmFinaliza.RectConfirmaClick(Sender: TObject);
begin
  AtualizaEstoque;
  GerarConta;
  FinalizaVenda;
end;

end.
