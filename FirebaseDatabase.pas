unit FirebaseDatabase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Net.HttpClientComponent, System.Net.URLClient, System.Net.Mime,
  System.Threading,
  Firebase.Database,
  System.JSON,
  System.Net.HttpClient,
  System.Generics.Collections,
  System.JSON.Types,
  System.JSON.Writers,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FirebaseAuthClass,
  FMX.Layouts, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FMX.TabControl, FMX.ComboEdit, FMX.Effects, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Ani, System.Actions,
  FMX.ActnList, FMX.Filter.Effects, FMX.ListBox, FMX.MultiView, System.IOUtils, System.Math;

const FWebApiKey = 'AIzaSyCZ7YB6Z2Ov4PszvJXpkCzaCrw4kRxZ5vE';
const FEmail = 'admin@chidhome.com';
      FPass = '#EDC2wsx!QAZ';
type
  TFirebase = class(TObject)
  private
    FApiKey,FToken: string;
    FNetHttpClient: TNetHTTPClient;
    function AuthUser(ApiKey : string) : string;
  public
    SecretKey: String;
    ProjectUrl: String;
    constructor Create(const NetHttpClient: TNetHTTPClient; const ApiKey: string);
    function FormatJSON(const JSON: string) : string;
    function Delete(Database: string; Data: string) : string;
    function Put(Database, Data: string) : string;
    function Post(Database, Data: string): String;
    function Patch(Database, Data: string) : string;
    function Get(Database: string; sKey: string; sValue: string): String;
  end;

var
  Task: ITask;
  FirebaseAuth: IFirebaseAuth;
  JsonAnswer: string;

implementation

{ TFirebase }

uses
  Firebase.Auth,
  Firebase.Interfaces;

constructor TFirebase.Create(const NetHttpClient: TNetHTTPClient; const ApiKey: string);
begin
try
  FNetHttpClient := NetHttpClient;
  FApiKey := ApiKey;
  AuthUser(FApiKey);
except
	Exit;
end;
end;

function TFirebase.AuthUser(ApiKey : string) : string;
var
  FirebaseAuth: IFirebaseAuth;
  AResponse: IFirebaseResponse;
  JSONResp: TJSONValue;
  Obj: TJSONObject;
  uStat : string;
begin
uStat := 'error';
Result := uStat;
if Length(Trim(ApiKey)) = 0 then Exit;
try
  FirebaseAuth := TFirebaseAuth.Create;
  FirebaseAuth.SetApiKey(ApiKey);
 	AResponse := FirebaseAuth.SignInWithEmailAndPassword(FEmail, FPass);
  JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
  if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
      begin
          if Assigned(JSONResp) then
          begin
            JSONResp.Free;
          end;
          Exit;
      end;
      Obj := JSONResp as TJSONObject;
      Obj.Values['idToken'].Value;
      if Pos('error',Obj.Values['idToken'].Value) > 0 then uStat := 'error' else uStat := Obj.Values['idToken'].Value;
      FToken := uStat;
except
  Result := uStat;
  Exit;
end;
end;

function TFirebase.FormatJSON(const JSON: string): string;
var
  JsonObject: TJsonObject;
begin
try
  JsonObject := TJsonObject.ParseJSONValue(JSON) as TJsonObject;
  try
	Result := JsonObject.Format();
  finally
	JsonObject.Free;
  end;
except
  Result := '';
  Exit;
end;
end;

function TFirebase.Delete(Database: string; Data: string) : string;
var
  ADatabase: TFirebaseDatabase;
  AResponse: IFirebaseResponse;
  JSONResp: TJSONValue;
begin
if Length(Trim(FToken)) = 0 then Exit;
try
  ADatabase := TFirebaseDatabase.Create;
  ADatabase.SetBaseURI(ProjectUrl);
  ADatabase.SetToken(FToken);
  try
    AResponse := ADatabase.Delete([Database+'/'+Data+ '.json']);
    JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
    if JSONResp.Owned then begin
       Result := '{"STATUS":"DELETE"}';
    end else begin
      if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
      begin
        if Assigned(JSONResp) then
        begin
          JSONResp.Free;
        end;
        Exit;
      end;
      Result := JSONResp.ToString;
    end;
  finally
    ADatabase.Free;
  end;
except
  Result := '';
  Exit;
end;
end;

function TFirebase.Get(Database: string; sKey: string; sValue: string): String;
var
  ADatabase: TFirebaseDatabase;
  AResponse: IFirebaseResponse;
  AParams: TDictionary<string, string>;
  JSONResp: TJSONValue;
begin
try
  if Length(Trim(FToken)) = 0 then Exit;
  ADatabase := TFirebaseDatabase.Create;
  ADatabase.SetBaseURI(ProjectUrl);
  ADatabase.SetToken(FToken);
  AParams := TDictionary<string, string>.Create;
  try
    AParams.Add(sKey, '"'+sValue+'"');
    AResponse := ADatabase.Get([Database + '.json'], AParams);
    JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
    if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
    begin
      if Assigned(JSONResp) then
      begin
        JSONResp.Free;
      end;
      Exit;
    end;
    Result := JSONResp.ToString;
  finally
    AParams.Free;
    ADatabase.Free;
  end;
except
  Result := '';
  Exit;
end;
end;

function TFirebase.Post(Database, Data: string): String;
var
  ADatabase: TFirebaseDatabase;
  AResponse: IFirebaseResponse;
  JSONReq: TJSONObject;
  JSONResp: TJSONValue;
  Writer: TJsonTextWriter;
  StringWriter: TStringWriter;
begin
if Length(Trim(FToken)) = 0 then Exit;
try
  StringWriter := TStringWriter.Create;
  StringWriter.Write(Data);
  Writer := TJsonTextWriter.Create(StringWriter);
  Writer.Formatting := TJsonFormatting.None;
  JSONReq := TJSONObject.ParseJSONValue(StringWriter.ToString) as TJSONObject;
  ADatabase := TFirebaseDatabase.Create;
  ADatabase.SetBaseURI(ProjectUrl);
  ADatabase.SetToken(FToken);
  try
    AResponse := ADatabase.Post([Database + '.json'], JSONReq);
    JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
    if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
    begin
      if Assigned(JSONResp) then
      begin
        JSONResp.Free;
      end;
      Exit;
    end;
    Result := JSONResp.ToString;
  finally
    ADatabase.Free;
  end;
except
  Result := '';
  Exit;
end;
end;

function TFirebase.Put(Database, Data: string) : string;
var
  ADatabase: TFirebaseDatabase;
  AResponse: IFirebaseResponse;
  JSONReq: TJSONObject;
  JSONResp: TJSONValue;
  Writer: TJsonTextWriter;
  StringWriter: TStringWriter;
begin
if Length(Trim(FToken)) = 0 then Exit;
try
  StringWriter := TStringWriter.Create;
  StringWriter.Write(Data);
  Writer := TJsonTextWriter.Create(StringWriter);
  Writer.Formatting := TJsonFormatting.None;
  JSONReq := TJSONObject.ParseJSONValue(StringWriter.ToString) as TJSONObject;
  ADatabase := TFirebaseDatabase.Create;
  ADatabase.SetBaseURI(ProjectUrl);
  ADatabase.SetToken(FToken);
  try
    AResponse := ADatabase.Put([Database + '.json'], JSONReq);
    JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
    if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
    begin
      if Assigned(JSONResp) then
      begin
        JSONResp.Free;
      end;
      Exit;
    end;
    Result := JSONResp.ToString;
  finally
    ADatabase.Free;
  end;
except
  Result := '';
  Exit;
end;
end;

function TFirebase.Patch(Database, Data: string) : string;
var
  ADatabase: TFirebaseDatabase;
  AResponse: IFirebaseResponse;
  JSONReq: TJSONObject;
  JSONResp: TJSONValue;
  Writer: TJsonTextWriter;
  StringWriter: TStringWriter;
begin
if Length(Trim(FToken)) = 0 then Exit;
try
  StringWriter := TStringWriter.Create;
  StringWriter.Write(Data);
  Writer := TJsonTextWriter.Create(StringWriter);
  Writer.Formatting := TJsonFormatting.None;
  JSONReq := TJSONObject.ParseJSONValue(StringWriter.ToString) as TJSONObject;
  ADatabase := TFirebaseDatabase.Create;
  ADatabase.SetBaseURI(ProjectUrl);
  ADatabase.SetToken(FToken);
  try
    AResponse := ADatabase.Patch([Database + '.json'], JSONReq);
    JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
    if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
    begin
      if Assigned(JSONResp) then
      begin
        JSONResp.Free;
      end;
      Exit;
    end;
    Result := JSONResp.ToString;
  finally
    ADatabase.Free;
  end;
except
  Result := '';
  Exit;
end;
end;


end.
