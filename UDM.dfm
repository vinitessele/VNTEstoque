object DM: TDM
  OldCreateOrder = False
  Height = 402
  Width = 620
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\vinic\Documents\Embarcadero\Studio\Projects\VN' +
        'TEstoque\Banco\BANCO.FDB'
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
    Active = True
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
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
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
    Active = True
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
    Active = True
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
end
