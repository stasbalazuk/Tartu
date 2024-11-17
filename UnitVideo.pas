unit UnitVideo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.DialogService, uFrameTranslate, uFrameTranslateEng, UI.Frame, UI.Base, UI.Standard, UI.Toast, UI.ListView, UI.Dialog, UI.VKhelper, uLoading, UI.Async,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Actions, FMX.ActnList, DW.AdMob, DW.AdMobBannerAd, DW.AdMobAds,
  FMX.Layouts;

const
  jsCode2 = 'document.getElementsByClassName("video-stream html5-main-video")[0].playbackRate = 2.2;';
  jsCode0 = 'document.getElementsByClassName("video-stream html5-main-video")[0].playbackRate = 0;';

type
  TPlataformaVideo = (YouTube, Vimeo);

  TFrmVideo = class(TForm)
    lTitle: TLabel;
    btnGoLog: TButton;
    ActionList1: TActionList;
    actClose: TAction;
    btnTrans1: TSpeedButton;
    actTranslate: TAction;
    LinearLayout1: TLinearLayout;
    WebBrowser1: TWebBrowser;
    btnSpeed: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actTranslateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AdMobBannerAd1AdClicked(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AdMobBannerAd1AdClosed(Sender: TObject);
    procedure AdMobBannerAd1AdFailedToLoad(Sender: TObject;
      const Error: TAdError);
    procedure AdMobBannerAd1AdImpression(Sender: TObject);
    procedure AdMobBannerAd1AdLoaded(Sender: TObject);
    procedure AdMobBannerAd1AdOpened(Sender: TObject);
    procedure btnSpeedClick(Sender: TObject);
  private
    FTitulo: string; uStat: Boolean;
    FPlataforma: TPlataformaVideo;
    FCod_video: string;
    IosStyleManager: TDialogStyleManager;
    uStr: TStringList;
    FIntAd: TInterstitialAd;
    FRewAd: TRewardedAd;
    procedure KeepWebBrowserInvisible(stat: Boolean);
    procedure LoadVideoVimeo(browser: TWebBrowser; codVideo: string;
      autoplay: boolean);
    procedure LoadVideoYoutube(browser: TWebBrowser; codVideo: string);
    procedure AjustarTamanhoVideo(browser: TWebBrowser);
    procedure AdDismissedFullScreenContentHandler(Sender: TObject);
    procedure AdFailedToLoadHandler(Sender: TObject; const AError: TAdError);
    procedure AdFailedToShowFullScreenContentHandler(Sender: TObject; const AError: TAdError);
    procedure AdLoadedHander(Sender: TObject);
  //  procedure AdMobConsentErrorHandler(Sender: TObject; const AError: TConsentError);
  //  procedure AdMobConsentCompleteHandler(Sender: TObject; const AStatus: TConsentStatus);
    procedure AdWillPresentFullScreenContentHandler(Sender: TObject);
    function GetErrorMessage(const AEvent: string; const ASender: TObject; const AError: TAdError): string;
    procedure UserEarnedRewardHandler(Sender: TObject; const AReward: TAdReward);
  public
    uLang: Integer;
    uPrivUser: Boolean;
    constructor Create(AOwner: TComponent); override;
    property codVideo: string read FCod_video write FCod_video;
    property titulo: string read FTitulo write FTitulo;
    property plataforma: TPlataformaVideo read FPlataforma write FPlataforma;
  end;

var
  FrmVideo: TFrmVideo; tmr: array[0..2] of Integer = (15000, 30000, 60000); // Время в миллисекундах

const
  PROPORCAO = 0.5625;  // 1920x1080  (1080 dividido por 1920)

implementation

{$R *.fmx}

const
  cConsentStatusValues: array[TConsentStatus] of string = ('Unknown', 'Required', 'Not Required', 'Obtained');

{ TForm1 }

constructor TFrmVideo.Create(AOwner: TComponent);
begin
try
  inherited;
  FIntAd := TInterstitialAd.Create;
  FIntAd.AdUnitID := 'ca-app-pub-3779339533209227/6683647908';
  FIntAd.TestMode := False;
  FIntAd.OnAdDismissedFullScreenContent := AdDismissedFullScreenContentHandler;
  FIntAd.OnAdFailedToShowFullScreenContent := AdFailedToShowFullScreenContentHandler;
  FIntAd.OnAdWillPresentFullScreenContent := AdWillPresentFullScreenContentHandler;
  FIntAd.OnAdLoaded := AdLoadedHander;
  FIntAd.OnAdFailedToLoad := AdFailedToLoadHandler;

  FRewAd := TRewardedAd.Create;
  FRewAd.TestMode := False;
  FRewAd.OnAdDismissedFullScreenContent := AdDismissedFullScreenContentHandler;
  FRewAd.OnAdFailedToShowFullScreenContent := AdFailedToShowFullScreenContentHandler;
  FRewAd.OnAdWillPresentFullScreenContent := AdWillPresentFullScreenContentHandler;
  // RewardAds only
  FRewAd.OnUserEarnedReward := UserEarnedRewardHandler;
  uStr.Append('AdUnitId - ' + IntToStr(FRewAd.GetHashCode) + ' - '+FIntAd.AdUnitID);
  if not uPrivUser then FIntAd.Load;
except
  Exit;
end;
end;

procedure TFrmVideo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
   WebBrowser1.Stop;
   Action := TCloseAction.caFree; // Освобождаем ресурсы формы при закрытии
   FrmVideo := nil; // Устанавливаем переменную в nil
except
  Exit;
end;
end;

procedure TFrmVideo.FormCreate(Sender: TObject);
begin
try
  uStat := False;
  uStr := TStringList.Create;
  IosStyleManager := TDialogStyleManager.Create(nil);
  IosStyleManager.BackgroundPadding.Top := 15;
  IosStyleManager.BackgroundRadius := 15;
  IosStyleManager.TitleHeight := 40;
  IosStyleManager.TitleTextBold := True;
  IosStyleManager.TitleGravity := TLayoutGravity.CenterHBottom;
  IosStyleManager.TitleTextSize := 17;
  IosStyleManager.TitleTextColor := $FF1A1A1A;
  IosStyleManager.TitleSpaceColor := IosStyleManager.BodyBackgroundColor;
  IosStyleManager.MessageTextMargins.Left := 10;
  IosStyleManager.MessageTextMargins.Right := 10;
  IosStyleManager.MessageTextMargins.Bottom := 10;
  IosStyleManager.MessageTextColor := $FF030303;
  IosStyleManager.MessageTextGravity := TLayoutGravity.Center;
  IosStyleManager.ButtonTextColor.Default := $FF0D69FF;
  IosStyleManager.ButtonHeight := 50;
except
  Exit;
end;
end;

procedure TFrmVideo.FormDestroy(Sender: TObject);
begin
try
  if Assigned(uStr) then uStr.Free;
except
  Exit;
end;
end;

procedure TFrmVideo.FormResize(Sender: TObject);
begin
try
  AjustarTamanhoVideo(WebBrowser1);
except
  Exit;
end;
end;

procedure TFrmVideo.actCloseExecute(Sender: TObject);
begin
try
  Close; // Закрываем форму
except
  Exit;
end;
end;

procedure RemoveFrameFromParent(Frame: TFrame);
begin
  try
    if Assigned(Frame) and Assigned(Frame.Parent) then
    begin
      // Удалить фрейм из родительского контейнера
      Frame.Parent.RemoveObject(Frame);
    end;
  except
    TDialogService.ShowMessage('Error Remove Object!');
    Exit;
  end;
end;

procedure DestroyFrame(Frame: TFrame);
begin
  try
    if Assigned(Frame) then
    begin
      // Освободить экземпляр фрейма из памяти
      Frame.DisposeOf;
    end;
  except
    TDialogService.ShowMessage('Error Frame DisposeOf!');
    Exit;
  end;
end;

procedure DestroyAndRemoveFrame(Frame: TFrame);
begin
  try
    DestroyFrame(Frame);
    RemoveFrameFromParent(Frame);
  except
    TDialogService.ShowMessage('Error Destroy and Remove Frame!');
    Exit;
  end;
end;

procedure TFrmVideo.KeepWebBrowserInvisible(stat: Boolean);
begin
  try
    WebBrowser1.Stop;
    WebBrowser1.Visible := stat;
    LinearLayout1.Visible := stat;
  except
    Exit;
  end;
end;

procedure TFrmVideo.actTranslateExecute(Sender: TObject);
var View: TFrameTranslateView; Vew: TFrameTranslateEngView;
begin
try
  if uLang = 0 then begin
    // Создание и настройка нового фрейма
    KeepWebBrowserInvisible(False);
    Vew := TFrameTranslateEngView.Create(Self);
    Vew.Parent := LinearLayout1;
    TDialogBuilder.Create(Self)
      .SetStyleManager(IosStyleManager)
      .SetView(Vew)
      .SetPosition(TDialogViewPosition.Bottom)
      .SetCancelButton('Cancel',
      procedure (Dialog: IDialog; Which: Integer) begin
        if Assigned(Vew) then
         begin
          // Освободить экземпляр фрейма из памяти
          DestroyAndRemoveFrame(Vew);
          KeepWebBrowserInvisible(True); //          SetRandomInterval;
         end;
      end
    )
    .Show;
  end else begin
    // Создание и настройка нового фрейма
    KeepWebBrowserInvisible(False);
    View := TFrameTranslateView.Create(Self);
    View.Parent := LinearLayout1;
    TDialogBuilder.Create(Self)
      .SetStyleManager(IosStyleManager)
      .SetView(View)
      .SetPosition(TDialogViewPosition.Bottom)
      .SetCancelButton('Cancel',
      procedure (Dialog: IDialog; Which: Integer) begin
        if Assigned(View) then
         begin
          // Освободить экземпляр фрейма из памяти
          DestroyAndRemoveFrame(View);
          KeepWebBrowserInvisible(True); //          SetRandomInterval;
         end;
      end
    )
    .Show;
  end;
except
  Exit;
end;
end;

function TFrmVideo.GetErrorMessage(const AEvent: string; const ASender: TObject; const AError: TAdError): string;
begin
try
  Result := Format('%s (%s)'#13#10'%d: %s ', [AEvent, ASender.ClassName, AError.ErrorCode, AError.Message]);
except
  Exit;
end;
end;

procedure TFrmVideo.AdDismissedFullScreenContentHandler(Sender: TObject);
begin
try
  uStr.Append('Fullscreen Ad Dismissed '+Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AdFailedToLoadHandler(Sender: TObject; const AError: TAdError);
begin
try
  uStr.Append(GetErrorMessage('Ad Failed To Load', Sender, AError));
except
  Exit;
end;
end;

procedure TFrmVideo.AdFailedToShowFullScreenContentHandler(Sender: TObject; const AError: TAdError);
begin
try
  uStr.Append(GetErrorMessage('Fullscreen Ad Failed', Sender, AError));
except
  Exit;
end;
end;

procedure TFrmVideo.AdLoadedHander(Sender: TObject);
begin
try
  uStr.Append('Ad Loaded '+ Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AdWillPresentFullScreenContentHandler(Sender: TObject);
begin
try
  uStr.Append('Fullscreen Ad Will Present ' + Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.UserEarnedRewardHandler(Sender: TObject; const AReward: TAdReward);
begin
try
  uStr.Append('Rewarded Ad Reward - ' + AReward.RewardType + ': ' + AReward.Amount.ToString);
except
  Exit;
end;
end;

procedure TFrmVideo.AdMobBannerAd1AdClicked(Sender: TObject);
begin
try
  uStr.Append('Ad Clicked ' + Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AdMobBannerAd1AdClosed(Sender: TObject);
begin
try
  uStr.Append('Ad Closed ' + Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AdMobBannerAd1AdFailedToLoad(Sender: TObject;
  const Error: TAdError);
begin
try
  uStr.Append(GetErrorMessage('Ad Failed To Load', Sender, Error));
except
  Exit;
end;
end;

procedure TFrmVideo.AdMobBannerAd1AdImpression(Sender: TObject);
begin
try
  uStr.Append('Ad Impression ' + Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AdMobBannerAd1AdLoaded(Sender: TObject);
begin
try
  uStr.Append('Ad Loaded ' + Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AdMobBannerAd1AdOpened(Sender: TObject);
begin
try
  uStr.Append('Ad Opened ' + Sender.ClassName);
except
  Exit;
end;
end;

procedure TFrmVideo.AjustarTamanhoVideo(browser: TWebBrowser);
var
    w, h: integer;
begin
try
    w := Trunc(browser.width - 30);
    h := Trunc(w * PROPORCAO) + 10;
    browser.Height := h;
except
  Exit;
end;
end;

procedure TFrmVideo.btnSpeedClick(Sender: TObject);
begin
  try
    if btnSpeed.StyleLookup = 'playtoolbutton' then
    begin
      btnSpeed.StyleLookup := 'pausetoolbutton';
      WebBrowser1.EvaluateJavaScript('player.setPlaybackRate(2.2);');  // Используйте API для изменения скорости
    end
    else
    begin
      btnSpeed.StyleLookup := 'playtoolbutton';
      WebBrowser1.EvaluateJavaScript('player.setPlaybackRate(1);');  // Сброс скорости
    end;
  except
    Exit;
  end;
end;

{procedure TFrmVideo.LoadVideoYoutube(browser: TWebBrowser; codVideo: string);
var
    html: string;
begin
try
    html := '<!DOCTYPE html>' +
      '<html>' +
      '<head>' +
      '<style>' +
      '.container {position: relative; overflow: hidden; width: 100%; padding-top: 56.25%;}{ ' +
      '.responsive-iframe {position: absolute; top: 0; left: 0; bottom: 0; right: 0; width: 100%; height: 100%;}{ ' +
      '</style>' +
      '<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>' + // compatibility mode
      '</head>' +
      '<body style="margin:0;height: 100%; overflow: hidden">' +
      '<iframe class="responsive-iframe"  ' +
      'src="https://www.youtube.com/embed/' + codVideo +
      '?controls=0' +
      ' frameborder="0" ' +
      ' autoplay=1&rel=0&controls=0&showinfo=0" ' +
      ' allow="autoplay" frameborder="0">' +
      '</iframe>' +
       '</body>' +
      '</html>';
    AjustarTamanhoVideo(browser);
    browser.LoadFromStrings(html, '');
except
  Exit;
end;
end;}

procedure TFrmVideo.LoadVideoYoutube(browser: TWebBrowser; codVideo: string);
var
    html: string;
begin
try
    html := '<!DOCTYPE html>' +
      '<html>' +
      '<head>' +
      '<script src="https://www.youtube.com/iframe_api"></script>' +  // Подключаем API
      '<style>' +
      'body { margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; }' + // Устанавливаем стили для body
      '.container { position: relative; overflow: hidden; width: 100%; height: 100%; }' +
      '.responsive-iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; } ' +
      '</style>' +
      '<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>' + // compatibility mode
      '</head>' +
      '<body>' +
      '<div class="container">' +
      '<div id="player" class="responsive-iframe"></div>' +
      '</div>' +
      '<script>' +
      'var player; ' +
      'function onYouTubeIframeAPIReady() {' +
      '    player = new YT.Player("player", {' +
      '        height: "100%",' +
      '        width: "100%",' +
      '        videoId: "' + codVideo + '",' +
      '        events: {' +
      '            "onReady": onPlayerReady' +
      '        }' +
      '    });' +
      '}' +
      'function onPlayerReady(event) {' +
      '    event.target.playVideo();' +
      '}' +
      '</script>' +
      '</body>' +
      '</html>';
    AjustarTamanhoVideo(browser);
    browser.LoadFromStrings(html, '');
except
    Exit;
end;
end;

procedure TFrmVideo.LoadVideoVimeo(browser: TWebBrowser; codVideo: string; autoplay: boolean);
var
    html: string;
    play: string;
begin
try
    if autoplay then play := '1' else play := '0';
    html := '<!DOCTYPE html>' +
      '<html>' +
      '<head>' +
      '<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>' +
      '</head>' +
      '<body style="margin:0;height: 100%; overflow: hidden">' +

      '<div style="padding:56.25% 0 0 0;position:relative;">' +
      '<iframe  src="https://player.vimeo.com/video/' + codVideo + '?h=3ca13aab9d&autoplay=' +  play + '&title=0&byline=0&portrait=0" ' +
      'style="position:absolute;top:0;left:0;width:100%;height:100%;" ' +
      'frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen>' +
      '</iframe>' +
      '</div>' +
      '<script src="https://player.vimeo.com/api/player.js"></script>' +

       '</body>' +
      '</html>';

    AjustarTamanhoVideo(browser);
    browser.LoadFromStrings(html, '');
except
  Exit;
end;
end;

procedure TFrmVideo.FormShow(Sender: TObject);
begin
try
  lTitle.Text := titulo;
  if plataforma = YouTube then
      LoadVideoYouTube(WebBrowser1, codVideo)
  else
      LoadVideoVimeo(WebBrowser1, codVideo, false);
except
  Exit;
end;
end;

end.

