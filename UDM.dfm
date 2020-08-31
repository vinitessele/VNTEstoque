object DM: TDM
  OldCreateOrder = False
  Height = 526
  Width = 620
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\vinic\Documents\Embarcadero\Studio\Projects\VN' +
        'TEstoque\Banco\BANCODADOS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'DriverID=FB')
    Connected = True
    AfterConnect = FDConnection1AfterConnect
    Left = 40
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Windows\System32\GDS32.DLL'
    Left = 144
    Top = 16
  end
  object FDQUsuario: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'gen_usuario'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from usuario')
    Left = 32
    Top = 336
    object FDQUsuarioID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQUsuarioDATACADASTRO: TDateField
      FieldName = 'DATACADASTRO'
      Origin = 'DATACADASTRO'
    end
    object FDQUsuarioDATAEXCLUSAO: TDateField
      FieldName = 'DATAEXCLUSAO'
      Origin = 'DATAEXCLUSAO'
    end
    object FDQUsuarioNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object FDQUsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 100
    end
  end
  object FDQPessoa: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_pessoa'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from pessoa')
    Left = 32
    Top = 208
    object FDQPessoaID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object FDQPessoaDATACADASTRO: TDateField
      FieldName = 'DATACADASTRO'
      Origin = 'DATACADASTRO'
    end
    object FDQPessoaDATAEXCLUSAO: TDateField
      FieldName = 'DATAEXCLUSAO'
      Origin = 'DATAEXCLUSAO'
    end
    object FDQPessoaUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
    end
    object FDQPessoaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 255
    end
    object FDQPessoaNOMEFANTASIA: TStringField
      FieldName = 'NOMEFANTASIA'
      Origin = 'NOMEFANTASIA'
      Size = 255
    end
    object FDQPessoaCPFCNPJ: TStringField
      FieldName = 'CPFCNPJ'
      Origin = 'CPFCNPJ'
      Size = 18
    end
    object FDQPessoaIERG: TStringField
      FieldName = 'IERG'
      Origin = 'IERG'
      Size = 12
    end
    object FDQPessoaSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object FDQPessoaRUA: TStringField
      FieldName = 'RUA'
      Origin = 'RUA'
      Size = 255
    end
    object FDQPessoaNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 4
    end
    object FDQPessoaBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 150
    end
    object FDQPessoaCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object FDQPessoaID_CIDADE: TIntegerField
      FieldName = 'ID_CIDADE'
      Origin = 'ID_CIDADE'
    end
    object FDQPessoaDATANASC: TDateField
      FieldName = 'DATANASC'
      Origin = 'DATANASC'
    end
    object FDQPessoaCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 100
    end
    object FDQPessoaOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Origin = 'OBSERVACOES'
      Size = 300
    end
    object FDQPessoaTIPOUSUAIRO: TStringField
      FieldName = 'TIPOUSUAIRO'
      Origin = 'TIPOUSUAIRO'
      FixedChar = True
      Size = 1
    end
    object FDQPessoaTELEFONE1: TStringField
      FieldName = 'TELEFONE1'
      Origin = 'TELEFONE1'
      Size = 14
    end
    object FDQPessoaTELEFONE2: TStringField
      FieldName = 'TELEFONE2'
      Origin = 'TELEFONE2'
      Size = 14
    end
    object FDQPessoaEMAIL1: TStringField
      FieldName = 'EMAIL1'
      Origin = 'EMAIL1'
      Size = 100
    end
    object FDQPessoaIMG: TBlobField
      FieldName = 'IMG'
      Origin = 'IMG'
    end
  end
  object FDQCidade: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from cidade')
    Left = 32
    Top = 80
    object FDQCidadeID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQCidadeNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object FDQCidadeID_ESTADO: TIntegerField
      FieldName = 'ID_ESTADO'
      Origin = 'ID_ESTADO'
    end
  end
  object FDQEstado: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from estado')
    Left = 32
    Top = 136
    object FDQEstadoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQEstadoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 30
    end
    object FDQEstadoUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      FixedChar = True
      Size = 2
    end
  end
  object FDQProdutos: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_produto'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from produto')
    Left = 104
    Top = 200
    object FDQProdutosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQProdutosDATACADASTRO: TDateField
      FieldName = 'DATACADASTRO'
      Origin = 'DATACADASTRO'
    end
    object FDQProdutosDATAEXCLUSAO: TDateField
      FieldName = 'DATAEXCLUSAO'
      Origin = 'DATAEXCLUSAO'
    end
    object FDQProdutosID_USUARIO: TIntegerField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
    end
    object FDQProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object FDQProdutosCODIGOBARRA: TStringField
      FieldName = 'CODIGOBARRA'
      Origin = 'CODIGOBARRA'
      Size = 25
    end
    object FDQProdutosESTOQUE: TFMTBCDField
      FieldName = 'ESTOQUE'
      Origin = 'ESTOQUE'
      Precision = 18
      Size = 2
    end
    object FDQProdutosESTOQUEMINIMO: TFMTBCDField
      FieldName = 'ESTOQUEMINIMO'
      Origin = 'ESTOQUEMINIMO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosVALORCOMPRA: TFMTBCDField
      FieldName = 'VALORCOMPRA'
      Origin = 'VALORCOMPRA'
      Precision = 18
      Size = 2
    end
    object FDQProdutosVALORVENDA: TFMTBCDField
      FieldName = 'VALORVENDA'
      Origin = 'VALORVENDA'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPORCENTAGEMLUCRO: TFMTBCDField
      FieldName = 'PORCENTAGEMLUCRO'
      Origin = 'PORCENTAGEMLUCRO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosUNIDADEMEDIA: TStringField
      FieldName = 'UNIDADEMEDIA'
      Origin = 'UNIDADEMEDIA'
      Size = 2
    end
    object FDQProdutosOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Origin = 'OBSERVACOES'
      Size = 255
    end
    object FDQProdutosCONTROLEESTOQUE: TStringField
      FieldName = 'CONTROLEESTOQUE'
      Origin = 'CONTROLEESTOQUE'
      FixedChar = True
      Size = 1
    end
  end
  object tabBusca: TFDQuery
    Connection = FDConnection1
    Left = 452
    Top = 160
  end
  object FDQVenda: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_venda'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from venda')
    Left = 32
    Top = 384
    object FDQVendaID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object FDQVendaDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object FDQVendaHORA: TTimeField
      FieldName = 'HORA'
      Origin = 'HORA'
    end
    object FDQVendaVLR_TOTAL: TFMTBCDField
      FieldName = 'VLR_TOTAL'
      Origin = 'VLR_TOTAL'
      Precision = 18
      Size = 2
    end
    object FDQVendaID_TIPOPAGAMENTO: TIntegerField
      FieldName = 'ID_TIPOPAGAMENTO'
      Origin = 'ID_TIPOPAGAMENTO'
    end
    object FDQVendaID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
    end
    object FDQVendaPARCELA: TIntegerField
      FieldName = 'PARCELA'
      Origin = 'PARCELA'
    end
    object FDQVendaID_CAIXA: TIntegerField
      FieldName = 'ID_CAIXA'
      Origin = 'ID_CAIXA'
    end
  end
  object FDQVendaItens: TFDQuery
    IndexFieldNames = 'ID_VENDA'
    MasterSource = dsVenda
    MasterFields = 'ID'
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_vendaItem'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from venda_item')
    Left = 144
    Top = 384
    object FDQVendaItensID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQVendaItensID_VENDA: TIntegerField
      FieldName = 'ID_VENDA'
      Origin = 'ID_VENDA'
      Required = True
    end
    object FDQVendaItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
    end
    object FDQVendaItensQTE_PRODUTO: TSingleField
      FieldName = 'QTE_PRODUTO'
      Origin = 'QTE_PRODUTO'
    end
    object FDQVendaItensVLR_UNITARIO: TFMTBCDField
      FieldName = 'VLR_UNITARIO'
      Origin = 'VLR_UNITARIO'
      Precision = 18
      Size = 2
    end
    object FDQVendaItensVLR_TOTAL: TFMTBCDField
      FieldName = 'VLR_TOTAL'
      Origin = 'VLR_TOTAL'
      Precision = 18
      Size = 2
    end
  end
  object dsVendaItens: TDataSource
    DataSet = FDQVendaItens
    Left = 136
    Top = 416
  end
  object dsVenda: TDataSource
    DataSet = FDQVenda
    Left = 72
    Top = 416
  end
  object FDQTpagamento: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select *from tipo_pagamento')
    Left = 32
    Top = 464
    object FDQTpagamentoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQTpagamentoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
  end
  object FDQCaixa: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_caixa'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from caixa')
    Left = 112
    Top = 80
    object FDQCaixaID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQCaixaDATA_ABERTURA: TDateField
      FieldName = 'DATA_ABERTURA'
      Origin = 'DATA_ABERTURA'
      Required = True
    end
    object FDQCaixaDATA_FECHAMENTO: TDateField
      FieldName = 'DATA_FECHAMENTO'
      Origin = 'DATA_FECHAMENTO'
    end
    object FDQCaixaHORA_ABERTURA: TTimeField
      FieldName = 'HORA_ABERTURA'
      Origin = 'HORA_ABERTURA'
    end
    object FDQCaixaHORA_FECHAMENTO: TTimeField
      FieldName = 'HORA_FECHAMENTO'
      Origin = 'HORA_FECHAMENTO'
    end
    object FDQCaixaSTATUS_CAIXA: TStringField
      FieldName = 'STATUS_CAIXA'
      Origin = 'STATUS_CAIXA'
      FixedChar = True
      Size = 1
    end
    object FDQCaixaVLR_ABERTURA: TFMTBCDField
      FieldName = 'VLR_ABERTURA'
      Origin = 'VLR_ABERTURA'
      Precision = 18
      Size = 2
    end
    object FDQCaixaVLR_ENTRADA: TFMTBCDField
      FieldName = 'VLR_ENTRADA'
      Origin = 'VLR_ENTRADA'
      Precision = 18
      Size = 2
    end
    object FDQCaixaVLR_SAIDA: TFMTBCDField
      FieldName = 'VLR_SAIDA'
      Origin = 'VLR_SAIDA'
      Precision = 18
      Size = 2
    end
    object FDQCaixaVLR_FECHAMENTO: TFMTBCDField
      FieldName = 'VLR_FECHAMENTO'
      Origin = 'VLR_FECHAMENTO'
      Precision = 18
      Size = 2
    end
  end
  object FDQconta: TFDQuery
    Active = True
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_conta'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from conta')
    Left = 184
    Top = 80
    object FDQcontaID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQcontaID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
    end
    object FDQcontaDOCUMENTO: TIntegerField
      FieldName = 'DOCUMENTO'
      Origin = 'DOCUMENTO'
    end
    object FDQcontaDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = 'DT_RECORD'
    end
    object FDQcontaDT_VENDA: TDateField
      FieldName = 'DT_VENDA'
      Origin = 'DT_VENDA'
    end
    object FDQcontaDT_PAGAMENTO: TDateField
      FieldName = 'DT_PAGAMENTO'
      Origin = 'DT_PAGAMENTO'
    end
    object FDQcontaVLR_TOTAL: TFMTBCDField
      FieldName = 'VLR_TOTAL'
      Origin = 'VLR_TOTAL'
      Precision = 18
      Size = 2
    end
    object FDQcontaVLR_PARCELA: TFMTBCDField
      FieldName = 'VLR_PARCELA'
      Origin = 'VLR_PARCELA'
      Precision = 18
      Size = 2
    end
    object FDQcontaVLR_PAGAMENTO: TFMTBCDField
      FieldName = 'VLR_PAGAMENTO'
      Origin = 'VLR_PAGAMENTO'
      Precision = 18
      Size = 2
    end
    object FDQcontaVLR_SALDO: TFMTBCDField
      FieldName = 'VLR_SALDO'
      Origin = 'VLR_SALDO'
      Precision = 18
      Size = 2
    end
    object FDQcontaTP_CONTA: TStringField
      FieldName = 'TP_CONTA'
      Origin = 'TP_CONTA'
      FixedChar = True
      Size = 1
    end
    object FDQcontaNR_PARCELA: TIntegerField
      FieldName = 'NR_PARCELA'
      Origin = 'NR_PARCELA'
    end
    object FDQcontaDT_VENCIMENTOPARCELA: TDateField
      FieldName = 'DT_VENCIMENTOPARCELA'
      Origin = 'DT_VENCIMENTOPARCELA'
    end
    object FDQcontaVLR_ENTRADA: TFMTBCDField
      FieldName = 'VLR_ENTRADA'
      Origin = 'VLR_ENTRADA'
      Precision = 18
      Size = 2
    end
    object FDQcontaID_CAIXA: TIntegerField
      FieldName = 'ID_CAIXA'
      Origin = 'ID_CAIXA'
    end
    object FDQcontaSTATUS_CONTA: TStringField
      FieldName = 'STATUS_CONTA'
      Origin = 'STATUS_CONTA'
      FixedChar = True
      Size = 1
    end
    object FDQcontaID_MOVIMENTACAO: TIntegerField
      FieldName = 'ID_MOVIMENTACAO'
      Origin = 'ID_MOVIMENTACAO'
    end
  end
  object FDQReceitas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select '
      'c.id, '
      'c.dt_record,  '
      'c.dt_pagamento, '
      'c.vlr_total, '
      'c.id_pessoa,'
      'c.vlr_pagamento, '
      'p.nome '
      'from conta c'
      'inner join pessoa p on p.id = c.id_pessoa'
      'where c.id_caixa = :caixa'
      'and status_conta ='#39'L'#39
      'and tp_conta ='#39'R'#39)
    Left = 32
    Top = 272
    ParamData = <
      item
        Name = 'CAIXA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 23
      end>
    object FDQReceitasID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQReceitasDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = 'DT_RECORD'
    end
    object FDQReceitasDT_PAGAMENTO: TDateField
      FieldName = 'DT_PAGAMENTO'
      Origin = 'DT_PAGAMENTO'
    end
    object FDQReceitasVLR_TOTAL: TFMTBCDField
      FieldName = 'VLR_TOTAL'
      Origin = 'VLR_TOTAL'
      Precision = 18
      Size = 2
    end
    object FDQReceitasID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
    end
    object FDQReceitasNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object FDQReceitasVLR_PAGAMENTO: TFMTBCDField
      FieldName = 'VLR_PAGAMENTO'
      Origin = 'VLR_PAGAMENTO'
      Precision = 18
      Size = 2
    end
  end
  object FDQDespesas: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_despesa'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from despesa')
    Left = 96
    Top = 136
    object FDQDespesasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object FDQDespesasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 60
    end
    object FDQDespesasDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object FDQDespesasVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 18
      Size = 2
    end
    object FDQDespesasID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
    end
    object FDQDespesasDOCUMENTO: TIntegerField
      FieldName = 'DOCUMENTO'
      Origin = 'DOCUMENTO'
    end
  end
  object FDQSumReceitas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select '
      'sum(vlr_pagamento) '
      'from conta'
      'where id_caixa = :caixa'
      'and status_conta ='#39'L'#39
      'and tp_conta ='#39'R'#39)
    Left = 96
    Top = 272
    ParamData = <
      item
        Name = 'CAIXA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 23
      end>
    object FDQSumReceitasSUM: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'SUM'
      Origin = '"SUM"'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
  object FDQDespesasCaixa: TFDQuery
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_despesa'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select '
      'c.id, '
      'c.dt_record,  '
      'c.dt_pagamento, '
      'c.vlr_total, '
      'c.id_pessoa,'
      'c.documento,'
      'c.vlr_pagamento '
      'from conta c'
      'where c.id_caixa = :caixa'
      'and status_conta ='#39'L'#39
      'and tp_conta ='#39'D'#39)
    Left = 208
    Top = 144
    ParamData = <
      item
        Name = 'CAIXA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 25
      end>
    object FDQDespesasCaixaID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object FDQDespesasCaixaDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = 'DT_RECORD'
    end
    object FDQDespesasCaixaDT_PAGAMENTO: TDateField
      FieldName = 'DT_PAGAMENTO'
      Origin = 'DT_PAGAMENTO'
    end
    object FDQDespesasCaixaVLR_TOTAL: TFMTBCDField
      FieldName = 'VLR_TOTAL'
      Origin = 'VLR_TOTAL'
      Precision = 18
      Size = 2
    end
    object FDQDespesasCaixaID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
    end
    object FDQDespesasCaixaVLR_PAGAMENTO: TFMTBCDField
      FieldName = 'VLR_PAGAMENTO'
      Origin = 'VLR_PAGAMENTO'
      Precision = 18
      Size = 2
    end
  end
  object FDQSumDespesas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select '
      'sum(vlr_pagamento) '
      'from conta'
      'where id_caixa = :caixa'
      'and status_conta ='#39'L'#39
      'and tp_conta ='#39'D'#39)
    Left = 280
    Top = 144
    ParamData = <
      item
        Name = 'CAIXA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 23
      end>
    object FDQSumDespesasSUM: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'SUM'
      Origin = '"SUM"'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
end
