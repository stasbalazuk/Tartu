object uDMForm: TuDMForm
  OnCreate = fConnectBeforeConnect
  OnDestroy = fConnectBeforeConnect
  Height = 317
  Width = 229
  object fConnect: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=D:\Programming\Delphi\2024\MyProject\masintolge.ut.ee\a' +
        'ssets\databases\notes.s3db')
    Connected = True
    LoginPrompt = False
    BeforeConnect = fConnectBeforeConnect
    Left = 96
    Top = 16
  end
  object fQuery: TFDQuery
    Connection = fConnect
    SQL.Strings = (
      '')
    Left = 96
    Top = 72
  end
  object FDSQLiteBackup1: TFDSQLiteBackup
    DriverLink = FDPhysSQLiteDriverLink1
    Catalog = 'MAIN'
    DestCatalog = 'MAIN'
    Left = 96
    Top = 136
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 96
    Top = 192
  end
  object FDSQLiteSecurity1: TFDSQLiteSecurity
    DriverLink = FDPhysSQLiteDriverLink1
    Left = 96
    Top = 248
  end
end
