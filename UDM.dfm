object DM: TDM
  OldCreateOrder = False
  Height = 402
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
    Top = 264
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
    Active = True
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'gen_venda'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from venda')
    Left = 32
    Top = 312
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
    Top = 312
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
    Top = 344
  end
  object dsVenda: TDataSource
    DataSet = FDQVenda
    Left = 72
    Top = 344
  end
  object FDQTpagamento: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select *from tipo_pagamento')
    Left = 192
    Top = 216
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
end
