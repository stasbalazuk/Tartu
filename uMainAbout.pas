unit uMainAbout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfMainAbout = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    btnClose: TButton;
    MaterialOxfordBlueSB: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMainAbout: TfMainAbout;

implementation

{$R *.fmx}

end.
