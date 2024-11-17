unit uFrameDiary;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.PushNotification, System.Notification, REST.Json,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Edit, UI.Base, UI.Standard, UI.Frame, FMX.Memo.Types, System.JSON, System.Math,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts, System.ImageList, DW.TextToSpeech,
  FMX.ImgList, FMX.Objects, System.Actions, FMX.ActnList, FMX.Calendar, FMX.ListBox, FMX.Styles.Objects,
  FMX.TabControl, FMX.Effects, FireDAC.Stan.Intf, FireDAC.Stan.Option, DateUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

const BASES_FILE = 'basesDiary.bsb';

type
  TDiaryEvent = procedure (AView: TFrame; ASource, ATarget: string) of object;
  TFrameDiaryView = class(TFrame)
    LinearLayout1: TLinearLayout;
    FrameContainer: TLayout;
    AniIndicator1: TAniIndicator;
    ActionList1: TActionList;
    actSpeak: TAction;
    RecCore: TRectangle;
    tCore: TTabControl;
    uCalendar: TTabItem;
    Layout1: TLayout;
    lFirst: TLabel;
    Layout3: TLayout;
    cal1: TCalendar;
    uMessage: TTabItem;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    mmo_src: TMemo;
    mmo_trg: TMemo;
    Splitter1: TSplitter;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    EditView1: TEditView;
    TextView1: TTextView;
    TextView2: TTextView;
    actGoto: TAction;
    actSave: TAction;
    btnTranslate: TCornerButton;
    Path1: TPath;
    actTranslate: TAction;
    lCount: TLabel;
    btnGoto: TButton;
    pthGoto: TPath;
    btnSpeak: TCornerButton;
    pthSpk: TPath;
    ShadowEffect1: TShadowEffect;
    FDMemTable1: TFDMemTable;
    procedure FrameResize(Sender: TObject);
    procedure uTransClick(Sender: TObject);
    procedure EditView1Click(Sender: TObject);
    procedure btnupdClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure actSpeakExecute(Sender: TObject);
    procedure actGotoExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actTranslateExecute(Sender: TObject);
    procedure cal1DateSelected(Sender: TObject);
    procedure mmo_srcChange(Sender: TObject);
    procedure cal1ApplyStyleLookup(Sender: TObject);
    procedure cal1Change(Sender: TObject);
  private
    { Private declarations }
    FSpeaker: TTextToSpeech;
    FSelectedLanguage: string;
    FOnTranslate: TDiaryEvent;
    procedure UpdateCalendar(Sender: TObject);
    procedure InsertOrUpdateBase(MessageText: string);
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
    procedure LoadDiaryDates;
    procedure DeleteBases;
    procedure CleanListBox(AListBox: TListBox; AIndex: Integer);
    function CountWordsInMemo : Integer;
  public
    { Public declarations }
    uLangs: string; uStr1,uStr2: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnTranslate: TDiaryEvent read FOnTranslate write FOnTranslate;
  end;
implementation
{$R *.fmx}
uses
  uDM, uMyDB, UI.Dialog, System.IOUtils;

function CountWords(const Text: string): Integer;
var
  Words: TArray<string>;
begin
  try
    // Разделяем текст на слова, используя пробелы и знаки препинания как разделители
    Words := Text.Split([' ', '.', ',', ';', ':', '!', '?', #10, #13], TStringSplitOptions.ExcludeEmpty);
    // Возвращаем количество слов
    Result := Length(Words);
  except
    on E: Exception do
       Exit;
  end;
end;

procedure TFrameDiaryView.CleanListBox(AListBox: TListBox; AIndex: Integer);
begin
  if AListBox.ItemByIndex(AIndex).TagObject<>nil then
    begin
      if AListBox.ItemByIndex(AIndex).TagObject is TCircle then
        begin
          TRectangle(AListBox.ItemByIndex(AIndex).TagObject).Free;
          AListBox.ItemByIndex(AIndex).TagObject := nil;
        end;
    end;
end;

procedure TFrameDiaryView.UpdateCalendar(Sender: TObject);
var
  I: Integer;
  LastMonth: Integer;
  DaysInMonth: Integer;
  StartMonth: Integer;
  EndMonth: Integer;
  LB: TListBox;
  Circle: TCircle;
begin
    LB := TListBox(cal1.Controls.Items[0].Controls.Items[0].Controls.Items[3]);
    DaysInMonth := DaysInAMonth(YearOf(cal1.DateTime), MonthOfTheYear(cal1.DateTime));
    StartMonth := 0;
    EndMonth := 0;
    LastMonth := 1;
    for I := 0 to LB.Count - 1 do
      begin
        if LB.ItemByIndex(I).Text.ToInteger=1 then
         begin
           StartMonth := 1;
           LastMonth := Max(I,1);
         end;
        if (StartMonth=1) AND (EndMonth=0) then
          begin
            if FDMemTable1.Locate('EventDateTime',VarArrayOf([EncodeDate(YearOf(cal1.DateTime), MonthOfTheYear(cal1.DateTime), LB.ItemByIndex(I).Text.ToInteger)])) then
              begin
                if LB.ItemByIndex(I).TagObject=nil then
                  begin
                    LB.ItemByIndex(I).TagObject := TCircle.Create(LB.ItemByIndex(I));
                    Circle := TCircle(LB.ItemByIndex(I).TagObject);
                    Circle.Parent := LB.ItemByIndex(I);
                    Circle.Align := TAlignLayout.Client;
                    Circle.Fill.Kind := TBrushKind.None;
                    Circle.Stroke.Color := TAlphaColorRec.Red;
                    Circle.Stroke.Thickness := 3;
                    Circle.HitTest := False;
                    Circle.Opacity := 0.5;
                 end;
              end
            else
              begin
                CleanListBox(LB, I);
              end;
          end
        else
          begin
            CleanListBox(LB, I);
          end;
        if (StartMonth=1) AND (LB.ItemByIndex(I).Text.ToInteger=DaysInMonth) then
          begin
            EndMonth := 1;
          end;
      end;
end;

function TFrameDiaryView.CountWordsInMemo : Integer;
var
  countTxT: Integer;
begin
  try
    if Length(Trim(mmo_src.Lines.Text)) = 0 then Exit;
    countTxT := CountWords(mmo_src.Lines.Text);
    Result := countTxT;
  except
    on E: Exception do
       Exit;
  end;
end;

constructor TFrameDiaryView.Create(AOwner: TComponent);
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
      lFirst.Text := 'Failed to create TTextToSpeech instance';
  except
    on E: Exception do
       lFirst.Text := 'Error initializing TTextToSpeech: ' + E.Message;
  end;
end;

destructor TFrameDiaryView.Destroy;
begin
try
  FSpeaker.Free;
  inherited;
except
  Exit;
end
end;

procedure TFrameDiaryView.SpeakerCheckDataCompleteHandler(Sender: TObject);
begin
try
  if Assigned(Sender) then
     lFirst.Text := 'Text-to-speech data is available'
  else
     lFirst.Text := 'Text-to-speech data is not available'
except
  //
end;
end;


procedure TFrameDiaryView.SpeakerSpeechFinishedHandler(Sender: TObject);
begin
try
  //
except
  //
end;
end;

procedure TFrameDiaryView.SpeakerSpeechStartedHandler(Sender: TObject);
begin
try
  //
except
  //
end;
end;

procedure TFrameDiaryView.SpeakText(const Text: string);
begin
try
  if FSpeaker.IsSpeaking then
    FSpeaker.Stop;
  FSpeaker.Speak(Text);
except
  Exit;
end;
end;

function TFrameDiaryView.GetTxtGoto(obj: string; idx: Integer): string;
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

function TFrameDiaryView.RusEst(txt: string) : string;
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
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult),0);
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

function TFrameDiaryView.EstRus(txt: string) : string;
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
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult),0);
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

function TFrameDiaryView.UkrEst(txt: string) : string;
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
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult),0);
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

function TFrameDiaryView.EstUkr(txt: string) : string;
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
    jso := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult),0);
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

function TFrameDiaryView.GetTxt(obj: string; idx: Integer): string;
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
function IsOrderIdExists(const OrderId: string): Boolean;
begin
try
 // Result := False;
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

procedure TFrameDiaryView.InsertOrUpdateBase(MessageText: string);
var
  MessID: string;
  CreateDate: TDate;
begin
  MessID := FormatDateTime('ddmmyyyy', cal1.Date);
  CreateDate := cal1.Date;
  try
    with uDMForm do
    begin
      fConnect.Open;
      try
        // Используем INSERT OR REPLACE для вставки или замены существующей записи
        fQuery.SQL.Text := 'INSERT OR REPLACE INTO t_jso_Diary (MessID, Message, CreateDate) VALUES (:MessID, :Message, :CreateDate)';
        fQuery.ParamByName('MessID').AsString := MessID;
        fQuery.ParamByName('Message').AsString := MessageText;
        fQuery.ParamByName('CreateDate').AsDate := CreateDate;
        fQuery.ExecSQL;
      finally
        fConnect.Close;
      end;
    end;
  except
    on E: Exception do
    begin
      lFirst.Text := 'Error inserting or updating in database: ' + E.Message;
      Exit;
    end;
  end;
end;

procedure TFrameDiaryView.LoadDiaryDates;
var
  i: Integer;
begin
try
  i := 0;
  with uDMForm do begin // Сохранение в базу данных
       if fConnect.Connected then fConnect.Close;  // Закрываем соединение перед открытием
       fConnect.Open;
       fQuery.SQL.Clear;
       fQuery.SQL.Text := 'SELECT DISTINCT CreateDate FROM t_jso_Diary';
       fQuery.Open;
       while not fQuery.Eof do
        begin
          i := i + 1;
          if i = 1 then lFirst.Text := 'First : '+fQuery.FieldByName('CreateDate').AsString+' - Last : ';
          fQuery.Next;
        end;
        lFirst.Text := lFirst.Text + fQuery.FieldByName('CreateDate').AsString;
  end;
except
  on E: Exception do begin
     lFirst.Text := 'LoadDiaryDates'+#13#10+E.Message;
     Exit;
  end;
end;
end;

procedure TFrameDiaryView.mmo_srcChange(Sender: TObject);
begin
try
  if Length(mmo_src.Text) >= 7000 then mmo_src.Text := StringReplace(mmo_src.Text,#13#10,' ',[rfreplaceall]) else
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          lCount.Text := '  Number of characters:           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
      TThread.Synchronize(nil,
        procedure
        begin
          lCount.Text := '  Number of characters:           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
      TThread.Synchronize(nil,
        procedure
        begin
          lCount.Text := '  Number of characters:           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
    end
  ).Start;
except
  Exit;
end;
end;

procedure TFrameDiaryView.uTransClick(Sender: TObject);
var CleanText, str,jOb,tmp: string; //myDate : TDateTime;
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
     mmo_src.Text := StringReplace(mmo_src.Text, #13#10, '', [rfReplaceAll]);
     CleanText := RemoveNonPrintableChars(mmo_src.Text);
     mmo_src.Text := CleanText;
     if (EditView1.Tag = 4) then begin
         jOb := GetTxt(mmo_src.Lines.Text,EditView1.Tag);
         Sleep(1500);
         tmp := GetTxtGoto(jOb,0);
         mmo_trg.Lines.Text := tmp;
     end else
         mmo_trg.Lines.Text := GetTxt(mmo_src.Lines.Text,EditView1.Tag);
     if ((Length(Trim(mmo_src.Text)) > 0)and(Length(Trim(mmo_trg.Text)) > 0)) then begin
         str := #13#10+'Source:'+#13#10+mmo_src.Text+#13#10+'Translation:'+#13#10+mmo_trg.Text;
        //InsertBases('['+FormatDateTime('dd/mm/yyyy hh:nn:ss', myDate)+'] {'+str+#13#10+'}','EE');
     end;
except
   on E: Exception do begin
      Exit; //E.Message;
   end;
end;
end;
procedure TFrameDiaryView.actGotoExecute(Sender: TObject);
begin
try
  tCore.TabPosition := TTabPosition.None;
  tCore.Tabs[0].Visible := True;
  tCore.Tabs[1].Visible := False;
  tCore.TabIndex := 0;
  tCore.ActiveTab := uCalendar;
  Self.actSaveExecute(Self);
except
  on E: Exception do begin
     lFirst.Text := 'actGotoExecute'+#13#10+E.Message;
     Exit;
  end;
end;
end;

procedure TFrameDiaryView.actSaveExecute(Sender: TObject);
begin
  try
   if Length(Trim(mmo_src.Text)) > 0 then InsertOrUpdateBase(mmo_src.Text); //InsertBases(mmo_src.Text);
  except
    on E: Exception do begin
       lFirst.Text := 'Save Execute'+#13#10+E.Message;
       Exit;
    end;
  end;
end;

procedure TFrameDiaryView.actSpeakExecute(Sender: TObject);
begin
if Length(Trim(mmo_src.Text)) = 0 then Exit;
try
   SpeakText(mmo_src.Text);
except
  on E: Exception do begin
     lFirst.Text := 'Error SpeakText '+#13#10+E.Message;
     Exit;
  end;
end;
end;

procedure TFrameDiaryView.actTranslateExecute(Sender: TObject);
var CleanText, jOb,tmp: string; //myDate : TDateTime;
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
     mmo_src.Text := StringReplace(mmo_src.Text, #13#10, '', [rfReplaceAll]);
     CleanText := RemoveNonPrintableChars(mmo_src.Text);
     mmo_src.Text := CleanText;
     mmo_trg.Lines.Text := GetTxt(mmo_src.Lines.Text,EditView1.Tag);
except
   on E: Exception do begin
      Exit;
   end;
end;
end;

procedure TFrameDiaryView.btnClearClick(Sender: TObject);
begin
try
  mmo_src.Text := '';
  mmo_trg.Text := '';
  mmo_src.SetFocus;
except
  Exit;
end;
end;

procedure TFrameDiaryView.btnupdClick(Sender: TObject);
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

procedure TFrameDiaryView.cal1ApplyStyleLookup(Sender: TObject);
begin
try
  UpdateCalendar(Self);
except
  Exit;
end;
end;

procedure TFrameDiaryView.cal1Change(Sender: TObject);
begin
try
  UpdateCalendar(Self);
except
  Exit;
end;
end;

procedure TFrameDiaryView.cal1DateSelected(Sender: TObject);
var
  MessID: string;
begin
try
  mmo_src.Lines.Clear;
  mmo_trg.Lines.Clear;
  MessID := FormatDateTime('ddmmyyyy', cal1.Date);
  with uDMForm do begin // Сохранение в базу данных
       fQuery.SQL.Clear;
       // Загрузка данных из базы данных
       fQuery.SQL.Text := 'SELECT Message FROM t_jso_Diary WHERE MessID = :MessID';
       fQuery.ParamByName('MessID').AsString := MessID;
       fQuery.Open;
       if not fQuery.IsEmpty then begin
          mmo_src.Text := fQuery.FieldByName('Message').AsString;
          tCore.TabPosition := TTabPosition.None;
          tCore.Tabs[1].Visible := True;
          tCore.Tabs[0].Visible := False;
          tCore.TabIndex := 1;
          tCore.ActiveTab := uMessage;
       end else begin
          mmo_src.Text := '';
          tCore.TabPosition := TTabPosition.None;
          tCore.Tabs[1].Visible := True;
          tCore.Tabs[0].Visible := False;
          tCore.TabIndex := 1;
          tCore.ActiveTab := uMessage;
       end;
  end;
  mmo_src.SetFocus;
  try
    LoadDiaryDates;
  except
    on E: Exception do begin
       lFirst.Text := 'LoadDiaryDates'+#13#10+E.Message
    end;
  end;
  try
    FDMemTable1.AppendRecord([cal1.Date,'Calendar Record']);
    UpdateCalendar(Self);
  except
    on E: Exception do begin
       lFirst.Text := 'UpdateCalendar'+#13#10+E.Message
    end;
  end;
except
  on E: Exception do begin
     lFirst.Text := 'Day'+#13#10+E.Message;
     DeleteBases;
     Exit;
  end;
end;
end;

procedure TFrameDiaryView.DeleteBases;
begin
try
  if TFile.Exists(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE)) then DeleteFile(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE));
  try
    with uDMForm do
    begin
      fConnect.Open;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'DROP TABLE IF EXISTS t_jso_Diary';
      fQuery.ExecSQL;
    end;
    with uDMForm do
    begin
      fConnect.Open;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'CREATE TABLE [t_jso_Diary] ([id] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,[MessID] INTEGER  UNIQUE NULL,[Message] TEXT  NULL,[CreateDate] DATE DEFAULT CURRENT_DATE NOT NULL)';
      fQuery.ExecSQL;
    end;
  except
    on E: Exception do
    begin
       lFirst.Text := 'Error drop table: ' + E.Message;
    end;
  end;
except
  Exit;
end;
end;

procedure TFrameDiaryView.EditView1Click(Sender: TObject);
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

procedure TFrameDiaryView.FrameResize(Sender: TObject);
begin
try
  cal1.Date := Now;
  Height := LinearLayout1.Height;
  tCore.TabPosition := TTabPosition.None;
  tCore.Tabs[0].Visible := True;
  tCore.Tabs[1].Visible := False;
  tCore.TabIndex := 0;
  tCore.ActiveTab := uCalendar;
  lCount.Text := '  Number of characters:           0/7000';
  mmo_src.SetFocus;
except
  Exit;
end;
end;

end.
