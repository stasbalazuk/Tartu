unit uFrameQuestion;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Edit, UI.Base, UI.Standard, UI.Frame, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;
type
  TQuestionEvent = procedure (AView: TFrame; ASource, ATarget: string) of object;
  TFrameQuestionView = class(TFrame)
    LinearLayout1: TLinearLayout;
    Memo1: TMemo;
    procedure FrameResize(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
    FOnQuestion: TQuestionEvent;
  public
    { Public declarations }
    uQuestion: string;
    property OnQuestion: TQuestionEvent read FOnQuestion write FOnQuestion;
  end;
implementation
{$R *.fmx}
uses
  UI.Dialog;
procedure TFrameQuestionView.FrameResize(Sender: TObject);
begin
  Height := LinearLayout1.Height;
end;
procedure TFrameQuestionView.Memo1Change(Sender: TObject);
begin
try
  if Memo1.Lines.Text = '' then begin
     Hint('Exit');
     Exit;
  end;
  uQuestion := LowerCase(Trim(Memo1.Lines.Text));
except
  Exit;
end;
end;

end.
