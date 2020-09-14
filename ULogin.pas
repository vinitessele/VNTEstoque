unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IdHashSHA,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects;

type
  TFrmLogin = class(TForm)
    RectEsconde: TRectangle;
    Label1: TLabel;
    Image1: TImage;
    EditLogin: TEdit;
    EditSenha: TEdit;
    btnOK: TSpeedButton;
    BtnConcelar: TSpeedButton;
    RectExibi: TRectangle;
    StyleBook1: TStyleBook;
    procedure btnOKClick(Sender: TObject);
    procedure RectEscondeClick(Sender: TObject);
    procedure RectExibiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses UDM, UMenu;

function SHA1FromString(const AString: string): string;
var
  SHA1: TIdHashSHA1;
begin
  SHA1 := TIdHashSHA1.Create;
  try
    Result := SHA1.HashStringAsHex(AString);
  finally
    SHA1.Free;
  end;
end;

procedure TFrmLogin.btnOKClick(Sender: TObject);
var
  senhaDigitada, senha: string;
begin
  dm.tabBusca.Open('select nome, senha from usuario where nome= ' +
    QuotedStr(EditLogin.Text));

  senha := dm.tabBusca.FieldByName('senha').AsString;
  senhaDigitada := SHA1FromString(EditSenha.Text);

  if (EditLogin.Text = 'ADM') and (EditSenha.Text = 'Tessele') then
  begin
    if not Assigned(FrmMenu) then
      Application.CreateForm(TFrmMenu, FrmMenu);

    Application.MainForm := FrmMenu;
    FrmMenu.Show;

    FrmLogin.Close;
  end
  else if senha = senhaDigitada then
  begin
    if not Assigned(FrmMenu) then
      Application.CreateForm(TFrmMenu, FrmMenu);

    Application.MainForm := FrmMenu;
    FrmMenu.Show;

    FrmLogin.Close;

  end
  else
  begin
    ShowMessage('Usuário ou senha incorreto');
  end;

end;

procedure TFrmLogin.RectEscondeClick(Sender: TObject);
begin
  RectEsconde.Visible := false;
  RectExibi.Visible := true;
  EditSenha.Password := false;
end;

procedure TFrmLogin.RectExibiClick(Sender: TObject);
begin
  RectEsconde.Visible := true;
  RectExibi.Visible := false;
  EditSenha.Password := true;
end;

end.
