unit uFrameTranslate;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.PushNotification, System.Notification, REST.Json,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Edit, UI.Base, UI.Standard, UI.Frame, FMX.Memo.Types, System.JSON, System.Math,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts, System.ImageList, DW.TextToSpeech,
  FMX.ImgList, FMX.Objects, System.Actions, FMX.ActnList;
type
  TTranslateEvent = procedure (AView: TFrame; ASource, ATarget: string) of object;
  TFrameTranslateView = class(TFrame)
    LinearLayout1: TLinearLayout;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    EditView1: TEditView;
    TextView1: TTextView;
    TextView2: TTextView;
    lSource: TLabel;
    mmo_src: TMemo;
    lTrans: TLabel;
    mmo_trg: TMemo;
    uTrans: TButton;
    FrameContainer: TLayout;
    btnupd: TButton;
    img: TImageList;
    btnClear: TButton;
    chkInsertBases: TCheckBox;
    AniIndicator1: TAniIndicator;
    btnSpeak: TCornerButton;
    pthSpk: TPath;
    ActionList1: TActionList;
    actSpeak: TAction;
    procedure FrameResize(Sender: TObject);
    procedure uTransClick(Sender: TObject);
    procedure EditView1Click(Sender: TObject);
    procedure btnupdClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure actSpeakExecute(Sender: TObject);
  private
    { Private declarations }
    FSpeaker: TTextToSpeech;
    FSelectedLanguage: string;
  //  FSelectedVoice: string;
    FOnTranslate: TTranslateEvent;
    procedure InsertBases(str: string; settings: string);
    function GetTxt(obj: string; idx: Integer): string;
    function GetTxtGoto(obj: string; idx: Integer): string;
    function EstRus(txt: string) : string;
    function RusEst(txt: string) : string;
    function EstUkr(txt: string) : string;
    function UkrEst(txt: string) : string;
    procedure SpeakText(const Text: string);
    procedure SpeakerCheckDataCompleteHandler(Sender: TObject);
    procedure SpeakerSpeechStartedHandler(Sender: TObject);
    procedure SpeakerSpeechFinishedHandler(Sender: TObject);
  public
    { Public declarations }
    uApiTartu: Boolean;
    uLangs: string; uStr1,uStr2: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnTranslate: TTranslateEvent read FOnTranslate write FOnTranslate;
  end;
implementation
{$R *.fmx}
uses
  uDM, uMyDB, UI.Dialog;

constructor TFrameTranslateView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  try
    FSpeaker := TTextToSpeech.Create;
    if Assigned(FSpeaker) then
    begin
      FSpeaker.OnSpeechStarted := SpeakerSpeechStartedHandler;
      FSpeaker.OnSpeechFinished := SpeakerSpeechFinishedHandler;
      FSpeaker.OnCheckDataComplete := SpeakerCheckDataCompleteHandler;
     // FSpeaker.CheckData; // Запуск асинхронной проверки данных
      // Начальные значения для языка
      FSelectedLanguage := 'et'; // Установите значение по умолчанию
      FSpeaker.Language := FSelectedLanguage;
      FSpeaker.SetLanguage(FSelectedLanguage);
    end
    else
      lTrans.Text := 'Failed to create TTextToSpeech instance';
  except
    on E: Exception do
      lTrans.Text := 'Error initializing TTextToSpeech: ' + E.Message;
  end;
end;

destructor TFrameTranslateView.Destroy;
begin
try
  FSpeaker.Free;
  inherited;
except
  Exit;
end
end;

procedure TFrameTranslateView.SpeakerCheckDataCompleteHandler(Sender: TObject);
begin
try
  if Assigned(Sender) then
     lTrans.Text := 'Text-to-speech data is available'
  else
     lTrans.Text := 'Text-to-speech data is not available';
except
  //
end;
end;


procedure TFrameTranslateView.SpeakerSpeechFinishedHandler(Sender: TObject);
begin
try
  //
except
  //
end;
end;

procedure TFrameTranslateView.SpeakerSpeechStartedHandler(Sender: TObject);
begin
try
  //
except
  //
end;
end;

procedure TFrameTranslateView.SpeakText(const Text: string);
begin
try
  if FSpeaker.IsSpeaking then
    FSpeaker.Stop;
  FSpeaker.Speak(Text);
except
  Exit;
end;
end;

function TFrameTranslateView.GetTxtGoto(obj: string; idx: Integer): string;
var jOb : string; str : string; myObj : TJSONObject;
begin
try
  if (idx = 0) then jOb := '{"text": "'+obj+'","tgt": "est", "src": "rus" }'; //RusEst
  try
     RESTClient1.BaseURL := 'https://api.tartunlp.ai/translation/v2';
     RESTClient1.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClient1.ContentType := 'application/json; charset=UTF-8';
     RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
     RESTRequest1.ClearBody;
     RESTRequest1.Params.Clear;
     RESTRequest1.Body.Add(jOb,REST.Types.ctAPPLICATION_JSON);
  except
     Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
     Exit;
  end;
  try
   RESTRequest1.Execute;
  except
   on E: ERESTException do begin
      Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
      Exit;
   end;
  end;
  try
  if RESTResponse1.StatusCode in [0,200] then begin
     str := RESTResponse1.Content;
     myObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
     Result := myObj.GetValue('result').Value;
  end else Exit;
  except
   on E: ERESTException do begin
      Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
      Exit;
   end;
  end;
except
   on E: ERESTException do begin
      Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
      Exit; //E.Message;
   end;
end;
end;

function TFrameTranslateView.RusEst(txt: string) : string;
var
 RestClient   : TRESTClient;
 RestResponse : TRESTResponse;
 RestRequest  : TRESTRequest;
 strResult,js : string;
 str          : string;
 jso          : TJSONValue;
begin
try
  Result := '';
  try
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=ru&tl=et&hl=et&dt=t&dt=bd&dj=1&source=icon&tk=967755.967755&q="'+txt+'"';
    RestRequest.Client   := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Execute;
    strResult := RestResponse.Content;
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult), 0);
    js  := TJson.Format(jso);
    if not (jso is TJSONObject) then Exit;
    try
      if jso is TJSONObject then
         strResult:=jso.GetValue<string>('sentences[0].trans');
         strResult:=StringReplace(strResult,'"','',[]);
         strResult:=StringReplace(strResult,'«','',[]);
         strResult:=StringReplace(strResult,'»','',[]);
         Result := StringReplace(strResult,'"','',[]);
    finally
         jso.Free;
    end;
  finally
    RestClient.Free;
    RestResponse.Free;
    RestRequest.Free;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Data';
         str := str +#13#10+E.Message;
         Result := ''; Exit;
   end;
end;
end;

function TFrameTranslateView.EstRus(txt: string) : string;
var
 RestClient   : TRESTClient;
 RestResponse : TRESTResponse;
 RestRequest  : TRESTRequest;
 strResult,js : string;
 str          : string;
 jso          : TJSONValue;
begin
try
  Result := '';
  try
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=et&tl=ru&hl=ru&dt=t&dt=bd&dj=1&source=icon&tk=918264.918264&q="'+txt+'"';
    RestRequest.Client   := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Execute;
    strResult := RestResponse.Content;
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult), 0);
    js  := TJson.Format(jso);
    if not (jso is TJSONObject) then Exit;
    try
      if jso is TJSONObject then
         strResult:=jso.GetValue<string>('sentences[0].trans');
         strResult:=StringReplace(strResult,'"','',[]);
         strResult:=StringReplace(strResult,'«','',[]);
         strResult:=StringReplace(strResult,'»','',[]);
         Result := StringReplace(strResult,'"','',[]);
    finally
         jso.Free;
    end;
  finally
    RestClient.Free;
    RestResponse.Free;
    RestRequest.Free;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Data';
         str := str +#13#10+E.Message;
         Result := ''; Exit;
   end;
end;
end;

function TFrameTranslateView.UkrEst(txt: string) : string;
var
 RestClient   : TRESTClient;
 RestResponse : TRESTResponse;
 RestRequest  : TRESTRequest;
 strResult,js : string;
 str          : string;
 jso          : TJSONValue;
begin
try
  Result := '';
  try
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=uk&tl=et&hl=et&dt=t&dt=bd&dj=1&source=icon&tk=967755.967755&q="'+txt+'"';
    RestRequest.Client   := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Execute;
    strResult := RestResponse.Content;
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult), 0);
    js  := TJson.Format(jso);
    if not (jso is TJSONObject) then Exit;
    try
      if jso is TJSONObject then
         strResult:=jso.GetValue<string>('sentences[0].trans');
         strResult:=StringReplace(strResult,'"','',[]);
         strResult:=StringReplace(strResult,'«','',[]);
         strResult:=StringReplace(strResult,'»','',[]);
         Result := StringReplace(strResult,'"','',[]);
    finally
         jso.Free;
    end;
  finally
    RestClient.Free;
    RestResponse.Free;
    RestRequest.Free;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Data';
         str := str +#13#10+E.Message;
         Result := ''; Exit;
   end;
end;
end;

function TFrameTranslateView.EstUkr(txt: string) : string;
var
 RestClient   : TRESTClient;
 RestResponse : TRESTResponse;
 RestRequest  : TRESTRequest;
 strResult,js : string;
 str          : string;
 jso          : TJSONValue;
begin
try
  Result := '';
  try
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=et&tl=uk&hl=uk&dt=t&dt=bd&dj=1&source=icon&tk=918264.918264&q="'+txt+'"';
    RestRequest.Client   := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Execute;
    strResult := RestResponse.Content;
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult), 0);
    js  := TJson.Format(jso);
    if not (jso is TJSONObject) then Exit;
    try
      if jso is TJSONObject then
         strResult:=jso.GetValue<string>('sentences[0].trans');
         strResult:=StringReplace(strResult,'"','',[]);
         strResult:=StringReplace(strResult,'«','',[]);
         strResult:=StringReplace(strResult,'»','',[]);
         Result := StringReplace(strResult,'"','',[]);
    finally
         jso.Free;
    end;
  finally
    RestClient.Free;
    RestResponse.Free;
    RestRequest.Free;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Data';
         str := str +#13#10+E.Message;
         Result := ''; Exit;
   end;
end;
end;

function TFrameTranslateView.GetTxt(obj: string; idx: Integer): string;
var jOb : string; str : string; myObj : TJSONObject;
begin
try
  if not uApiTartu then begin
    if (idx = 0) then Result := RusEst(obj);
    if (idx = 1) then Result := EstRus(obj);
    if (idx = 2) then Result := UkrEst(obj);
    if (idx = 3) then Result := EstUkr(obj);
    if (idx = 4) then Result := RusEst(EstRus(obj));
  end else begin
    if ((idx = 0)and(EditView1.Tag = idx)) then jOb := '{"text": "'+obj+'","tgt": "est", "src": "rus" }'; //RusEst
    if ((idx = 1)and(EditView1.Tag = idx)) then jOb := '{"text": "'+obj+'","tgt": "rus", "src": "est" }'; //EstRus
    if ((idx = 2)and(EditView1.Tag = idx)) then jOb := '{"text": "'+obj+'","tgt": "est", "src": "ukr" }'; //UkrEst
    if ((idx = 3)and(EditView1.Tag = idx)) then jOb := '{"text": "'+obj+'","tgt": "ukr", "src": "est" }'; //EstUkr
    if ((idx = 4)and(EditView1.Tag = idx)) then jOb := '{"text": "'+obj+'","tgt": "rus", "src": "est" }'; //EstEst
    try
       RESTClient1.BaseURL := 'https://api.tartunlp.ai/translation/v2';
       RESTClient1.AcceptCharset := 'utf-8, *;q=0.8';
       RESTClient1.ContentType := 'application/json; charset=UTF-8';
       RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
       RESTRequest1.ClearBody;
       RESTRequest1.Params.Clear;
       RESTRequest1.Body.Add(jOb,REST.Types.ctAPPLICATION_JSON);
       try
         RESTRequest1.Execute;
       except
         on E: ERESTException do begin
            Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
            Exit;
         end;
       end;
       try
        if RESTResponse1.StatusCode in [0,200,201] then begin
           str := RESTResponse1.Content;
           myObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
           Result := myObj.GetValue('result').Value; //FormatJSON(str);
        end else Exit;
       except
         on E: ERESTException do begin
            Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
            Exit;
         end;
       end;
    except
       Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
       Exit;
    end;
  end;
except
  on E: ERESTException do begin
     Result := 'Ma ei saa sinust aru, väljenda oma mõtteid teisiti!';
     Exit;
  end;
end;
end;
function RemoveNonPrintableChars(const S: string): string;
var
  i: Integer;
begin
try
  Result := '';
  for i := 1 to Length(S) do
  begin
    if Ord(S[i]) > 31 then
      Result := Result + S[i];
  end;
except
   Result := '';
   Exit;
end;
end;
function IsOrderIdExists(const OrderId: string): Boolean;
begin
try
  Result := False;
  // Проверяем существование OrderId в базе данных
  with uDMForm do begin
       fConnect.Open;
       fQuery.SQL.Clear;
       fQuery.SQL.Text := 'SELECT COUNT(*) FROM t_jso_Notes WHERE orderid = :OrderId';
       fQuery.ParamByName('OrderId').AsString := OrderId;
       fQuery.Open;
       try
        Result := fQuery.Fields[0].AsInteger > 0; // Если количество записей > 0, значит OrderId уже существует
       finally
        fQuery.Close;
       end;
  end;
except
  on E: Exception do begin
     ShowMessage('Error IsOrderId ! '+#13#10+E.Message);
     Result := False;
     Exit;
  end;
end;
end;
function GenerateUniqueOrderId(length: Integer): string;
var i: Integer;
begin
try
  Result := '';
  repeat
    Result := '';
    // Генерируем случайные цифры для формирования уникального номера
    for i := 1 to length do
        Result := Result + IntToStr(RandomRange(0, 10)); // Генерируем случайные цифры от 0 до 9
  until not IsOrderIdExists(Result); // Проверяем, что сгенерированный OrderId уникален
except
  on E: Exception do begin
     ShowMessage('Error GenerateUniqueOrderId ! '+#13#10+E.Message);
     Result := '';
     Exit;
  end;
end;
end;
procedure TFrameTranslateView.InsertBases(str: string; settings: string);
var
  UniqueOrderId: Integer;
begin
try
  // Генерируем уникальный номер из 7 цифр
  UniqueOrderId := StrToInt(GenerateUniqueOrderId(7));
  try
  with uDMForm do begin
       fConnect.Open;
       fQuery.SQL.Clear;
       fQuery.SQL.Text := 'insert into t_jso_Notes(OrderID, Translate, SettingText) VALUES (:OrderID, :Translate, :SettingText)';
       fQuery.ParamByName('OrderID').AsInteger := UniqueOrderId;
       fQuery.ParamByName('Translate').AsString := Trim(str);
       fQuery.ParamByName('SettingText').AsString := settings;
       fQuery.ExecSQL;
  end;
  except
    lTrans.Text := 'Error insert to Bases';
    Exit;
  end;
except
  on E: Exception do begin
     lTrans.Text := 'Error insert ! '+#13#10+E.Message;
     Exit;
  end;
end;
end;
procedure TFrameTranslateView.uTransClick(Sender: TObject);
var CleanText, str,jOb,tmp: string; myDate : TDateTime;
begin
try
  if mmo_src.Lines.Text = '' then begin
    Hint('Enter text to translate');
    Exit;
  end;
  if EditView1.Tag < 0 then begin
    Hint('Select language for translation');
    Exit;
  end;
  if Length(Trim(mmo_src.Text)) = 0 then Exit;
     mmo_src.Text := Trim(mmo_src.Text);
     mmo_src.Text := StringReplace(mmo_src.Text, #13#10, '', [rfReplaceAll]);
     CleanText := RemoveNonPrintableChars(mmo_src.Text);
     mmo_src.Text := CleanText;
     mmo_trg.Lines.Text := GetTxt(mmo_src.Lines.Text,EditView1.Tag);
     if ((Length(Trim(mmo_src.Text)) > 0)and(Length(Trim(mmo_trg.Text)) > 0)) then begin
         str := #13#10+'Source:'+#13#10+mmo_src.Text+#13#10+'Translation:'+#13#10+mmo_trg.Text;
         myDate := Now;
       if chkInsertBases.IsChecked then InsertBases('['+FormatDateTime('dd/mm/yyyy hh:nn:ss', myDate)+'] {'+str+#13#10+'}','EE');
     end;
except
   on E: Exception do begin
      Exit;
   end;
end;
end;
procedure TFrameTranslateView.actSpeakExecute(Sender: TObject);
begin
if Length(Trim(mmo_src.Text)) = 0 then Exit;
try
   SpeakText(mmo_src.Text);
except
  on E: Exception do begin
     lTrans.Text := 'Error SpeakText '+#13#10+E.Message;
     Exit;
  end;
end;
end;

procedure TFrameTranslateView.btnClearClick(Sender: TObject);
begin
try
  mmo_src.Text := '';
  mmo_trg.Text := '';
  mmo_src.SetFocus;
except
  Exit;
end;
end;

procedure TFrameTranslateView.btnupdClick(Sender: TObject);
begin
try
  uStr1 := mmo_src.Text;
  uStr2 := mmo_trg.Text;
  mmo_src.Text := uStr2;
  mmo_trg.Text := uStr1;
  mmo_src.SetFocus;
except
  Exit;
end;
end;

procedure TFrameTranslateView.EditView1Click(Sender: TObject);
begin
try //RusEst - 0, EstRus - 1, UkrEst - 2, EstUkr - 3, EstEst - 4
  TDialogBuilder.Create(Self)
      .SetSingleChoiceItems(['From Russian to Estonian', 'From Estonian to Russian', 'From Ukrainian to Estonian', 'From Estonian to Ukrainian', 'How do you say this in Estonian?'], EditView1.Tag,
        procedure (Dialog: IDialog; Which: Integer)
        begin
          EditView1.Tag := Dialog.Builder.CheckedItem;
          EditView1.Text := Dialog.Builder.ItemArray[Dialog.Builder.CheckedItem];
          uLangs := Dialog.Builder.ItemArray[Dialog.Builder.CheckedItem];
          Dialog.AsyncDismiss;
        end
      )
      .SetDownPopup(EditView1, 0, 0, TLayoutGravity.LeftBottom)
      .SetListItemDefaultHeight(34)
      .Show;
except
  Exit;
end;
end;

procedure TFrameTranslateView.FrameResize(Sender: TObject);
begin
  Height := LinearLayout1.Height;
end;

end.
