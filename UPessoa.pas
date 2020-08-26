unit UPessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Bind.Grid, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Controls, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  Data.Bind.Components, FMX.Layouts, FMX.Bind.Navigator, Data.Bind.Grid,
  Data.Bind.DBScope, FMX.ListBox;

type
  TFrmPessoa = class(TFrmModelo)
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    EditId: TEdit;
    Label2: TLabel;
    EditNome: TEdit;
    Label3: TLabel;
    EditFantasia: TEdit;
    Label4: TLabel;
    EditCPFCNPJ: TEdit;
    EditRgIE: TEdit;
    Label5: TLabel;
    Label9: TLabel;
    EditCep: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    EditNumero: TEdit;
    Label10: TLabel;
    EditDtNascimento: TEdit;
    Label11: TLabel;
    Label8: TLabel;
    Label14: TLabel;
    EditCidade: TEdit;
    Label12: TLabel;
    EditCelular: TEdit;
    Label13: TLabel;
    EditEmail: TEdit;
    Image1: TImage;
    bntFoto: TButton;
    ComboBoxGenero: TComboBox;
    EditEndereco: TEdit;
    EditBairro: TEdit;
    procedure bntFotoClick(Sender: TObject);
    procedure EditCepExit(Sender: TObject);
    procedure RectNovoClick(Sender: TObject);
    procedure RectAlterarClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure RectCancelarClick(Sender: TObject);
    procedure RectExclirClick(Sender: TObject);
    procedure EditDtNascimentoTyping(Sender: TObject);
    procedure EditCPFCNPJTyping(Sender: TObject);
    procedure EditLocalizarKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPessoa: TFrmPessoa;

implementation

{$R *.fmx}

uses UDM, uCepWS, Loading, uFormat;

procedure TFrmPessoa.bntFotoClick(Sender: TObject);
begin
  inherited;
  If OpenDialog1.Execute Then
  begin
    Image1.Bitmap.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmPessoa.EditCepExit(Sender: TObject);
var
  dadoscep: TCep;
  endereco, bairro, cidade, uf: string;

begin
  inherited;
  dadoscep := TCep.Create;
  dadoscep.Consultar(EditCep.Text);
  endereco := dadoscep.Logradouro;
  bairro := dadoscep.bairro;
  cidade := dadoscep.Localidade;
  uf := dadoscep.uf;
  dadoscep.Free;

  dm.tabBusca.Open('select c.id, c.nome, e.uf from cidade c ' +
    ' inner join estado e on e.id=c.id_estado ' + ' where c.nome = ' +
    QuotedStr(cidade) + ' and  e.uf=' + QuotedStr(uf));
  EditCidade.Tag := dm.tabBusca.FieldByName('id').AsInteger;

  EditEndereco.Text := endereco;
  EditBairro.Text := bairro;
  EditCidade.Text := cidade + '/' + uf;

end;

procedure TFrmPessoa.EditCPFCNPJTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditCPFCNPJ, TFormato.CNPJorCPF);
end;

procedure TFrmPessoa.EditDtNascimentoTyping(Sender: TObject);
begin
  inherited;
  Formatar(EditDtNascimento, TFormato.Dt);
end;

procedure TFrmPessoa.EditLocalizarKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  ListBox1.Visible := True;
  ListBox1.items.Clear;
  dm.tabBusca.Open('SELECT ID,Nome,Rua,CpfCnpj FROM pessoa ' + ' WHERE ' +
    ' Nome LIKE ' + QuotedStr('%' + EditLocalizar.Text + '%') +
    ' OR CpfCnpj LIKE ' + QuotedStr('%' + EditLocalizar.Text + '%'));
  ListBox1.items.BeginUpdate;
  while not dm.tabBusca.Eof do
  begin
    ListBox1.items.Add(dm.tabBusca.FieldByName('id').AsString+' - '+dm.tabBusca.FieldByName('Nome').AsString);
    dm.tabBusca.Next;
  end;
  ListBox1.items.EndUpdate;
end;

procedure TFrmPessoa.ListBox1DblClick(Sender: TObject);
var
  nome: string;
begin
  inherited;
  nome := ListBox1.items[ListBox1.ItemIndex];

  dm.tabBusca.Open
    ('select p.id, p.nome,  p.nomefantasia, p.cpfcnpj, p.ierg, p.rua, p.numero, p.bairro, p.cep, '
    + ' p.datanasc, p.complemento, p.sexo, p.telefone1, p.email1, p.img, p.observacoes, '
    + ' c.nome as cidade ,e.uf from pessoa p ' +
    ' inner join cidade c on p.id_cidade = c.id ' +
    ' inner join estado e on c.id_estado = e.id ' + ' and p.nome  = ' +
    QuotedStr(nome));
  EditId.Text := dm.tabBusca.FieldByName('id').AsString;
  EditNome.Text := dm.tabBusca.FieldByName('Nome').AsString;
  EditFantasia.Text := dm.tabBusca.FieldByName('nomefantasia').AsString;
  EditCPFCNPJ.Text := dm.tabBusca.FieldByName('cpfcnpj').AsString;
  EditRgIE.Text := dm.tabBusca.FieldByName('ierg').AsString;
  EditEndereco.Text := dm.tabBusca.FieldByName('rua').AsString;
  EditNumero.Text := dm.tabBusca.FieldByName('numero').AsString;
  EditBairro.Text := dm.tabBusca.FieldByName('bairro').AsString;
  EditCidade.Text := dm.tabBusca.FieldByName('cidade').AsString + '/' +
    dm.tabBusca.FieldByName('uf').AsString;
  EditCep.Text := dm.tabBusca.FieldByName('cep').AsString;
  EditCelular.Text := dm.tabBusca.FieldByName('telefone1').AsString;
  EditEmail.Text := dm.tabBusca.FieldByName('email1').AsString;
  EditDtNascimento.Text := dm.tabBusca.FieldByName('datanasc').AsString;

  ListBox1.Visible := false;
  {
    StreamImg := TMemoryStream.Create;
    Image1.Bitmap.SaveToStream(StreamImg);
    dm.FDQPessoaIMG.LoadFromStream(StreamImg);
  }

end;

procedure TFrmPessoa.RectAlterarClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := True;
  dm.FDQPessoa.Edit;
  EditNome.SetFocus;
end;

procedure TFrmPessoa.RectCancelarClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := false;
end;

procedure TFrmPessoa.RectExclirClick(Sender: TObject);
begin
  GroupBox2.Enabled := false;
  dm.FDQPessoa.Delete;
  inherited;
end;

procedure TFrmPessoa.RectNovoClick(Sender: TObject);
begin
  inherited;
  GroupBox2.Enabled := True;
  dm.FDQPessoa.Append;
  EditNome.SetFocus;
end;

procedure TFrmPessoa.RectSalvarClick(Sender: TObject);
var
  StreamImg: TStream;
begin
  GroupBox2.Enabled := false;
  dm.FDQPessoaNOME.AsString := EditNome.Text;
  dm.FDQPessoaNOMEFANTASIA.AsString := EditFantasia.Text;
  dm.FDQPessoaDATACADASTRO.AsString := DateToStr(date);
  dm.FDQPessoaCPFCNPJ.AsString := EditCPFCNPJ.Text;
  dm.FDQPessoaIERG.AsString := EditRgIE.Text;
  dm.FDQPessoaRUA.AsString := EditEndereco.Text;
  dm.FDQPessoaNUMERO.AsString := EditNumero.Text;
  dm.FDQPessoaBAIRRO.AsString := EditBairro.Text;
  dm.FDQPessoaCEP.AsString := EditCep.Text;
  dm.FDQPessoaTELEFONE1.AsString := EditCelular.Text;
  dm.FDQPessoaSEXO.AsString := ComboBoxGenero.items[ComboBoxGenero.ItemIndex];
  dm.FDQPessoaEMAIL1.AsString := EditEmail.Text;
  dm.FDQPessoaDATANASC.AsString := EditDtNascimento.Text;
  dm.FDQPessoaID_CIDADE.AsInteger := EditCidade.Tag;

  StreamImg := TMemoryStream.Create;
  Image1.Bitmap.SaveToStream(StreamImg);
  dm.FDQPessoaIMG.LoadFromStream(StreamImg);

  dm.FDQPessoa.Post;
  dm.FDConnection1.CommitRetaining;
  inherited;

end;

end.
