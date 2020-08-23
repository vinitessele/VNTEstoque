program VntEstoque;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMenu in 'UMenu.pas' {FrmMenu},
  ULogin in 'ULogin.pas' {FrmLogin},
  UModelo in 'UModelo.pas' {FrmModelo},
  UDM in 'UDM.pas' {DM: TDataModule},
  UUsuario in 'UUsuario.pas' {FrmUsuario},
  UPessoa in 'UPessoa.pas' {FrmPessoa},
  Loading in 'Loading.pas',
  uFormat in 'uFormat.pas',
  uCepWS in 'uCepWS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmUsuario, FrmUsuario);
  Application.CreateForm(TFrmPessoa, FrmPessoa);
  Application.Run;
end.
