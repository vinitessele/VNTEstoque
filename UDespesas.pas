unit UDespesas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.Objects,
  FMX.Controls.Presentation;

type
  TFrmDespesas = class(TFrmModelo)
    Label1: TLabel;
    EditID: TEdit;
    Label2: TLabel;
    EditDescricao: TEdit;
    Label3: TLabel;
    EditData: TEdit;
    Label4: TLabel;
    EditValor: TEdit;
    Label5: TLabel;
    EditDocumento: TEdit;
    procedure EditValorTyping(Sender: TObject);
    procedure EditDataTyping(Sender: TObject);
    procedure EditLocalizarKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ListBox1DblClick(Sender: TObject);
    procedure RectNovoClick(Sender: TObject);
    procedure RectAlterarClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure RectCancelarClick(Sender: TObject);
    procedure RectExclirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDespesas: TFrmDespesas;

implementation

{$R *.fmx}

uses Loading, UDM, uFormat, UMenu;

procedure TFrmDespesas.EditDataTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditData, TFormato.Dt);
end;

procedure TFrmDespesas.EditLocalizarKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  dm.tabBusca.Open('select id, descricao, data, valor from despesa ' +
    'where descricao like ' + '%' + QuotedStr(EditLocalizar.Text) + '%');
  ListBox1.Visible := True;
  ListBox1.items.Clear;

  while not dm.tabBusca.Eof do
  begin
    ListBox1.items.Add(dm.tabBusca.FieldByName('descricao').AsString);
    dm.tabBusca.Next;
  end;
end;

procedure TFrmDespesas.EditValorTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditValor, Valor);
end;

procedure TFrmDespesas.ListBox1DblClick(Sender: TObject);
var
  nome: string;
begin
  inherited;
  nome := ListBox1.items[ListBox1.ItemIndex];
  dm.tabBusca.Open('select id, descricao, data, valor from despesa ' +
    'where descricao =' + nome);

  EditID.Text := dm.tabBusca.FieldByName('id').AsString;
  EditDescricao.Text := dm.tabBusca.FieldByName('descricao').AsString;
  EditData.Text := dm.tabBusca.FieldByName('data').AsString;
  EditValor.Text := dm.tabBusca.FieldByName('valor').AsString;

end;

procedure TFrmDespesas.RectAlterarClick(Sender: TObject);
begin
  inherited;
  dm.FDQDespesas.Edit;
end;

procedure TFrmDespesas.RectCancelarClick(Sender: TObject);
begin
  inherited;
  dm.FDQDespesas.Cancel;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFrmDespesas.RectExclirClick(Sender: TObject);
begin
  inherited;

  if EditID.Text <> EmptyStr then
  begin

  end;
  dm.FDQDespesas.Delete;
  dm.FDConnection1.CommitRetaining;

end;

procedure TFrmDespesas.RectNovoClick(Sender: TObject);
begin
  inherited;
  EditID.Text := EmptyStr;
  EditDescricao.Text := EmptyStr;
  EditData.Text := EmptyStr;
  EditValor.Text := EmptyStr;
  EditDocumento.Text := EmptyStr;
  EditDocumento.SetFocus;
  dm.FDQDespesas.Append;
end;

procedure TFrmDespesas.RectSalvarClick(Sender: TObject);
begin
  inherited;

  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura from caixa where status_caixa =''A'' ');

  dm.FDQDespesasdescricao.AsString := EditDescricao.Text;
  dm.FDQDespesasData.AsDateTime := StrToDate(EditData.Text);
  dm.FDQDespesasVALOR.AsFloat := StrToFloat(EditValor.Text);
  dm.FDQDespesasDocumento.AsString := EditDocumento.Text;
  dm.FDQDespesas.Post;
  dm.FDConnection1.CommitRetaining;

  dm.FDQconta.Append;
  dm.FDQcontaid_movimentacao.AsInteger := dm.FDQDespesasID.AsInteger;
  dm.FDQcontaDOCUMENTO.AsString := EditDocumento.Text;
  dm.FDQcontaDT_PAGAMENTO.AsDateTime := StrToDate(EditData.Text);
  dm.FDQcontaVLR_TOTAL.AsFloat := StrToFloat(EditValor.Text);
  dm.FDQcontaVLR_PAGAMENTO.AsFloat := StrToFloat(EditValor.Text);
  dm.FDQcontaDT_VENDA.AsDateTime := StrToDate(EditData.Text);
  dm.FDQcontaDT_RECORD.AsDateTime := Date;
  dm.FDQcontaTP_CONTA.AsString := 'D';
  dm.FDQcontaID_CAIXA.AsInteger := dm.tabBusca.FieldByName('id').AsInteger;
  dm.FDQcontaSTATUS_CONTA.AsString := 'L';
  dm.FDQconta.Post;

  dm.FDConnection1.CommitRetaining;
end;

end.
