unit pTalk;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Platform, FMX.Platform.Android,
  FMX.Controls.Presentation, FMX.Edit, FMX.Effects, FMX.StdCtrls, FMX.Layouts,
  System.Actions, FMX.ActnList;
type
  TFrmTalkMain = class(TForm)
    RectBackground: TRectangle;
    MaterialOxfordBlueSB: TStyleBook;
    Layout1: TLayout;
    btnGoto: TButton;
    ActionList1: TActionList;
    actClose: TAction;
    procedure actCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    uStr: string;
    procedure ResultSpeech(AResult: string);
  end;
var
  FTalkMain: TFrmTalkMain;

implementation

{$R *.fmx}

uses FMX.SpeechToText, AndroidSpeechRecognition;


procedure TFrmTalkMain.ResultSpeech(AResult: string);
begin
try
  uStr := AResult;
except
  Exit;
end;
end;
procedure TFrmTalkMain.FormShow(Sender: TObject);
begin
try
  TSpeech_Text.StartRecognition('SPEAK Now', ResultSpeech);
except
  Exit;
end;
end;
procedure TFrmTalkMain.actCloseExecute(Sender: TObject);
begin
try
  ModalResult := mrOk;
  Close;
except
  Exit;
end;
end;

end.
