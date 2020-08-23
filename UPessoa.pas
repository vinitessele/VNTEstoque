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
    EditEndereco: TEdit;
    Label7: TLabel;
    EditNumero: TEdit;
    Label10: TLabel;
    EditDtNascimento: TEdit;
    Label11: TLabel;
    Label8: TLabel;
    EditBairro: TEdit;
    Label14: TLabel;
    EditCidade: TEdit;
    Label12: TLabel;
    EditCelular: TEdit;
    Label13: TLabel;
    EditEmail: TEdit;
    Image1: TImage;
    bntFoto: TButton;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    NavigatorBindSourceDB1: TBindNavigator;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    LinkControlToField10: TLinkControlToField;
    LinkControlToField11: TLinkControlToField;
    LinkControlToField13: TLinkControlToField;
    ComboBoxGenero: TComboBox;
    procedure bntFotoClick(Sender: TObject);
    procedure EditCepExit(Sender: TObject);
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
  FrmPessoa: TFrmPessoa;

implementation

{$R *.fmx}

uses UDM, uCepWS;

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
begin
  inherited;
  dadoscep := TCep.Create;
  dadoscep.Consultar(EditCep.Text);
  EditEndereco.Text := dadoscep.Logradouro;
  EditBairro.Text := dadoscep.Bairro;
  dm.FDQCidade.Locate('nome', dadoscep.Localidade, []);
  EditCidade.Tag := dm.FDQCidadeID.AsInteger;
  EditCidade.Text := dadoscep.Localidade + '/' + dadoscep.Uf;
  //dadoscep.Free;
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
  inherited;
  GroupBox2.Enabled := false
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
  dm.FDQPessoaSEXO.AsString := ComboBoxGenero.Items[ComboBoxGenero.ItemIndex];
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
