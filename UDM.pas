unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDQUsuario: TFDQuery;
    FDQUsuarioID: TIntegerField;
    FDQUsuarioDATACADASTRO: TDateField;
    FDQUsuarioDATAEXCLUSAO: TDateField;
    FDQUsuarioNOME: TStringField;
    FDQUsuarioSENHA: TStringField;
    FDQPessoa: TFDQuery;
    FDQPessoaID: TFDAutoIncField;
    FDQPessoaDATACADASTRO: TDateField;
    FDQPessoaDATAEXCLUSAO: TDateField;
    FDQPessoaUSUARIO: TIntegerField;
    FDQPessoaNOME: TStringField;
    FDQPessoaNOMEFANTASIA: TStringField;
    FDQPessoaCPFCNPJ: TStringField;
    FDQPessoaIERG: TStringField;
    FDQPessoaSEXO: TStringField;
    FDQPessoaRUA: TStringField;
    FDQPessoaNUMERO: TStringField;
    FDQPessoaBAIRRO: TStringField;
    FDQPessoaCEP: TStringField;
    FDQPessoaID_CIDADE: TIntegerField;
    FDQPessoaDATANASC: TDateField;
    FDQPessoaCOMPLEMENTO: TStringField;
    FDQPessoaOBSERVACOES: TStringField;
    FDQPessoaTIPOUSUAIRO: TStringField;
    FDQPessoaTELEFONE1: TStringField;
    FDQPessoaTELEFONE2: TStringField;
    FDQPessoaEMAIL1: TStringField;
    FDQPessoaIMG: TBlobField;
    FDQCidade: TFDQuery;
    FDQEstado: TFDQuery;
    FDQCidadeID: TIntegerField;
    FDQCidadeNOME: TStringField;
    FDQCidadeID_ESTADO: TIntegerField;
    FDQEstadoID: TIntegerField;
    FDQEstadoNOME: TStringField;
    FDQEstadoUF: TStringField;
    FDQProdutos: TFDQuery;
    FDQProdutosID: TIntegerField;
    FDQProdutosDATACADASTRO: TDateField;
    FDQProdutosDATAEXCLUSAO: TDateField;
    FDQProdutosID_USUARIO: TIntegerField;
    FDQProdutosDESCRICAO: TStringField;
    FDQProdutosCODIGOBARRA: TStringField;
    FDQProdutosESTOQUE: TFMTBCDField;
    FDQProdutosESTOQUEMINIMO: TFMTBCDField;
    FDQProdutosVALORCOMPRA: TFMTBCDField;
    FDQProdutosVALORVENDA: TFMTBCDField;
    FDQProdutosPORCENTAGEMLUCRO: TFMTBCDField;
    FDQProdutosUNIDADEMEDIA: TStringField;
    FDQProdutosOBSERVACOES: TStringField;
    FDQProdutosCONTROLEESTOQUE: TStringField;
    tabBusca: TFDQuery;
    FDQVenda: TFDQuery;
    FDQVendaItens: TFDQuery;
    FDQVendaID: TFDAutoIncField;
    FDQVendaDATA: TDateField;
    FDQVendaHORA: TTimeField;
    FDQVendaVLR_TOTAL: TFMTBCDField;
    FDQVendaID_TIPOPAGAMENTO: TIntegerField;
    FDQVendaItensID: TIntegerField;
    FDQVendaItensID_VENDA: TIntegerField;
    FDQVendaItensID_PRODUTO: TIntegerField;
    FDQVendaItensQTE_PRODUTO: TSingleField;
    FDQVendaItensVLR_UNITARIO: TFMTBCDField;
    FDQVendaItensVLR_TOTAL: TFMTBCDField;
    dsVendaItens: TDataSource;
    dsVenda: TDataSource;
    FDQVendaID_PESSOA: TIntegerField;
    FDQTpagamento: TFDQuery;
    FDQTpagamentoID: TIntegerField;
    FDQTpagamentoDESCRICAO: TStringField;
    FDQVendaPARCELA: TIntegerField;
    FDQCaixa: TFDQuery;
    FDQconta: TFDQuery;
    FDQCaixaID: TIntegerField;
    FDQCaixaDATA_ABERTURA: TDateField;
    FDQCaixaDATA_FECHAMENTO: TDateField;
    FDQCaixaHORA_ABERTURA: TTimeField;
    FDQCaixaHORA_FECHAMENTO: TTimeField;
    FDQcontaID: TIntegerField;
    FDQcontaID_PESSOA: TIntegerField;
    FDQcontaDOCUMENTO: TIntegerField;
    FDQcontaDT_RECORD: TDateField;
    FDQcontaDT_VENDA: TDateField;
    FDQcontaDT_PAGAMENTO: TDateField;
    FDQcontaVLR_TOTAL: TFMTBCDField;
    FDQcontaVLR_PARCELA: TFMTBCDField;
    FDQcontaVLR_PAGAMENTO: TFMTBCDField;
    FDQcontaVLR_SALDO: TFMTBCDField;
    FDQcontaTP_CONTA: TStringField;
    FDQcontaNR_PARCELA: TIntegerField;
    FDQcontaDT_VENCIMENTOPARCELA: TDateField;
    FDQcontaVLR_ENTRADA: TFMTBCDField;
    FDQCaixaSTATUS_CAIXA: TStringField;
    FDQVendaID_CAIXA: TIntegerField;
    FDQReceitas: TFDQuery;
    FDQDespesas: TFDQuery;
    FDQSumReceitas: TFDQuery;
    FDQSumReceitasSUM: TFMTBCDField;
    FDQReceitasID: TIntegerField;
    FDQReceitasDT_RECORD: TDateField;
    FDQReceitasDT_PAGAMENTO: TDateField;
    FDQReceitasVLR_TOTAL: TFMTBCDField;
    FDQReceitasID_PESSOA: TIntegerField;
    FDQReceitasNOME: TStringField;
    FDQcontaID_CAIXA: TIntegerField;
    FDQcontaSTATUS_CONTA: TStringField;
    FDQReceitasVLR_PAGAMENTO: TFMTBCDField;
    FDQCaixaVLR_ABERTURA: TFMTBCDField;
    FDQCaixaVLR_ENTRADA: TFMTBCDField;
    FDQCaixaVLR_SAIDA: TFMTBCDField;
    FDQCaixaVLR_FECHAMENTO: TFMTBCDField;
    procedure FDConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
begin
  FDQUsuario.Active := True;
  FDQCidade.Active := True;
  FDQEstado.Active := True;
  FDQPessoa.Active := True;
  FDQProdutos.Active := True;
  FDQVenda.Active := True;
  FDQVendaItens.Active := True;
  FDQTpagamento.Active := True;
  FDQconta.Active := True;
  FDQCaixa.Active := True;
  FDQReceitas.Active := True;
  FDQSumReceitas.Active := True;
end;

end.
