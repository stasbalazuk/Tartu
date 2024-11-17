program tartu;
uses
  System.StartUpCopy,
  FMX.Forms,
  BFA.Func in 'sources\BFA.Func.pas',
  BFA.Rest in 'sources\BFA.Rest.pas',
  uTartu in 'uTartu.pas' {FormMain},
  uMyDB in 'uMyDB.pas' {uDMForm: TDataModule},
  uLoading in 'Units\uLoading.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait];
  Application.CreateForm(TuDMForm, uDMForm);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
