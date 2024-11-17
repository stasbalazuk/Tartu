unit PopupFrameU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.ImageList, FMX.ImgList,
  System.Actions, FMX.ActnList, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TPopupF = class(TFrame)
    Layout1: TLayout;
    img: TImageList;
    CloseButton: TButton;
    ActionList1: TActionList;
    actClose: TAction;
    lbl: TLabel;
    procedure actCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetText(const AText: string);
  end;

var
  PopupF: TPopupF;

implementation

{$R *.fmx}

procedure TPopupF.actCloseExecute(Sender: TObject);
begin
  Self.Parent := nil;
  Self.Visible := False;
  ShowMessage('Frame is closed');
end;

procedure TPopupF.SetText(const AText: string);
begin
  lbl.Text := AText;
  lbl.Visible := True;
  lbl.BringToFront;
  lbl.Repaint; // Обновление интерфейса
  Application.ProcessMessages; // Обновление интерфейса
  ShowMessage('Text set to: ' + AText); // Отладочное сообщение
  ShowMessage('lbl.Visible: ' + BoolToStr(lbl.Visible, True)); // Проверка видимости
  ShowMessage('lbl.Height: ' + FloatToStr(lbl.Height)); // Проверка высоты
  ShowMessage('lbl.Width: ' + FloatToStr(lbl.Width)); // Проверка ширины
  ShowMessage('PopupF.Visible: ' + BoolToStr(lbl.Visible, True)); // Проверка видимости родителя
end;

end.
