unit UCaixa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.Objects, FMX.Controls.Presentation,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope;

type
  TFrmCaixa = class(TForm)
    ToolBar1: TToolBar;
    RectNovo: TRectangle;
    RectSalvar: TRectangle;
    RectpPesquisar: TRectangle;
    GroupBox2: TGroupBox;
    EditID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditDataAbertura: TEdit;
    Label3: TLabel;
    EditDataFechamento: TEdit;
    Label4: TLabel;
    EditVlrAbertura: TEdit;
    Label5: TLabel;
    EditVlrFechamento: TEdit;
    Label6: TLabel;
    LabelStatus: TLabel;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    GridReceita: TGrid;
    GridDespesas: TGrid;
    Label7: TLabel;
    EditReceita: TEdit;
    EditDespesas: TEdit;
    Label8: TLabel;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    StyleBook1: TStyleBook;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    ListBox1: TListBox;
    EditLocalizar: TEdit;
    procedure EditVlrAberturaTyping(Sender: TObject);
    procedure RectNovoClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RectpPesquisarClick(Sender: TObject);
    procedure EditLocalizarExit(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    procedure AberturaCaixa(vlr_abertura: Real);
    procedure FechamentoCaixa(vlr_abertura: Real);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCaixa: TFrmCaixa;

implementation

{$R *.fmx}

uses UDM, uFormat, UMenu;

procedure TFrmCaixa.EditLocalizarExit(Sender: TObject);
var
  Data: string;
  sql: string;
  localizar: string;
begin
  ListBox1.Visible := True;
  ListBox1.items.Clear;
  Data := DateToStr(date);
  localizar := stringreplace(EditLocalizar.Text, '/', '.', [rfReplaceAll]);

  dm.tabBusca.Open('select id, data_abertura, status_caixa from caixa where' +
    ' data_abertura =' + QuotedStr(localizar));

  ListBox1.items.BeginUpdate;
  while not dm.tabBusca.Eof do
  begin
    ListBox1.items.Add(dm.tabBusca.FieldByName('id').AsString + ' - ' +
      dm.tabBusca.FieldByName('data_abertura').AsString);
    dm.tabBusca.Next;
  end;
  ListBox1.items.EndUpdate;
end;

procedure TFrmCaixa.AberturaCaixa(vlr_abertura: Real);
begin
  dm.FDQCaixa.Append;
  dm.FDQCaixaDATA_ABERTURA.AsDateTime := date;
  dm.FDQCaixaHORA_ABERTURA.AsDateTime := Time;
  dm.FDQCaixaVLR_ABERTURA.AsFloat := vlr_abertura;
  dm.FDQCaixaSTATUS_CAIXA.AsString := 'A';
  dm.FDQCaixa.Post;
  dm.FDConnection1.CommitRetaining;
  MessageDlg('Caixa aberto com sucesso', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbok], 0);
end;

procedure TFrmCaixa.FechamentoCaixa(vlr_abertura: Real);
begin
  EditID.Text := dm.tabBusca.FieldByName('id').AsString;
  dm.FDQCaixa.Locate('id', EditID.Text, []);
  EditDataAbertura.Text := dm.tabBusca.FieldByName('data_abertura').AsString;
  EditVlrAbertura.Text := dm.tabBusca.FieldByName('vlr_abertura').AsString;
  if dm.tabBusca.FieldByName('status_caixa').AsString = 'A' then
    LabelStatus.Text := 'Aberto'
  else
    LabelStatus.Text := 'Fechado';
  dm.FDQCaixa.Edit;
  dm.FDQCaixaSTATUS_CAIXA.AsString := 'F';
  dm.FDQCaixaHORA_FECHAMENTO.AsDateTime := Time;
  dm.FDQCaixaDATA_FECHAMENTO.AsDateTime := date;

  if EditReceita.Text <> '0' then
    dm.FDQCaixaVLR_ENTRADA.AsFloat := StrToFloat(EditReceita.Text);

  dm.FDQCaixaVLR_FECHAMENTO.AsFloat :=
    (vlr_abertura + StrToFloat(EditReceita.Text)) -
    StrToFloat(EditDespesas.Text);
  EditVlrFechamento.Text := FormatFloat('#,##0.00',
    dm.FDQCaixaVLR_FECHAMENTO.AsFloat);
  EditDataFechamento.Text := DateToStr(dm.FDQCaixaDATA_FECHAMENTO.AsDateTime);
  dm.FDQCaixa.Post;
  dm.FDConnection1.CommitRetaining;
  MessageDlg('Caixa Fechado com sucesso', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbok], 0);
end;

procedure TFrmCaixa.EditVlrAberturaTyping(Sender: TObject);
begin
  Formatar(EditVlrAbertura, valor);
end;

procedure TFrmCaixa.FormShow(Sender: TObject);
var
  vlr_abertura: Real;
begin
  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura, vlr_abertura from caixa where status_caixa =''A'' ');

  if dm.tabBusca.RecordCount > 0 then
  begin

    EditID.Text := dm.tabBusca.FieldByName('id').AsString;

    dm.FDQReceitas.Close;
    dm.FDQReceitas.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQReceitas.Open();

    dm.FDQSumReceitas.Close;
    dm.FDQSumReceitas.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQSumReceitas.Open();

    EditReceita.Text := FormatFloat('#,##0.00', dm.FDQSumReceitasSUM.AsFloat);

    dm.FDQDespesasCaixa.Close;
    dm.FDQDespesasCaixa.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQDespesasCaixa.Open();

    dm.FDQSumDespesas.Close;
    dm.FDQSumDespesas.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQSumDespesas.Open();

    EditDespesas.Text := FormatFloat('#,##0.00', dm.FDQSumDespesasSum.AsFloat);

    EditDataAbertura.Text := dm.tabBusca.FieldByName('data_abertura').AsString;
    EditVlrAbertura.Text := dm.tabBusca.FieldByName('vlr_abertura').AsString;
    if dm.tabBusca.FieldByName('status_caixa').AsString = 'A' then
      LabelStatus.Text := 'Aberto'
    else
      LabelStatus.Text := 'Fechado';
  end
  else
  begin
    dm.FDQReceitas.Close;
    dm.FDQDespesasCaixa.Close;
  end;

end;

procedure TFrmCaixa.ListBox1DblClick(Sender: TObject);
var
  selecionado: string;
  Dividido: TArray<String>;
begin

  selecionado := ListBox1.items[ListBox1.ItemIndex];
  Dividido := selecionado.Split(['-']);
  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura, vlr_abertura from caixa where id ='
    + QuotedStr(Dividido[0]));

  if dm.tabBusca.RecordCount > 0 then
  begin

    EditID.Text := dm.tabBusca.FieldByName('id').AsString;

    dm.FDQReceitas.Close;
    dm.FDQReceitas.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQReceitas.Open();

    dm.FDQSumReceitas.Close;
    dm.FDQSumReceitas.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQSumReceitas.Open();

    EditReceita.Text := FormatFloat('#,##0.00', dm.FDQSumReceitasSUM.AsFloat);

    dm.FDQDespesasCaixa.Close;
    dm.FDQDespesasCaixa.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQDespesasCaixa.Open();

    dm.FDQSumDespesas.Close;
    dm.FDQSumDespesas.ParamByName('caixa').AsInteger := StrToInt(EditID.Text);
    dm.FDQSumDespesas.Open();

    EditDespesas.Text := FormatFloat('#,##0.00', dm.FDQSumDespesasSum.AsFloat);

    EditDataAbertura.Text := dm.tabBusca.FieldByName('data_abertura').AsString;
    EditVlrAbertura.Text := dm.tabBusca.FieldByName('vlr_abertura').AsString;
    if dm.tabBusca.FieldByName('status_caixa').AsString = 'A' then
      LabelStatus.Text := 'Aberto'
    else
      LabelStatus.Text := 'Fechado';
  end
  else
  begin
    dm.FDQReceitas.Close;
    dm.FDQDespesasCaixa.Close;
  end;
end;

procedure TFrmCaixa.RectNovoClick(Sender: TObject);
var
  vlr_abertura: Real;
begin
  EditVlrAbertura.SetFocus;
  EditDataAbertura.Text := DateToStr(date);
  EditReceita.Text := '0';
  EditDespesas.Text := '0';

  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura, vlr_abertura, vlr_fechamento from caixa where status_caixa =''F'' order by data_fechamento, hora_fechamento desc');

  vlr_abertura := dm.tabBusca.FieldByName('vlr_fechamento').AsFloat;
  EditVlrAbertura.Text := FormatFloat('#,##0.00', vlr_abertura);

  AberturaCaixa(vlr_abertura);

end;

procedure TFrmCaixa.RectpPesquisarClick(Sender: TObject);
begin
  if EditLocalizar.Visible then
    EditLocalizar.Visible := false
  else
    EditLocalizar.Visible := True;
end;

procedure TFrmCaixa.RectSalvarClick(Sender: TObject);
var
  vlr_abertura: Real;
begin
  dm.tabBusca.Open
    ('select id, status_caixa, data_abertura, vlr_abertura from caixa where status_caixa =''A'' ');

  if EditVlrAbertura.Text <> '' then
    vlr_abertura := StrToFloat(EditVlrAbertura.Text)
  else
    vlr_abertura := 0;

  if dm.tabBusca.RecordCount > 0 then
  begin
    FechamentoCaixa(vlr_abertura);
  end
  else
  begin
    AberturaCaixa(vlr_abertura);
  end;

end;

end.
