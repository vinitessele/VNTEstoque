unit UUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IniFiles,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Objects, FMX.Controls.Presentation, Data.DB, FMX.Edit, IdHashSHA,
  System.Rtti, FMX.Grid.Style, FMX.Bind.Grid, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Controls, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  Data.Bind.Components, FMX.Layouts, FMX.Bind.Navigator, Data.Bind.Grid,
  Data.Bind.DBScope, FMX.ScrollBox, FMX.Grid, FMX.ListBox, FMX.TabControl;

type
  TFrmUsuario = class(TFrmModelo)
    Editusuario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    editsenha: TEdit;
    RectEsconde: TRectangle;
    RectExibi: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Label3: TLabel;
    EditServidor: TEdit;
    Label4: TLabel;
    EditCaminho: TEdit;
    RectConfirma: TRectangle;
    Label9: TLabel;
    procedure RectSalvarClick(Sender: TObject);
    procedure RectEscondeClick(Sender: TObject);
    procedure RectExibiClick(Sender: TObject);
    procedure RectNovoClick(Sender: TObject);
    procedure RectAlterarClick(Sender: TObject);
    procedure RectCancelarClick(Sender: TObject);
    procedure RectExclirClick(Sender: TObject);
    procedure RectConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUsuario: TFrmUsuario;

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

procedure TFrmUsuario.RectAlterarClick(Sender: TObject);
begin
  inherited;
  dm.FDQUsuario.Edit;
end;

procedure TFrmUsuario.RectCancelarClick(Sender: TObject);
begin
  inherited;
  dm.FDQUsuario.Cancel;
  dm.FDConnection1.RollbackRetaining;
end;

procedure TFrmUsuario.RectConfirmaClick(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  inherited;
  ArqIni := TIniFile.Create(extractFilePath(ParamStr(0)) + 'Conf.ini');
  try
    ArqIni.WriteString('SERVIDOR', 'Servidor', EditServidor.Text);
    ArqIni.WriteString('SERVIDOR', 'Database', EditCaminho.Text);

  finally
    ArqIni.Free;
  end;
end;

procedure TFrmUsuario.RectEscondeClick(Sender: TObject);
begin
  inherited;
  RectEsconde.Visible := false;
  RectExibi.Visible := True;
  editsenha.Password := false;
end;

procedure TFrmUsuario.RectExclirClick(Sender: TObject);
begin
  inherited;
  dm.FDQUsuario.Edit;
  dm.FDQUsuarioDATAEXCLUSAO.AsDateTime := Date;
  dm.FDQUsuario.Post;
  dm.FDConnection1.CommitRetaining;
end;

procedure TFrmUsuario.RectExibiClick(Sender: TObject);
begin
  inherited;
  RectEsconde.Visible := True;
  RectExibi.Visible := false;
  editsenha.Password := True;
end;

procedure TFrmUsuario.RectNovoClick(Sender: TObject);
begin
  inherited;
  Editusuario.Enabled := True;
  editsenha.Enabled := True;
  dm.FDQUsuario.Append;
end;

procedure TFrmUsuario.RectSalvarClick(Sender: TObject);
var
  senha: string;
begin

  senha := SHA1FromString(editsenha.Text);

  dm.FDQUsuarioDATACADASTRO.AsDateTime := Date;
  dm.FDQUsuarioNOME.AsString := Editusuario.Text;
  dm.FDQUsuarioSENHA.AsString := senha;
  dm.FDQUsuario.Post;
  dm.FDConnection1.CommitRetaining;
  inherited;
end;

end.
