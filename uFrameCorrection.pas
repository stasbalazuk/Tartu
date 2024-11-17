unit uFrameCorrection;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.NetEncoding,
  System.PushNotification, System.Notification, REST.Json, System.StrUtils,
  System.Threading, System.Math, HtmlParserEx, System.RegularExpressions, System.Generics.Collections,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Edit, UI.Base, UI.Standard, UI.Frame, FMX.Memo.Types, System.JSON,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client, FMX.DialogService,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts, System.ImageList, DW.TextToSpeech,
  FMX.ImgList, FMX.Objects, System.Actions, FMX.Colors, FMX.SVGIconImage, FMX.ActnList,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

const uRLs = '@STR';
const uRLWords = '@WORDS';

type
  TCorrectionEvent = procedure (AView: TFrame; ASource, ATarget: string) of object;
  TFrameCorrectionView = class(TFrame)
    LinearLayout1: TLinearLayout;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    FrameContainer: TLayout;
    ActionList1: TActionList;
    actSpeak: TAction;
    lbword: TLabel;
    EditView1: TEditView;
    lbword1: TLabel;
    mmo1word: TMemo;
    lbword2: TLabel;
    mmo2word: TMemo;
    lbExample: TLabel;
    mmo3word: TMemo;
    mmo4word: TMemo;
    actCorrect: TAction;
    actUpdate: TAction;
    actClean: TAction;
    Layout1: TLayout;
    uTrans: TButton;
    btnupd: TButton;
    btnClear: TButton;
    NetHTTPRequest1: TNetHTTPRequest;
    NetHTTPClient1: TNetHTTPClient;
    SVGIconImage1: TSVGIconImage;
    AniIndicator1: TAniIndicator;
    procedure FrameResize(Sender: TObject);
    procedure EditView1Click(Sender: TObject);
    procedure actSpeakExecute(Sender: TObject);
    procedure actCorrectExecute(Sender: TObject);
    procedure actUpdateExecute(Sender: TObject);
    procedure actCleanExecute(Sender: TObject);
  private
    { Private declarations }
    uRLSVG: string;
    sWord: Boolean;
    FSpeaker: TTextToSpeech;
    FSelectedLanguage: string;
    FOnTranslate: TCorrectionEvent;
    procedure UpdateData;
    function GetTxt(obj: string; idx: Integer): string;
    function GetTxtGoto(obj: string; idx: Integer): string;
    function EstRus(txt: string) : string;
    function RusEst(txt: string) : string;
    function EstUkr(txt: string) : string;
    function UkrEst(txt: string) : string;
    function GetHtmlContent(value: string) : string;
    function ExtractValuesFromHtml(const HTMLContent: string): TArray<string>;
    procedure LoadImageFromURL(url: string);
    procedure SpeakText(const Text: string);
    procedure SpeakerCheckDataCompleteHandler(Sender: TObject);
    procedure SpeakerSpeechStartedHandler(Sender: TObject);
    procedure SpeakerSpeechFinishedHandler(Sender: TObject);
    procedure UpdateGoogleSheetsCell(strData: string; strTranslate: string; idx: Integer);
    procedure UpdateGoogleSheetsCellTest(strDataD, strDataE, strDataF: string; idx: Integer);
    procedure UpdateGoogleSheetsCellImageSVG(strDataD, strDataF: string; idx: Integer);
    function GetWordIdFromGoogleSheets(word: string): Integer;
    procedure ExtractWordsFromHTML(const HTML: string);
    procedure fnLoading(isEnabled : Boolean);
    procedure UpdateEvent;
    function GetTranslationOnly3Words(const AJSONString, LangCode: string): TArray<string>;
    function ExtractValuesOnly3FromJSON(const AJSONString: string): TArray<string>;
    function RemoveDuplicates(const WordsList: TArray<string>): TArray<string>;
    function GetJSONFromURL(const AURL: string): string;
  public
    { Public declarations }
    uIDX: Integer;
    uURL,uURLWords,uSonApi,uTranslate,accessToken,uToken: string;
    uStr0,uStr1,uStr2,uStr3: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnTranslate: TCorrectionEvent read FOnTranslate write FOnTranslate;
  end;

implementation

{$R *.fmx}

uses
  UI.Dialog;

constructor TFrameCorrectionView.Create(AOwner: TComponent);
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
      Self.lbExample.Text := 'Failed to create TTextToSpeech instance';
  except
    on E: Exception do
       Self.lbExample.Text := 'Error initializing TTextToSpeech: ' + E.Message;
  end;
end;

destructor TFrameCorrectionView.Destroy;
begin
try
  FSpeaker.Free;
  inherited;
except
  Exit;
end
end;

procedure TFrameCorrectionView.LoadImageFromURL(url: string);
var
  HttpClient: TNetHTTPClient;
  HttpResponse: IHTTPResponse;
begin
try
  if Length(Trim(url)) = 0 then Exit;
     HttpClient := TNetHTTPClient.Create(nil);
  try
     // Выполняем GET запрос по переданному URL
     HttpResponse := HttpClient.Get(url);
    if HttpResponse.StatusCode = 200 then
    begin
      // Устанавливаем полученный SVG текст напрямую в SVGIconImage
      SVGIconImage1.SVGText := HttpResponse.ContentAsString;
      // Обновляем изображение
      SVGIconImage1.Repaint;
    end;
  finally
    HttpClient.Free;
  end;
except
  on E: Exception do
  begin
     Self.lbExample.Text := 'Error Load Image: '+ HttpResponse.StatusText +#13#10+ E.Message;
     Exit;
  end;
end;
end;

function RemoveSpanTags(const Input: string): string;
begin
try
  // Заменяем теги <span> и </span> на пустую строку
  Result := TRegEx.Replace(Input, '<\/?span>', '', [roIgnoreCase]);  //<span>
  Result := StringReplace(Result, '<span>', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '</span>', '', [rfReplaceAll, rfIgnoreCase]);
except
  Exit;
end;
end;

function RemoveEkiFormTags(const InputStr: string): string;
begin
try
  Result := StringReplace(InputStr, '<eki-form>', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '</eki-form>', '', [rfReplaceAll, rfIgnoreCase]);
except
  Exit;
end;
end;


procedure TFrameCorrectionView.SpeakerCheckDataCompleteHandler(Sender: TObject);
begin
try
  if Assigned(Sender) then
     Self.lbExample.Text := 'Text-to-speech data is available'
  else
     Self.lbExample.Text := 'Text-to-speech data is not available';
except
  //
end;
end;

procedure TFrameCorrectionView.SpeakerSpeechFinishedHandler(Sender: TObject);
begin
try
  //
except
  //
end;
end;

procedure TFrameCorrectionView.SpeakerSpeechStartedHandler(Sender: TObject);
begin
try
  //
except
  //
end;
end;

procedure TFrameCorrectionView.SpeakText(const Text: string);
begin
try
  if FSpeaker.IsSpeaking then
    FSpeaker.Stop;
  FSpeaker.Speak(Text);
except
  Exit;
end;
end;

function TFrameCorrectionView.GetTxtGoto(obj: string; idx: Integer): string;
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

function TFrameCorrectionView.RusEst(txt: string) : string;
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

function TFrameCorrectionView.EstRus(txt: string) : string;
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

function TFrameCorrectionView.UkrEst(txt: string) : string;
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

function TFrameCorrectionView.EstUkr(txt: string) : string;
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

function TFrameCorrectionView.GetJSONFromURL(const AURL: string): string;
var
  RestClient: TRestClient;
  RestRequest: TRestRequest;
  RestResponse: TRestResponse;
begin
try
  RestClient := TRestClient.Create(nil);
  RestRequest := TRestRequest.Create(nil);
  RestResponse := TRestResponse.Create(nil);
  try
    RestClient.BaseURL := AURL;
    RestRequest.Client := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Method := rmGET; // HTTP GET запрос
    RestRequest.Execute; // Выполнение запроса
    Result := RestResponse.Content; // Возвращаем JSON контент как строку
  finally
    RestResponse.Free;
    RestRequest.Free;
    RestClient.Free;
  end;
except
  on E: ERESTException do begin
     Self.lbExample.Text := 'Error GetJSONFromURL '+E.Message; Result := ''; Exit;
  end;
end;
end;

function TFrameCorrectionView.RemoveDuplicates(const WordsList: TArray<string>): TArray<string>;
var
  UniqueWords: TDictionary<string, Boolean>;
  Word: string;
  ResultList: TList<string>;
begin
try
  UniqueWords := TDictionary<string, Boolean>.Create;
  ResultList := TList<string>.Create;
  try
    for Word in WordsList do
    begin
      // Добавляем только уникальные слова
      if not UniqueWords.ContainsKey(Word) then
      begin
        UniqueWords.Add(Word, True);
        ResultList.Add(Word);
      end;
    end;
    // Преобразуем список в массив и возвращаем результат
    Result := ResultList.ToArray;
  finally
    UniqueWords.Free;
    ResultList.Free;
  end;
except
  on E: ERESTException do begin
     Self.lbExample.Text := 'Error RemoveDuplicates '+E.Message; Result := nil; Exit;
  end;
end;
end;

function TFrameCorrectionView.ExtractValuesOnly3FromJSON(const AJSONString: string): TArray<string>;
var
  JSONObject, SearchResult, WordForm: TJSONObject;
  SearchResultArray, WordFormsArray: TJSONArray;
  i, j, x, q: Integer;
  MorphValue, tmpStr: string;
  ValueList: TArray<string>;
  SelectedValues: TArray<string>;
  ValidMorphValues: TArray<string>;
begin
try
  // Заданные morphValues
  ValidMorphValues := [
    'ma-infinitiiv e ma-tegevusnimi',
    'da-infinitiiv e da-tegevusnimi',
    'muutumatu sõna (indekl)',
    'ainsuse nimetav',
    'ainsuse omastav',
    'ainsuse osastav',
    'kindla kõneviisi oleviku ainsuse 3.p.'
  ];
  x := 0;
  q := 0;
  tmpStr := '';
  JSONObject := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
  try
    // Получаем массив searchResult
    SearchResultArray := JSONObject.GetValue<TJSONArray>('searchResult');

    // Проходим по массиву searchResult
    for i := 0 to SearchResultArray.Count - 1 do
    begin
      SearchResult := SearchResultArray.Items[i] as TJSONObject;

      // Получаем массив wordForms
      WordFormsArray := SearchResult.GetValue<TJSONArray>('wordForms');
      for j := 0 to WordFormsArray.Count - 1 do
      begin
        WordForm := WordFormsArray.Items[j] as TJSONObject;
        MorphValue := WordForm.GetValue<string>('morphValue');

        // Проверяем, совпадает ли morphValue с заданными
        if MatchStr(MorphValue, ValidMorphValues) then
        begin
          if q >= 3 then Break;
          Inc(q);
          if Length(Trim(tmpStr)) > 0 then
          if tmpStr = WordForm.GetValue<string>('value') then Inc(x);
          tmpStr := WordForm.GetValue<string>('value');
          // Добавляем соответствующее значение "value"
          ValueList := ValueList + [WordForm.GetValue<string>('value')];
        end;
      end;
    end;
    if x > 2 then ValueList := RemoveDuplicates(ValueList);
    Result := ValueList; // Возвращаем массив значений "value"
  finally
    JSONObject.Free;
  end;
except
  on E: ERESTException do begin
     Self.lbExample.Text := 'Error ExtractValuesOnly3FromJSON '+E.Message; Result := nil; Exit;
  end;
end;
end;

function TFrameCorrectionView.GetTranslationOnly3Words(const AJSONString, LangCode: string): TArray<string>;
var
  JSONObject, MeaningObject, Translations, TranslationItem: TJSONObject;
  MeaningsArray, TranslationArray: TJSONArray;
  i, j, z, x: Integer;
  WordsList: TArray<string>;
begin
try
  x := 0;
  // Парсим JSON-строку в объект
  JSONObject := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
  try
    // Извлекаем массив "searchResult"
    MeaningsArray := JSONObject.GetValue<TJSONArray>('searchResult');
    // Проходим по каждому элементу массива "searchResult"
    for i := 0 to MeaningsArray.Count - 1 do
    begin
      if x > 0 then Break;
      MeaningObject := MeaningsArray.Items[i] as TJSONObject;
      // Проверяем, есть ли поле "meanings"
      if MeaningObject.TryGetValue<TJSONArray>('meanings', MeaningsArray) then
      begin
        // Проходим по каждому элементу массива "meanings"
        for j := 0 to MeaningsArray.Count - 1 do
        begin
          MeaningObject := MeaningsArray.Items[j] as TJSONObject;
          // Проверяем, есть ли объект "translations" для текущего значения "meanings"
          if MeaningObject.TryGetValue<TJSONObject>('translations', Translations) then
          begin
            // Проверяем, есть ли указанный язык в "translations"
            if Translations.TryGetValue<TJSONArray>(LangCode, TranslationArray) then
            begin
              // Проходим по каждому объекту в массиве переводов для заданного языка
              for z := 0 to TranslationArray.Count - 1 do
              begin
                if x >= 2 then Break;
                TranslationItem := TranslationArray.Items[z] as TJSONObject;
                // Добавляем значение поля "words" в список
                WordsList := WordsList + [TranslationItem.GetValue<string>('words')];
                Inc(x);
              end;
            end;
          end;
        end;
      end;
    end;
    WordsList := RemoveDuplicates(WordsList);
    Result := WordsList; // Возвращаем массив слов
  finally
    JSONObject.Free;
  end;
except
  on E: ERESTException do begin
     Self.lbExample.Text := 'Error GetTranslationOnly3Words '+E.Message; Result := nil; Exit;
  end;
end;
end;

function TFrameCorrectionView.GetTxt(obj: string; idx: Integer): string;
var jOb : string; str : string; myObj : TJSONObject;
begin
try
   if (idx = 0) then Result := RusEst(obj);
   if (idx = 1) then Result := EstRus(obj);
   if (idx = 2) then Result := UkrEst(obj);
   if (idx = 3) then Result := EstUkr(obj);
   if (idx = 4) then Result := RusEst(EstRus(obj));
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

function ExtractSVGUrl(const HtmlContent: string): string;
var
  RegEx: TRegEx;
  Match: TMatch;
begin
try
  // Регулярное выражение для нахождения тега <a> с атрибутом href, который содержит .svg
  RegEx := TRegEx.Create('<a\s+href="([^"]+\.svg)"', [roIgnoreCase]);
  // Ищем совпадение
  Match := RegEx.Match(HtmlContent);
  if Match.Success then
  begin
    // Возвращаем первый найденный URL
    Result := Match.Groups[1].Value;
  end
  else
  begin
    // Если не найдено - возвращаем пустую строку
    Result := '';
  end;
except
  Result := '';
  Exit;
end;
end;

procedure TFrameCorrectionView.actCleanExecute(Sender: TObject);
begin
try
  mmo1word.Text := '';
  mmo2word.Text := '';
  mmo3word.Text := '';
  mmo1word.ReadOnly := False;
  mmo2word.ReadOnly := False;
  mmo3word.ReadOnly := False;
  mmo1word.Enabled := True;
  mmo2word.Enabled := True;
  mmo3word.Enabled := True;
  mmo1word.SetFocus;
except
  Exit;
end;
end;

procedure TFrameCorrectionView.UpdateEvent;
begin
  if not sWord then Exit;
  try
    TTask.Run(procedure
    begin
      try
        TThread.Queue(nil, procedure begin fnLoading(True); end); // Безопасный вызов UI
        try
          if Length(Trim(EditView1.Text)) > 0 then
             uIDX := GetWordIdFromGoogleSheets(EditView1.Text)-1;
             TThread.Queue(nil,
              procedure
              begin
                Self.lbExample.Text := 'Get idx - Ok';
              end);
        except
          on E: Exception do
          begin
             TThread.Queue(nil,
              procedure
              begin
                Self.lbExample.Text := 'Error idx token: ' + E.Message;
              end);
              Exit;
          end;
        end;
        try
         if Length(Trim(AccessToken)) > 0 then begin
            if uIDX < 0 then Exit else begin
               if ((Length(Trim(mmo1word.Text)) > 0)and(Length(Trim(mmo2word.Text)) > 0)and(Length(Trim(mmo3word.Text)) > 0)and(Length(Trim(uRLSVG)) > 0)and(uIDX > -1)) then
                  UpdateGoogleSheetsCellTest('('+mmo1word.Text+','+mmo2word.Text+','+mmo3word.Text+')','0',uRLSVG,uIDX) else
               if ((Length(Trim(mmo1word.Text)) > 0)and(Length(Trim(mmo2word.Text)) > 0)and(Length(Trim(mmo3word.Text)) > 0)and(Length(Trim(uTranslate)) > 0)and(uIDX > -1)) then
                  UpdateGoogleSheetsCell('('+mmo1word.Text+','+mmo2word.Text+','+mmo3word.Text+')',uTranslate,uIDX);
                  sWord := False;
            end;
            TThread.Queue(nil,
              procedure
              begin
                Self.lbExample.Text := 'Load data - Ok';
              end);
         end;
        except
          on E: Exception do
          begin
             TThread.Queue(nil,
              procedure
              begin
                Self.lbExample.Text := 'Error Load data: ' + E.Message;
              end);
              Exit;
          end;
        end;
      finally
        TThread.Queue(nil,
          procedure
          begin
            fnLoading(False);
            TDialogService.ShowMessage('The selected data has been updated successfully!');
          end);
      end;
    end);
  except
    on E: Exception do
    begin
       Self.lbExample.Text := 'Global Error: ' + E.Message;
       Exit;
    end;
  end;
end;

procedure TFrameCorrectionView.actCorrectExecute(Sender: TObject);
begin
 try
   UpdateEvent;
 except
   on E: Exception do
    begin
       Self.lbExample.Text := 'Error ' + E.Message;
       Exit;
    end;
 end;
end;

procedure TFrameCorrectionView.actSpeakExecute(Sender: TObject);
begin
if Length(Trim(mmo4word.Text)) = 0 then Exit;
try
   SpeakText(mmo4word.Text);
except
  on E: Exception do begin
     Self.lbExample.Text := 'Error SpeakText '+#13#10+E.Message;
     Exit;
  end;
end;
end;

function ExtractWordID(const HTML: string): string;
var
  Match: TMatch;
begin
try
  Result := '';
  Match := TRegEx.Match(HTML, '<input\s+type="hidden"\s+name="word-id"\s+value="(\d+)"');
  if Match.Success then
     Result := Match.Groups[1].Value; // Получаем значение
except
  Exit;
end;
end;

function DecodeURL(const EncodedStr: string): string;
begin
  try
    Result := TNetEncoding.URL.Decode(EncodedStr);
  except
    Exit;
  end;
end;

function ExtractBetween(const Value, A, B: string): string;
var
  aPos, bPos: Integer;
begin
try
  result := '';
  aPos := Pos(A, Value);
  if aPos > 0 then begin
    aPos := aPos + Length(A);
    bPos := PosEx(B, Value, aPos);
    if bPos > 0 then begin
      result := Copy(Value, aPos, bPos - aPos);
    end;
  end;
except
  Exit;
end;
end;

function ExtractWordFromHTML(const Input: string; A: string; B: string): string;
var
  ResultWord: string;
begin
try
  // Удаляем теги <eki-stress> и </eki-stress> из строки
  ResultWord := ExtractBetween(Input,A,B);
  ResultWord := ExtractBetween(ResultWord,'<a href="/search/lite/dlall/','/1/rus"');
  // Возвращаем очищенное слово
  Result := Trim(ResultWord);
except
  Exit;
end;
end;

function ParseStr(str, tag1, tag2: string): TStrings;
var
  st,fin:Integer;
begin
try
  Result :=TStringList.Create;
  repeat
    st :=Pos(tag1, str);
    if st > 0 then begin
      str :=Copy(str, st+length(tag1), length(str)-1);
      st :=1;
      fin :=Pos(tag2, str);
      Result.Add(Copy(str, st, fin-st));
      str :=Copy(str, fin+length(tag2), length(str)-1);
    end;
  until st<=0;
except
  Exit;
end;
end;

function ExampleWords(const Input: string; A: string; B: string): string;
var
 // ResultWord: string;
  uTmp: TStringList;
begin
try
  uTmp := TStringList.Create;
  try
    // Удаляем теги <eki-stress> и </eki-stress> из строки
    uTmp.AddStrings(ParseStr(Input,A,B));
    if ((Pos('Error',uTmp.Text) = 0)or(Pos('eki-stress',uTmp.Text) = 0)) then
    // Возвращаем очищенное слово
    Result := Trim(uTmp.Text) else Result := '';
  finally
    uTmp.Free;
  end;
except
  Exit;
end;
end;

procedure TFrameCorrectionView.ExtractWordsFromHTML(const HTML: string);
var
  Regex: TRegEx;
  Match: TMatch;
  ExtractedWords: TStringList;
  CleanedWord: string;
  i: Integer;
begin
  try
    // Регулярное выражение для поиска слов с учётом возможных тегов <eki-form>
    Regex := TRegEx.Create('<span[^>]*class="form-value-field"[^>]*>([\wõäöüÕÄÖÜ`´]+)(?:<eki-form>[^<]*</eki-form>)?</span>', [roIgnoreCase]);

    // Создаем список для сохранения найденных слов
    ExtractedWords := TStringList.Create;
    ExtractedWords.Sorted := True;          // Устанавливаем сортировку
    ExtractedWords.Duplicates := dupIgnore; // Игнорируем дубликаты

    try
      Match := Regex.Match(HTML);
      while Match.Success do
      begin
        // Извлекаем и очищаем слово
        CleanedWord := StringReplace(Match.Groups[1].Value, '[', '', [rfReplaceAll]);
        ExtractedWords.Add(CleanedWord);
        Match := Match.NextMatch;
      end;

      // Выводим результат
      for i := 0 to ExtractedWords.Count - 1 do
      begin
        mmo4word.Lines.Add('[' + IntToStr(i + 1) + '] ' + ExtractedWords[i]);
      end;
    finally
      ExtractedWords.Free;
    end;
  except
    Exit;
  end;
end;

procedure TFrameCorrectionView.fnLoading(isEnabled : Boolean);
begin
try
  AniIndicator1.Visible := isEnabled;
  AniIndicator1.Enabled := isEnabled;
except
  Exit;
end;
end;

procedure TFrameCorrectionView.UpdateData;
var
  tmp,tmpw,tmpsrc: string;
  Response,rSource: string;
  Values: TArray<string>;
  WordID: string; i: Integer;
  ExampleText: TStringList;
  JSONContent: string;
  Words: TArray<string>;
  ExtractedWords: TStringList;
begin
 try
  if Length(Trim(EditView1.text)) = 0 then Exit;
  if Length(Trim(uURL)) = 0 then Exit;
     uTranslate := '';
  try
    tmpsrc := Copy(LowerCase(Trim(EditView1.text)), 1,2);
  except
    fnLoading(False);
    Self.lbExample.Text := 'Error tmpsrc ';
  end;
    ExampleText := TStringList.Create;
  try
   WordID := '';
   tmp := StringReplace(uURL+uRLs, uRLs, EditView1.text, [rfReplaceAll]);
   try
     rSource := GetHtmlContent(tmp);
     Response := rSource;
   except
    on E: Exception do
    begin
       Self.lbExample.Text := 'Error ' + E.Message;
       fnLoading(False);
       Exit;
    end;
   end;
   if Length(Trim(uStr3)) = 0 then Exit;
   try
    ExtractedWords := TStringList.Create; // ExtractedWords.Sorted := True;          // Устанавливаем сортировку
    ExtractedWords.Duplicates := dupIgnore; // Игнорируем дубликаты
   try
   try
    JSONContent := GetJSONFromURL(Trim(uSonApi+Trim(uStr3)));
   except
     on E: Exception do
      begin
        Self.lbExample.Text := 'Error JSON content: ' + E.Message;
        fnLoading(False);
        Exit;
      end;
   end;
   if Pos('404',JSONContent) > 0 then begin Self.lbExample.Text := '404: ' + JSONContent; Exit end;
   if Pos('Error',JSONContent) > 0 then begin Self.lbExample.Text := 'Error: ' + JSONContent; Exit end;
   try
     Values := ExtractValuesOnly3FromJSON(JSONContent);
   except
     on E: Exception do
      begin
        Self.lbExample.Text := 'Error Values Frame: ' + E.Message;
        fnLoading(False);
        Exit;
      end;
   end;
   try
    Words := GetTranslationOnly3Words(JSONContent, 'rus');
   except
     on E: Exception do
      begin
        Self.lbExample.Text := 'Error Words Frame: ' + E.Message;
        fnLoading(False);
        Exit;
      end;
   end;
   mmo4word.Lines.Add('Sõnavormid: ');
   tmpw := '';
   try
    for i := 0 to Length(Values) - 1 do
     begin
        if ((Length(Values) >= 2)and(i >= 2)) then begin
          mmo1word.Text := Values[0];
          mmo2word.Text := Values[1];
          mmo3word.Text := Values[2];
        end;
        ExtractedWords.Add(Values[i]);
        tmpw := tmpw + Values[i];
     end;
   except
     on E: Exception do
      begin
        Self.lbExample.Text := 'Error ExtractedWords Values Frame: ' + E.Message;
        fnLoading(False);
        Exit;
      end;
   end;
   try
    for i := 0 to Length(Words) - 1 do
     begin
        if Pos(Words[i],uTranslate) = 0 then begin
        if Length(Trim(uTranslate)) = 0 then
           uTranslate := Words[i] else
           uTranslate := uTranslate +','+ Words[i];
        end;
        ExtractedWords.Add(Words[i]); // Вывод каждого слова
        tmpw := tmpw + Words[i];
     end;
   except
     on E: Exception do
      begin
        Self.lbExample.Text := 'Error ExtractedWords Words Frame: ' + E.Message;
        fnLoading(False);
        Exit;
      end;
   end;
   mmo4word.Lines.Add(ExtractedWords.Text);
   mmo4word.Lines.Add('-----------------------------------------');
   finally
     ExtractedWords.Free;
   end;
   except
     fnLoading(False);
     Self.lbExample.Text := 'Error ExtractedWords';
   end;
   try
   if Pos('Error',Response) = 0 then
      WordID := ExtractWordID(Response);
   if Length(Trim(WordID)) > 0 then begin
      tmp := StringReplace(uURLWords+uRLWords, uRLWords, WordID, [rfReplaceAll]);
      Response := GetHtmlContent(tmp);
     //  ExampleText.Add(Response);
     //  ExampleText.SaveToFile('testresp.html');
     if Length(Trim(Response)) > 0 then begin
        if Length(Trim(tmpw)) = 0 then begin
           tmp := DecodeURL(ExtractWordFromHTML(Response,'title="vene"','</div>'));
           mmo4word.Lines.Add(tmp);
        end;
        if Pos('Error',Response) = 0 then begin
           uRLSVG := ExtractSVGUrl(Response);
           if Length(Trim(uRLSVG)) > 0 then LoadImageFromURL(uRLSVG);
           // ExampleText.Add(ExtractSVGUrl(Response));
           // ExampleText.SaveToFile('testsvg.html');
           if Length(Trim(tmpw)) = 0 then begin
              Values := ExtractValuesFromHtml(Response); //ExtractValues(Response);
              ExtractWordsFromHTML(Response);
             // Выводим извлеченные значения в Memo
             for i := Low(Values) to High(Values) do
              if (i mod 2 = 0) then begin
               tmp := '';
               tmp := LowerCase(Values[i]);
               if Pos(tmpsrc,Values[i]) > 0 then begin
               if Pos('span',tmp) > 0 then tmp := RemoveSpanTags(tmp) else tmp := '';
               if Pos('span',tmp) > 0 then tmp := RemoveEkiFormTags(tmp) else tmp := '';
               if Length(Trim(tmp)) > 0 then
               mmo4word.Lines.Add(tmp)
               else
               mmo4word.Lines.Add(Values[i]);
               if ((Length(Trim(tmp)) > 0)and(i = 0)) then
               mmo1word.Lines.Text := tmp
               else if i = 0 then
               mmo1word.Lines.Text := Values[i];
               if ((Length(Trim(tmp)) > 0)and(i = 2)) then
               mmo2word.Lines.Text := tmp
               else if i = 2 then
               mmo2word.Lines.Text := Values[i];
               if ((Length(Trim(tmp)) > 0)and(i = 4)) then
               mmo3word.Lines.Text := tmp
               else if i = 4 then
               mmo3word.Lines.Text := Values[i];
               end;
               mmo1word.ReadOnly := True;
               mmo2word.ReadOnly := True;
               mmo3word.ReadOnly := True;
               mmo1word.Enabled := False;
               mmo2word.Enabled := False;
               mmo3word.Enabled := False;
              end else
               mmo4word.Lines.Add(Values[i]);
           end;
           mmo1word.ReadOnly := True;
           mmo2word.ReadOnly := True;
           mmo3word.ReadOnly := True;
           mmo1word.Enabled := False;
           mmo2word.Enabled := False;
           mmo3word.Enabled := False;
           mmo4word.Lines.Add('Example :');
           ExampleText.Clear;
           ExampleText.Add(ExampleWords(Response,'<span class="example-text-value">','</span>'));
           mmo4word.Lines.Add(RemoveEkiFormTags(RemoveSpanTags(ExampleText.Text)));
           sWord := True;
        end;
     end;
   end;
   except
    fnLoading(False);
    Self.lbExample.Text := 'Error ExampleText Frame';
   end;
  finally
    ExampleText.Free;
  end;
 except
    fnLoading(False);
    Self.lbExample.Text := 'Error Sõnavormid';
 end;
end;

procedure TFrameCorrectionView.actUpdateExecute(Sender: TObject);
begin
try
  TTask.Run(procedure
  begin
    try
      fnLoading(True); // Безопасный вызов UI
      try
        UpdateData;
      except
        on E: Exception do
        begin
           TThread.Queue(nil,
            procedure
            begin
              fnLoading(False);
              Self.lbExample.Text := 'Error UpdateData: ' + E.Message;
            end);
            Exit;
        end;
      end;
    finally
      fnLoading(False);
    end;
  end);
except
  fnLoading(False);
  Exit;
end;
end;

function VariantToJSON(Value: Variant): TJSONValue;
  var i: integer;
      JSONArray: TJSONArray;
  function VarToInt(Value: Variant): integer;
  begin
    Result := Value;
  end;
  function VarToFloat(Value: Variant): double;
  begin
    Result := Value;
  end;
  function Item(Value: Variant): TJSONValue;
  begin
    case VarType(Value) of
      varEmpty, varNull, varUnknown:
        Result := TJSONNull.Create;
      varSmallint, varInteger, varShortInt, VarInt64:
        Result := TJSONNumber.Create(VarToInt(Value));
      varSingle, varDouble, varCurrency:
        Result := TJSONNumber.Create(VarToFloat(Value));
      varDate:
        Result := TJSONString.Create(DateToStr(Value));
      varBoolean:
        Result := TJSONBool.Create(Value);
    else
        Result := TJSONString.Create(Value);
    end;
  end;
begin
try
  if not VarIsArray(Value) then
  begin
    Result := Item(Value);
  end
  else
  begin
    JSONArray := TJSONArray.Create;
    for i := 0 to Length(Value) do
    begin
      JSONArray.AddElement(Item(Value[i]));
    end;
    Result := JSONArray;
  end;
except
  Exit;
end;
end;

procedure TFrameCorrectionView.UpdateGoogleSheetsCell(strData: string; strTranslate: string; idx: Integer);
var
  myObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  updateBody: TJSONObject;
  newRowArray: TJSONArray;
begin
  try
    if Length(Trim(uToken)) = 0 then Exit;
    if Length(Trim(accessToken)) = 0 then Exit;
    try
      // Установка параметров запроса к Google Sheets API для получения данных
      RESTClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/B1:E10608?majorDimension=ROWS';
      RESTClient1.AcceptCharset := 'utf-8, *;q=0.8';
      RESTClient1.ContentType := 'application/json; charset=UTF-8';
      RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
      RESTRequest1.ClearBody;
      RESTRequest1.Params.Clear;
      // Добавление токена авторизации
      RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
      // Выполнение запроса для получения данных
      RESTRequest1.Execute;
      // Обработка JSON-ответа
      myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
      try
        valuesArray := myObj.GetValue('values') as TJSONArray;
        if Assigned(valuesArray) and (idx < valuesArray.Count) then
        begin
          rowArray := valuesArray.Items[idx] as TJSONArray; // Используем idx для доступа к нужной строке
          if Assigned(rowArray) then
          begin
            // Создаем массив для обновления значений в колонках C и D
            newRowArray := TJSONArray.Create;
            newRowArray.Add(strTranslate); // Обновляем колонку C (индекс 2)
            newRowArray.Add(strData);      // Обновляем колонку D (индекс 3)
            // Теперь нужно обновить данные в Google Sheets
            RESTClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/EestiS!C' + IntToStr(idx + 1) + ':D' + IntToStr(idx + 1) + '?valueInputOption=RAW';
            // Формируем тело запроса для обновления
            updateBody := TJSONObject.Create;
            try
              updateBody.AddPair('range', 'EestiS!C' + IntToStr(idx + 1) + ':D' + IntToStr(idx + 1)); // Диапазон C и D
              updateBody.AddPair('majorDimension', 'ROWS');
              updateBody.AddPair('values', TJSONArray.Create(newRowArray));
              RESTRequest1.ClearBody;
              RESTRequest1.AddBody(updateBody.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
              RESTRequest1.Method := TRESTRequestMethod.rmPUT;
              // Выполняем запрос для обновления данных
              RESTRequest1.Execute;
            finally
              updateBody.Free;
            end;
          end;
        end;
      finally
        myObj.Free; // Освободить ресурсы JSON-объекта
      end;
    finally
      if RESTResponse1.StatusCode = 200 then
      begin
         Self.lbExample.Text := 'The selected data has been updated successfully!';
      end;
    end;
  except
    on E: ERESTException do
    begin
      Self.lbExample.Text := 'REST Error: ' + IntToStr(RESTResponse1.StatusCode) + ' - ' + E.Message;
    end;
  end;
end;

function TFrameCorrectionView.GetWordIdFromGoogleSheets(word: string): Integer;
var
  myObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i: Integer;
begin
  Result := -1; // Значение по умолчанию, если слово не найдено
  try
    if Length(Trim(uToken)) = 0 then Exit;
    if Length(Trim(accessToken)) = 0 then Exit;
    // Установка параметров запроса к Google Sheets API для получения данных
    RESTClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/EestiS!A1:B10608?majorDimension=ROWS';
    RESTClient1.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient1.ContentType := 'application/json; charset=UTF-8';
    RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest1.ClearBody;
    RESTRequest1.Params.Clear;
    // Добавление токена авторизации
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    // Выполнение запроса для получения данных
    RESTRequest1.Execute;
    // Обработка JSON-ответа
    myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    try
      valuesArray := myObj.GetValue('values') as TJSONArray;
      if Assigned(valuesArray) then
      begin
        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray; // Получаем текущую строку
          if Assigned(rowArray) and (rowArray.Count > 0) then
          begin
            // Проверяем, совпадает ли введенное слово с элементом в первой колонке (A)
            if SameText(rowArray.Items[1].Value, word) then
            begin
              // Если совпадение найдено, получаем ID из ячейки A
              Result := StrToInt(rowArray.Items[0].Value); // Извлекаем ID
              Exit; // Завершаем поиск, если слово найдено
            end;
          end;
        end;
      end;
    finally
      myObj.Free; // Освобождаем ресурсы JSON-объекта
    end;
  except
    on E: Exception do
    begin
      Self.lbExample.Text := 'Error while fetching ID: ' + E.Message;
      Result := -1;
    end;
  end;
end;

procedure TFrameCorrectionView.UpdateGoogleSheetsCellTest(strDataD, strDataE, strDataF: string; idx: Integer);
var
  updateBody: TJSONObject;
  valuesArray, rowArray: TJSONArray;
begin
 try
    if Length(Trim(uToken)) = 0 then Exit;
    if Length(Trim(accessToken)) = 0 then Exit;
  try
    // Устанавливаем URL для обновления диапазона
    RESTClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/EestiS!D' + IntToStr(idx + 1) + ':F' + IntToStr(idx + 1) + '?valueInputOption=RAW';
    // Добавляем заголовок авторизации с токеном
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    // Очищаем предыдущее тело запроса
    RESTRequest1.ClearBody;
    // Формируем JSON тело запроса
    updateBody := TJSONObject.Create;
    valuesArray := TJSONArray.Create;
    rowArray := TJSONArray.Create; // создаем массив для одной строки
    try
      // Добавляем данные для строки (D и F)
      rowArray.Add(strDataD);  // Добавляем данные для столбца D
      rowArray.Add(strDataE);        // Пустая ячейка для столбца E
      rowArray.Add(strDataF);  // Добавляем данные для столбца F
      valuesArray.Add(rowArray); // Добавляем строку в массив значений
      updateBody.AddPair('range', 'EestiS!D' + IntToStr(idx + 1) + ':F' + IntToStr(idx + 1)); // Указываем диапазон
      updateBody.AddPair('majorDimension', 'ROWS'); // По строкам
      updateBody.AddPair('values', valuesArray); // Добавляем массив значений
      // Добавляем тело запроса
      RESTRequest1.AddBody(updateBody.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      RESTRequest1.Method := TRESTRequestMethod.rmPUT;
      // Выполняем запрос для обновления данных
      RESTRequest1.Execute;
    finally
      updateBody.Free;
    end;
  finally
     TDialogService.ShowMessage('The selected data has been updated successfully!');
  end;
 except
   on E: Exception do
    begin
       Self.lbExample.Text := 'Error: ' + E.Message;
    end;
 end;
end;

procedure TFrameCorrectionView.UpdateGoogleSheetsCellImageSVG(strDataD, strDataF: string; idx: Integer);
var
  myObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  updateBody: TJSONObject;
begin
 try
    if Length(Trim(uToken)) = 0 then Exit;
    if Length(Trim(accessToken)) = 0 then Exit;
  try
    // Установка параметров запроса к Google Sheets API для получения данных
    RESTClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/B1:F999?majorDimension=ROWS';
    RESTClient1.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient1.ContentType := 'application/json; charset=UTF-8';
    RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest1.ClearBody;
    RESTRequest1.Params.Clear;

    // Добавление токена авторизации
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

    // Выполнение запроса для получения данных
    RESTRequest1.Execute;

    // Обработка JSON-ответа
    myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    try
      valuesArray := myObj.GetValue('values') as TJSONArray;

      if Assigned(valuesArray) and (idx < valuesArray.Count) then
      begin
        rowArray := valuesArray.Items[idx] as TJSONArray; // Используем idx для доступа к нужной строке
        if Assigned(rowArray) then
        begin
          // Создаем массив для обновления значений в столбцах D и F
          var newRowArray := TJSONArray.Create;
          newRowArray.Add(strDataD); // Обновляем значение для колонки D
          newRowArray.Add(''); // Пропуск колонок E
          newRowArray.Add(strDataF); // Обновляем значение для колонки F

          // Теперь нужно обновить данные в Google Sheets
          RESTClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/EestiS!D' + IntToStr(idx + 1) + ':F' + IntToStr(idx + 1) + '?valueInputOption=RAW';

          // Формируем тело запроса для обновления
          updateBody := TJSONObject.Create;
          try
            updateBody.AddPair('range', 'EestiS!D' + IntToStr(idx + 1) + ':F' + IntToStr(idx + 1)); // Ячейки D и F
            updateBody.AddPair('majorDimension', 'ROWS');
            // Оборачиваем newRowArray в массив
            updateBody.AddPair('values', TJSONArray.Create(TJSONArray.Create(newRowArray)));

            RESTRequest1.ClearBody;
            RESTRequest1.AddBody(updateBody.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
            RESTRequest1.Method := TRESTRequestMethod.rmPUT;

            // Выполняем запрос для обновления данных
            RESTRequest1.Execute;
          finally
            updateBody.Free;
          end;
        end;
      end;
    finally
      myObj.Free; // Освободить ресурсы JSON-объекта
    end;
  finally
    TDialogService.ShowMessage('The selected data has been updated successfully!');
  end;
 except
    on E: Exception do
    begin
       Self.lbExample.Text := 'Error: ' + E.Message;
    end;
 end;
end;

function TFrameCorrectionView.GetHtmlContent(value: string) : string;
begin
  if Length(Trim(value)) = 0 then Exit;  //ShowMessage('url ' + value);
  RestClient1.BaseURL := value;
  RestRequest1.Client := RestClient1;
  RestRequest1.Response := RestResponse1;
  RestRequest1.Method := TRESTRequestMethod.rmGET;
  RestRequest1.Params.Clear;
  try
    RestRequest1.Execute;
    if RestResponse1.StatusCode = 200 then
       Result := RestResponse1.Content
    else
       Result := 'Error: ' + RestResponse1.StatusText;
  except
    on E: Exception do
    begin
       Result := '';
       Self.lbExample.Text := 'Error ' + E.Message;
       Exit;
    end;
  end;
end;

function DecodeHTML(const EncodedStr: string): string;
begin
try
  Result := EncodedStr.Replace('&#91;', '[').Replace('&#93;', ']')
                      .Replace('&lt;', '<').Replace('&gt;', '>')
                      .Replace('&amp;', '&').Replace('&quot;', '"')
                      .Replace('&#39;', ''''); // Добавляем обработку HTML-сущностей
except
  on E: Exception do
  begin
     Result := '';
     Exit;
  end;
end;
end;

function TFrameCorrectionView.ExtractValuesFromHtml(const HTMLContent: string): TArray<string>;
var
  RegEx: TRegEx;
  Match: TMatch;
  Results: TList<string>;
  InnerText, EkiFormText, CombinedText: string;
begin
  Results := TList<string>.Create;
  try
    // Обновленное регулярное выражение для захвата всех случаев <span> с или без <eki-form>
    RegEx := TRegEx.Create('<span[^>]*title="[^"]*"[^>]*>(.*?)(<eki-form>(.*?)<\/eki-form>)?<\/span>', [roIgnoreCase, roMultiLine]);
    // Поиск совпадений
    Match := RegEx.Match(HTMLContent);
    while Match.Success do
    begin
      // Получение текста внутри <span>
      InnerText := DecodeHTML(Match.Groups[1].Value);  // Декодируем символы
      if Length(Trim(InnerText)) >= 3 then begin
         // Если присутствует <eki-form>, добавляем его текст
         if (Match.Groups.Count > 3) and Match.Groups[3].Success then
           EkiFormText := DecodeHTML(Match.Groups[3].Value)  // Декодируем и этот текст
         else
           EkiFormText := '';
         // Объединяем текст <span> и <eki-form> (если есть)
         CombinedText := InnerText + EkiFormText;
         // Добавляем результат в список
         Results.Add(CombinedText);
      end;
      // Переход к следующему совпадению
      Match := Match.NextMatch;
    end;
    // Возвращаем результат в виде массива строк
    Result := Results.ToArray;
  finally
    Results.Free;
  end;
end;

procedure TFrameCorrectionView.EditView1Click(Sender: TObject);
begin
try
  //
except
  Exit;
end;
end;

procedure TFrameCorrectionView.FrameResize(Sender: TObject);
begin
  Height := LinearLayout1.Height;
  if Length(Trim(uStr0)) = 0 then Exit;
  if Length(Trim(uStr1)) = 0 then Exit;
  if Length(Trim(uStr2)) = 0 then Exit;
  mmo1word.Text := uStr0;
  mmo2word.Text := uStr1;
  mmo3word.Text := uStr2;
  EditView1.Text := uStr3;
  sWord := False;
  fnLoading(sWord);
end;

end.
