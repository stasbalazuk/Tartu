unit uFrameDialogAI;
interface
uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Edit, UI.Base, UI.Standard, UI.Frame, FMX.Memo.Types, System.SysUtils,
  System.JSON, System.Math, System.Generics.Collections, System.PushNotification, System.Notification,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts, System.ImageList,
  FMX.ImgList;

const MODEL_WizardLM = 'microsoft/WizardLM-2-8x22B';
const MODEL_GGemma29bit = 'google/gemma-2-9b-it';

type
  TSheetRowAI = class
  public
    ID: Integer;
    TextSrc: string;
    TextTrg: string;
  end;

type
  TSheetRowList = TObjectList<TSheetRowAI>;

type
  TDialogAIEvent = procedure (AView: TFrame; ASource, ATarget: string) of object;
  TFrameDialogAIView = class(TFrame)
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
    img: TImageList;
    btnClear: TButton;
    AniIndicator1: TAniIndicator;
    btnSave: TButton;
    procedure FrameResize(Sender: TObject);
    procedure uTransClick(Sender: TObject);
    procedure EditView1Click(Sender: TObject);
    procedure btnupdClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    idx: Integer;
    sheetRow: TSheetRowAI;
    FSheetData: TSheetRowList;
    FOnTranslate: TDialogAIEvent;
    procedure InsertBases(str: string; settings: string);
    function GetTxt(obj: string; idx: Integer): string;
    function GetTxtGoto(obj: string; idx: Integer): string;
  public
    { Public declarations }
    sID: Integer;
    ModelAI,tKey,uApiGemini: string;
    uLangs,uText,uPrompt,uStr: string; uStr1,uStr2: string;
    property OnTranslate: TDialogAIEvent read FOnTranslate write FOnTranslate;
  end;

implementation

{$R *.fmx}

uses
  uDM, uMyDB, UI.Dialog, uTartu;

function TFrameDialogAIView.GetTxtGoto(obj: string; idx: Integer): string;
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
     RESTRequest1.Execute;
  except
   on E: ERESTException do begin
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
      Exit;
   end;
  end;
except
   on E: ERESTException do begin
      Exit; //E.Message;
   end;
end;
end;

function TFrameDialogAIView.GetTxt(obj: string; idx: Integer): string;
var jOb : string; str : string; myObj : TJSONObject;
begin
try
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
  except
     Exit;
  end;
  try
   RESTRequest1.Execute;
  except
   on E: ERESTException do begin
      Exit;
   end;
  end;
  try
  if RESTResponse1.StatusCode in [0,200] then begin
     str := RESTResponse1.Content;
     myObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
     Result := myObj.GetValue('result').Value; //FormatJSON(str);
  end else Exit;
  except
   on E: ERESTException do begin
      Exit;
   end;
  end;
except
   on E: ERESTException do begin
      Exit; //E.Message;
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
   Exit;
end;
end;
function IsOrderIdExists(const OrderId: string): Boolean;
begin
try
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
     Exit;
  end;
end;
end;
procedure TFrameDialogAIView.InsertBases(str: string; settings: string);
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
procedure TFrameDialogAIView.uTransClick(Sender: TObject);
var CleanText: string;
begin
try
  if mmo_src.Lines.Text = '' then begin
     Hint('Enter text to request');
     Exit;
  end;
  if EditView1.Tag < 0 then begin
     Hint('Select model AI for request');
     Exit;
  end;
  if Length(Trim(mmo_src.Lines.Text)) = 0 then Exit;
     mmo_src.Text := LowerCase(Trim(mmo_src.Text));
  if (Length(Trim(uApiGemini)) > 0) then tKey := uApiGemini else lTrans.Text := 'Not Api Key'; //lTrans.Text := 'FrameDialogAI : '+tKey,0);
     uPrompt := Trim(mmo_src.Lines.Text);
     uText := uPrompt;
     uText := uText + '. Vasta ainult eesti keeles!!! Vastus peab olema ühes lauses!!! Pärast iga eestikeelse vastuse rida tõlkige see vene keelde!!!';
  if ((Length(Trim(uText)) > 0)and(Length(Trim(tKey)) > 0)) then begin
     uText := StringReplace(uText, #13#10, '', [rfReplaceAll]);
     CleanText := RemoveNonPrintableChars(uText);
   if Length(Trim(CleanText)) > 0 then begin
      uStr := FormMain.SendChatCompletion(tKey, ModelAI, Trim(CleanText), False);
      if Length(Trim(uText)) > 0 then
      if ((Length(Trim(uStr)) > 0)and(Pos('Error',uStr) = 0)) then begin
         mmo_trg.Lines.Add(uStr);
        try
          Inc(idx);
          sheetRow.ID := idx;
          sheetRow.TextSrc := mmo_src.Lines.Text;
          sheetRow.TextTrg := mmo_trg.Lines.Text;
         try
           FSheetData.Add(sheetRow);
         except
           lTrans.Text := 'Error FSheetData add info';
         end;
        except
          lTrans.Text := 'Error sheetRow add info';
        end;
      end else begin
         uStr := 'Ma ei saa aru, mida sa täpselt teada tahad?';
         mmo_trg.Lines.Add(uStr);
      end;
   end;
  end;
except
   on E: ERESTException do begin
      Exit; //E.Message;
   end;
end;
end;
procedure TFrameDialogAIView.btnClearClick(Sender: TObject);
begin
try
  mmo_src.Text := '';
  mmo_trg.Text := '';
  mmo_src.SetFocus;
except
  Exit;
end;
end;

procedure TFrameDialogAIView.btnSaveClick(Sender: TObject);
begin
try
  lTrans.Text := 'Save Data : '+#13#10+sheetRow.TextSrc+#13#10+sheetRow.TextTrg;
  sID := 5;
  FormMain.YourMessageAI(sheetRow.TextSrc);
  FormMain.FriendMessageAI(sheetRow.TextTrg);
except
  Exit;
end;
end;

procedure TFrameDialogAIView.btnupdClick(Sender: TObject);
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

procedure TFrameDialogAIView.EditView1Click(Sender: TObject);
begin
try
  TDialogBuilder.Create(Self)
      .SetSingleChoiceItems([
          'WizardLM (microsoft)',
          'Gemma-2-9b-it (Google)'
        ], EditView1.Tag,
        procedure (Dialog: IDialog; Which: Integer)
        begin
          EditView1.Tag := Dialog.Builder.CheckedItem;
          EditView1.Text := Dialog.Builder.ItemArray[Dialog.Builder.CheckedItem];
          if EditView1.Tag = 0 then ModelAI := MODEL_WizardLM;
          if EditView1.Tag = 1 then ModelAI := MODEL_GGemma29bit;
          Dialog.AsyncDismiss;
        end
      )
      .SetDownPopup(EditView1, 0, 0, TLayoutGravity.LeftBottom)
      .SetListItemDefaultHeight(34)
      .Show;
      FSheetData.Clear;
except
  Exit;
end;
end;

procedure TFrameDialogAIView.FrameResize(Sender: TObject);
begin
  try
    if not Assigned(sheetRow) then begin
       sheetRow := TSheetRowAI.Create;
       FSheetData := TSheetRowList.Create;
       lTrans.Text := 'SheetRow Create - Ok';
    end;
  except
    lTrans.Text := 'Error sheetRow';
  end;
  if idx <> 0 then idx := 0;
  Height := LinearLayout1.Height;
end;

end.
