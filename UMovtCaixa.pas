unit UMovtCaixa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Edit;

type
  TFMovtoCaixa = class(TForm)
    Rectangle3: TRectangle;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    EditSaldoAtual: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditVlrMovimentacao: TEdit;
    Label4: TLabel;
    EditSaldoFinal: TEdit;
    RectConfirma: TRectangle;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EditVlrMovimentacaoExit(Sender: TObject);
    procedure EditVlrMovimentacaoTyping(Sender: TObject);
    procedure RectConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    saldoatual, novosaldo, vlr: real;
    idcaixa: integer;
  end;

var
  FMovtoCaixa: TFMovtoCaixa;

implementation

{$R *.fmx}

uses UDM, uFormat;

procedure TFMovtoCaixa.EditVlrMovimentacaoExit(Sender: TObject);
begin
  if EditVlrMovimentacao.Text <> EmptyStr then
  begin
    saldoatual := StrToFloat(EditSaldoAtual.Text);
    vlr := StrToFloat(EditVlrMovimentacao.Text);

    if ComboBox1.Items[ComboBox1.ItemIndex] = 'Suprimento' then
    begin
      novosaldo := saldoatual + vlr;
    end
    else
    begin
      novosaldo := saldoatual - vlr;
    end;
    EditSaldoFinal.Text := FormatFloat('#0.00', novosaldo);
  end;

end;

procedure TFMovtoCaixa.EditVlrMovimentacaoTyping(Sender: TObject);
begin
  formatar(EditVlrMovimentacao, valor);
end;

procedure TFMovtoCaixa.FormShow(Sender: TObject);
begin
  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura, vlr_abertura, vlr_fechamento from caixa where status_caixa =''A'' order by data_fechamento, hora_fechamento desc');
  idcaixa := dm.tabBusca.FieldByName('id').AsInteger;
  EditSaldoAtual.Text := FormatFloat('#0.00',
    dm.tabBusca.FieldByName('vlr_abertura').AsFloat);
end;

procedure TFMovtoCaixa.RectConfirmaClick(Sender: TObject);
begin
  dm.FDQMovtoCaixa.Append;
  dm.FDQMovtoCaixaDATA_MOVIMENTO.AsDateTime := date;
  dm.FDQMovtoCaixaHORA_MOVIMENTO.AsDateTime := time;
  dm.FDQMovtoCaixaid_caixa.AsInteger := idcaixa;
  // dm.FDQMovtoCaixaID_USUARIO
  if ComboBox1.Items[ComboBox1.ItemIndex] = 'Suprimento' then
    dm.FDQMovtoCaixaTP_MOVIMENTO.AsString := 'E'
  else
    dm.FDQMovtoCaixaTP_MOVIMENTO.AsString := 'S';

  dm.FDQMovtoCaixaVLR_MOVIMENTO.AsFloat := StrToFloat(EditVlrMovimentacao.Text);
  dm.FDQMovtoCaixa.Post;

  dm.FDQCaixa.Locate('id', idcaixa, []);
  dm.FDQCaixa.Edit;
  dm.FDQCaixaVLR_ABERTURA.AsFloat := novosaldo;
  dm.FDQCaixa.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Salvo com sucesso!');
end;

end.
