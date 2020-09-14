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
  uCepWS in 'uCepWS.pas',
  UProdutos in 'UProdutos.pas' {FrmProdutos},
  UVenda in 'UVenda.pas' {FrmVenda},
  UFinalizaVenda in 'UFinalizaVenda.pas' {FrmFinaliza},
  UCaixa in 'UCaixa.pas' {FrmCaixa},
  UDespesas in 'UDespesas.pas' {FrmDespesas},
  UEntradaProdutos in 'UEntradaProdutos.pas' {FrmEntradaProdutos},
  Upagamento in 'Upagamento.pas' {FrmPagamento};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.Run;
end.
