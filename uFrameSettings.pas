unit uFrameSettings;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UI.Edit, UI.Base, UI.Standard, UI.Frame, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Layouts;
type
  TQuestionEvent = procedure (AView: TFrame; ASource, ATarget: string) of object;
  TFrameSettingsWordsView = class(TFrame)
    LinearLayout1: TLinearLayout;
    lName: TLabel;
    Layout1: TLayout;
    chkA1: TCheckBox;
    chkA2: TCheckBox;
    chkB1: TCheckBox;
    chkB2: TCheckBox;
    chkC1: TCheckBox;
    procedure FrameResize(Sender: TObject);
    procedure chkA1Change(Sender: TObject);
    procedure chkA2Change(Sender: TObject);
    procedure chkB1Change(Sender: TObject);
    procedure chkB2Change(Sender: TObject);
    procedure chkC1Change(Sender: TObject);
  private
    { Private declarations }
    FOnQuestion: TQuestionEvent;
  public
    { Public declarations }
    uA1,uA2,uB1,uB2,uC1: Boolean;
    property OnQuestion: TQuestionEvent read FOnQuestion write FOnQuestion;
  end;
implementation
{$R *.fmx}
uses
  UI.Dialog;

procedure TFrameSettingsWordsView.chkA1Change(Sender: TObject);
begin
  chkA1.IsChecked := True;
  chkA2.IsChecked := False;
  chkB1.IsChecked := False;
  chkB2.IsChecked := False;
  chkC1.IsChecked := False;
end;

procedure TFrameSettingsWordsView.chkA2Change(Sender: TObject);
begin
  chkA1.IsChecked := False;
  chkA2.IsChecked := True;
  chkB1.IsChecked := False;
  chkB2.IsChecked := False;
  chkC1.IsChecked := False;
end;

procedure TFrameSettingsWordsView.chkB1Change(Sender: TObject);
begin
  chkA1.IsChecked := False;
  chkA2.IsChecked := False;
  chkB1.IsChecked := True;
  chkB2.IsChecked := False;
  chkC1.IsChecked := False;
end;

procedure TFrameSettingsWordsView.chkB2Change(Sender: TObject);
begin
  chkA1.IsChecked := False;
  chkA2.IsChecked := False;
  chkB1.IsChecked := False;
  chkB2.IsChecked := True;
  chkC1.IsChecked := False;
end;

procedure TFrameSettingsWordsView.chkC1Change(Sender: TObject);
begin
  chkA1.IsChecked := False;
  chkA2.IsChecked := False;
  chkB1.IsChecked := False;
  chkB2.IsChecked := False;
  chkC1.IsChecked := True;
end;

procedure TFrameSettingsWordsView.FrameResize(Sender: TObject);
begin
  Height := LinearLayout1.Height;
end;

end.
