unit BFA.Func;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, System.Generics.Collections, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.Json, System.NetEncoding, Data.DBXJsonCommon,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FMX.ListView.Types,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.Objects, System.IniFiles, System.IOUtils, FMX.Grid.Style, FMX.Grid, REST.Json,
  IdCoder, IdCoderMIME, IdCoder3to4;

procedure fnCreateDir;
function fnGetLoc : String;
function fnLoadFile(AFileName : String) : String;
procedure fnLog(FMessage : String); overload;
procedure fnLog(FKey, FMessage : String); overload;
procedure SaveSettingString(Section, Name, Value: string);
function LoadSettingString(Section, Name, Value: string): string;

procedure fnDownloadFile(FURL, ASaveFile : String);
procedure fnDecode(FData : String; FSaveFile : String);
procedure fnDecodeBase64(FData : String; FSaveFile : String);
implementation
procedure fnCreateDir;
begin
  {$IF DEFINED(MSWINDOWS)}
    if not DirectoryExists(ExpandFileName(GetCurrentDir) + PathDelim + 'assets') then
      CreateDir(ExpandFileName(GetCurrentDir) + PathDelim + 'assets');
    if not DirectoryExists(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'image') then
      CreateDir(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'image');
    if not DirectoryExists(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'doc') then
      CreateDir(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'doc');
    if not DirectoryExists(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'video') then
      CreateDir(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'video');
    if not DirectoryExists(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'music') then
      CreateDir(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'music');
    if not DirectoryExists(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'other') then
      CreateDir(ExpandFileName(GetCurrentDir) + PathDelim + 'assets' + PathDelim + 'other');
  {$ENDIF}
end;
function fnGetLoc : String;
begin
  fnCreateDir;
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    Result := TPath.GetDocumentsPath + PathDelim;
  {$ELSEIF DEFINED(MSWINDOWS)}
    Result := ExpandFileName(GetCurrentDir) + PathDelim;
  {$ENDIF}
end;
function fnLoadFile(AFileName : String) : String;
var
  ext : String;
begin
  ext := LowerCase(ExtractFileExt(AFileName));
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    Result := fnGetLoc + AFileName;
  {$ELSEIF DEFINED(MSWINDOWS)}
    if (ext = '.jpg') or (ext = '.jpeg') or (ext = '.png') or (ext = '.bmp') then
      Result := fnGetLoc + 'assets' + PathDelim + 'image' + PathDelim + AFileName
    else if (ext = '.doc') or (ext = '.pdf') or (ext = '.csv') or (ext = '.txt') or (ext = '.xls') then
      Result := fnGetLoc + 'assets' + PathDelim + 'doc' + PathDelim + AFileName
    else if (ext = '.mp4') or (ext = '.avi') or (ext = '.wmv') or (ext = '.flv') or (ext = '.mov') or (ext = '.mkv') or (ext = '.3gp') then
      Result := fnGetLoc + 'assets' + PathDelim + 'video' + PathDelim + AFileName
    else if (ext = '.mp3') or (ext = '.wav') or (ext = '.wma') or (ext = '.aac') or (ext = '.flac') or (ext = '.m4a') then
      Result := fnGetLoc + 'assets' + PathDelim + 'music' + PathDelim + AFileName
    else
      Result := fnGetLoc + 'assets' + PathDelim + 'other' + PathDelim + AFileName
  {$ENDIF}
end;
procedure fnLog(FMessage : String);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(fnGetLoc + 'log.ini');
  try
    ini.WriteString('Log', FormatDateTime('yyyy-mm-dd hh:nn:ss:zz', Now) + ' ', ' ' + FMessage);
  finally
    ini.DisposeOf;
  end;
end;
procedure fnLog(FKey, FMessage : String);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(fnGetLoc + 'log.ini');
  try
    ini.WriteString('Log', FormatDateTime('yyyy-mm-dd hh:nn:ss:zz', Now) + ' ', ' [' + FKey + '] - ' + FMessage);
  finally
    ini.DisposeOf;
  end;
end;
procedure fnDownloadFile(FURL, ASaveFile : String);
var
  HTTP : TNetHTTPClient;
  Stream : TMemoryStream;
begin
  HTTP := TNetHTTPClient.Create(nil);
  try
    Stream := TMemoryStream.Create;
    try
      HTTP.Get(FURL, Stream);
      Stream.SaveToFile(fnLoadFile(ASaveFile));
    finally
      Stream.DisposeOf;
    end;
  finally
    HTTP.DisposeOf;
  end;
end;
function LoadSettingString(Section, Name, Value: string): string;
var
  ini: TIniFile;
begin
  {$IF DEFINED (ANDROID)}
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim + 'config.ini');
  {$ELSEIF DEFINED (MSWINDOWS)}
  if not DirectoryExists(TPath.GetPublicPath + PathDelim + 'BFA') then
    CreateDir(TPath.GetPublicPath + PathDelim + 'BFA');
  ini := TIniFile.Create(TPath.GetPublicPath + PathDelim + 'BFA' + PathDelim + 'config.ini');
  {$ENDIF}
  try
    Result := ini.ReadString(Section, Name, Value);
  finally
    ini.DisposeOf;
  end;
end;
procedure SaveSettingString(Section, Name, Value: string);
var
  ini: TIniFile;
begin
  {$IF DEFINED (ANDROID)}
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim + 'config.ini');
  {$ELSEIF DEFINED (MSWINDOWS)}
  if not DirectoryExists(TPath.GetPublicPath + PathDelim + 'BFA') then
    CreateDir(TPath.GetPublicPath + PathDelim + 'BFA');
  ini := TIniFile.Create(TPath.GetPublicPath + PathDelim + 'BFA' + PathDelim + 'config.ini');
  {$ENDIF}
  try
    ini.WriteString(Section, Name, Value);
  finally
    ini.DisposeOf;
  end;
end;
procedure fnDecode(FData : String; FSaveFile : String);
var
  memStream : TMemoryStream;
  jsonArray : TJSONArray;
  decode : String;
begin
try
  memStream := TMemoryStream.Create;
   decode := TNetEncoding.Base64.Decode(FData);
  jsonArray := TJSONObject.ParseJSONValue(decode) as TJSONArray;
  try
    memStream.LoadFromStream(TDBXJSONTools.JSONToStream(jsonArray));
    memStream.SaveToFile(FSaveFile);
  finally
    memStream.DisposeOf;
    jsonArray.DisposeOf;
  end;
except
   {if memStream <> nil then memStream := nil;
   if jsonArray <> nil then jsonArray := nil;} Exit;
end;
end;

procedure fnDecodeBase64(FData : String; FSaveFile : String);
begin
  var memStream := TMemoryStream.Create;
  try
    TIdDecoderMIME.DecodeStream(FData, memStream);
    memStream.Position := 0;
    memStream.SaveToFile(FSaveFile);
  finally
    memStream.DisposeOf;
  end;
end;
end.
