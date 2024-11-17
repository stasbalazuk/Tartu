unit FirebaseAuthClass;
 
interface 
 
uses 
  System.SysUtils, System.Types, System.UITypes, System.Classes, 
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, 
  FMX.Controls.Presentation, System.Net.URLClient, System.Net.HttpClient, 
  System.Net.HttpClientComponent, JSON, System.Threading, 
  System.Net.Mime, System.Generics.Collections; 
 
type 
  IFirebaseAuth = interface 
	function SignUpWithEmailAndPassword(const Email, Password: string): string; 
	function SignInWithEmailAndPassword(const Email, Password: string): string; 
	function ResetPassword(const Email: string): string;
  end;
 
  TFirebaseAuth = class(TInterfacedObject, IFirebaseAuth) 
  private 
	FNetHttpClient: TNetHTTPClient; 
	FApiKey: string; 
	function FormatJSON(const JSON: string): string;
  public 
	constructor Create(const NetHttpClient: TNetHTTPClient; const ApiKey: string); 
	function SignUpWithEmailAndPassword(const Email, Password: string): string; 
	function SignInWithEmailAndPassword(const Email, Password: string): string; 
	function ResetPassword(const Email: string): string;
	class function ParseJsonForResult(const JsonAnswer: string): string;
  end; 
 
implementation 
 
{ TFirebaseAuth }

uses uTartu;
 
constructor TFirebaseAuth.Create(const NetHttpClient: TNetHTTPClient; const ApiKey: string); 
begin 
  FNetHttpClient := NetHttpClient; 
  if ApiKey <> '' then 
	FApiKey := ApiKey 
  else 
  begin 
	ShowMessage('Web API key is empty!'); 
	Exit; 
  end; 
end;

function TFirebaseAuth.FormatJSON(const JSON: string): string;
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
  FormMain.mLog.Lines.Text := 'Error Parse JSON Value !';
end;
end;
 
class function TFirebaseAuth.ParseJsonForResult(const JsonAnswer: string): string;
var 
  JsonObject: TJsonObject; 
  Key: string; 
  JsonResponse: TJsonValue; 
  ObjectNum: Integer; 
begin
try
  JsonResponse := TJsonObject.ParseJSONValue(JsonAnswer); 
  try 
	JsonObject := JsonResponse as TJsonObject; 
	for ObjectNum := 0 to JsonObject.Count-1 do
	begin 
  	Key := JsonObject.Pairs[ObjectNum].JsonString.Value; 
  	if Key = 'error' then 
    	Result := Key 
  	else if Key = 'email' then 
    	Result := Key; 
	end; 
  finally 
	JsonResponse.Free; 
  end;
except
  FormMain.mLog.Lines.Text := 'Error Parse JSON Result !';
end;
end;

function TFirebaseAuth.ResetPassword(const Email: string): string;
var 
  JsonObject: TJsonObject; 
  Header: TNameValuePair; 
  MultipartFormData: TMultipartFormData; 
  Stream, ResponseContent: TStringStream; 
begin
try
  Stream := nil; 
  ResponseContent := nil; 
  MultipartFormData := nil; 
  JsonObject := nil; 
  try 
	JsonObject := TJsonObject.Create; 
	JsonObject.AddPair('requestType', 'PASSWORD_RESET'); 
	JsonObject.AddPair('email', Email); 
	JsonObject.AddPair('returnSecureToken', 'true'); 
	Header := TNameValuePair.Create('Content-Type', 'application/json'); 
	MultipartFormData := TMultipartFormData.Create; 
	Stream := TStringStream.Create(FormatJSON(JsonObject.ToJSON), TEncoding.UTF8); 
	MultipartFormData.Stream.LoadFromStream(Stream); 
	ResponseContent := TStringStream.Create; 
	FNetHttpClient.Post('https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=' + 
  	FApiKey, MultipartFormData, ResponseContent, [Header]); 
	Result := ResponseContent.DataString; 
  finally 
	Stream.Free; 
	ResponseContent.Free; 
	MultipartFormData.Free;
	JsonObject.Free; 
  end;
except
  FormMain.mLog.Lines.Text := 'Error Reset Password !';
end;
end; 
 
function TFirebaseAuth.SignInWithEmailAndPassword(const Email, Password: string): string;
var 
  JsonObject: TJsonObject; 
  Header: TNameValuePair; 
  MultipartFormData: TMultipartFormData; 
  Stream, ResponseContent: TStringStream; 
begin
try
  Stream := nil;
  ResponseContent := nil; 
  MultipartFormData := nil; 
  JsonObject := nil; 
  try 
	JsonObject := TJsonObject.Create; 
	JsonObject.AddPair('email', Email); 
	JsonObject.AddPair('password', Password); 
	JsonObject.AddPair('returnSecureToken', 'true'); 
	Header := TNameValuePair.Create('Content-Type', 'application/json'); 
	MultipartFormData := TMultipartFormData.Create; 
	Stream := TStringStream.Create(FormatJSON(JsonObject.ToJSON), TEncoding.UTF8); 
	MultipartFormData.Stream.LoadFromStream(Stream); 
	ResponseContent := TStringStream.Create; 
	FNetHttpClient.Post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=' + FApiKey, 
  	MultipartFormData, ResponseContent, [Header]); 
	Result := FormatJSON(ResponseContent.DataString); 
  finally 
	Stream.Free; 
	ResponseContent.Free; 
	MultipartFormData.Free; 
	JsonObject.Free; 
  end;
except
  FormMain.mLog.Lines.Text := 'Error SignIn With Email And Password !';
end;
end; 
 
function TFirebaseAuth.SignUpWithEmailAndPassword(const Email, Password: string): string;
var 
  JsonObject: TJsonObject; 
  Header: TNameValuePair; 
  MultipartFormData: TMultipartFormData; 
  Stream, ResponseContent: TStringStream; 
begin
try
  Stream := nil; 
  ResponseContent := nil; 
  MultipartFormData := nil; 
  JsonObject := nil; 
  try 
	JsonObject := TJsonObject.Create; 
	JsonObject.AddPair('email', Email); 
	JsonObject.AddPair('password', Password); 
	JsonObject.AddPair('returnSecureToken', 'true'); 
	Header := TNameValuePair.Create('Content-Type', 'application/json'); 
	MultipartFormData := TMultipartFormData.Create; 
	Stream := TStringStream.Create(FormatJSON(JsonObject.ToJSON), TEncoding.UTF8); 
	MultipartFormData.Stream.LoadFromStream(Stream); 
	ResponseContent := TStringStream.Create; 
	FNetHttpClient.Post('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=' + FApiKey, 
  	MultipartFormData, ResponseContent, [Header]); 
	Result := ResponseContent.DataString; 
  finally 
	Stream.Free; 
	ResponseContent.Free; 
	MultipartFormData.Free; 
	JsonObject.Free; 
  end;
except
  FormMain.mLog.Lines.Text := 'Error SignUp With Email And Password !';
end;
end; 
 
end.