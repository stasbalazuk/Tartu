unit uMyDB;

interface

uses
  System.SysUtils, System.IOUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IBDef, FireDAC.Phys.IBBase, FireDAC.Phys.IB;

type
  TuDMForm = class(TDataModule)
    fConnect: TFDConnection;
    fQuery: TFDQuery;
    FDSQLiteBackup1: TFDSQLiteBackup;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDSQLiteSecurity1: TFDSQLiteSecurity;
    procedure fConnectBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uDMForm: TuDMForm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TuDMForm.fConnectBeforeConnect(Sender: TObject);
begin
try
{$IFDEF ANDROID}
  fConnect.Params.Values['Database'] := TPath.GetDocumentsPath + PathDelim + 't.s3db';
  FDSQLiteBackup1.Database := TPath.GetDocumentsPath + PathDelim + 't.s3db';
  FDSQLiteBackup1.DriverLink := FDPhysSQLiteDriverLink1;
{$ENDIF}
except
  Exit;
end;
end;

end.
