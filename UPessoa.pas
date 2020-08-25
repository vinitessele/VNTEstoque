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

  dm.FDQCidade.Locate('nome', cidade, []);
  EditCidade.Tag := dm.FDQCidadeID.AsInteger;

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

  while not dm.tabBusca.Eof do
  begin
    ListBox1.items.Add(dm.tabBusca.FieldByName('Nome').AsString);
    dm.tabBusca.Next;
  end;

end;

procedure TFrmPessoa.ListBox1DblClick(Sender: TObject);
begin
  inherited;
  dm.FDQPessoa.Locate('nome', ListBox1.items[ListBox1.ItemIndex], []);

  EditNome.Text := dm.FDQPessoaNOME.AsString;
  EditFantasia.Text := dm.FDQPessoaNOMEFANTASIA.AsString;
  EditCPFCNPJ.Text := dm.FDQPessoaCPFCNPJ.AsString;
  EditRgIE.Text := dm.FDQPessoaIERG.AsString;
  EditEndereco.Text := dm.FDQPessoaRUA.AsString;
  EditNumero.Text := dm.FDQPessoaNUMERO.AsString;
  EditBairro.Text := dm.FDQPessoaBAIRRO.AsString;
  EditCep.Text := dm.FDQPessoaCEP.AsString;
  EditCelular.Text := dm.FDQPessoaTELEFONE1.AsString;
  EditEmail.Text := dm.FDQPessoaEMAIL1.AsString;
  EditDtNascimento.Text := dm.FDQPessoaDATANASC.AsString;

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
