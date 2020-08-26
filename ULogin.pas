unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
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

procedure TFrmLogin.btnOKClick(Sender: TObject);
begin
  if not Assigned(FrmMenu) then
    Application.CreateForm(TFrmMenu, FrmMenu);

  Application.MainForm := FrmMenu;
  FrmMenu.Show;

  FrmLogin.Close;
end;

procedure TFrmLogin.RectEscondeClick(Sender: TObject);
begin
  RectEsconde.Visible := false;
  RectExibi.Visible := true;
  editsenha.Password := false;
end;

procedure TFrmLogin.RectExibiClick(Sender: TObject);
begin
  RectEsconde.Visible := True;
  RectExibi.Visible := false;
  editsenha.Password := True;
end;

end.
