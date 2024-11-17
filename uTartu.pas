unit uTartu;
interface
uses
  DECFormat,
  DECFormatBase,
  JOSE.Core.JWT,
  JOSE.Core.JWS,
  JOSE.Core.JWK,
  JOSE.Core.JWA,
  JOSE.Types.Bytes,
  JOSE.Types.JSON,
  JOSE.Core.Builder,
  System.Messaging, System.RegularExpressions, System.StrUtils,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Permissions,
  System.PushNotification, System.Notification, System.DateUtils, System.Threading, System.Math,
  FMX.Types, FMX.Styles,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.TabControl,
  FMX.StdCtrls,
  FMX.Gestures,
  FMX.Controls.Presentation,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Edit,
  FMX.Media, FMX.Clipboard,
  FMX.DialogService,
  FMX.PushNotification.Android,
  FMX.Platform.Android, FMX.Platform, FMX.BiometricAuth,
  FMX.MediaLibrary.Actions, FMX.MediaLibrary, FMX.ImgList,
  FMX.Effects, FMX.Objects, FMX.Ani, FMX.Layouts, FMX.ActnList,
  FMX.Grid.Style, FMX.Grid, FMX.ListView.Types,
  FMX.StdActns, FMX.ListBox, FMX.MultiView, FMX.TextLayout,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FirebaseAuthClass, FireDAC.Comp.UI, FireDAC.Phys.SQLite,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions,
  {$IFDEF ANDROID or IOS}
  AndroidTTS,
  Androidapi.NativeActivity,
  Androidapi.NativeWindow,
  Androidapi.NativeWindowJni, Androidapi.JNIBridge, Androidapi.JNI.Provider,
  Androidapi.JNI.Os, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes, Androidapi.JNI.Webkit, Androidapi.JNI.Net,
  Androidapi.JNI.App, Androidapi.JNI.Support,
  Androidapi.Helpers, Androidapi.Jni.Media,
  Androidapi.JNI.Widget,
  Androidapi.JNI.Java.Net, Androidapi.Jni.Embarcadero,
  {$ENDIF}
  REST.Types, REST.Client,
  DW.Biometric, DW.WebBrowserExt, DW.IOUtils.Helpers, DW.WebChromeClient.Android, DW.AppUpdate,
  DW.OSLog, DW.Consts.Android, DW.Permissions.Helpers, DW.Androidapi.JNI.DWWebChromeClient, DW.TextToSpeech,
  Data.Bind.Components, Data.Bind.ObjectScope, System.ImageList, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  System.Rtti, Data.Bind.DBScope, UnitVideo, HtmlParserEx,
  UI.Frame, UI.Base, UI.Standard, UI.Toast, UI.ListView, UI.Dialog, UI.Async, uLoading,// UI.VKhelper,
  uFrameTranslate, uFrameDiary, uFrameQuestion, uFrameDialogAI, FMX.WebBrowser, System.JSON,
  FMX.Advertising, FMX.SVGIconImage, uFrameSettings, System.Generics.Collections,
  DW.AdMob, DW.AdMobBannerAd, DW.AdMobAds;

const uPassword = 'password';
const TEST_FILE = 'lgn.txt';
const tSwitchFile = 'sw.st';
const BASES_FILE = 'bs.bsb';
const BASES_CRYPTFILE = 'bs.cry';
const BASES_OLD_FILE = 'bs';
const cTouchMeCaption = 'Now touch the fingerprint sensor!';
const RSA = 'MIIBIjANBgk...';
const headerJwt = '{"alg":"RS256","typ":"JWT"}';
const DBExport: integer = 88;
const uRLs = '@STR';
const uRLWords = '@WORDS';
const uSheetId = '1xAMa...';
const uApiKey = 'AIzaS...';
const DBImport: integer = 99;
const API_URL = 'https://api.deepinfra.com/v1/openai/chat/completions';
const MODEL_WizardLM = 'microsoft/WizardLM-2-8x22B';
const MODEL_GGemma29bit = 'google/gemma-2-9b-it';
const uTokenW = '1BXb5T...';
const uToken = '1U2mAr...';
const uTokenKusiMA = '1Znzt...';
const uTokenDatas = '1BXb5T...';
const uKeyEnc = 'Key12345';
const uVectEnc = '123456';
const FAPIKEY = 'AIzaS...';
const uPrivUsers = '1Q8U...';
const uGoogleApiKeys = 'AIza...';
const uGoogleApiKeySheets = '1wTtO...';
const uGoogleApiGemeni = '1c5T...';
const uTokenEngPlayList = '1hSY...';
const uTokenEstPlayList = '1Ek...';
const uTokenEksView = '18a...';
const uGamesEng = 'https://www.gamestolearnenglish.com';
const uGamesEngOne = 'https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcS...';

const uSTS = 'https://www.17-minute-languages.com/affiliates/?id=TBR131279&ok=1';
const uSTST = 'https://www.17-minute-languages.com/affiliates/?id=TBR131279&ok=1';
const uSTSnu = 'https://www.17-minute-languages.com/affiliates/?id=TBR131279&ok=1;
const uSTSP = 'https://www.17-minute-languages.com/affiliates/?id=TBR131279&ok=1';
const uKellB1 = 'https://www.keeletee.ee/en/login';
const uSTSLern = 'https://numbrid.eestikeeles.ee';
const uRLSTS = 'https://buymeacoffee.com/stalkersts';
const uTPrivPolicy = 'https://topgame.work/...';
const uCheckedP = 'document.querySelector("#name").value = "login"; document.querySelector("#pass").value = "pass"; document.querySelector("#remember").checked = true;'+' document.querySelector("#content > div > table > tbody > tr:nth-child(8) > td.bottom.left > div:nth-child(1) > input").click();';
const uApiSheets = '1YRb...';
const uTokenSheets = '1dX7V...';
const uTokenAntonimid = '1lyC...';
const uTokenPostpositsioonid = '1fkp...';
const uTokenEestiGames = '1xyg...';
const uTextLabel = 'Translation :                                               0 / 7000';
const myJson = '{privat}';

type
  TCustomStringsListAdapter = class(UI.ListView.TStringsListAdapter)
  protected
    function GetView(const Index: Integer; ConvertView: TViewBase; Parent: TViewGroup): TViewBase; override;
  end;

type
  TGoogleServiceAccount = class
  strict private
    FServiceAccountKey: TJSONObject;
    FAccessToken: string;
    FAccessTokenExpiry: TDateTime;
    function GetAccessToken: string;
  public
    constructor Create(const ServiceAccountKeyFile: string);
    property AccessToken: string read GetAccessToken;
  end;

type
  TSheetRow = class
  public
    ID: Integer;
    Column2: string;
    Column3: string;
    Column4: string;
  end;

type
  TSheetRowList = TObjectList<TSheetRow>;

type
  TSheetPostpositsiooneRow = class
  public
    ID: Integer;
    Question: string;
    Word: string;
    Example: string;
  end;

type
  TSheetPostpositsiooneRowList = TObjectList<TSheetPostpositsiooneRow>;

type
  TSheetQuestRow = class
  public
    ID: Integer;
    EstWord: string;
    RusWord: string;
    AinWord: string;
    MitWord: string;
    PadWord: string;
    ExaWord: string;
  end;

type
  TSheetQuestRowList = TObjectList<TSheetQuestRow>;

type
  TSheetExampRow = class
  public
    ID: Integer;
    ExaWord: string;
    EstWord: string;
    RusWord: string;
  end;

type
  TSheetExampRowList = TObjectList<TSheetExampRow>;

type
  TSheetUrlRow = class
  public
    ID: Integer;
    Url: string;
  end;

type
  TSheetUrlRowList = TObjectList<TSheetUrlRow>;

type
  TTranslationRecord = record
    ID: Integer;
    EstonianWord: string;
    RussianTranslation: string;
    ExtraData: string; // Например, строка в формате (Maja, Maja, Maja)
    Number: Integer;
    LevelWords: string;
  end;

type
  TSheetRowGames = class
  public
    ID: Integer;
    Column2: string;
    Column3: string;
  end;

type
  TSheetRowListGames = TObjectList<TSheetRowGames>;

type
  JEnvironmentClass = interface(JObjectClass)
  ['{D131F4D4-A6AD-43B7-B2B6-A9222BC46C74}']
    function _GetMEDIA_BAD_REMOVAL: JString; cdecl;
    function _GetMEDIA_CHECKING: JString; cdecl;
    function _GetMEDIA_EJECTING: JString; cdecl;
    function _GetMEDIA_MOUNTED: JString; cdecl;
    function _GetMEDIA_MOUNTED_READ_ONLY: JString; cdecl;
    function _GetMEDIA_NOFS: JString; cdecl;
    function _GetMEDIA_REMOVED: JString; cdecl;
    function _GetMEDIA_SHARED: JString; cdecl;
    function _GetMEDIA_UNKNOWN: JString; cdecl;
    function _GetMEDIA_UNMOUNTABLE: JString; cdecl;
    function _GetMEDIA_UNMOUNTED: JString; cdecl;
    function _GetDIRECTORY_ALARMS: JString; cdecl;
    function _GetDIRECTORY_DCIM: JString; cdecl;
    function _GetDIRECTORY_DOCUMENTS: JString; cdecl;
    function _GetDIRECTORY_DOWNLOADS: JString;
    function _GetDIRECTORY_MOVIES: JString; cdecl;
    function _GetDIRECTORY_MUSIC: JString; cdecl;
    function _GetDIRECTORY_NOTIFICATIONS: JString; cdecl;
    function _GetDIRECTORY_PICTURES: JString; cdecl;
    function _GetDIRECTORY_PODCASTS: JString; cdecl;
    function _GetDIRECTORY_RINGTONES: JString; cdecl;
    {class} function init: JEnvironment; cdecl;
    {class} function getDataDirectory: JFile; cdecl;
    {class} function getDownloadCacheDirectory: JFile; cdecl;
    {class} function getExternalStorageDirectory(): JFile; cdecl;
    {class} function getExternalStoragePublicDirectory(&type: JString): JFile; cdecl;
    {class} function getExternalStorageState: JString; cdecl; overload;
    {class} function getExternalStorageState(path: JFile): JString; cdecl; overload;
    {class} function getRootDirectory: JFile; cdecl;
    {class} function getStorageState(path: JFile): JString; cdecl;
    {class} function getStorageDirectory: JFile; cdecl; // **** Android 11 ****
    {class} function isExternalStorageEmulated: Boolean; cdecl; overload;
    {class} function isExternalStorageEmulated(path: JFile): Boolean; cdecl; overload;
    {class} function isExternalStorageLegacy: Boolean; cdecl; overload; // **** Android 10 ****
    {class} function isExternalStorageLegacy(path: JFile): Boolean; cdecl; overload; // **** Android 10 ****
    {class} function isExternalStorageManager: Boolean; cdecl; overload; // **** Android 11 ****
    {class} function isExternalStorageManager(path: JFile): Boolean; cdecl; overload; // **** Android 11 ****
    {class} function isExternalStorageRemovable: Boolean; cdecl; overload;
    {class} function isExternalStorageRemovable(path: JFile): Boolean; cdecl; overload;
    {class} property MEDIA_BAD_REMOVAL: JString read _GetMEDIA_BAD_REMOVAL;
    {class} property MEDIA_CHECKING: JString read _GetMEDIA_CHECKING;
    {class} property MEDIA_EJECTING: JString read _GetMEDIA_EJECTING;
    {class} property MEDIA_MOUNTED: JString read _GetMEDIA_MOUNTED;
    {class} property MEDIA_MOUNTED_READ_ONLY: JString read _GetMEDIA_MOUNTED_READ_ONLY;
    {class} property MEDIA_NOFS: JString read _GetMEDIA_NOFS;
    {class} property MEDIA_REMOVED: JString read _GetMEDIA_REMOVED;
    {class} property MEDIA_SHARED: JString read _GetMEDIA_SHARED;
    {class} property MEDIA_UNKNOWN: JString read _GetMEDIA_UNKNOWN;
    {class} property MEDIA_UNMOUNTABLE: JString read _GetMEDIA_UNMOUNTABLE;
    {class} property MEDIA_UNMOUNTED: JString read _GetMEDIA_UNMOUNTED;
    {class} property DIRECTORY_ALARMS: JString read _GetDIRECTORY_ALARMS;
    {class} property DIRECTORY_DCIM: JString read _GetDIRECTORY_DCIM;
    {class} property DIRECTORY_DOCUMENTS: JString read _GetDIRECTORY_DOCUMENTS;
    {class} property DIRECTORY_DOWNLOADS: JString read _GetDIRECTORY_DOWNLOADS;
    {class} property DIRECTORY_MOVIES: JString read _GetDIRECTORY_MOVIES;
    {class} property DIRECTORY_MUSIC: JString read _GetDIRECTORY_MUSIC;
    {class} property DIRECTORY_NOTIFICATIONS: JString read _GetDIRECTORY_NOTIFICATIONS;
    {class} property DIRECTORY_PICTURES: JString read _GetDIRECTORY_PICTURES;
    {class} property DIRECTORY_PODCASTS: JString read _GetDIRECTORY_PODCASTS;
    {class} property DIRECTORY_RINGTONES: JString read _GetDIRECTORY_RINGTONES;
  end;

  [JavaSignature('android/os/Environment')]
  JEnvironment = interface(JObject)
  ['{83A2E94E-7D8E-432F-BE21-AEC2115015BE}']
  end;

  TJEnvironment = class(TJavaGenericImport<JEnvironmentClass, JEnvironment>);
type
  TPlaylistItem = record
    PlaylistID: string;
    PlaylistName: string;
  end;
type
  TDataEntry = record
    DateTime: TDateTime;
    Source: string;
    Translation: string;
  end;
type
  TFormMain = class(TForm)
    GestureManager1: TGestureManager;
    TabControl1: TTabControl;
    uAuth1: TTabItem;
    LayAuth: TLayout;
    RectFon: TRectangle;
    LytBody: TLayout;
    RctQuiz: TRectangle;
    LytAnswers: TLayout;
    RctSignUp: TRectangle;
    TxtOptionFirst: TText;
    FloatAnimation2: TFloatAnimation;
    RctResetPassWord: TRectangle;
    TxtOptionThird: TText;
    FloatAnimation3: TFloatAnimation;
    RctSignIn: TRectangle;
    TxtOptionSecond: TText;
    FloatAnimation4: TFloatAnimation;
    RctExit: TRectangle;
    TextExit: TText;
    FloatAnimation5: TFloatAnimation;
    InnerGlowEffect4: TInnerGlowEffect;
    LayLogin: TLayout;
    InnerGlowEffect6: TInnerGlowEffect;
    uLogger: TTabItem;
    LayLogger: TLayout;
    mLog: TMemo;
    ShadowEffect3: TShadowEffect;
    Layout4: TLayout;
    btnGoto: TButton;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    SettingsFDMemTable: TFDMemTable;
    NotificationCenter1: TNotificationCenter;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    ActionList1: TActionList;
    actSignUp: TAction;
    actSignIn: TAction;
    actResetPass: TAction;
    actExit: TAction;
    actGoto: TAction;
    ActionList2: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    Core: TTabItem;
    Layout1: TLayout;
    MultiView: TMultiView;
    Rectangle1: TRectangle;
    LabMenu: TLabel;
    Layout3: TLayout;
    actGotoLog: TAction;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Layout2: TLayout;
    btnGo: TButton;
    Layout6: TLayout;
    Layout8: TLayout;
    lstatus: TLabel;
    mmo_src: TMemo;
    mmo_trg: TMemo;
    acSwitch: TAction;
    BiometricAuth1: TBiometricAuth;
    REnter: TRectangle;
    FloatAnimation6: TFloatAnimation;
    BiometricImage: TImage;
    Arc1: TArc;
    FloatAnimation7: TFloatAnimation;
    acBiometria: TAction;
    acBioClick: TAction;
    acTranslate: TAction;
    acTranslateTxT: TAction;
    img: TImageList;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    Layout9: TLayout;
    l_sett: TLabel;
    Layout10: TLayout;
    actArowUpDown: TAction;
    acSaveData: TAction;
    SBMenu1: TSpeedButton;
    Layout11: TLayout;
    actAbout: TAction;
    uBases: TTabItem;
    Layout14: TLayout;
    Layout15: TLayout;
    btnGoTo1: TButton;
    btnAbout: TButton;
    Button1: TButton;
    mpUI: TMediaPlayer;
    actBases: TAction;
    mmoBases: TMemo;
    btnSaveTrans: TButton;
    btnTheBack: TButton;
    btnLoadBases: TButton;
    btnTrash: TButton;
    acTrash: TAction;
    actSaveToBases: TAction;
    lbName: TLabel;
    btnAdm: TButton;
    actAdmin: TAction;
    actEncrypt: TAction;
    actDecrypt: TAction;
    actVerif: TAction;
    bSendData: TButton;
    actSaveEncryptBases: TAction;
    actUpdatePrg: TAction;
    actSortView: TAction;
    BindSourceDB1: TBindSourceDB;
    spl1: TSplitter;
    actSearch: TAction;
    actLoadBases: TAction;
    actGoExportImport: TAction;
    lblSaveBases: TLabel;
    actExportBases: TAction;
    actImportBases: TAction;
    bSaveBases: TButton;
    l_Count_db: TLabel;
    ds1: TDataSource;
    uKusi: TTabItem;
    Layout12: TLayout;
    Layout13: TLayout;
    Button4: TButton;
    Label3: TLabel;
    Button5: TButton;
    mmoKusi: TMemo;
    actGetKusiMusi: TAction;
    swtch1: TSwitch;
    Rectangle2: TRectangle;
    Text1: TText;
    FloatAnimation1: TFloatAnimation;
    actSaveDataKusi: TAction;
    actAllKusi: TAction;
    actGetGSheets: TAction;
    RESTRespKusi: TRESTResponse;
    RESTReqKusi: TRESTRequest;
    RESTClnKusi: TRESTClient;
    actGetKusi: TAction;
    actGetKusiMAALL: TAction;
    btnEncryptPGP: TButton;
    Path6: TPath;
    btnDecryptPGP: TButton;
    Path7: TPath;
    btnSend: TButton;
    actSendCryptoText: TAction;
    Image1: TImage;
    Image2: TImage;
    actViewChat: TAction;
    mmoInfo: TMemo;
    Rectangle3: TRectangle;
    FloatAnimation10: TFloatAnimation;
    Text4: TText;
    btnClearVSB: TButton;
    actClearVSB: TAction;
    RESTClient3: TRESTClient;
    RESTRequest3: TRESTRequest;
    RESTResponse3: TRESTResponse;
    actPlus: TAction;
    AddPanelButton: TSpeedButton;
    AddPanelAction: TAction;
    RemovePanelAction: TAction;
    uYoutube: TTabItem;
    Layout17: TLayout;
    btnGoLog: TButton;
    lvVideos: TListView;
    Rectangle4: TRectangle;
    Label4: TLabel;
    actGoYoutube: TAction;
    Rectangle5: TRectangle;
    Text5: TText;
    FloatAnimation11: TFloatAnimation;
    lGoogle: TLabel;
    Rectangle6: TRectangle;
    Text6: TText;
    FloatAnimation12: TFloatAnimation;
    actGoYoutubeEng: TAction;
    AniIndicator1: TAniIndicator;
    ComboBoxItem: TComboBox;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    u17Minutis: TTabItem;
    WebBrowser1: TWebBrowser;
    Layout18: TLayout;
    btnGoHome: TButton;
    actCloseJSWeb: TAction;
    actGetAccessToken: TAction;
    btnTrans: TSpeedButton;
    actTranslate: TAction;
    actNumbridEE: TAction;
    btnNumber: TButton;
    actGetSheetsAnot: TAction;
    btnNumbrid: TButton;
    btnTrans1: TSpeedButton;
    rWeb: TRectangle;
    actLoadGamesEesti: TAction;
    SpeedButton1: TSpeedButton;
    btnGoH: TSpeedButton;
    actTranslateCore: TAction;
    actViewSettings: TAction;
    actGGView: TAction;
    actEEView: TAction;
    actViewKusi: TAction;
    Rectangle7: TRectangle;
    Text7: TText;
    FloatAnimation13: TFloatAnimation;
    actEksamiValmis: TAction;
    reInputs: TRectangle;
    Line1: TLine;
    PLogin: TPath;
    Line2: TLine;
    PPassw: TPath;
    Circle1: TCircle;
    Image3: TImage;
    MaterialOxfordBlueSB: TStyleBook;
    EditPassword: TEdit;
    EditEmail: TEdit;
    imgDelete: TImage;
    ListView1: TListView;
    Rectangle8: TRectangle;
    Text2: TText;
    FloatAnimation8: TFloatAnimation;
    actGamesEng: TAction;
    actDiary: TAction;
    Rectangle9: TRectangle;
    Text3: TText;
    FloatAnimation9: TFloatAnimation;
    VSB: TVertScrollBox;
    uAI: TTabItem;
    VSBAI: TVertScrollBox;
    Layout7: TLayout;
    btnGoHome1: TButton;
    pthSend: TPath;
    btnSendMess: TButton;
    AniIndicator2: TAniIndicator;
    actMessAI: TAction;
    actGetAI: TAction;
    actClearChatAI: TAction;
    ScrollBox1: TScrollBox;
    btnHelp: TSpeedButton;
    btnClearChat: TButton;
    Path1: TPath;
    ShadowEffect1: TShadowEffect;
    tmr1: TTimer;
    btnSaveTEXT: TButton;
    btnGGView: TButton;
    actGetSheetsQuest: TAction;
    actGetSheetsExamp: TAction;
    uWordCorrect: TTabItem;
    CardLayout: TLayout;
    CardBack: TRectangle;
    BackLayout: TLayout;
    BackLabel: TLabel;
    FloatAnimationSObjR: TFloatAnimation;
    FloatAnimationSObjX: TFloatAnimation;
    FloatAnimationSObjY: TFloatAnimation;
    StyleBook1: TStyleBook;
    CardFront: TRectangle;
    FrontLayout: TLayout;
    FrontLabel: TLabel;
    LayImg: TLayout;
    SVGIconImage1: TSVGIconImage;
    ButtonsLayout1: TLayout;
    Label1: TLabel;
    btnPrev: TButton;
    Layout5: TLayout;
    ShadowEffectSwipe: TShadowEffect;
    Button2: TButton;
    actWordCorrect: TAction;
    actNextCards: TAction;
    actPrevCards: TAction;
    actEditCards: TAction;
    Rectangle10: TRectangle;
    Text8: TText;
    FloatAnimation14: TFloatAnimation;
    actViewCards: TAction;
    btnSearchWords: TSpeedButton;
    bNextCards: TButton;
    AniIndicator4: TAniIndicator;
    btnSaveToBases: TButton;
    actSaveBasesTxT: TAction;
    btnSettings: TButton;
    lWordLevel: TLabel;
    ButtonsAdMob: TLayout;
    BannerAd1: TBannerAd;
    actFrontClick: TAction;
    Layout16: TLayout;
    btnHelpWords: TButton;
    actCopyData: TAction;
    ShadowEffect2: TShadowEffect;
    actSearchWords: TAction;
    ln1: TLine;
    btnSearch: TButton;
    edtSearch: TEdit;
    Layout19: TLayout;
    lWords: TLabel;
    btnDelBases: TButton;
    actDelBases: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSignUpExecute(Sender: TObject);
    procedure actSignInExecute(Sender: TObject);
    procedure actResetPassExecute(Sender: TObject);
    procedure actGotoExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure TakePhotoFromCameraAction1DidFinishTaking(str: string);
    procedure imgQRCodeDblClick(Sender: TObject);
    procedure actGotoLogExecute(Sender: TObject);
    procedure acSwitchExecute(Sender: TObject);
    procedure BiometricAuth1AuthenticateFail(Sender: TObject;
      const FailReason: TBiometricFailReason; const ResultMessage: string);
    procedure BiometricAuth1AuthenticateSuccess(Sender: TObject);
    procedure acBiometriaExecute(Sender: TObject);
    procedure acBioClickExecute(Sender: TObject);
    procedure acTranslateExecute(Sender: TObject);
    procedure acTranslateTxTExecute(Sender: TObject);
    procedure mmo_srcChange(Sender: TObject);
    procedure actArowUpDownExecute(Sender: TObject);
    procedure acSaveDataExecute(Sender: TObject);
    procedure REnterClick(Sender: TObject);
    procedure EditEmailKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditPasswordKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure actAboutExecute(Sender: TObject);
    procedure actBasesExecute(Sender: TObject);
    procedure acTrashExecute(Sender: TObject);
    procedure actSaveToBasesExecute(Sender: TObject);
    procedure actAdminExecute(Sender: TObject);
    procedure actSaveEncryptBasesExecute(Sender: TObject);
    procedure actUpdatePrgExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure actLoadBasesExecute(Sender: TObject);
    procedure actGoExportImportExecute(Sender: TObject);
    procedure actImportBasesExecute(Sender: TObject);
    procedure actExportBasesExecute(Sender: TObject);
    procedure actEncryptExecute(Sender: TObject);
    procedure actDecryptExecute(Sender: TObject);
    procedure actGetKusiMusiExecute(Sender: TObject);
    procedure actSaveDataKusiExecute(Sender: TObject);
    procedure actAllKusiExecute(Sender: TObject);
    procedure actSendCryptoTextExecute(Sender: TObject);
    procedure actViewChatExecute(Sender: TObject);
    procedure actClearVSBExecute(Sender: TObject);
    procedure actPlusExecute(Sender: TObject);
    procedure AddPanelActionExecute(Sender: TObject);
    procedure RemovePanelActionExecute(Sender: TObject);
    procedure lvVideosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvVideosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure actGoYoutubeExecute(Sender: TObject);
    procedure actGoYoutubeEngExecute(Sender: TObject);
    procedure ComboBoxItemChange(Sender: TObject);
    procedure actGetAccessTokenExecute(Sender: TObject);
    procedure actNumbridEEExecute(Sender: TObject);
    procedure actTranslateExecute(Sender: TObject);
    procedure TabControl1Click(Sender: TObject);
    procedure LinearLayout1Click(Sender: TObject);
    procedure actGetSheetsAnotExecute(Sender: TObject);
    procedure rWebClick(Sender: TObject);
    procedure actLoadGamesEestiExecute(Sender: TObject);
    procedure actTranslateCoreExecute(Sender: TObject);
    procedure actViewSettingsExecute(Sender: TObject);
    procedure actGGViewExecute(Sender: TObject);
    procedure actEEViewExecute(Sender: TObject);
    procedure actViewKusiExecute(Sender: TObject);
    procedure actEksamiValmisExecute(Sender: TObject);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure actGamesEngExecute(Sender: TObject);
    procedure actDiaryExecute(Sender: TObject);
    procedure actMessAIExecute(Sender: TObject);
    procedure actGetAIExecute(Sender: TObject);
    procedure actClearChatAIExecute(Sender: TObject);
    procedure mmo_srcClick(Sender: TObject);
    procedure mmo_trgClick(Sender: TObject);
    procedure SBMenu1Click(Sender: TObject);
    procedure ComboBoxItemClick(Sender: TObject);
    procedure lstatusClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure TxtOptionSecondClick(Sender: TObject);
    procedure MultiViewStartShowing(Sender: TObject);
    procedure MultiViewShown(Sender: TObject);
    procedure chkSoonavebChange(Sender: TObject);
    procedure actGetSheetsQuestExecute(Sender: TObject);
    procedure actGetSheetsExampExecute(Sender: TObject);
    procedure actWordCorrectExecute(Sender: TObject);
    procedure actNextCardsExecute(Sender: TObject);
    procedure actPrevCardsExecute(Sender: TObject);
    procedure btnVolumeFrontClick(Sender: TObject);
    procedure actEditCardsExecute(Sender: TObject);
    procedure actViewCardsExecute(Sender: TObject);
    procedure actSaveBasesTxTExecute(Sender: TObject);
    procedure EditEmailClick(Sender: TObject);
    procedure lvVideosClick(Sender: TObject);
    procedure actFrontClickExecute(Sender: TObject);
    procedure actCopyDataExecute(Sender: TObject);
    procedure RctQuizClick(Sender: TObject);
    procedure LytBodyClick(Sender: TObject);
    procedure reInputsClick(Sender: TObject);
    procedure LytAnswersClick(Sender: TObject);
    procedure actSearchWordsExecute(Sender: TObject);
    procedure actDelBasesExecute(Sender: TObject);
  private
    uX,uIndex  : Integer;
    uID,sLevelWords,uLevelWords : Boolean;
    uURL,uURLWords,uURLd,uURLWordsd,uSonApi,MyUrl: string;
    FSelectedLanguage: string;
    FSelectedVoice: string;
    FSpeaker: TTextToSpeech;
    chkSoundPlay, uApiTartu: Boolean;
    FAppUpdate: TAppUpdate;
    FBiometric: TBiometric;
    idx,idTab: Integer;
    sContID, xAnswer, xSettinwer, xKusiwer: Integer;
    sTouchMe: string;
    FEmail: string;
    FFilePath: String;
    FWebApiKey: string;
    cEncoding,cZone: string;
    LTokenBases: string;
    FAPIKEYYOUTUBE,FAPIKEYSpeaker : string;
    FPermissionReadExternalStorage,
    FPermissionWriteExternalStorage: string;
    stat: Boolean; jsonTxT: string;
    JSONObjSave: TJSONObject; // Добавляем переменную для сохранения JSON
    GoogleServiceAccount: TGoogleServiceAccount;
    IosStyleManager: TDialogStyleManager;
    FSheetData: TSheetRowList;
    FSheetPostpositsiooneData: TSheetPostpositsiooneRowList;
    FSheetQuestData: TSheetQuestRowList;
    FSheetExampData: TSheetExampRowList;
    FSheetDataGames: TSheetRowListGames;
    FSheetUrlData: TSheetUrlRowList;
    FSwipeObject: TRectangle;
    FSwipe: Boolean;
    FSwipePos: TPointF;
    FSwipeDirTop: Boolean;
    CurrentIndex: Integer;
    FTranslationsJSON: string;
    JSONArr: TJSONArray; // Объявляем здесь переменную JSONArray
    TranslationRecords: TArray<TTranslationRecord>;
    idLang,idxLang: Integer;
    uAccessToken: string;
    uApiGemini : string;
    FDeviceToken: string;
    tIDX: Integer;
    ExampleText: TStringList;
    aiTextSrc,aiTextTrg: string;
    procedure GetCountMemoText;
    function GetHtmlContent(value: string) : string;
    function ExtractValuesFromHtml(const HTMLContent: string): TArray<string>;
    function GetSheetDataUrl(const spreadsheetId, accessToken, IDStr: string): string;
    procedure DialogLogin(AView: TFrame; AUserName, APassword: string);
    function GetRandomUrl : string;
    function GetKusiAll: string;
    function GetBasesJson: string;
    function GetEngPlayList : string;
    function GetEstPlayList : string;
    function GetEksUrl : string;
    function GetUrlKulla(idx: Integer) : string;
    function GetSheetDataPrivatUsers(const spreadsheetId, accessToken, email: string): Boolean;
    procedure HandleUserSession;
    procedure PlayVoiceIfNeeded(const Text: string);
    procedure StartTranslation(const Text: string);
    procedure SaveBasesIfNecessary(src: string; trg: string);
    procedure GetTranslateData;
    procedure HandleSonaveebTranslation(const CleanText: string);
    function HandleLanguageSpecificTranslation(const Text: string): string;
    procedure AddMessageAI(const AText: String; AAlignLayout: TAlignLayout; ACalloutPosition: TCalloutPosition; index: Integer);
    procedure UpdateListView;
    procedure DeleteNoteFromDatabase(OrderID: Integer);
    procedure GetLangID(idx: Integer); //idx = 0 - GG, 1 - EE
    procedure FillPlaylistComboBox(const JSONContent: string);
    procedure ViewEksamEst(const jsonStr: string);
    procedure ShowPopupFrame(const SourceText, TranslationText: string);
    function GetResultKusi(idx: Integer): string;
    function GetJSONData(jsonData: string; uStr: string): string;
    procedure InitR(const Sender: TObject; const M: TMessage);
    procedure OnActivityResult(RequestCode, ResultCode: Integer; Data: JIntent);
    function DoсInit(Uri: JNet_Uri): string;
    function GetTxt(obj: string): string;
    function getVoice(FText : String) : Boolean;
    function getVoiceFromTranslate(FText : String) : Boolean;
    function EstRus(txt: string) : string;
    function RusEst(txt: string) : string;
    function EstUkr(txt: string) : string;
    function UkrEst(txt: string) : string;
    function RusEng(txt: string) : string;
    function EngRus(txt: string) : string;
    function UkrEng(txt: string) : string;
    function EngUkr(txt: string) : string;
    procedure GetUpdateMyPrg(prg: string);
    procedure DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure TakePicturePermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    procedure OnReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
    procedure OnServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
    //------------------------------------------------
    procedure Listening(const AIsListening: Boolean);
    procedure VerificationFailResultHandler(const AFailResult: TBiometricFailResult; const AResultMessage: string);
    procedure VerificationSuccessResultHandler;
    procedure Verify;
    procedure SaveCryptoBases;
    procedure SaveBases(str: string);
    procedure InsertBases(str: string; settings: string);
    procedure InsertTranslation(EstonianWord, RussianTranslation, ExtraData: string; Number: Integer);
    procedure LoadBases;
    procedure DeleteBases;
    procedure CompressDatabase;
    procedure SearchBases(const SearchText: string);
    procedure SearchBasesWords(const SearchText: string);
    procedure GetCountLineBases;
    procedure ClearVSB;
    function DetectLanguage(const Text, ApiKey: string): string;
    procedure PlayManText(const Text, ApiKey: string);
    procedure PermissionsCheck;
    procedure AppUpdateInfoHandler(Sender: TObject; const AInfo: TAppUpdateInfo);
    procedure AppUpdateResultHandler(Sender: TObject; const AUpdateResult: TAppUpdateResult);
    procedure AppUpdateStartedFlowHandler(Sender: TObject; const AStarted: Boolean);
    //---------------------------------------//
    procedure ListarEstVideos(uPlayList : string);
    procedure ListarEngVideos(uPlayList : string);
    procedure StartEngLongOperation;
    procedure StartEstLongOperation;
    procedure StartEksLongOperation;
    procedure AddVideoListview(id_video, descricao, url_foto: string; plataforma: TPlataformaVideo);
    procedure LayoutListview(AItem: TListViewItem);
    function GetTextHeight(const D: TListItemText; const Width: single;
      const Text: string): Integer;
    procedure ThreadTerminate(Sender: TObject);
    procedure LoadImageFromURL(img: TBitmap; url: string);
    procedure DownloadFotoListview(lv: TListview; obj_foto: string);
    //---------------------------------------//
    procedure LogMessage(const AMessage: string);
    procedure PerformUpdate;
    procedure StartUpdateTask;
    procedure CheckForUpdate;
    function GetGoogleApiKey(value: string; key: string; SpreadsheetId: string) : string;
    function LoadSheetData: TSheetRowList;
    function LoadSheetDataGames: TSheetRowListGames;
    function LoadSheetExampData: TSheetExampRowList;
    function LoadSheetQuestData: TSheetQuestRowList;
    function LoadPostpositsiooneSheetData: TSheetPostpositsiooneRowList;
    function CountWordsInMemo : Integer;
    //----------------------------------------//
    procedure SpeakText(const Text: string);
    procedure SetLanguageAndVoice;
    procedure SpeakerCheckDataCompleteHandler(Sender: TObject);
    procedure SpeakerSpeechStartedHandler(Sender: TObject);
    procedure SpeakerSpeechFinishedHandler(Sender: TObject);
    //-----------------------------------------//
    procedure LoadImageFromURLSVG(url: string);
    procedure UpdateGoogleSheetsCell(strData, accessToken: string; idx: Integer);
    procedure ResetSwipeObject(const SObject: TRectangle);
    procedure TransferWords(sWord: string);
    function ExtractImageURLFromHTML(const HTML: string): string;
    function GetTranslationsFromGoogleSheetsRec(accessToken: string; MyUrl: string): TArray<TTranslationRecord>;
    function GetCountSheets(SpreadsheetId: string; SelectedSheet: string) : Integer;
    function GetTranslationsFromGoogleSheetsRecOnlyD(accessToken: string; MyUrl: string): TArray<TTranslationRecord>;
    function GetTranslationsCount: Integer;
    function GetLocalTranslations(sLevel: string): TArray<TTranslationRecord>;
    function GetLocalTranslationsAllWords: TArray<TTranslationRecord>;
    procedure LoadTranslations;
    procedure SelectRandomLink;
    procedure GenerateLinks(uLevel: string);
    procedure TransferEvent(idx: Integer);
    procedure DisplayWord(Index: Integer);
    procedure fnLoading(isEnabled : Boolean);
    procedure fnLoadingCore(isEnabled : Boolean);
    procedure InsertTranslationsAsync(Records: TArray<TTranslationRecord>);
    procedure SyncTranslationsWithGoogleSheets(accessToken: string);
    procedure GetLocalBasesWords;
    //-----------------------------------------//
    procedure ModifLocalBases(stat: string);
  protected
  public
    { Public declarations }
    sID : Integer;
    uYout : Integer;
    uStr1,uStr2, uTag: string;
    uList: Boolean;
    privUsers: Boolean;
    procedure SetStyle;
    procedure ResultSpeech(AResult: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure KeepWebBrowserInvisible(stat: Boolean);
    procedure ScrollToBottom;
    procedure AddMessageAsync(const AText: String; AAlignLayout: TAlignLayout; ACalloutPosition: TCalloutPosition);
    procedure AddMessage(const AText: String; AAlignLayout: TAlignLayout; ACalloutPosition: TCalloutPosition);
    procedure FriendMessage(const S: String);
    procedure YourMessage(const S: String);
    procedure LabelPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    property Email: string read FEmail;
    function GetKeyGemini(value: string; key: string; SpreadsheetId: string) : string;
    function SendChatCompletion(APIKey, Model, Prompt: string; Stream: Boolean): string;
    procedure FriendMessageAI(const S: String);
    procedure YourMessageAI(const S: String);
  end;


var
  FormMain: TFormMain;
  Task: ITask; DBStr: string;
  FirebaseAuth: IFirebaseAuth;
  JsonAnswer: string;
  DataList: TDataEntry;
  NativeBrowser: JWebBrowser;
  PlaylistItems: array of TPlaylistItem; // Объявляем динамический массив

implementation

{$R *.fmx}

uses System.IOUtils, System.NetEncoding, REST.Json, uMyDB, Prism.Crypto.AES,
     Generics.Defaults, BFA.Func, BFA.Helper.MemTable, BFA.Helper.Main,
     FMX.SpeechToText, AndroidSpeechRecognition, //pTalk,
     System.TypInfo, IdSSLOpenSSLHeaders, IdSSLOpenSSL;

const
  cConsentStatusValues: array[TConsentStatus] of string = ('Unknown', 'Required', 'Not Required', 'Obtained');

function FormatJSON(Value: String; Indentation: Integer = 4): String; inline;
var
  JV: TJSONValue;
begin
  Result := '';
  JV := nil;
try
  try
    JV := TJSONObject.ParseJSONValue(Value);
    Result := JV.Format(Indentation);
  finally
    FreeAndNil(JV);
  end;
except
  on E: Exception do begin Result := ''; Exit; end;
end;
end;

function TCustomStringsListAdapter.GetView(const Index: Integer;
  ConvertView: TViewBase; Parent: TViewGroup): TViewBase;
begin
try
  Result := inherited GetView(Index, ConvertView, Parent);
  if (ConvertView = nil) or (not (ConvertView is TListTextItem)) then
    TListTextItem(Result).Gravity := TLayoutGravity.Center;
except
  on E: Exception do begin Result := nil; Exit; end;
end;
end;

function GetKeyDay : string;
var wYear, wMonth, wDay: Word; x,y,z: Integer;
begin
try
  Result := '';
  DecodeDate(Now, wYear, wMonth, wDay); y := wDay + (wMonth * 2); z := y + wYear; x := z; Result := Trim(IntToStr(x));
except
  on E: Exception do begin
     Result := '';
     Exit;
  end;
end;
end;

procedure ShowNotification(MessageText: string; BadgeNumber: integer);
begin
try
  TThread.Queue(nil, // Перемещаем выполнение в основной поток
    procedure
    var
      NotificationCenter: TNotificationCenter;
      Notification: TNotification;
    begin
      {$IF DEFINED(ANDROID) OR DEFINED(IOS)}
      NotificationCenter := TNotificationCenter.Create(nil); // Создание экземпляра
      try
        if NotificationCenter.Supported then
        begin
          Notification := NotificationCenter.CreateNotification;
          try
            Notification.Title := '[Eesti sõnad]';
            Notification.AlertBody := MessageText;
            Notification.EnableSound := True;
            Notification.Number := BadgeNumber;
            NotificationCenter.ApplicationIconBadgeNumber := BadgeNumber;
            NotificationCenter.PresentNotification(Notification);
          finally
            Notification.Free;
          end;
        end
        else
        begin
          ShowMessage('Notifications are not supported on this device.');
        end;
      finally
        NotificationCenter.Free; // Освобождение ресурсов
      end;
      {$ELSE}
        TThread.Queue(nil,  // Изменение Label1 в главном потоке
          procedure
          begin
            // Проверяем состояние формы и Label
            if Assigned(Form1) and Assigned(Form1.Label1) then
            begin
              try
                Form1.Label1.Text := MessageText;
              except
                on E: Exception do
                   ShowMessage('Error updating label: ' + E.Message);
              end;
            end
            else
              ShowMessage('Form or Label is not assigned');
          end);
      {$ENDIF}
    end);
except
  on E: Exception do begin
     Exit;
  end;
end;
end;

function TFormMain.ExtractImageURLFromHTML(const HTML: string): string;
var
  LHtml: IHtmlElement;
  LList: IHtmlElementList;
begin
  Result := ''; // Инициализация результата
  try
    // Парсим HTML-контент
    LHtml := ParserHTML(HTML);
    if not Assigned(LHtml) then
    begin
      ShowNotification('HTML parsing failed: LHtml is nil', 0);
      Exit;
    end;
    // Используем селектор для поиска нужного изображения
    LList := LHtml.SimpleCSSSelector('.homonym-image.m-0.p-0');
    if Assigned(LList) and (LList.Count > 0) then
    begin
      Result := LList[0].Attributes['src']; // Получаем значение атрибута src первого найденного элемента
    end
    else
    begin
      ShowNotification('Image with class "homonym-image m-0 p-0" not found', 0);
    end;
  except
    on E: Exception do
    begin
      ShowNotification('Error extracting image URL: ' + E.Message, 0);
      Exit;
    end;
  end;
end;

procedure TFormMain.LoadImageFromURLSVG(url: string);
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
     ShowNotification('Error Load Image: '+ HttpResponse.StatusText +#13#10+ E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.ResetSwipeObject(const SObject: TRectangle);
begin
try
  FloatAnimationSObjX.Enabled := False;
  FloatAnimationSObjY.Enabled := False;
  FloatAnimationSObjR.Enabled := False;
  FloatAnimationSObjX.Parent := SObject;
  FloatAnimationSObjY.Parent := SObject;
  FloatAnimationSObjR.Parent := SObject;
  FloatAnimationSObjX.StopValue := (CardLayout.Width / 2) - (SObject.Width / 2);
  FloatAnimationSObjY.StopValue := (CardLayout.Height / 2) - (SObject.Height / 2);
  FloatAnimationSObjX.Enabled := True;
  FloatAnimationSObjY.Enabled := True;
  FloatAnimationSObjR.Enabled := True;
except
  on E: Exception do begin
     ShowNotification('Error '+#13#10+E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.UpdateGoogleSheetsCell(strData, accessToken: string; idx: Integer);
var
  myObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  updateBody: TJSONObject;
begin
  try
    // Установка параметров запроса к Google Sheets API для получения данных
    RestClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uTokenW + '/values/B1:E999?majorDimension=ROWS';
    RestClient1.AcceptCharset := 'utf-8, *;q=0.8';
    RestClient1.ContentType := 'application/json; charset=UTF-8';
    RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest1.ClearBody;
    RESTRequest1.Params.Clear;

    // Добавление токена авторизации
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

    // Выполнение запроса для получения данных
    RESTRequest1.Execute;
    FTranslationsJSON := RESTResponse1.Content;

    // Обработка JSON-ответа
    myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    try
      valuesArray := myObj.GetValue('values') as TJSONArray;

      if Assigned(valuesArray) and (idx < valuesArray.Count) then
      begin
        rowArray := valuesArray.Items[idx] as TJSONArray; // Используем idx для доступа к нужной строке
        if Assigned(rowArray) then
        begin
          // Обновляем ячейку на основе strData
          rowArray.Items[2].ParseJSONValue(strData,false,false); // Обновляем значение в нужной колонке

          // Теперь нужно обновить данные в Google Sheets
          RestClient1.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uTokenW + '/values/B' + IntToStr(idx + 1) + '?valueInputOption=RAW'; // Убедитесь, что индекс правильно указывает на нужную строку

          // Формируем тело запроса для обновления
          updateBody := TJSONObject.Create;
          try
            updateBody.AddPair('range', 'EestiS!D' + IntToStr(idx + 1)); // Ячейка D (например, третья колонка)
            updateBody.AddPair('majorDimension', 'ROWS');
            // Используем обновленный rowArray
            updateBody.AddPair('values', rowArray.Items[2].Value); // Обернуть в массив для JSON

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
  except
    on E: ERESTException do
    begin
      ShowNotification('HTTP Error: ' + IntToStr(RESTResponse1.StatusCode) + ' - ' + E.Message, 0);
    end;
    on E: Exception do
    begin
      ShowNotification('Error: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SelectRandomLink;
var
  randomIndex: Integer;
  selectedUrl: string;
begin
try
  if FSheetUrlData.Count = 0 then
  begin
    ShowNotification('Link list is empty.', 0);
    Exit;
  end;
  // Генерация случайного индекса
  randomIndex := Random(FSheetUrlData.Count); // Возвращает значение от 0 до Count-1
  // Получение выбранной ссылки
  selectedUrl := FSheetUrlData[randomIndex].Url;
  MyUrl := selectedUrl;
  //ShowNotification('Url Link - Ok ', 0);
except
  on E: Exception do
  begin
     ShowNotification('General Error SelectRandomLink: ' + E.Message, 0);
     FSheetUrlData.Clear;
     Exit;
  end;
end;
end;

function TFormMain.GetCountSheets(SpreadsheetId: string; SelectedSheet: string) : Integer;
var
  Range: string;
  JSONResponse: TJSONObject;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
begin
try
  Result := 0;

  if Length(Trim(SpreadsheetId)) = 0 then Exit;
  if Length(Trim(uAccessToken)) = 0 then Exit;

  // Формируем диапазон на основе выбранного листа
  Range := Format('%s!A1:G10451', [SpreadsheetId]);  // Диапазон для A1:F9999 на выбранном листе

  RestClient1.BaseURL := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s', [SelectedSheet, Range]);
  RestRequest1.Client := RestClient1;
  RestRequest1.Response := RestResponse1;
  RestRequest1.Method := TRESTRequestMethod.rmGET;
  RestRequest1.Params.Clear;
  RestRequest1.AddAuthParameter('Authorization', 'Bearer ' + uAccessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

  try
    RestRequest1.Execute;
    if RestResponse1.StatusCode = 200 then
    begin
      JSONResponse := TJSONObject.ParseJSONValue(RestResponse1.Content) as TJSONObject;
      try
        JSONValue := JSONResponse.GetValue('values');
        if JSONValue is TJSONArray then
        begin
          JSONArray := JSONValue as TJSONArray;
          Result := JSONArray.Count;  // Возвращаем количество строк
          mmoInfo.Lines.Add(Format('Selected list %s has %d rows.', [SelectedSheet, JSONArray.Count]));
        end
        else
        begin
          mmoInfo.Lines.Add('Error: Values not found in response.');
        end;
      finally
        JSONResponse.Free;
      end;
    end
    else
    begin
      mmoInfo.Lines.Add('Error: ' + RestResponse1.StatusText);
    end;
  except
    on E: Exception do
    begin
      ShowNotification('Error: ' + E.Message, 0);
    end;
  end;
except
  Exit;
end;
end;

procedure TFormMain.GenerateLinks(uLevel: string);
var
  i: Integer;
  startRow, endRow: Integer;
  sheetRow: TSheetUrlRow;
  selectedSheet: string;
begin
try
  if Length(Trim(uLevel)) = 0 then Exit;
  try
    FSheetUrlData.Clear;
    // Получаем выбранное значение из ComboBox
    selectedSheet := uLevel;  // Например, A1, A2 и т.д.
    // Получаем общее количество записей для выбранного листа
    sID := GetCountSheets(selectedSheet, uTokenW);  // Общее количество записей
    startRow := 1;  // Начальная строка
    endRow := sID;  // Конечная строка
    for i := 0 to startRow do  // ссылок
    begin
      // Генерация ссылки
      MyUrl := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s!B%d:E%d?majorDimension=ROWS',
        [uTokenW, selectedSheet, startRow, endRow]);  // Включаем выбранный лист в диапазон
      RestClient1.BaseURL := MyUrl;
      // Отображение или использование сгенерированной ссылки
      mmoInfo.Lines.Add('Link ' + IntToStr(startRow) + ': ' + MyUrl);
      // Сохранение URL в коллекции
      sheetRow := TSheetUrlRow.Create;
      sheetRow.ID := i;
      sheetRow.Url := MyUrl;
      FSheetUrlData.Add(sheetRow);
      CurrentIndex := 1;
      // Прерываем, если достигли конца
      if startRow >= i then
        Break;
    end;
    mmoInfo.Lines.Add('Start ['+IntToStr(startRow)+'] - End ['+IntToStr(startRow)+']');
  except
    on E: Exception do
    begin
      ShowNotification('General Error GenerateLinks: ' + E.Message, 0);
      Exit;
    end;
  end;
except
  Exit;
end;
end;

function TFormMain.GetTranslationsCount: Integer;
begin
  Result := 0; // Инициализация результата
  try
    with uDMForm do
    begin
      fConnect.Open;
      try
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'SELECT COUNT(*) FROM Translations';
        fQuery.Open;
        Result := fQuery.Fields[0].AsInteger; // Получаем значение из первой колонки результата
      finally
        fQuery.Close;
        fConnect.Close;
      end;
    end;
  except
    on E: Exception do
    begin
       ShowMessage('Error getting number of records: ' + E.Message);
       Result := -1; // Возвращаем -1 при ошибке
    end;
  end;
end;

procedure TFormMain.InsertTranslationsAsync(Records: TArray<TTranslationRecord>);
begin
try
  TTask.Run(
    procedure
    var
      i: Integer;
    begin
      try
        ModifLocalBases('CREATE');
        with uDMForm do
        begin
         try
          fConnect.Open;
          try
            for i := 0 to High(Records) do
            begin
              fQuery.SQL.Clear;
              fQuery.SQL.Text :=
                'INSERT INTO Translations (EstonianWord, RussianTranslation, ExtraData, Number, LevelWords) ' +
                'VALUES (:EstonianWord, :RussianTranslation, :ExtraData, :Number, :LevelWords)';
              fQuery.ParamByName('EstonianWord').AsString := Trim(Records[i].EstonianWord);
              fQuery.ParamByName('RussianTranslation').AsString := Trim(Records[i].RussianTranslation);
              fQuery.ParamByName('ExtraData').AsString := Records[i].ExtraData;
              fQuery.ParamByName('Number').AsInteger := Records[i].Number;
              fQuery.ParamByName('LevelWords').AsString := Records[i].LevelWords;
              fQuery.ExecSQL;
            end;
          finally
            if fQuery.Active then
               fQuery.Close;
               fConnect.Close;
          end;
         except
           //
         end;
        end;
        try
          TThread.Queue(nil,
            procedure
            begin
              ShowNotification('Data successfully added to the Translations table.', 0);
            end);
        except
         //
        end;
      except
        on E: Exception do
           try
            TThread.Queue(nil,
              procedure
              begin
                ShowNotification('Error adding data to table Translations: '+ E.Message, 0);
              end);
           except
             //
           end;
      end;
    end);
    TDialogService.ShowMessage('Data successfully added to the Translations table.');
except
  Exit;
end;
end;

procedure TFormMain.LoadTranslations;
var
  recordItem: TTranslationRecord;
  recordsList: TList<TTranslationRecord>;
begin
  if (Trim(MyUrl) = '') or (Trim(uAccessToken) = '') then Exit;
  try
    // Получение локальных переводов или данных из Google Sheets
    TranslationRecords := GetLocalTranslationsAllWords;
    if Length(TranslationRecords) = 0 then
    begin
      if GetTranslationsCount < 10451 then Exit; // Прерывание выполнения, если данных недостаточно
      recordsList := TList<TTranslationRecord>.Create;
      try
        with uDMForm do
        begin
          fConnect.Open;
          try
            fQuery.SQL.Text := 'SELECT ID, EstonianWord, RussianTranslation, ExtraData, Number, LevelWords FROM Translations';
            fQuery.Open;
            while not fQuery.Eof do
            begin
              try
                recordItem.ID := fQuery.FieldByName('ID').AsInteger;
                recordItem.EstonianWord := fQuery.FieldByName('EstonianWord').AsString;
                recordItem.RussianTranslation := fQuery.FieldByName('RussianTranslation').AsString;
                recordItem.ExtraData := fQuery.FieldByName('ExtraData').AsString;
                // Проверка и преобразование поля Number
                if not fQuery.FieldByName('Number').IsNull then
                  if not TryStrToInt(fQuery.FieldByName('Number').AsString, recordItem.Number) then
                    recordItem.Number := 0
                  else
                    recordItem.Number := fQuery.FieldByName('Number').AsInteger;
                    recordItem.LevelWords := fQuery.FieldByName('LevelWords').AsString;
                    recordsList.Add(recordItem);
              except
                on E: Exception do
                  ShowNotification('Error processing record ID=' + IntToStr(recordItem.ID) + ': ' + E.Message, 0);
              end;
              fQuery.Next;
            end;
          finally
            fQuery.Close;
            fConnect.Close;
          end;
        end;
        // Преобразование временного списка в массив
        TranslationRecords := recordsList.ToArray;
        ShowNotification('Load databases - Ok', 0);
        Label1.Text := 'Count: ' + IntToStr(Length(TranslationRecords));
      finally
        recordsList.Free;
      end;
    end
    else
    begin
      Label1.Text := 'Count: ' + IntToStr(Length(TranslationRecords));
    end;
  except
    on E: Exception do
      ShowNotification('Error loading translations: ' + E.Message, 0);
  end;
end;

procedure TFormMain.fnLoading(isEnabled : Boolean);
begin
try
  TThread.Synchronize(nil, procedure begin
    AniIndicator1.Visible := isEnabled;
    AniIndicator1.Enabled := isEnabled;
  end);
except
  try
    ShadowEffect1.UpdateParentEffects;
    ShadowEffect2.UpdateParentEffects;
    Exit;
  except
    //
  end;
end;
end;

procedure TFormMain.fnLoadingCore(isEnabled : Boolean);
begin
try
  TThread.Synchronize(nil, procedure begin
    AniIndicator4.Visible := isEnabled;
    AniIndicator4.Enabled := isEnabled;
  end);
except
  try
    ShadowEffect1.UpdateParentEffects;
    ShadowEffect2.UpdateParentEffects;
    Exit;
  except
    //
  end;
end;
end;

procedure TFormMain.DisplayWord(Index: Integer);
begin
try
  if Length(TranslationRecords) = 0 then Exit;
  if (Index >= 0) and (Index <= Length(TranslationRecords)) then
  begin
    // Отображаем слово на основной стороне (например, на FrontLabel)
    FrontLabel.Text := TranslationRecords[Index].EstonianWord +#13#10+ TranslationRecords[Index].ExtraData;
    // Отображаем перевод на обратной стороне (например, на BackLabel)
    BackLabel.Text := TranslationRecords[Index].RussianTranslation;
    // Отображение уровня
    if (Index <= 695) then lWordLevel.Text := 'A1';
    if ((Index >= 695)and(Index <= 1736)) then lWordLevel.Text := 'A2';
    if ((Index >= 1736)and(Index <= 4537)) then lWordLevel.Text := 'B1';
    if ((Index >= 4537)and(Index <= 9698)) then lWordLevel.Text := 'B2';
    if ((Index >= 9698)and(Index <= 10451)) then lWordLevel.Text := 'C1';
  end;
except
  on E: Exception do begin
     ShowNotification('Error '+#13#10+E.Message, 0);
     Exit;
  end;
end;
end;

function TFormMain.GetLocalTranslationsAllWords: TArray<TTranslationRecord>;
var
  recordItem: TTranslationRecord;
  recordsList: TList<TTranslationRecord>; // Используем временный список для удобного управления размером
begin
try
  Result := nil; // Инициализация результата на случай ошибки
  recordsList := TList<TTranslationRecord>.Create; // Создаем временный список для записи данных
  try
    with uDMForm do
    begin
      fConnect.Open;
      try
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'SELECT ID, EstonianWord, RussianTranslation, ExtraData, Number, LevelWords FROM Translations';
        fQuery.Open;
        while not fQuery.Eof do
        begin
          try
            recordItem.ID := fQuery.FieldByName('ID').AsInteger;
            recordItem.EstonianWord := fQuery.FieldByName('EstonianWord').AsString;
            recordItem.RussianTranslation := fQuery.FieldByName('RussianTranslation').AsString;
            recordItem.ExtraData := fQuery.FieldByName('ExtraData').AsString;
            // Проверяем и безопасно преобразуем поле Number
            if not fQuery.FieldByName('Number').IsNull then
            begin
              if not TryStrToInt(fQuery.FieldByName('Number').AsString, recordItem.Number) then
              begin
                 ShowNotification('Conversion error on record ID=' + IntToStr(recordItem.ID) + ': Setting Number to 0', 0);
                 recordItem.Number := 0;
              end;
            end
            else
              recordItem.Number := 0;
              recordItem.LevelWords := fQuery.FieldByName('LevelWords').AsString;
              // Добавляем запись в список
              recordsList.Add(recordItem);
          except
            on E: Exception do
               ShowNotification('Error processing record ID=' + IntToStr(recordItem.ID) + ': ' + E.Message, 0);
          end;
          fQuery.Next;
        end;
      finally
        fQuery.Close;
        fConnect.Close;
      end;
    end;
    // Конвертируем список в массив для возвращения
    Result := recordsList.ToArray;
  except
    on E: Exception do
       ShowNotification('Error loading local translations: ' + E.Message, 0);
  end;
  // Освобождаем временный список
  recordsList.Free;
except
  on E: Exception do begin
     Exit;
  end;
end;
end;

function TFormMain.GetLocalTranslations(sLevel: string): TArray<TTranslationRecord>;
var
  recordItem: TTranslationRecord;
  recordsList: TList<TTranslationRecord>; // Используем временный список для удобного управления размером
begin
try
  Result := nil; // Инициализация результата на случай ошибки
  recordsList := TList<TTranslationRecord>.Create; // Создаем временный список для записи данных
  try
    if Trim(sLevel) = '' then
      Exit;
    //ShowNotification('[Level] : '+sLevel, 0);
    with uDMForm do
    begin
      fConnect.Open;
      try
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'SELECT ID, EstonianWord, RussianTranslation, ExtraData, Number, LevelWords ' +
                           'FROM Translations WHERE LevelWords = :LevelWords';
        fQuery.Params.ParamByName('LevelWords').AsString := sLevel;
       // ShowNotification('SQL : '+fQuery.SQL.Text, 0);
        fQuery.Open;
        while not fQuery.Eof do
        begin
          try
            recordItem.ID := fQuery.FieldByName('ID').AsInteger;
            recordItem.EstonianWord := fQuery.FieldByName('EstonianWord').AsString;
            recordItem.RussianTranslation := fQuery.FieldByName('RussianTranslation').AsString;
            recordItem.ExtraData := fQuery.FieldByName('ExtraData').AsString;
            // Проверяем и безопасно преобразуем поле Number
            if not fQuery.FieldByName('Number').IsNull then
            begin
              if not TryStrToInt(fQuery.FieldByName('Number').AsString, recordItem.Number) then
              begin
                 ShowNotification('Conversion error on record ID=' + IntToStr(recordItem.ID) + ': Setting Number to 0', 0);
                 recordItem.Number := 0;
              end;
            end
            else
              recordItem.Number := 0;
              recordItem.LevelWords := fQuery.FieldByName('LevelWords').AsString;
            // Добавляем запись в список
            recordsList.Add(recordItem);
          except
            on E: Exception do
               ShowNotification('Error processing record ID=' + IntToStr(recordItem.ID) + ': ' + E.Message, 0);
          end;
          fQuery.Next;
        end;
      finally
        fQuery.Close;
        fConnect.Close;
      end;
    end;
    // Конвертируем список в массив для возвращения
    Result := recordsList.ToArray;
  except
    on E: Exception do
       ShowNotification('Error loading local translations: ' + E.Message, 0);
  end;
  // Освобождаем временный список
  recordsList.Free;
except
  on E: Exception do begin
     Exit;
  end;
end;
end;

procedure TFormMain.GetLocalBasesWords;
begin
try
  TTask.Run(
    procedure
    begin
      TThread.Queue(nil, procedure begin fnLoadingCore(True); end); // Включаем индикатор загрузки
      try
        if Length(Trim(uAccessToken)) = 0 then Exit else
           SyncTranslationsWithGoogleSheets(Trim(uAccessToken));
      except
        on E: Exception do
           TThread.Queue(nil,
            procedure
            begin
              if swtch1.IsChecked then
                ShowNotification('Error: ' + E.Message, 0);
            end);
      end;
      // Отключаем индикатор загрузки
      TThread.Queue(nil, procedure begin fnLoadingCore(False); end);
    end).Start;
except
  Exit;
end;
end;

procedure TFormMain.TransferEvent(idx: Integer);
var
  uLVL: string;
begin
try
  TTask.Run(procedure
  begin
    TThread.Queue(nil, procedure begin fnLoadingCore(True); end); // Включаем индикатор загрузки
    try
      // Определяем значение uLVL на основе idx
      case idx of
        0: uLVL := 'A1';
        1: uLVL := 'A2';
        2: uLVL := 'B1';
        3: uLVL := 'B2';
        4: uLVL := 'C1';
      else
        uLVL := 'A1'; // значение по умолчанию
      end;
      GenerateLinks(uLVL);
      // Получение токена доступа, если он еще не получен
      if (Trim(uAccessToken) = '') and (uX > 0) then
      begin
        TThread.Queue(nil, procedure begin actGetAccessTokenExecute(Self); end);
        if swtch1.IsChecked then
        TThread.Queue(nil, procedure begin ShowNotification('Get access token - Ok', 0); end);
      end;
      // Загрузка данных, если токен получен
      if Trim(uAccessToken) <> '' then
      begin
        LoadTranslations; // Функция для считывания данных и заполнения TranslationRecords
        TThread.Queue(nil, procedure
        begin
            DisplayWord(CurrentIndex); // Отображение текущего слова
            if (swtch1.IsChecked) and (Length(TranslationRecords) > 0) then
            ShowNotification('Load data - Ok', 0);
        end);
      end;
    except
      on E: Exception do
        TThread.Queue(nil, procedure
        begin
          if swtch1.IsChecked then
             ShowNotification('Error: ' + E.Message, 0);
        end);
    end;
    // Выключаем индикатор загрузки в главном потоке
    TThread.Queue(nil, procedure begin fnLoadingCore(False); end);
    TThread.Queue(nil, procedure begin edtSearch.SetFocus; end);
  end);
except
  Exit;
end;
end;

function TFormMain.GetTranslationsFromGoogleSheetsRecOnlyD(accessToken: string; MyUrl: string): TArray<TTranslationRecord>;
var
  myObj: TJSONObject;
  valuesArray, rowArray: TJSONArray;
  i, validCount: Integer;
  recordItem: TTranslationRecord;
begin
try
  if Length(Trim(MyUrl)) = 0 then Exit;
  if Length(Trim(accessToken)) = 0 then Exit;
  // Вызов функции для получения всех данных
  SetLength(TranslationRecords, 0); // Инициализация массива
  try
    // Установка параметров запроса к Google Sheets API
    RestClient1.BaseURL := MyUrl;
    RestClient1.AcceptCharset := 'utf-8, *;q=0.8';
    RestClient1.ContentType := 'application/json; charset=UTF-8';
    RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest1.ClearBody;
    RESTRequest1.Params.Clear;
    RESTRequest1.Timeout := 60000; // Установим тайм-аут на 60 секунд
    // Добавление токена авторизации
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    // Выполнение запроса
    RESTRequest1.Execute;
    // Обработка JSON-ответа
    myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    try
      valuesArray := myObj.GetValue('values') as TJSONArray;
      if Assigned(valuesArray) then
      begin
        // Определяем, сколько валидных записей у нас будет
        validCount := 0;
        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray;
          if Assigned(rowArray) and (rowArray.Count >= 4) then
          begin
            // Проверяем, что в колонке D (индекс 3) содержится значение '()'
            if (rowArray.Items[2].Value <> '(test,test,test)') then
              Inc(validCount);
          end;
        end;
        // Инициализируем массив TranslationRecords только для валидных записей
        SetLength(TranslationRecords, validCount);
        validCount := 0;
        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray;
          if Assigned(rowArray) and (rowArray.Count >= 4) then
          begin
            // Проверяем, что в колонке D содержится значение '()'
            if (rowArray.Items[2].Value <> '(test,test,test)') then
            begin
              recordItem.ID := i + 1;
              recordItem.EstonianWord := rowArray.Items[0].Value;
              recordItem.RussianTranslation := rowArray.Items[1].Value;
              recordItem.ExtraData := rowArray.Items[2].Value;
              // Обрабатываем номер
              try
                recordItem.Number := StrToInt(rowArray.Items[3].Value);
              except
                on E: Exception do
                begin
                   recordItem.Number := 0; // Значение по умолчанию в случае ошибки
                   ShowNotification('Error converting number: ' + E.Message, 0);
                end;
              end;
              recordItem.LevelWords := lWordLevel.Text;
              TranslationRecords[validCount] := recordItem;
              Inc(validCount);
            end;
          end
          else
          begin
            ShowNotification('Row ' + IntToStr(i + 1) + ' is not a valid JSON array or has insufficient data.', 0);
          end;
        end;
      end;
    finally
      myObj.Free; // Освобождение объекта JSON
    end;
  except
    on E: Exception do
    begin
       ShowNotification('General Error: ' + E.Message, 0);
       SetLength(TranslationRecords, 0); // Возвращаем пустой массив при ошибке
    end;
  end;
  Result := TranslationRecords; // Возвращаем результат
except
  Result := nil;
  Exit;
end;
end;

function TFormMain.GetTranslationsFromGoogleSheetsRec(accessToken: string; MyUrl: string): TArray<TTranslationRecord>;
var
  myObj: TJSONObject;
  valuesArray, rowArray: TJSONArray;
  i: Integer;
  recordItem: TTranslationRecord;
begin
  if Length(Trim(MyUrl)) = 0 then Exit;
  if Length(Trim(accessToken)) = 0 then Exit;
     SetLength(TranslationRecords, 0); // Инициализация массива
  try
    // Установка параметров запроса к Google Sheets API
    RestClient1.BaseURL := MyUrl;
    RestClient1.AcceptCharset := 'utf-8, *;q=0.8';
    RestClient1.ContentType := 'application/json; charset=UTF-8';
    RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest1.ClearBody;
    RESTRequest1.Params.Clear;
    RESTRequest1.Timeout := 60000; // Установим тайм-аут на 60 секунд

    // Добавление токена авторизации
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);

    // Выполнение запроса
    RESTRequest1.Execute;

    // Обработка JSON-ответа
    myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    try
      valuesArray := myObj.GetValue('values') as TJSONArray;

      if Assigned(valuesArray) then
      begin
        SetLength(TranslationRecords, valuesArray.Count);

        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray;
          if Assigned(rowArray) then
          begin
            // Проверка количества элементов
            if rowArray.Count >= 4 then
            begin
              recordItem.ID := i + 1;
              recordItem.EstonianWord := rowArray.Items[0].Value;
              recordItem.RussianTranslation := rowArray.Items[1].Value;

              // Проверка для ExtraData
              if rowArray.Count > 2 then
              begin
                if rowArray.Items[2].Value = '()' then
                  recordItem.ExtraData := '(' + rowArray.Items[0].Value + ',' + rowArray.Items[0].Value + ',' + rowArray.Items[0].Value + ')'
                else
                  recordItem.ExtraData := rowArray.Items[2].Value;
              end
              else
                recordItem.ExtraData := '';

              // Проверка для Number
              try
                recordItem.Number := StrToInt(rowArray.Items[3].Value);
              except
                on E: Exception do
                begin
                  recordItem.Number := 0; // Значение по умолчанию в случае ошибки
                  if swtch1.IsChecked then ShowNotification('Error converting number: ' + E.Message, 0);
                end;
              end;
              recordItem.LevelWords := lWordLevel.Text;
              TranslationRecords[i] := recordItem;
              if ((not rowArray.Items[0].Null)and(not rowArray.Items[1].Null)and(not rowArray.Items[2].Null)) then
              // Запись значений в метки
              TThread.Queue(nil,
                procedure
                begin
                  if Assigned(FrontLabel) and Assigned(BackLabel) then
                  begin
                   try
                     FrontLabel.Text := ''; //rowArray.Items[0].Value + IfThen(rowArray.Count > 2, rowArray.Items[2].Value, '');
                     BackLabel.Text := ''; //rowArray.Items[1].Value;
                   except
                     if swtch1.IsChecked then ShowNotification('FrontLabel error data.', 0);
                   end;
                  end;
                end);
            end
            else
            begin
              if swtch1.IsChecked then ShowNotification('Row ' + IntToStr(i + 1) + ' has insufficient data.', 0);
            end;
          end
          else
          begin
            if swtch1.IsChecked then ShowNotification('Row ' + IntToStr(i + 1) + ' is not a valid JSON array.', 0);
          end;
        end;
      end;
    finally
      myObj.Free; // Освобождение объекта JSON
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('General Error: ' + E.Message, 0);
      SetLength(Result, 0); // Возвращаем пустой массив при ошибке
    end;
  end;
  Result := TranslationRecords; // Возвращаем результат
end;

constructor TGoogleServiceAccount.Create(const ServiceAccountKeyFile: string);
begin
try
  FServiceAccountKey := TJSONObject.ParseJSONValue(ServiceAccountKeyFile) as TJSONObject;
except
  on E: Exception do begin
     ShowNotification('Error FServiceAccountKey', 0);
     Exit;
  end;
end;
end;

procedure TFormMain.SetLanguageAndVoice;
begin
  try
    FSpeaker.SetLanguage(FSelectedLanguage);
    if FSpeaker.Language = FSelectedLanguage then
       ShowNotification('Language set to ' + FSelectedLanguage, 0)
    else
       ShowNotification('Failed to set language to ' + FSelectedLanguage, 0);
       FSpeaker.Language := FSelectedLanguage;
    if FSpeaker.AvailableVoices[0] <> '' then
       ShowNotification('Voice set to ' + FSelectedVoice, 0)
    else
       ShowNotification('Failed to set voice to ' + FSelectedVoice, 0);
  except
    on E: Exception do
    begin
       ShowNotification('Error setting language or voice: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SpeakerCheckDataCompleteHandler(Sender: TObject);
begin
  try
    if Length(FSpeaker.AvailableVoices) > 0 then
    begin
       ShowNotification('Available voices:', 0);
       // Предположим, что вы выбрали первый доступный голос для примера
       FSelectedVoice := FSpeaker.AvailableVoices[0]; SetLanguageAndVoice;
       ShowNotification('Selected voice: ' + FSelectedVoice, 0);
    end;
  except
    on E: Exception do
    begin
       ShowNotification('Error in SpeakerCheckDataCompleteHandler: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SpeakerSpeechFinishedHandler(Sender: TObject);
begin
  try
    if Assigned(FSpeaker) then FSpeaker.Stop; // Остановить любую текущую активность
  except
    on E: Exception do
    begin
       ShowNotification('Error in Finished Handler: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SpeakerSpeechStartedHandler(Sender: TObject);
begin
  try
    FSpeaker.SetLanguage(FSelectedLanguage);
  except
    on E: Exception do
    begin
      ShowNotification('Error in Started Handler: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SpeakText(const Text: string);
begin
try
     // Установите выбранный язык и голос перед воспроизведением
     FSpeaker.Language := FSelectedLanguage;
     SetLanguageAndVoice;
  if FSpeaker.IsSpeaking then
     FSpeaker.Stop;
     FSpeaker.Speak(Text);
except
  on E: Exception do
  begin
     ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.GetLangID(idx: Integer);
begin
try
  {$IFDEF ANDROID}
  idLang := 3;
  idxLang := idx;
  TDialogBuilder.Create(Self)
    .SetTitle('Choose language')
    .SetSingleChoiceItems(
      [
      'Rus - Est',
      'Est - Rus',
      'Est - Ukr',
      'Ukr - Est',
      'Rus - Eng',
      'Eng - Rus',
      'Ukr - Eng',
      'Eng - Ukr'
    ], idLang)
    .SetPositiveButton('Cancel')
    .SetNegativeButton('Sellect',
      procedure (Dialog: IDialog; Which: Integer) begin
        idLang := Dialog.Builder.CheckedItem;
        if idLang = 0 then lstatus.Text := uTextLabel + '  [Rus - Est]';
        if idLang = 1 then lstatus.Text := uTextLabel + '  [Est - Rus]';
        if idLang = 2 then lstatus.Text := uTextLabel + '  [Est - Ukr]';
        if idLang = 3 then lstatus.Text := uTextLabel + '  [Ukr - Est]';
        if idLang = 4 then lstatus.Text := uTextLabel + '  [Rus - Eng]';
        if idLang = 5 then lstatus.Text := uTextLabel + '  [Eng - Rus]';
        if idLang = 6 then lstatus.Text := uTextLabel + '  [Ukr - Eng]';
        if idLang = 7 then lstatus.Text := uTextLabel + '  [Eng - Ukr]';
        btnGo.Enabled := True;
      end
    )
    .Show;
  {$ENDIF}
except
  Exit;
end;
end;

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
    on E: Exception do begin
       Result := 0;
       Exit;
    end;
  end;
end;
// Get count words in text
function TFormMain.CountWordsInMemo : Integer;
var
  countTxT: Integer;
begin
  try
    if Length(Trim(mmo_src.Lines.Text)) = 0 then begin
       Result := 0;
       Exit;
    end else begin
       countTxT := CountWords(mmo_src.Lines.Text);
       Result := countTxT;
    end;
  except
    on E: Exception do begin
       Result := 0;
       Exit;
    end;
  end;
end;

function TFormMain.GetHtmlContent(value: string) : string;
begin
try
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
       ShowNotification('Error ' + E.Message, 0);
       Exit;
    end;
  end;
except
  Exit;
end;
end;

function ExtractTextFromHTML(const HTML: string): string;
var
  LHtml: IHtmlElement;
  LList: IHtmlElementList;
  LItem: IHtmlElement;
  TextResult: string;
  SentencesCount: Integer;
  MaxSentences: Integer;
  SentenceArray: TArray<string>;
begin
  Result := ''; // Инициализация результата
  MaxSentences := 3; // Ограничение на количество предложений
  SentencesCount := 0;
  try
    // Парсим HTML-контент
    LHtml := ParserHTML(HTML);
    if not Assigned(LHtml) then
    begin
      ShowNotification('HTML parsing failed: LHtml is nil', 0);
      Exit;
    end;
    // Используем селектор для поиска нужного элемента
    LList := LHtml.SimpleCSSSelector('.example-text-value');
    if not Assigned(LList) or (LList.Count = 0) then
    begin
      ShowNotification('No elements found with the selector .example-text-value', 0);
      Exit;
    end;
    // Извлекаем текст из элементов с классом example-text-value
    for LItem in LList do
    begin
      // Добавляем текст элемента
      TextResult := TextResult + LItem.InnerText.Trim + ' ';
      // Подсчитываем количество предложений (количество точек)
      SentenceArray := SplitString(LItem.InnerText, '.'); // Разбиваем по точкам
      SentencesCount := SentencesCount + Length(SentenceArray) - 1; // Количество предложений
      // Прерываем цикл, если достигнуто максимальное количество предложений
      if SentencesCount >= MaxSentences then
        Break;
    end;
    // Убираем лишние пробелы и возвращаем результат
    Result := TextResult.Trim;
    if Result = '' then
       ShowNotification('Result is empty after parsing', 0);
  except
    on E: Exception do
    begin
      ShowNotification('Error parsing HTML: ' + E.Message, 0);
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

procedure TFormMain.TransferWords(sWord: string);
var
  tmp, WordID: string;
begin
  try
    if Trim(sWord) = '' then Exit;
    if Trim(uURL) = '' then Exit;
    lWords.Text := '';
    TTask.Run(procedure
    var
      Response: string;
      ExtractedWords: TStringList;
    begin
      TThread.Queue(nil, procedure begin fnLoadingCore(True); end); // Включение индикатора загрузки
      try
        // Формируем URL и получаем HTML-контент
        tmp := StringReplace(uURL + uRLs, uRLs, sWord, [rfReplaceAll]);
        Response := GetHtmlContent(tmp);
        TThread.Queue(nil, procedure begin ShowNotification(' ... ', 0); end); // Отладка 'HTML Content Loaded: ' + IntToStr(Length(Trim(Response)))
        // Проверка на отсутствие ошибок в ответе
        if Pos('Error', Response) = 0 then
        begin
          WordID := ExtractWordID(Response);
          TThread.Queue(nil, procedure begin ShowNotification(' ... ', 0); end); //'Extracted WordID: ' + WordID
        end
        else
        begin
          TThread.Queue(nil, procedure begin ShowNotification('Error in first Response', 0); end);
        end;
        // Если найден WordID, загружаем дополнительный контент
        if WordID.Trim <> '' then
        begin
          tmp := StringReplace(uURLWords + uRLWords, uRLWords, WordID, [rfReplaceAll]);
          Response := GetHtmlContent(tmp);
          TThread.Queue(nil, procedure begin ShowNotification(' ... ', 0); end);
        end else begin
           TThread.Queue(nil, procedure begin ShowNotification('No WordID found after first Response', 0); end);
        end;
        if Length(Trim(Response)) = 0 then
           TThread.Queue(nil, procedure begin ShowNotification('Response is Null', 0); end);
           // Обработка извлеченного текста
           ExtractedWords := TStringList.Create;
        try
           ExtractedWords.Text := ExtractTextFromHTML(Response);
           TThread.Queue(nil, procedure begin ShowNotification(' ... ', 0); end); //'Extracted Text: ' + ExtractedWords.Text
           // Обновляем интерфейс только если текст валиден
           TThread.Queue(nil, procedure
          begin
            if (Pos('error', LowerCase(ExtractedWords.Text)) = 0) and
               (Pos('span', LowerCase(ExtractedWords.Text)) = 0) and
               (ExtractedWords.Text.Trim <> '') then
            begin
               lWords.Text := ExtractedWords.Text;
            end
            else
            begin
            // Если найден WordID, загружаем дополнительный контент
            if WordID.Trim <> '' then
            begin
              tmp := StringReplace(uURLWordsd + uRLWords, uRLWords, WordID, [rfReplaceAll]);
              Response := GetHtmlContent(tmp);
              TThread.Queue(nil, procedure begin ShowNotification(' ... ', 0); end); //Second Response Loaded
              ExtractedWords.Text := ExtractTextFromHTML(Response);
              if (Pos('error', LowerCase(ExtractedWords.Text)) = 0) and
                 (Pos('span', LowerCase(ExtractedWords.Text)) = 0) and
                 (ExtractedWords.Text.Trim <> '') then
              begin
                 lWords.Text := ExtractedWords.Text;
              end;
            end
            else
            begin
              TThread.Queue(nil, procedure begin ShowNotification('No WordIDs found after first Response', 0); end);
            end;
            end;
          end);
          // Пытаемся загрузить изображение, если текст был найден
          TThread.Queue(nil, procedure
          begin
            try
              var ImageURL := ExtractImageURLFromHTML(Response);
              if ImageURL <> '' then
                 LoadImageFromURLSVG(ImageURL)
              else
                 TThread.Queue(nil, procedure begin ShowNotification('Image URL not found', 0); end);
            except
              TThread.Queue(nil, procedure begin ShowNotification('No image svg', 0); end);
            end;
          end);
        finally
          ExtractedWords.Free;
        end;
      except
        on E: Exception do
        begin
          TThread.Queue(nil, procedure
          begin
            ShowNotification('Error: ' + E.Message, 0);
          end);
        end;
      end;
      TThread.Queue(nil, procedure begin fnLoadingCore(False); end); // Отключаем индикатор загрузки
    end);
  except
    Exit;
  end;
end;

//Load Games eesti
function TFormMain.LoadSheetDataGames: TSheetRowListGames;
var
  str: string;
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i: Integer;
  sheetRow: TSheetRowGames;
begin
  FSheetDataGames.Clear;
  try
    RESTClient.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uTokenEestiGames + '/values/A1:C999?majorDimension=ROWS&key=' + uApiKey;
    RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient.ContentType := 'application/json; charset=UTF-8';
    RESTRequest.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest.ClearBody;
    RESTRequest.Params.Clear;
    RESTRequest.Execute;
    str := RESTResponse.Content;
    // Парсинг JSON ответа
    jsonObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
    try
      valuesArray := jsonObj.GetValue('values') as TJSONArray;
      for i := 0 to valuesArray.Count - 1 do
      begin
        rowArray := valuesArray.Items[i] as TJSONArray;
        if rowArray.Count >= 3 then
        begin
          sheetRow := TSheetRowGames.Create;
          sheetRow.ID := StrToIntDef(rowArray.Items[0].Value, 0);
          sheetRow.Column2 := rowArray.Items[1].Value;
          sheetRow.Column3 := rowArray.Items[2].Value;
          FSheetDataGames.Add(sheetRow);
        end;
      end;
    finally
      jsonObj.Free;
    end;
  except
    on E: Exception do
    begin
      if FormMain.swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
         FSheetDataGames.Clear;
    end;
  end;
end;

function TFormMain.LoadPostpositsiooneSheetData: TSheetPostpositsiooneRowList;
var
  str: string;
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i: Integer;
  sheetRow: TSheetPostpositsiooneRow;
begin
  FSheetPostpositsiooneData.Clear;
  try
    RESTClient.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uTokenPostpositsioonid + '/values/A1:G999?majorDimension=ROWS&key=' + uApiKey;
    RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient.ContentType := 'application/json; charset=UTF-8';
    RESTRequest.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest.ClearBody;
    RESTRequest.Params.Clear;
    RESTRequest.Execute;
    str := RESTResponse.Content;
    if RestResponse.StatusCode = 200 then
    begin
      // Парсинг JSON ответа
      jsonObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
      try
        valuesArray := jsonObj.GetValue('values') as TJSONArray;
        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray;
          if rowArray.Count >= 4 then
          begin
            sheetRow := TSheetPostpositsiooneRow.Create;
            sheetRow.ID := StrToIntDef(rowArray.Items[0].Value, 0);
            sheetRow.Question := rowArray.Items[1].Value;
            sheetRow.Word := rowArray.Items[2].Value;
            sheetRow.Example := rowArray.Items[3].Value;
            FSheetPostpositsiooneData.Add(sheetRow);
          end;
        end;
      finally
        jsonObj.Free;
      end;
    end else ShowNotification('Error: ' + RestResponse.StatusText, 0);
  except
    on E: Exception do
    begin
      if FormMain.swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
         FSheetPostpositsiooneData.Clear;
    end;
  end;
end;

function TFormMain.LoadSheetData: TSheetRowList;
var
  str: string;
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i: Integer;
  sheetRow: TSheetRow;
begin
  FSheetData.Clear;
  try
    RESTClient.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uTokenAntonimid + '/values/A1:D999?majorDimension=ROWS&key=' + uApiKey;
    RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient.ContentType := 'application/json; charset=UTF-8';
    RESTRequest.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest.ClearBody;
    RESTRequest.Params.Clear;
    RESTRequest.Execute;
    str := RESTResponse.Content;
    // Парсинг JSON ответа
    jsonObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
    try
      valuesArray := jsonObj.GetValue('values') as TJSONArray;
      for i := 0 to valuesArray.Count - 1 do
      begin
        rowArray := valuesArray.Items[i] as TJSONArray;
        if rowArray.Count >= 4 then
        begin
          sheetRow := TSheetRow.Create;
          sheetRow.ID := StrToIntDef(rowArray.Items[0].Value, 0);
          sheetRow.Column2 := rowArray.Items[1].Value;
          sheetRow.Column3 := rowArray.Items[2].Value;
          sheetRow.Column4 := rowArray.Items[3].Value;
          FSheetData.Add(sheetRow);
        end;
      end;
    finally
      jsonObj.Free;
    end;
  except
    on E: Exception do
    begin
      if FormMain.swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
      FSheetData.Clear;
    end;
  end;
end;

function TFormMain.LoadSheetQuestData: TSheetQuestRowList;
var
  str: string;
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i: Integer;
  sheetRow: TSheetQuestRow;
begin
  FSheetQuestData.Clear;
  try
    RESTClient.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uToken + '/values/A1:G999?majorDimension=ROWS&key=' + uApiKey;
    RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient.ContentType := 'application/json; charset=UTF-8';
    RESTRequest.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest.ClearBody;
    RESTRequest.Params.Clear;
    RESTRequest.Execute;
    str := RESTResponse.Content;
    // Парсинг JSON ответа
    jsonObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
    try
      valuesArray := jsonObj.GetValue('values') as TJSONArray;
      for i := 0 to valuesArray.Count - 1 do
      begin
        rowArray := valuesArray.Items[i] as TJSONArray;
        if rowArray.Count >= 4 then
        begin
          sheetRow := TSheetQuestRow.Create;
          sheetRow.ID := StrToIntDef(rowArray.Items[0].Value, 0);
          sheetRow.EstWord := rowArray.Items[1].Value;
          sheetRow.RusWord := rowArray.Items[2].Value;
          sheetRow.AinWord := rowArray.Items[3].Value;
          sheetRow.MitWord := rowArray.Items[4].Value;
          sheetRow.PadWord := rowArray.Items[5].Value;
          sheetRow.ExaWord := rowArray.Items[6].Value;
          FSheetQuestData.Add(sheetRow);
        end;
      end;
    finally
      jsonObj.Free;
    end;
  except
    on E: Exception do
    begin
      if FormMain.swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
      FSheetQuestData.Clear;
    end;
  end;
end;

function TFormMain.LoadSheetExampData: TSheetExampRowList;
var
  str: string;
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i: Integer;
  sheetRow: TSheetExampRow;
begin
  FSheetExampData.Clear;
  try
    RESTClient.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/' + uTokenKusiMA + '/values/A1:G999?majorDimension=ROWS&key=' + uApiKey;
    RESTClient.AcceptCharset := 'utf-8, *;q=0.8';
    RESTClient.ContentType := 'application/json; charset=UTF-8';
    RESTRequest.Client.FallbackCharsetEncoding := 'raw';
    RESTRequest.ClearBody;
    RESTRequest.Params.Clear;
    RESTRequest.Execute;
    str := RESTResponse.Content;
    // Парсинг JSON ответа
    jsonObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
    try
      valuesArray := jsonObj.GetValue('values') as TJSONArray;
      for i := 0 to valuesArray.Count - 1 do
      begin
        rowArray := valuesArray.Items[i] as TJSONArray;
        if rowArray.Count >= 4 then
        begin
          sheetRow := TSheetExampRow.Create;
          sheetRow.ID := StrToIntDef(rowArray.Items[0].Value, 0);
          sheetRow.ExaWord := rowArray.Items[1].Value;
          sheetRow.EstWord := rowArray.Items[2].Value;
          sheetRow.RusWord := rowArray.Items[3].Value;
          FSheetExampData.Add(sheetRow);
        end;
      end;
    finally
      jsonObj.Free;
    end;
  except
    on E: Exception do
    begin
      if FormMain.swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
      FSheetExampData.Clear;
    end;
  end;
end;

function GetRandomPostpositsiooneRow(SheetRowList: TSheetPostpositsiooneRowList): TSheetPostpositsiooneRow;
var
  RandomIndex: Integer;
begin
try
 if SheetRowList.Count = 0 then
    raise Exception.Create('The list is empty.');
    RandomIndex := Random(SheetRowList.Count);
    Result := SheetRowList[RandomIndex];
except
  Result := nil;
  Exit;
end;
end;

function GetRandomRow(SheetRowList: TSheetRowList): TSheetRow;
var
  RandomIndex: Integer;
begin
try
 if SheetRowList.Count = 0 then
    raise Exception.Create('The list is empty.');
    RandomIndex := Random(SheetRowList.Count);
    Result := SheetRowList[RandomIndex];
except
  Result := nil;
  Exit;
end;
end;

function GetRandomExampRow(SheetRowList: TSheetExampRowList): TSheetExampRow;
var
  RandomIndex: Integer;
begin
try
 if SheetRowList.Count = 0 then
    raise Exception.Create('The list is empty.');
    RandomIndex := Random(SheetRowList.Count);
    Result := SheetRowList[RandomIndex];
except
  Result := nil;
  Exit;
end;
end;

function GetRandomQuestRow(SheetRowList: TSheetQuestRowList): TSheetQuestRow;
var
  RandomIndex: Integer;
begin
try
 if SheetRowList.Count = 0 then
    raise Exception.Create('The list is empty.');
    RandomIndex := Random(SheetRowList.Count);
    Result := SheetRowList[RandomIndex];
except
  Result := nil;
  Exit;
end;
end;

function GetRandomGamesRow(SheetRowList: TSheetRowListGames): TSheetRowGames;
var
  RandomIndex: Integer;
begin
try
 if SheetRowList.Count = 0 then
    raise Exception.Create('The list is empty.');
    RandomIndex := Random(SheetRowList.Count);
    Result := SheetRowList[RandomIndex];
except
  Result := nil;
  Exit;
end;
end;

function TGoogleServiceAccount.GetAccessToken: string;
var
  JWT: TJWT;
  JWS: TJWS;
  JWK: TJWK;
  JWTToken: TJOSEBytes;
  JSONResponse: TJSONObject;
  HTTPClient: TNetHTTPClient;
  RequestBody: TStringStream;
  Response: IHTTPResponse;
begin
try
  Result := '';
  if (FAccessToken = '') or (Now >= FAccessTokenExpiry) then
  begin
    // Create JWT
    JWT := TJWT.Create;
    try
      JWT.Claims.Issuer := FServiceAccountKey.GetValue<string>('client_email');
      JWT.Claims.Subject := FServiceAccountKey.GetValue<string>('client_email');
      JWT.Claims.Audience := 'https://oauth2.googleapis.com/token';
      JWT.Claims.Expiration := Now + EncodeTime(1, 0, 0, 0); // Expiry in 1 day
      JWT.Claims.SetClaimOfType('scope', 'https://www.googleapis.com/auth/spreadsheets');
      JWT.Claims.SetClaimOfType('aud', 'https://oauth2.googleapis.com/token');
      JWT.Claims.IssuedAt := Now;
      JWT.Header.KeyID := FServiceAccountKey.GetValue<string>('private_key_id');
      // Create JWS
      JWK := TJWK.Create(FServiceAccountKey.GetValue<string>('private_key'));
      JWS := TJWS.Create(JWT);
      try
        JWS.Sign(JWK, TJOSEAlgorithmId.RS256);
        JWTToken := JWS.CompactToken;
        // Request Access Token
        HTTPClient := TNetHTTPClient.Create(nil);
        try
          RequestBody := TStringStream.Create('grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=' + JWTToken.AsString);
          try
            if FormMain.swtch1.IsChecked then ShowNotification('Post Obj - Token ... ', 0);
            HTTPClient.ContentType := 'application/x-www-form-urlencoded';
            Response := HTTPClient.Post('https://oauth2.googleapis.com/token', RequestBody);
            if Response.StatusCode = 200 then
            begin
              JSONResponse := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
              try
                FAccessToken := JSONResponse.GetValue<string>('access_token');
                FAccessTokenExpiry := Now + StrToFloat(JSONResponse.GetValue<string>('expires_in')) / SecsPerDay;
                //if FormMain.swtch1.IsChecked then ShowNotification('Access Token - Ok ', 0);
                try
                 FormMain.mmoInfo.Lines.Add('Access Token : '+#13#10+FAccessToken+#13#10+'Date Token Expiry: '+#13#10+DateToStr(FAccessTokenExpiry));
                except
                 FormMain.mmoInfo.Lines.Add('Error read token ...'); //if FormMain.swtch1.IsChecked then ShowNotification('Error Access Token', 0);
                end;
              finally
                JSONResponse.Free;
              end;
            end
            else
              raise Exception.CreateFmt('Error getting access token: %s', [Response.ContentAsString]);
          finally
            RequestBody.Free;
          end;
        finally
          HTTPClient.Free;
        end;
      finally
        JWS.Free;
      end;
    finally
      JWT.Free;
    end;
  end;
  Result := FAccessToken;
except
  on E: Exception do begin
     if FormMain.swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Result := '';
     Exit;
  end;
end;
end;

function TFormMain.GetKeyGemini(value: string; key: string; SpreadsheetId: string) : string;
var
  Range: string;
  JSONResponse: TJSONObject;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  RowArray: TJSONArray;
  APIKeyValue, OAuthToken, APIKeyName: string;
begin
  Result := '';
  if Length(Trim(uAccessToken)) = 0 then Exit;
  Range := Format('key!A%s:C%s', [key, key]); // Пример диапазона, содержащего API ключ
  RestClient1.BaseURL := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s', [SpreadsheetId, Range]);
  RestRequest1.Client := RestClient1;
  RestRequest1.Response := RestResponse1;
  RestRequest1.Method := TRESTRequestMethod.rmGET;
  RestRequest1.Params.Clear;
  RestRequest1.AddAuthParameter('Authorization', 'Bearer ' + uAccessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
  // Убираем AddBody для GET-запроса
  // RestRequest1.AddBody(JSONObj.ToString, TRESTContentType.ctAPPLICATION_JSON);
  try
    RestRequest1.Execute;
    if RestResponse1.StatusCode = 200 then
    begin
      JSONResponse := TJSONObject.ParseJSONValue(RestResponse1.Content) as TJSONObject;
      try
        JSONValue := JSONResponse.GetValue('values');
        if JSONValue is TJSONArray then
        begin
          JSONArray := JSONValue as TJSONArray;
          if JSONArray.Count > 0 then
          begin
            RowArray := JSONArray.Items[0] as TJSONArray;
            if RowArray.Count > 1 then
            begin
              APIKeyValue := RowArray.Items[0].Value;
              OAuthToken := RowArray.Items[1].Value;
              APIKeyName := RowArray.Items[2].Value;
              if APIKeyName = value then
              begin
                Result := Trim(OAuthToken);
                mLog.Lines.Add('OAuth Token '+value+' : ' + OAuthToken); //ShowNotification('Api Key - Ok', 0);
              end
              else
              begin
                Result := 'Error: API Key Name does not match.';
              end;
            end
            else
            begin
              Result := 'Error: Insufficient values in the row.';
            end;
          end
          else
          begin
            Result := 'Error: No rows found.';
          end;
        end
        else
        begin
          Result := 'Error: Values not found in response.';
        end;
      finally
        JSONResponse.Free;
      end;
    end
    else
    begin
      Result := 'Error: ' + RestResponse1.StatusText;
    end;
  except
    on E: Exception do
    begin
      ShowNotification('Error ' + E.Message, 0);
      Exit;
    end;
  end;
end;

function TFormMain.GetGoogleApiKey(value: string; key: string; SpreadsheetId: string) : string;
var
  APIKey, Range: string;
  JSONResponse: TJSONObject;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  RowArray: TJSONArray;
  APIKeyValue, OAuthToken, APIKeyName: string; //JSONObj: TJSONObject;
begin
try
  Result := '';
  APIKey := uGoogleApiKeys;
  Range := 'statKey!A'+key+':C'+key; // Пример диапазона, содержащего API ключ
  // Настраиваем RestClient и RestRequest
  RestClient.BaseURL := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s', [SpreadsheetId, Range]);
  RestRequest.Client := RestClient;
  RestRequest.Response := RestResponse;
  RestRequest.Method := TRESTRequestMethod.rmGET;
  RestRequest.Params.Clear;
  RestRequest.AddParameter('key', APIKey, TRESTRequestParameterKind.pkQUERY);
  // Выполняем запрос
  RestRequest.Execute;
  // Обрабатываем ответ
  if RestResponse.StatusCode = 200 then
  begin
    JSONResponse := TJSONObject.ParseJSONValue(RestResponse.Content) as TJSONObject;
    try
      // Получаем данные из JSON ответа
      JSONValue := JSONResponse.GetValue('values');
      if JSONValue is TJSONArray then
      begin
        JSONArray := JSONValue as TJSONArray;
        if JSONArray.Count > 0 then
        begin
          // Предполагаем, что данные в первой строке (индекс 0)
          RowArray := JSONArray.Items[0] as TJSONArray;
          if RowArray.Count > 1 then
          begin
            APIKeyValue := RowArray.Items[0].Value;
            OAuthToken := RowArray.Items[1].Value;
            APIKeyName := RowArray.Items[2].Value;
            if APIKeyName = value then begin
               Result := Trim(OAuthToken);            //ShowMessage('OAuth Token: ' + OAuthToken); if FormMain.swtch1.IsChecked then ShowNotification('Api Key - Ok', 0);
            end else Result := 'Error';
          end
          else
          begin
            Result := 'Error: Insufficient values in the row.';
          end;
        end
        else
        begin
          Result := 'Error: No rows found.';
        end;
      end
      else
      begin
        Result := 'Error: Values not found in response.';
      end;
    finally
      JSONResponse.Free;
    end;
  end
  else
  begin
    Result := 'Error: ' + RestResponse.StatusText;
  end;
except
  on E: Exception do begin
     if FormMain.swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Result := '';
     Exit;
  end;
end;
end;

procedure DelayedSetFocus(Control: TControl);
begin
try
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize( nil,
         procedure
         begin
           Control.SetFocus;
         end
      );
    end
  ).Start;
except
  on E: Exception do begin
     if FormMain.swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.AppUpdateInfoHandler(Sender: TObject; const AInfo: TAppUpdateInfo);
begin
try
  mmoInfo.Lines.Add('Available: ' + BoolToStr(AInfo.Available, True));
  if AInfo.Available then
  begin
    mmoInfo.Lines.Add('Total Bytes: ' + AInfo.TotalBytesToDownload.ToString);
    mmoInfo.Lines.Add('Priority: ' + AInfo.Priority.ToString);
    mmoInfo.Lines.Add('Immediate: ' + BoolToStr(AInfo.Immediate, True));
    mmoInfo.Lines.Add('Flexible: ' + BoolToStr(AInfo.Flexible, True));
    if AInfo.Flexible then
       mmoInfo.Lines.Add('Staleness Days: ' + AInfo.StalenessDays.ToString);
  end;
except
  on E: Exception do begin
     if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.AppUpdateResultHandler(Sender: TObject; const AUpdateResult: TAppUpdateResult);
begin
try
  mmoInfo.Lines.Add('Update result: ' + GetEnumName(TypeInfo(TAppUpdateResult), Ord(AUpdateResult)));
except
  on E: Exception do begin
     if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.AppUpdateStartedFlowHandler(Sender: TObject; const AStarted: Boolean);
begin
try
  mmoInfo.Lines.Add('Flow started: ' + BoolToStr(AStarted, True));
except
  on E: Exception do begin
     if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;

{$IF DEFINED(ANDROID) AND (RTLVersion >= 33)}
procedure TFormMain.PermissionsCheck;
begin
try
  if TJBuild_VERSION.JavaClass.SDK_INT >= 23 then begin
     FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
     FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);

     PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage],
       TakePicturePermissionRequestResult{$IF RTLVersion >= 35}, DisplayRationale{$ENDIF});
  end;
except
  on E: Exception do begin
     if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;
{$ENDIF}

//------------------Youtube-----------------------------
procedure TFormMain.LoadImageFromURL(img: TBitmap; url: string);
var
  HttpClient: TNetHTTPClient;
  Response: IHTTPResponse;
  MemoryStream: TMemoryStream;
begin
 try
  HttpClient := TNetHTTPClient.Create(nil);
  MemoryStream := TMemoryStream.Create;
  try
    Response := HttpClient.Get(url);
    if Response.StatusCode = 200 then
    begin
      MemoryStream.LoadFromStream(Response.ContentStream);
      MemoryStream.Position := 0;
      img.LoadFromStream(MemoryStream);
    end
    else
      raise Exception.Create('Error loading image: ' + Response.StatusText);
  finally
    MemoryStream.Free;
    HttpClient.Free;
  end;
 except
    on E: Exception do begin
       if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
       Exit;
    end;
 end;
end;

procedure TFormMain.lstatusClick(Sender: TObject);
begin
  ShowNotification('Number of characters written', 0);
end;

procedure TFormMain.lvVideosClick(Sender: TObject);
begin
try
  BannerAd1.Visible := False;
  ButtonsAdMob.Visible := False;
except
  Exit;
end;
end;

procedure TFormMain.lvVideosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
 try
    if not Assigned(FrmVideo) then
       Application.CreateForm(TFrmVideo, FrmVideo);
    if AItem.Tag = 1 then
       FrmVideo.plataforma := TPlataformaVideo.YouTube
    else
       FrmVideo.plataforma := TPlataformaVideo.Vimeo;
       FrmVideo.codVideo := AItem.TagString;
       FrmVideo.titulo := TListItemText(AItem.Objects.FindDrawable('txtTitulo')).Text;
       FrmVideo.uPrivUser := privUsers;
       FrmVideo.uLang := uYout;
       FrmVideo.Show;
 except
    on E: Exception do begin
       if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
       Exit;
    end;
 end;
end;

procedure TFormMain.lvVideosUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
 try
    LayoutListview(AItem);
 except
    on E: Exception do begin
       if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
       Exit;
    end;
 end;
end;

procedure TFormMain.LytAnswersClick(Sender: TObject);
begin
  ShowNotification('Login, Register, Password Reset or Logout Event Selection Panel', 0);
end;

procedure TFormMain.LytBodyClick(Sender: TObject);
begin
  ShowNotification('Main form', 0);
end;

procedure TFormMain.DownloadFotoListview(lv: TListview; obj_foto: string);
var
  t: TThread;
  img: TListItemImage;
begin
 try
  t := TThread.CreateAnonymousThread(procedure
  var
    i: Integer;
    Bitmap: TBitmap;
    URL: string;
  begin
    for i := 0 to lv.Items.Count - 1 do
    begin
      img := TListItemImage(lv.Items[i].Objects.FindDrawable(obj_foto));
      URL := img.TagString;

      if URL <> '' then
      begin
        Bitmap := TBitmap.Create;
        try
          // Загрузка изображения
          LoadImageFromURL(Bitmap, URL);
          TThread.Synchronize(nil, procedure
          begin
            // Установка загруженного изображения
            img.Bitmap := Bitmap;
            img.OwnsBitmap := True;
          end);
        except
          Bitmap.Free;
        end;
      end;
    end;
  end);
  t.Start;
 except
    on E: Exception do begin
       if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
       Exit;
    end;
 end;
end;

function TFormMain.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  try
    Layout := TTextLayoutManager.DefaultTextLayout.Create;
    try
      Layout.BeginUpdate;
      try
        Layout.Font.Assign(D.Font);
        Layout.VerticalAlign := D.TextVertAlign;
        Layout.HorizontalAlign := D.TextAlign;
        Layout.WordWrap := D.WordWrap;
        Layout.Trimming := D.Trimming;
        Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
        Layout.Text := Text;
      finally
        Layout.EndUpdate;
      end;
      Result := Round(Layout.Height);
      Layout.Text := 'm';
      Result := Result + Round(Layout.Height);
    finally
      Layout.Free;
    end;
  except
    on E: Exception do begin
       if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
       Result := 0;
       Exit;
    end;
  end;
end;

procedure TFormMain.LayoutListview(AItem: TListViewItem);
var
  txt: TListItemText;
  img: TListItemImage;
  proporcao: Double;
begin
  try
    img := AItem.Objects.FindDrawable('imgVideo') as TListItemImage;
    txt := AItem.Objects.FindDrawable('txtTitulo') as TListItemText;
    proporcao := 1080 / 1920; // 0.5625
    img.PlaceOffset.X := 0;
    img.PlaceOffset.Y := 0;
    img.Width := lvVideos.Width;
    img.Height := img.Width * proporcao;
    txt.Width := lvVideos.Width - 20;
    txt.Height := GetTextHeight(txt, txt.Width, txt.Text) + 5;
    txt.PlaceOffset.Y := img.PlaceOffset.Y + img.Height + 3;
    AItem.Height := Trunc(txt.PlaceOffset.Y + txt.Height);
  except
    on E: Exception do begin
       if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
       Exit;
    end;
  end;
end;

procedure TFormMain.AddVideoListview(id_video, descricao, url_foto: string; plataforma: TPlataformaVideo);
var
  item: TListViewItem;
  img: TListItemImage;
begin
  try
    item := lvVideos.Items.Add;
    with item do
    begin
      Height := 150;
      TagString := id_video;
      if plataforma = TPlataformaVideo.YouTube then
        tag := 1
      else
        tag := 2;
      // Устанавливаем URL изображения в TagString, позже используем для загрузки изображения
      img := TListItemImage(Objects.FindDrawable('imgVideo'));
      img.TagString := url_foto;
      // Пустое изображение для начала
      img.Bitmap := nil;
      TListItemText(Objects.FindDrawable('txtTitulo')).Text := descricao;
    end;
    LayoutListview(item);
  except
    on E: Exception do
      if swtch1.IsChecked then ShowNotification('Error in AddVideoListview: ' + E.Message, 0);
  end;
end;

procedure TFormMain.ThreadTerminate(Sender: TObject);
begin
  try
    //TLoading.Hide;
    lvVideos.EndUpdate;
    // Запускаем загрузку изображений после завершения основного потока
    DownloadFotoListview(lvVideos, 'imgVideo');
  except
    on E: Exception do
      if swtch1.IsChecked then ShowNotification('Error in ThreadTerminate: ' + E.Message, 0);
  end;
end;

procedure TFormMain.tmr1Timer(Sender: TObject);
begin
try
  tIDX := tIDX - 1;
  TxtOptionSecond.Text := 'Login ['+IntToStr(tIDX)+']';
  if tIDX <= 0 then begin
     tIDX := 13;
     tmr1.Enabled := False;
     Self.actSignInExecute(Self);
  end;
except
  Exit;
end;
end;

procedure TFormMain.TxtOptionSecondClick(Sender: TObject);
begin

end;

//Load English video
procedure TFormMain.LinearLayout1Click(Sender: TObject);
begin
try
  WebBrowser1.Visible := True;
except
  Exit;
end;
end;

procedure TFormMain.ListarEngVideos(uPlayList : string);
var
  HttpClient: TNetHTTPClient;
  HttpResponse: IHTTPResponse;
  JSONObj, ItemObj, SnippetObj: TJSONObject;
  ItemsArray: TJSONArray;
  VideoID, VideoTitle: string;
  J: Integer;
begin
try
  lvVideos.ScrollTo(0);
  lvVideos.BeginUpdate;
  lvVideos.Items.Clear;  //if Length(Trim(FAPIKEYYOUTUBE)) = 0 then FAPIKEYYOUTUBE := GetGoogleApiKey('Youtube','1');
  HttpClient := TNetHTTPClient.Create(nil);
  try
     if Length(Trim(uPlayList)) > 0 then begin
      HttpResponse := HttpClient.Get('https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=' + uPlayList + '&maxResults=50&key=' + FAPIKEYYOUTUBE);
      if HttpResponse.StatusCode = 200 then
      begin
        JSONObj := TJSONObject.ParseJSONValue(HttpResponse.ContentAsString) as TJSONObject;
        try
          ItemsArray := JSONObj.GetValue<TJSONArray>('items');
          for J := 0 to ItemsArray.Count - 1 do
          begin
            ItemObj := ItemsArray.Items[J] as TJSONObject;
            SnippetObj := ItemObj.GetValue<TJSONObject>('snippet');
            VideoID := SnippetObj.GetValue<TJSONObject>('resourceId').GetValue<string>('videoId');
            VideoTitle := SnippetObj.GetValue<string>('title');
            TThread.Synchronize(nil, procedure
            begin
              AddVideoListview(VideoID, VideoTitle, 'https://i.ytimg.com/vi/' + VideoID + '/hqdefault.jpg', YouTube);
            end);
          end;
        finally
          JSONObj.Free;
        end;
      end
      else
      begin
        if swtch1.IsChecked then ShowNotification('Error: ' + HttpResponse.StatusText, 0);
      end;
     end;
  finally
    HttpClient.Free;
    TThread.Synchronize(nil, procedure
    begin
      Self.ThreadTerminate(Self);
    end);
  end;
except
  if swtch1.IsChecked then ShowNotification('Error ListarEngVideos !', 0);
  lvVideos.EndUpdate;
  Exit;
end;
end;

procedure TFormMain.ListarEstVideos(uPlayList : string);
const
  FixedVideos0: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'GT-WOx4XeIo'; VideoTitle : 'Hommikul saadan lapsed ekskursioonile ja lähen tööle. (B1)'),
    (VideoID : 'YAFlefWknBc'; VideoTitle : 'Pärastlõunal saadan lapsed muuseumisse ja lähen ise postkontorisse. (B1)'),
    (VideoID : 'Vu5oU2wlg3g'; VideoTitle : 'Õhtul saadan lapsed ujumistrenni ja lähen ise jõusaali. (B1)'),
    (VideoID : 'eZutx_6ueNU'; VideoTitle : 'Jõuan koju kella kuueks. (B1)'),
    (VideoID : 'mgvV9dnB2L8'; VideoTitle : 'Lähen õhtul sõbra juurde. (B1)'),
    (VideoID : 'jdjwu8KwuBY'; VideoTitle : 'Lähen? Tulen? Käin?'),
    (VideoID : '4DDN6kSJ3O8'; VideoTitle : 'Minu tavaline hommik'),
    (VideoID : 'PmMw8SrUKNw'; VideoTitle : 'Väikesed sõnad.'),
    (VideoID : 'qhKewkCkvZA'; VideoTitle : 'Küsimused eesti keeles.'),
    (VideoID : 'wC6se4E3YtE'; VideoTitle : 'Küsimused eesti keeles 2.'),
    (VideoID : 'zwSiL8E-qCE'; VideoTitle : 'Tagasõnad.'),
    (VideoID : 'YzWEN5Fnnls'; VideoTitle : 'Määrsõnad.'),
    (VideoID : 'NsfLyYEhfmE'; VideoTitle : 'Soovid.'),
    (VideoID : 'yT9ls4INNaI'; VideoTitle : 'Kahesõnalised tegusõnad.'),
    (VideoID : 'oWBkDOtmctw'; VideoTitle : 'Köögis.'),
    (VideoID : 'l9MH08cL12A'; VideoTitle : 'Tunded.'),
    (VideoID : 'm60hSEB7RVw'; VideoTitle : 'Vaba aeg.'),
    (VideoID : '76hrGiQGIjY'; VideoTitle : 'Kuud ja aastaajad.'),
    (VideoID : 'LB1PejpD-7Q'; VideoTitle : 'Minu päev. (B1)'),
    (VideoID : 'giscN5ueOAQ'; VideoTitle : 'Reisimine. (B1)'),
    (VideoID : '7X0WtilYH04'; VideoTitle : 'Eesti keele teise keelena põhikooli lõpueksami suulise osa näidisvideo'),
    (VideoID : 'OTvskUR4uUA'; VideoTitle : 'Eesti keele teise keelena riigieksami suulise osa näidisvideo')
  );

const
  FixedVideos1: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : '2QuEp3IKh6A'; VideoTitle : 'Ilmateade. Sügis.'),
    (VideoID : '7MUWYWCEqTA'; VideoTitle : 'Ilmateade. Talv.'),
    (VideoID : 'PvoJSxqahLU'; VideoTitle : 'Ilmateade. Kevad.'),
    (VideoID : '6124owAESzI'; VideoTitle : 'Ilmateade. Suvi.'),
    (VideoID : 'e5KxyqCjC0A'; VideoTitle : 'Kardinaalsed suunad - põhja, lõuna, ida, lääs.'),
    (VideoID : 'cFmlbWPsvkA'; VideoTitle : 'Täna on päikesepaisteline ilm.'),
    (VideoID : '81AFv_Z_-EI'; VideoTitle : 'Mitu tuletorni Eestis on? Eestis on vähemalt 40 tuletorni. (B1)'),
    (VideoID : 'JtMd4gyeCdg'; VideoTitle : 'Eestis on palju tuletorne. (B1)'),
    (VideoID : 'wDxZVx4-1sY'; VideoTitle : 'Kõige suurem saar. Suurim saar. (B1)'),
    (VideoID : 'NhWiBKRYSrw'; VideoTitle : 'See loss on nii suur! Need lossid on nii suured! (B1)'),
    (VideoID : 'iZ2Ihq-RN14'; VideoTitle : 'Sidesõnad. (B1)'),
    (VideoID : 'fq675_wx3vY'; VideoTitle : 'Mu vanatädi tahtis sõita Saaremaale, aga sõitis hoopis Hiiumaale. (B1)'),
    (VideoID : 'C-UCvk4tFcc'; VideoTitle : 'Siis ma lähen bussi peale. (B1)'),
    (VideoID : '5t3vvleII3c'; VideoTitle : 'Kella kuue ajal olen kodus. (B1)'),
    (VideoID : 'VNaAF52tiXY'; VideoTitle : 'Eesti keele õppimise lood: Olga (B1)'),
    (VideoID : '_-vOihrNkWI'; VideoTitle : 'Kursus vajab tuge: e-õppevahenditega õppimine.'),
    (VideoID : 'j2hbLYY0peU'; VideoTitle : 'Integratsiooni Sihtasutus - 1.'),
    (VideoID : 'XdSS4Gcj6zk'; VideoTitle : 'Integratsiooni Sihtasutus - 2.'),
    (VideoID : 'yp-zPNC4QtU'; VideoTitle : 'Integratsiooni Sihtasutus - 3.'),
    (VideoID : 'QqPUB6NqNFI'; VideoTitle : 'Integratsiooni Sihtasutus - 4.'),
    (VideoID : 'TbIyysu5BQU'; VideoTitle : 'Integratsiooni Sihtasutus - 5.'),
    (VideoID : 'eNtA5AC5YIg'; VideoTitle : 'Kella seitsme paiku söön õhtusööki. (B1)')
  );

const
  FixedVideos2: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'hJdC4Hn7bpc'; VideoTitle : 'Kuulake intervjuud. (B1)'),
    (VideoID : 'FmAKm4ag3qg'; VideoTitle : 'Hommik ja õhtu. (B1)'),
    (VideoID : '4AtJAiruqlU'; VideoTitle : 'Kodused tööd. (B1)'),
    (VideoID : '_E1s6QzQCAY'; VideoTitle : 'Kellega sa räägid? (B1)'),
    (VideoID : '7nZVeDvCiF0'; VideoTitle : 'Ma räägin oma lapsega. (B1)'),
    (VideoID : 's6QxUwEEFhY'; VideoTitle : 'Head ööd. (B1)'),
    (VideoID : 'cSpHj8rjGAw'; VideoTitle : 'Rõõm ja viha. (B1)'),
    (VideoID : 'LrU3pVep_gQ'; VideoTitle : 'Kingituse üle. (B1)'),
    (VideoID : '7RKR-QIEM6M'; VideoTitle : 'Ma vihastasin oma sõbra peale. (B1)'),
    (VideoID : '6i6_zp-hdX0'; VideoTitle : 'Unenäod. (B1)'),
    (VideoID : 'Kk4cZQZ6wKE'; VideoTitle : 'Ma näen sind. (B1)'),
    (VideoID : 'J2JmY7Tw00c'; VideoTitle : 'Ma mäletan seda lugu hästi. (B1)'),
    (VideoID : 'X24-o697nUE'; VideoTitle : 'Laua broneerimine ja maksmine. (B1)'),
    (VideoID : 'NQMP23YZ74k'; VideoTitle : 'Palun arvet. (B1)'),
    (VideoID : 'RqqS62cIZ-0'; VideoTitle : 'Ma tahaksin vett. (B1)'),
    (VideoID : 'ccmyHmIfd9s'; VideoTitle : 'Ma tahaksin midagi juua. (B1)'),
    (VideoID : 'zMe_9ErAOJg'; VideoTitle : 'Ma peaksin hommikul vähem kohvi jooma. (B1)'),
    (VideoID : 'SmADUc0TzpM'; VideoTitle : 'Toidu valimine ja soovitamine. (B1)'),
    (VideoID : 'UtcrfKUaP8s'; VideoTitle : 'Ma eelistan veini õllele. (B1)'),
    (VideoID : 'QVxyZOo0WOQ'; VideoTitle : 'Kas sa oled kunagi kaheksajalga maitsnud. (B1)'),
    (VideoID : 'jAFqPBAx7MI'; VideoTitle : 'Grillitud seliha ... (B1)'),
    (VideoID : '142Lv0uVCYw'; VideoTitle : 'Toidu tellimine. (B1)')
  );

const
  FixedVideos3: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'AM8ckQIrBoo'; VideoTitle : 'Mida teile? (B1)'),
    (VideoID : 'CS-2nbxwdO4'; VideoTitle : 'Millest see salat koosneb? (B1)'),
    (VideoID : '7WZ0CcY_nII'; VideoTitle : 'Ma olen allergiline ... (B1)'),
    (VideoID : 'kVgbV3QUVDs'; VideoTitle : 'Milline on sinu pere? (B1)'),
    (VideoID : 'hdNWQmZwzSQ'; VideoTitle : 'Milline on sinu suguvõsa? (B1)'),
    (VideoID : 'fhEpZCVfBw8'; VideoTitle : 'Minu tädipojad ja täditütred. (B1)'),
    (VideoID : 'Xsy7EIRwE6o'; VideoTitle : 'Mul on kaheksa tädipoega ... (B1)'),
    (VideoID : 'YpBElUx_xLU'; VideoTitle : 'Ma olen rõõmsameelsem ... (B1)'),
    (VideoID : 'FA5YS6Yi_1Y'; VideoTitle : 'Kõige noorem ja vanem sugulane. (B1)'),
    (VideoID : 'zqO2LtSZ9H0'; VideoTitle : 'Minu väike pojake. (B1)'),
    (VideoID : 'RL-lUPhHYgw'; VideoTitle : 'Minu vanaonu on üle üheksakumne. (B1)'),
    (VideoID : 'ZoumCIelAj4'; VideoTitle : 'Minu kõige vanemal pojal ... (B1)'),
    (VideoID : 'WRMcjNBA8XU'; VideoTitle : 'Käin tihti oma noorematel ... (B1)'),
    (VideoID : 'f8meJoDaydQ'; VideoTitle : 'Mul on palju onusid ja tädisid. (B1)'),
    (VideoID : 'i3y5O24whNc'; VideoTitle : 'Minu kodu. (B1)'),
    (VideoID : '0DYjJhgR9g0'; VideoTitle : 'Mitu korda sa elus kolinud oled? (B1)'),
    (VideoID : '_rlFj-PKWJw'; VideoTitle : 'See maja on ehitatud kaheksakümnendatel. (B1)'),
    (VideoID : 'HznAIy3Cc44'; VideoTitle : 'Minu sõber kolis eelmisel aastal Inglismaale, Londonisse. (B1)'),
    (VideoID : 'HnnVBKEeGb8'; VideoTitle : 'Kolisin Kohtla-Järvelt Tallinnasse. (B1)'),
    (VideoID : '7urGQqyurA4'; VideoTitle : 'Ma kolisin teiselt korruselt kaheteistkümnendale korrusele. (B1)'),
    (VideoID : '5m0kcvvugVU'; VideoTitle : 'See maja ehitati eelmisel aastal. (B1)'),
    (VideoID : '1cExSqgL2HE'; VideoTitle : 'Kas sulle meeldib sinu kodu? (B1)')
  );

const
  FixedVideos4: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'tCgrAJ4tRlM'; VideoTitle : 'Kas sa suhtled oma naabritega? (B1)'),
    (VideoID : 'vG6yoDwsmyc'; VideoTitle : 'Missugused värvid sulle meeldivad? (B1)'),
    (VideoID : 'CKLEL-pbr1Q'; VideoTitle : 'Vancouver sarnaneb Rio de Janeiroga. (B1)'),
    (VideoID : 'iP2Tej59_A8'; VideoTitle : 'Ma unistan uuest kodust. (B1)'),
    (VideoID : 'YJfhGBylvko'; VideoTitle : 'Naabritega suhtlemine on päris tore! (B1)'),
    (VideoID : 'GcV7yxcJFy4'; VideoTitle : 'Mind häirib vali muusika. (B1)'),
    (VideoID : 'YsUj-6kCOqA'; VideoTitle : 'Ma suhtlen tihti oma naabriga. (B1)'),
    (VideoID : 'T8NK9-9cyoo'; VideoTitle : 'Ostmine, kauba uurimine, allahindlus. (B1)'),
    (VideoID : '27ZvC9P883A'; VideoTitle : 'Suur allahindlus! (B1)'),
    (VideoID : '-hFs3sJfDtg'; VideoTitle : 'Mis päeval ja mis kell te pesumasina ära toote? (B1)'),
    (VideoID : 'FSCto9qAzYI'; VideoTitle : 'Kõik sõltub hinnast. (B1)'),
    (VideoID : 'eFXHlQg9gbg'; VideoTitle : 'Meil on teile väga hea pakkumine! (B1)'),
    (VideoID : 'pZKQjR7QOEI'; VideoTitle : 'Las ma mõtlen! (B1)'),
    (VideoID : 'lkLmoC52RI0'; VideoTitle : 'Paigalduse ja kojuveo tellimine. (B1)'),
    (VideoID : 'Dol6jR_UxFU'; VideoTitle : 'Ostu vormistamine. (B1)'),
    (VideoID : '2XkcPXt__Pw'; VideoTitle : 'Palun kirjutage siia oma allkiri! (B1)'),
    (VideoID : '6dP-AwWnJoo'; VideoTitle : 'Saate pesumasina homse päeva jooksul. (B1)'),
    (VideoID : 'tyRy5Mts5E0'; VideoTitle : 'Kas sa nägid seda roosat tolmuimejat? Ei, roosat tolmuimejat ma ei näinud. (B1)'),
    (VideoID : 'EZyajZIW3eQ'; VideoTitle : 'Ma võtan selle punase külmkapi. Seda sinist külmkappi ma ei võta. (B1)'),
    (VideoID : 'tsR_VA3u0QQ'; VideoTitle : 'Kus sa koolis oled käinud? (B1)'),
    (VideoID : 'O6gpiKtn6-w'; VideoTitle : 'Missugune õppeaine sulle meeldis? (B1)'),
    (VideoID : 'zcQ79sqiaF8'; VideoTitle : 'Põhiharidus, keskharidus, kutseharidus, kõrgharidus. (B1)')
  );

const
  FixedVideos5: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'wqTyZQhACjw'; VideoTitle : 'Sina õpid eesti keelt. Mina õpetan eesti keelt. (B1)'),
    (VideoID : 'oTJ7aVdEIkE'; VideoTitle : 'Läksin kooli 1967. aastal. (B1)'),
    (VideoID : '43QrsmPWvV4'; VideoTitle : '2010. aastal läksin esimesse klassi. 2010. aastal käisin esimeses klassis. (B1)'),
    (VideoID : 'fQf1tQ3KcT4'; VideoTitle : 'Mida sa viimati õppisid?'),
    (VideoID : 'm8GShXOeuYk'; VideoTitle : 'Ma oleksin välismaal õppinud, kui mul oleks olnud raha ja võimalusi. (B1)'),
    (VideoID : '4FhlCnZUjIM'; VideoTitle : 'Ma töötasin näitlejana, aga tegelikult tahtsin saada õpetajaks. (B1)'),
    (VideoID : 'D7cWvpo-IB4'; VideoTitle : 'Ma tahtsin keemiat õppida, aga läksin hoopis muusikat õppima. (B1)'),
    (VideoID : 'KniOORtj_8M'; VideoTitle : 'Õppisin politseinikuks, sest mulle meeldisid märulifilmid. (B1)'),
    (VideoID : 'nrKi_ITWhlI'; VideoTitle : 'Mul on lõpetamata kõrgharidus. (B1)'),
    (VideoID : 'RcaUTPYdbcM'; VideoTitle : 'Bussipiletite ostmine. (B1)'),
    (VideoID : 'MBAtc09nW_s'; VideoTitle : 'Hotelli broneerimine. (B1)'),
    (VideoID : 'oYk9HKCinME'; VideoTitle : 'Lendasin Roomasse Riia kaudu. Lendasin Roomasse läbi Riia. (B1)'),
    (VideoID : 'T_kOj6b-zss'; VideoTitle : 'Jäin lennukist maha. (B1)'),
    (VideoID : 'ThWbAZEnd5c'; VideoTitle : 'Ma pean Amsterdamis ümber istuma. (B1)'),
    (VideoID : 'T61-Upub8J0'; VideoTitle : 'Jätsin krediitkaardi hotelli. (B1)'),
    (VideoID : 'W7RfogKbUQE'; VideoTitle : 'Kus sinu pass on? Kas sa unustasid jälle oma passi koju? (B1)'),
    (VideoID : '_bH8He1Gxks'; VideoTitle : 'Ookeanis ujudes külmetusin. (B1)'),
    (VideoID : 'jT9EvSx9cZY'; VideoTitle : 'Räägi ühest reisist! (B1)'),
    (VideoID : 'xT05EzlOdPU'; VideoTitle : 'Reisielamus. (B1)'),
    (VideoID : 'tiz8ACX46Ow'; VideoTitle : 'Kus sa puhkuse ajal käisid? (B1)'),
    (VideoID : 'Ax6pB7CrKjI'; VideoTitle : 'Mina arvan, et reisimine on väga tore. (B1)'),
    (VideoID : 'OrDNxUpOfxk'; VideoTitle : 'Minu arvates oli see reis hirmus vahva! (B1)')
  );

const
  FixedVideos6: array[0..21] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'T7A3ZOLXz3o'; VideoTitle : 'Käisime huvitavates muuseumites. (B1)'),
    (VideoID : 'UJ-FUu2Pq5o'; VideoTitle : 'Ta on vist kusagil reisil. (B1)'),
    (VideoID : 'clPgeMa2qvA'; VideoTitle : 'Ööbisime mingis väga kallis hotellis. (B1)'),
    (VideoID : 'isA6XNBgppA'; VideoTitle : 'Kuidas hoiad oma tervist? (B1)'),
    (VideoID : 'S3bvgihGl_A'; VideoTitle : 'Ma käisin eile arsti juures. Ma olen juba kümme aastat selle arsti juures käinud. (B1)'),
    (VideoID : 'hKVJPvzYVE0'; VideoTitle : 'Teile tehakse röntgenuuring. (B1)'),
    (VideoID : 'lZTUZO0HWCo'; VideoTitle : 'Kellele sa helistad, kui sa haige oled? Doktor Porgandile. (B1)'),
    (VideoID : '3YNye4Xer7k'; VideoTitle : 'Ma ei maga. Ära maga! Mitte keegi ei maga. (B1)'),
    (VideoID : '9PmuKyTA4XU'; VideoTitle : 'Ma püüan hommikuti võimelda. Ma olen harjunud hommikuti võimlema. (B1)'),
    (VideoID : 'GtHXnPsAsBk'; VideoTitle : 'Arsti juurde aja broneerimine. (B1)'),
    (VideoID : '9xbY1-i6cvE'; VideoTitle : 'Arsti juures. (B1)'),
    (VideoID : 'w3WMLJG-UaI'; VideoTitle : 'Kas sa teed ise endale süsti? (B1)'),
    (VideoID : 'vFxk_pm60js'; VideoTitle : 'Ma olen haige. Mul on palavik. Mu kõrv valutab. (B1)'),
    (VideoID : 'zVQooHRUkOo'; VideoTitle : 'Lähen arsti juurde. Olen arsti juures. Käin arsti juures. Tulen arsti juurest. (B1)'),
    (VideoID : '0cqgPSZ0-L4'; VideoTitle : 'Toit on tervislik. Ma söön tervislikult. (B1)'),
    (VideoID : 'ifpHvZZNstM'; VideoTitle : 'Missugune on sinu töö? Piret. (B1)'),
    (VideoID : 'zBWVYUaPv6o'; VideoTitle : 'Missugune on sinu töö? Johannes. (B1)'),
    (VideoID : 'gafBl-ZkpIo'; VideoTitle : 'Missugune on sinu töö? Ott. (B1)'),
    (VideoID : 'rjHPWCoj6kU'; VideoTitle : 'Missugune on sinu töö? Marita. (B1)'),
    (VideoID : '_9a6zhTry5A'; VideoTitle : 'Mu tööpäev algab kell üheksa ja lõpeb kell viis. Alustan oma tööpäeva kell... (B1)'),
    (VideoID : 'kP6lvcJs3HE'; VideoTitle : 'Ülemus ütles mulle, et ma tuleks homme hiljem tööle. (B1)'),
    (VideoID : 'fPoN0CjKGBQ'; VideoTitle : 'Ma helistan ja teatan neile. Ma küsin teilt nõu ja abi. (B1)')
  );

const
  FixedVideos7: array[0..29] of record
    VideoID, VideoTitle: string;
  end = (
    (VideoID : 'PAFe75COtUM'; VideoTitle : 'Mul on toredad kolleegid, kellega on hea töötada. (B1)'),
    (VideoID : 'a-Vpu8XjCu4'; VideoTitle : 'Mis vahendeid sa kasutad oma töös? (B1)'),
    (VideoID : '29Mj9CkqIQ8'; VideoTitle : 'Kas sa oled oma tööga rahul? (B1)'),
    (VideoID : 'PMMyPwI_ZaQ'; VideoTitle : 'Mis vahendeid te kasutate oma töös? (B1)'),
    (VideoID : 'D1PsBvPsccA'; VideoTitle : 'Ilma internetita ei saa ma töötada! (B1)'),
    (VideoID : 'X8zX1L-arEE'; VideoTitle : 'Ma olen oma töö ja kolleegidega väga rahul. (B1)'),
    (VideoID : 'y-9W4aL52jY'; VideoTitle : 'Kas Peeter läkski töölt ära? (B1)'),
    (VideoID : '47Yoi51XSmE'; VideoTitle : 'Ma aitan oma kolleegi hea meelega. (B1)'),
    (VideoID : 'pdKL4FqAUSc'; VideoTitle : 'Mida sa teed vabal ajal? (B1)'),
    (VideoID : 'BqQfIHpFYsE'; VideoTitle : 'Mulle meeldib kinoskäimine, aga ma pole mingi eriline telekavaataja. (B1)'),
    (VideoID : '75KccDkpplM'; VideoTitle : 'Kumb sulle rohkem meeldib, kas ujumine või jooksmine? Mulle meeldivad mõlemad. (B1)'),
    (VideoID : 'LgceTjtP2Ms'; VideoTitle : 'Tegevused kevadel. (B1)'),
    (VideoID : '4NHa4sA7FmI'; VideoTitle : 'Tegevused suvel. (B1)'),
    (VideoID : 'd4U33WEL8T8'; VideoTitle : 'Tegevused sügisel. (B1)'),
    (VideoID : 'GOxW2YxQJO0'; VideoTitle : 'Tegevused talvel. (B1)'),
    (VideoID : '5tmJ0IRp1LM'; VideoTitle : 'Kevaditi ma kaevan aiamaa üles ja istutan lilli. (B1)'),
    (VideoID : 'TvPVL5pO5kA'; VideoTitle : 'Kas sa käid tihti teatris? Ei, ma ei käi peaaegu mitte kunagi teatris. (B1)'),
    (VideoID : 'AU_HbJE2HEY'; VideoTitle : 'Tähtpäevad. (B1)'),
    (VideoID : 'aegyEzK2tnE'; VideoTitle : 'Tähtpäevad talvel. (B1)'),
    (VideoID : '9H5pOxmH8Qs'; VideoTitle : 'Muidugi! Miks mitte! (B1)'),
    (VideoID : 'xyU7OwLc7rs'; VideoTitle : 'Ostsin turult lilled ja tellisin kohvikust koogi. (B1)'),
    (VideoID : 'T9nnBFQLSII'; VideoTitle : 'Huvitavad üritused. (B1)'),
    (VideoID : 'mQY01nl_Pjo'; VideoTitle : 'Kus kohas on Eestis kõige huvitavamad kontserdid? (B1)'),
    (VideoID : 'IbPZI11rLns'; VideoTitle : 'Suvel toimub mitu spordivõistlust. Mõni spordivõistlus toimub Eestis, mõni välismaal. (B1)'),
    (VideoID : 'RI5mn4Q8HjE'; VideoTitle : 'Ma osalen laulu- ja tantsupeol. Ma võtan osa laulu- ja tantsupeost. (B1)'),
    (VideoID : 'DpXLFnXZu30'; VideoTitle : 'Festival toimub teisest maist kuni kümnenda maini. (B1)'),
    (VideoID : 'HnOVQDhugcQ'; VideoTitle : 'Lähme sellele suurele käsitöölaadale! (B1)'),
    (VideoID : 'ZQhR-lNSIMc'; VideoTitle : 'Ega sulle ei meeldi ooperimuusika? (B1)'),
    (VideoID : 'Rg627xibh7o'; VideoTitle : 'Meie linnas olevat täna tsirkuseetendus. (B1)'),
    (VideoID : '8oL2XDNcl1w'; VideoTitle : 'Kohad Eestis. (B1)')
  );
var
  HttpClient: TNetHTTPClient;
  HttpResponse: IHTTPResponse;
  JSONObj, ItemObj, SnippetObj: TJSONObject;
  ItemsArray: TJSONArray;
  VideoID, VideoTitle: string;
  I,J: Integer;
begin
  try
    try
     lvVideos.ScrollTo(0);
     lvVideos.BeginUpdate;
     lvVideos.Items.Clear;
    except
      Application.ProcessMessages;
    end;
    // Проверяем, если JSONObjSave уже содержит данные
    if Length(Trim(uPlayList)) > 0 then begin
    if Assigned(JSONObjSave) then
    begin
      // Используем сохраненные данные
      JSONObj := JSONObjSave;
      try
        try
          ItemsArray := JSONObj.GetValue<TJSONArray>('items');
          for J := 0 to ItemsArray.Count - 1 do
          begin
            ItemObj := ItemsArray.Items[J] as TJSONObject;
            SnippetObj := ItemObj.GetValue<TJSONObject>('snippet');
            VideoID := SnippetObj.GetValue<TJSONObject>('resourceId').GetValue<string>('videoId');
            VideoTitle := SnippetObj.GetValue<string>('title');
            TThread.Synchronize(nil, procedure
            begin
              AddVideoListview(VideoID, VideoTitle, 'https://i.ytimg.com/vi/' + VideoID + '/hqdefault.jpg', YouTube);
            end);
          end;
        finally
          JSONObj.Free;
        end;
      except
        if swtch1.IsChecked then ShowNotification('Error JSONObj', 0);
        lvVideos.EndUpdate;
      end;
    end
    else
    begin
     try
      HttpClient := TNetHTTPClient.Create(nil);
      try
          HttpResponse := HttpClient.Get('https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=' + uPlayList + '&maxResults=50&key=' + FAPIKEYYOUTUBE);
          if HttpResponse.StatusCode = 200 then
          begin
            JSONObj := TJSONObject.ParseJSONValue(HttpResponse.ContentAsString) as TJSONObject;
            try
              ItemsArray := JSONObj.GetValue<TJSONArray>('items');
              for J := 0 to ItemsArray.Count - 1 do
              begin
                ItemObj := ItemsArray.Items[J] as TJSONObject;
                SnippetObj := ItemObj.GetValue<TJSONObject>('snippet');
                VideoID := SnippetObj.GetValue<TJSONObject>('resourceId').GetValue<string>('videoId');
                VideoTitle := SnippetObj.GetValue<string>('title');
                TThread.Synchronize(nil, procedure
                begin
                  AddVideoListview(VideoID, VideoTitle, 'https://i.ytimg.com/vi/' + VideoID + '/hqdefault.jpg', YouTube);
                end);
              end;
            finally
              JSONObj.Free;
            end;
          end
          else
          begin
            if swtch1.IsChecked then ShowNotification('Error: ' + HttpResponse.StatusText, 0);
          end;
      finally
        HttpClient.Free;
      end;
     except
      if swtch1.IsChecked then ShowNotification('Error JSONObj', 0);
      lvVideos.EndUpdate;
     end;
    end;
    end;
    // Обработка данных
    try
      if ((uList)and(Pos('1215-stalkersts-781215-0001',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos0) to High(FixedVideos0) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos0[I].VideoID, FixedVideos0[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos0[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0002',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos1) to High(FixedVideos1) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos1[I].VideoID, FixedVideos1[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos1[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0003',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos2) to High(FixedVideos2) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos2[I].VideoID, FixedVideos2[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos2[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0004',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos3) to High(FixedVideos3) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos3[I].VideoID, FixedVideos3[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos3[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0005',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos4) to High(FixedVideos4) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos4[I].VideoID, FixedVideos4[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos4[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0006',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos5) to High(FixedVideos5) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos5[I].VideoID, FixedVideos5[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos5[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0007',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos6) to High(FixedVideos6) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos6[I].VideoID, FixedVideos6[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos6[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
      if ((uList)and(Pos('1215-stalkersts-781215-0008',uPlayList) > 0)) then begin
          try
            // Добавляем фиксированные видео
            for I := Low(FixedVideos7) to High(FixedVideos7) do
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  AddVideoListview(FixedVideos7[I].VideoID, FixedVideos7[I].VideoTitle, 'https://i.ytimg.com/vi/' + FixedVideos7[I].VideoID + '/hqdefault.jpg', YouTube);
                end);
            end;
          except
            if swtch1.IsChecked then ShowNotification('Error Add Video', 0);
            lvVideos.EndUpdate;
          end;
      end;
    finally
      TThread.Synchronize(nil, procedure
      begin
        Self.ThreadTerminate(Self);
      end);
      lvVideos.EndUpdate;
    end;
  except
    if swtch1.IsChecked then ShowNotification('Error ListarEstVideos !', 0);
    lvVideos.EndUpdate;
    Exit;
  end;
end;

procedure TFormMain.StartEngLongOperation;
begin
try
  // Показать индикатор загрузки
  AniIndicator1.Visible := True;
  AniIndicator1.Enabled := True;
  // Выполнение фоновой задачи
  TTask.Run(procedure
  begin
    try
     TThread.Synchronize(nil, procedure
      begin
        FillPlaylistComboBox(GetEngPlayList);
      end);
    finally
      // Скрытие индикатора загрузки по завершению операции
      TThread.Synchronize(nil, procedure
      begin
        AniIndicator1.Enabled := False;
        AniIndicator1.Visible := False;
      end);
    end;
  end);
except
  if swtch1.IsChecked then ShowNotification('Error StartEngLongOperation !', 0);
  Exit;
end;
end;

procedure TFormMain.StartEksLongOperation;
begin
try
  // Показать индикатор загрузки
  AniIndicator1.Visible := True;
  AniIndicator1.Enabled := True;
  // Выполнение фоновой задачи
  TTask.Run(procedure
  begin
    try
     TThread.Synchronize(nil, procedure
      begin
        ViewEksamEst(GetEksUrl);
      end);
    finally
      // Скрытие индикатора загрузки по завершению операции
      TThread.Synchronize(nil, procedure
      begin
        AniIndicator1.Enabled := False;
        AniIndicator1.Visible := False;
      end);
    end;
  end);
except
  if swtch1.IsChecked then ShowNotification('Error StartEstLongOperation !', 0);
  Exit;
end;
end;

procedure TFormMain.StartEstLongOperation;
begin
try
  // Показать индикатор загрузки
  AniIndicator1.Visible := True;
  AniIndicator1.Enabled := True;
  // Выполнение фоновой задачи
  TTask.Run(procedure
  begin
    try
     TThread.Synchronize(nil, procedure
      begin
        FillPlaylistComboBox(GetEstPlayList);
      end);
    finally
      // Скрытие индикатора загрузки по завершению операции
      TThread.Synchronize(nil, procedure
      begin
        AniIndicator1.Enabled := False;
        AniIndicator1.Visible := False;
      end);
    end;
  end);
except
  if swtch1.IsChecked then ShowNotification('Error StartEstLongOperation !', 0);
  Exit;
end;
end;

//------------------Encrypt-----------------------------
function GetEncryptAES(Str: string; Keys, IVs: string) : String;
var
  OriginalText, Key, IV, EncryptedText: TBytes;
begin
try
  Result := '';
  OriginalText := TEncoding.ANSI.GetBytes(Str);
  Key := TEncoding.ANSI.GetBytes(Keys); // 256 bits-32 bytes
  IV := TEncoding.ANSI.GetBytes(IVs); // 16 bytes
  EncryptedText := TAES.Encrypt(OriginalText, Key, 256, IV, cmCBC, pmPKCS7);
  Result := TNetEncoding.Base64.EncodeBytesToString(EncryptedText);
except
  if FormMain.swtch1.IsChecked then ShowNotification('Error GetEncryptAES !', 0);
  Result := '';
  Exit;
end;
end;

function GetDecryptAES(Str: string; Keys, IVs: string) : String;
var
  InBytes, OutBytes: TBytes;
  Key, IV: TBytes;
  s : string;
begin
try
  Result := '';
  InBytes := TNetEncoding.Base64.DecodeStringToBytes(Str);
  Key := TEncoding.ANSI.GetBytes(Keys); // 256 bits-32 bytes
  IV := TEncoding.ANSI.GetBytes(IVs); // 16 bytes
  OutBytes := TAES.Decrypt(InBytes, Key, 256, IV, cmCBC, pmPKCS7);
  s := TNetEncoding.Base64.EncodeBytesToString(OutBytes);
  Result := TNetEncoding.Base64.Decode(PWideChar(s));
except
  if FormMain.swtch1.IsChecked then ShowNotification('Error GetDecryptAES !', 0);
  Result := '';
  Exit;
end;
end;
//------------------------------------------------------

function GetText(str: string) : string;
begin
try
  FormMain.mmo_src.Lines.Text := str;
except
  on E: Exception do begin
     if FormMain.swtch1.IsChecked then ShowNotification('Error GetText '+E.Message, 0);
     Result := '';
     Exit;
  end;
end;
end;

procedure TFormMain.ResultSpeech(AResult: string);
begin
try
  GetText(AResult);
except
  on E: Exception do begin
     if FormMain.swtch1.IsChecked then ShowNotification('Error '+E.Message, 0);
     Exit;
  end;
end;
end;

function TFormMain.GetKusiAll: string;
var
  str: string;
begin
Result := '';
try
if Length(Trim(mmoKusi.Text)) <= 0 then begin
   stat := True;
   heLoading(True);
   try
    // Ваш код для выполнения запроса к Google Sheets API                   //GetDecryptAES(uToken,uKeyEnc,uVectEnc)           //GetDecryptAES(uApiKey,uKeyEnc,uVectEnc)
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uToken+'/values/A1:G999?majorDimension=ROWS&key='+uApiKey+'';
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
    // Получение содержимого ответа
    str := RESTRespKusi.Content;
    Result := FormatJSON(str); // Переносим присвоение результата в конец блока try
   except
    on E: Exception do
    begin
       heLoading(False);
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
   end;
   heLoading(False);
end;
except
  Result := '';
  Exit;
end;
end;

function TFormMain.GetUrlKulla(idx: Integer) : string;
var
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  urlArray: TJSONArray;
  url: string; str: string;
begin
  Result := '';
  try
    // Ваш код для выполнения запроса к Google Sheets API
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uTokenEksView+'/values/B'+IntToStr(idx)+':B'+IntToStr(idx)+'?majorDimension=ROWS&key='+uApiKey+'';
  //   ShowNotification('BaseURL '+#13#10+RESTClnKusi.BaseURL, 0);
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
     // Получение содержимого ответа
     str := RESTRespKusi.Content;
     // Парсим JSON-строку
     jsonObj := TJSONObject.ParseJSONValue(FormatJSON(str)) as TJSONObject;
     try
        if Assigned(jsonObj) then
        begin
          // Получаем массив значений
          valuesArray := jsonObj.GetValue<TJSONArray>('values');
          if Assigned(valuesArray) and (valuesArray.Count > 0) then
          begin
            urlArray := valuesArray.Items[0] as TJSONArray;
            if Assigned(urlArray) and (urlArray.Count > 0) then
            begin
              url := urlArray.Items[0].Value;
            end;
          end;
        end;
     finally
        jsonObj.Free;
     end;  //   ShowNotification('url '+#13#10+url, 0);
     Result := url; // Переносим присвоение результата в конец блока try
  except
    on E: Exception do
    begin
       heLoading(False);
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
  end;
end;

function TFormMain.GetEksUrl : string;
var
  str: string;
begin
try
   Result := '';
   stat := True;
   try
    // Ваш код для выполнения запроса к Google Sheets API
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uTokenEksView+'/values/B1:B1?majorDimension=ROWS&key='+uApiKey+'';
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
     // Получение содержимого ответа
     str := RESTRespKusi.Content;
     Result := FormatJSON(str); // Переносим присвоение результата в конец блока try
   except
    on E: Exception do
    begin
       heLoading(False);
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
   end;
except
  Result := '';
  Exit;
end;
end;

function TFormMain.GetEstPlayList : string;
var
  str: string;
begin
try
   Result := '';
   stat := True;
   try
    // Ваш код для выполнения запроса к Google Sheets API
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uTokenEstPlayList+'/values/A1:C999?majorDimension=ROWS&key='+uApiKey+'';
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
     // Получение содержимого ответа
     str := RESTRespKusi.Content;
     Result := FormatJSON(str); // Переносим присвоение результата в конец блока try
   except
    on E: Exception do
    begin
       heLoading(False);
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
   end;
except
  Result := '';
  Exit;
end;
end;

function TFormMain.GetEngPlayList : string;
var
  str: string;
begin
try
   Result := '';
   stat := True;
   try
    // Ваш код для выполнения запроса к Google Sheets API
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uTokenEngPlayList+'/values/A1:C999?majorDimension=ROWS&key='+uApiKey+'';
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
     // Получение содержимого ответа
     str := RESTRespKusi.Content;
     Result := FormatJSON(str); // Переносим присвоение результата в конец блока try
   except
    on E: Exception do
    begin
       heLoading(False);
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
   end;
except
  Result := '';
  Exit;
end;
end;

procedure TFormMain.ViewEksamEst(const jsonStr: string);
var
  jsonObj: TJSONObject;
  valuesArray: TJSONArray;
  urlArray: TJSONArray;
  url: string;
begin
  try
    // Парсим JSON-строку
    jsonObj := TJSONObject.ParseJSONValue(jsonStr) as TJSONObject;
    try
      if Assigned(jsonObj) then
      begin
        // Получаем массив значений
        valuesArray := jsonObj.GetValue<TJSONArray>('values');
        if Assigned(valuesArray) and (valuesArray.Count > 0) then
        begin
          urlArray := valuesArray.Items[0] as TJSONArray;
          if Assigned(urlArray) and (urlArray.Count > 0) then
          begin
            url := urlArray.Items[0].Value;
          end;
        end;
      end;
    finally
      jsonObj.Free;
    end;
    if Length(Trim(url)) > 0 then begin
       MultiView.HideMaster;
       TabControl1.Tabs[6].Visible := True;
       TabControl1.GotoVisibleTab(6);
       TabControl1.Tabs[0].Visible := False;
       TabControl1.Tabs[2].Visible := False;
       TabControl1.Tabs[3].Visible := False;
       TabControl1.Tabs[4].Visible := False;
       TabControl1.Tabs[5].Visible := False;
       TabControl1.Tabs[1].Visible := False;
       TabControl1.Tabs[7].Visible := False;
       TabControl1.Tabs[8].Visible := False;
       TabControl1.Tabs[6].SetFocus;
       actNumbridEE.Visible := True;
       AddPanelButton.Enabled := True;
       WebBrowser1.URL := url;
       WebBrowser1.Navigate;
       KeepWebBrowserInvisible(True);
    end else TDialogService.ShowMessage('Sait pole saadaval!');
  except
    on E: Exception do
    begin
      // Обработка исключений
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+ E.Message, 0);
      Exit;
    end;
  end;
end;

procedure TFormMain.FillPlaylistComboBox(const JSONContent: string);
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  JSONItem: TJSONValue;
  I: Integer;
  PlaylistItem: TPlaylistItem;
begin
try
  JSONValue := TJSONObject.ParseJSONValue(JSONContent);
  try
    if Assigned(JSONValue) then
    begin
      JSONArray := JSONValue.GetValue<TJSONArray>('values');
      if Assigned(JSONArray) then
      begin
        ComboBoxItem.Clear;
        SetLength(PlaylistItems, JSONArray.Count);
        for I := 0 to JSONArray.Count - 1 do
        begin
          JSONItem := JSONArray.Items[I];
          if Assigned(JSONItem) and (JSONItem is TJSONArray) then
          begin
            PlaylistItem.PlaylistID := TJSONArray(JSONItem).Items[1].Value; // Значение идентификатора плейлиста
            PlaylistItem.PlaylistName := TJSONArray(JSONItem).Items[2].Value; // Отображаемое имя плейлиста
            PlaylistItems[I] := PlaylistItem; // Сохраняем информацию о плейлисте в массиве
            ComboBoxItem.Items.Add(PlaylistItem.PlaylistName); // Добавляем имя плейлиста в ComboBoxItem
          end;
        end;
      end;
    end;
  finally
    JSONValue.Free;
  end;
except
  Exit;
end;
end;

function TFormMain.GetJSONData(jsonData: string; uStr: string): string;
var
  jsonObject: TJSONObject;
  valuesArray: TJSONArray;
  i: Integer;
  extractedData: TStringList;
begin
try
  Result := '';
  extractedData := TStringList.Create;
  try
    jsonObject := TJSONObject.ParseJSONValue(jsonData) as TJSONObject;
    if Assigned(jsonObject) then
    begin
      valuesArray := jsonObject.GetValue('values') as TJSONArray;
      if Assigned(valuesArray) then
      begin
        for i := 0 to valuesArray.Count - 1 do
        begin
          // Получаем второй и третий элемент каждой записи и добавляем только те записи, которые содержат uStr во втором элементе
          if (valuesArray.Items[i] as TJSONArray).Items[1].Value.Contains(uStr) then
          begin
            extractedData.Add((valuesArray.Items[i] as TJSONArray).Items[2].Value);
            extractedData.Add((valuesArray.Items[i] as TJSONArray).Items[3].Value);
          end;
        end;
      end;
    end;
    // Возвращаем извлеченные данные в виде строки, объединяя их с помощью перевода строки
    Result := extractedData.Text;
  finally
   try
    extractedData.Free;
    jsonObject.Free;
   except
     //
   end;
  end;
except
  Result := '';
  Exit;
end;
end;

//GetBasesJson
function TFormMain.GetBasesJson: string;
var
  str: string;
begin
try
   Result := '';
   stat := True;
   try
    // Ваш код для выполнения запроса к Google Sheets API                    //GetDecryptAES(uTokenKusiMA,uKeyEnc,uVectEnc)          //GetDecryptAES(uApiKey,uKeyEnc,uVectEnc)
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uTokenDatas+'/values/A1:D999?majorDimension=ROWS&key='+uApiKey+'';
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
     // Получение содержимого ответа
     str := RESTRespKusi.Content;
     Result := FormatJSON(str); // Переносим присвоение результата в конец блока try
   except
    on E: Exception do
    begin
       heLoading(False);
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
   end;
except
  Result := '';
  Exit;
end;
end;

function TFormMain.DetectLanguage(const Text, ApiKey: string): string;
var
  JSONObj: TJSONObject;
  Lang: string;
begin
try
  Result := '';
  try
  // Настройка REST-запроса
  RESTClient3.BaseURL := 'https://translation.googleapis.com/language/translate/v2/detect';
  RESTRequest3.Resource := '';
  RESTRequest3.Params.Clear;
  RESTRequest3.Params.AddItem('key', ApiKey, pkGETorPOST);
  RESTRequest3.Params.AddItem('q', Text, pkGETorPOST);
  RESTRequest3.Method := TRESTRequestMethod.rmPOST;
  // Выполнение запроса
  RESTRequest3.Execute;
  except
    if swtch1.IsChecked then ShowNotification('Error Execute DetectLanguage ', 0); Result := '';
  end;
  try
  // Обработка ответа
  JSONObj := TJSONObject.ParseJSONValue(RESTResponse3.Content) as TJSONObject;
  try
    Lang := JSONObj.GetValue<string>('data.detections[0][0].language');
    Result := Lang;
  finally
    JSONObj.Free;
  end;
  except
    if swtch1.IsChecked then ShowNotification('Error ParseJSONValue DetectLanguage ', 0); Result := '';
  end;
except
  Result := '';
  Exit;
end;
end;

procedure TFormMain.PlayManText(const Text, ApiKey: string);
var
  Lang, FURL: string; FilePath, str: string;
begin
try
  if mpUI.State = TMediaState.Playing then mpUI.Stop; mpUI.Clear;
  // Определяем язык текста
  Lang := DetectLanguage(Text, ApiKey);
  if swtch1.IsChecked then ShowNotification('PlayManText '+#13#10+Lang, 0);
  // Формируем URL для Google Translate TTS API
  FURL := 'https://translate.google.com/translate_tts?ie=UTF-8&client=gtx&q=' + Text + '&tl=' + Lang + '&tl=en-US-Wavenet-D';
  try
  // Скачиваем аудиофайл
  RESTClient3.BaseURL := FURL;
  RESTRequest3.Resource := '';
  RESTRequest3.Params.Clear;
  RESTRequest3.Method := TRESTRequestMethod.rmGET;
  // Выполнение запроса
  RESTRequest3.Execute;
  except on E:Exception do
    begin
      str := 'Error: ' + RESTResponse3.ErrorMessage +#13#10+ ' Error: ' + E.Message;
      if swtch1.IsChecked then ShowNotification(str, 0);
    end;
  end;

  // Сохраняем аудиофайл
  try
    // Получаем путь к текущему рабочему каталогу
    FilePath := TPath.Combine(TPath.GetDocumentsPath, 'tempMan.mp3');
    // Сохраняем аудиофайл
    TFile.WriteAllBytes(FilePath, RESTResponse3.RawBytes);
  except
    on E: Exception do
    if swtch1.IsChecked then ShowNotification('Error saving file: ' + E.Message, 0);
  end;
  // Воспроизводим аудиофайл, если он существует
  try
  if FileExists(FilePath) then
  begin
     mpUI.FileName := FilePath;
     mpUI.Play;
  end;
  except
    if swtch1.IsChecked then ShowNotification('Error PlayManText tempMan.mp3', 0);
  end;
except
  Exit;
end;
end;

function TFormMain.GetResultKusi(idx: Integer): string;
var
  str: string;
  myObj: TJSONObject;
  valuesArray: TJSONArray;
  rowArray: TJSONArray;
  i,j: Integer;
begin
try
  Result := '';
  try
    // Ваш код для выполнения запроса к Google Sheets API                    //GetDecryptAES(uToken,uKeyEnc,uVectEnc)                                          //GetDecryptAES(uApiKey,uKeyEnc,uVectEnc)
     RESTClnKusi.BaseURL := 'https://sheets.googleapis.com/v4/spreadsheets/'+uToken+'/values/B'+IntToStr(idx)+'%3AG'+IntToStr(idx)+'?majorDimension=ROWS&key='+uApiKey+'';
     RESTClnKusi.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClnKusi.ContentType := 'application/json; charset=UTF-8';
     RESTReqKusi.Client.FallbackCharsetEncoding := 'raw';
     RESTReqKusi.ClearBody;
     RESTReqKusi.Params.Clear;
     RESTReqKusi.Execute;
     // Получение содержимого ответа
     str := RESTRespKusi.Content;
    // Разбор JSON-строки
     myObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
    // Получение массива значений
     valuesArray := myObj.GetValue('values') as TJSONArray;
    // Проверка на nil
    if Assigned(valuesArray) then
    begin
      str := '';
      // Перебор элементов массива
      for i := 0 to valuesArray.Count - 1 do
      begin
        // Проверка на TJSONArray
        if valuesArray.Items[i] is TJSONArray then
        begin
          // Получение текущего массива строк
          rowArray := valuesArray.Items[i] as TJSONArray;
          // Проверка на nil
          if Assigned(rowArray) then
          begin
            // Формирование строки значения
            for j := 0 to rowArray.Count - 1 do
            begin
              str := str + rowArray.Items[j].Value;
              if j = 1 then str := str + #13#10 else
              if j = 2 then str := str + #13#10 else
              if j = 3 then str := str + #13#10 else
              if j = 4 then str := str + #13#10;
              // Добавление запятой между значениями (кроме последнего)
              if j < rowArray.Count - 1 then str := str + ', ';
            end;
          end;
        end;
      end;
    end;
    Result := str; // Переносим присвоение результата в конец блока try
  except
    on E: Exception do
    begin
       str := E.Message;
       if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0);
       Result := str; // В случае ошибки также возвращаем str
    end;
  end;
except
  Result := '';
  Exit;
end;
end;

function TFormMain.DoсInit(Uri: JNet_Uri): string;
var
  C: JCursor;
begin
try
  result := '';
  try
    C := TAndroidHelper.Activity.getContentResolver.query(Uri, nil, nil,
      nil, nil, nil);
    if (C = nil) then
      exit;
    C.moveToFirst;
    result := JStringToString
      (C.getString(C.getColumnIndex(TJOpenableColumns.JavaClass.DISPLAY_NAME)));
  finally
    C.close;
  end;
except
  on E: Exception do Exit;
end;
end;

procedure TFormMain.OnActivityResult(RequestCode, ResultCode: Integer;
  Data: JIntent);
var
  Uri: JNet_Uri;
  Ad: string;
begin
try
  mmoInfo.Lines.Clear;
  if ResultCode = TJActivity.JavaClass.RESULT_OK then
  begin
    // Sonuз verisi kullanэcэnэn seзtiрi
    // belge veya dizin iзin bir URI iзerir.
    Uri := nil;
    if Assigned(Data) then
    begin
      if (Data = nil) then
      begin
        mmoInfo.Lines.Add('Uri is not available!');
        exit;
      end;
      Uri := Data.getData;
      Ad := '"' + DoсInit(Uri) + '" ';
      mmoInfo.Lines.Add(Ad);
    end;
    mmoInfo.Lines.Add(' ');
    mmoInfo.GoToTextEnd;
  end;
except
  on E: Exception do Exit;
end;
end;

procedure TFormMain.InitR(const Sender: TObject; const M: TMessage);
begin
try
  if M is TMessageResultNotification then
     OnActivityResult(TMessageResultNotification(M).RequestCode,
      TMessageResultNotification(M).ResultCode,
      TMessageResultNotification(M).Value);
except
  on E: Exception do Exit;
end;
end;

constructor TFormMain.Create(AOwner: TComponent);
begin
try
  inherited;
  FSpeaker := TTextToSpeech.Create;
  FSpeaker.OnSpeechStarted := SpeakerSpeechStartedHandler;
  FSpeaker.OnSpeechFinished := SpeakerSpeechFinishedHandler;
  FSpeaker.OnCheckDataComplete := SpeakerCheckDataCompleteHandler;
  // Начальные значения для языка
  FSelectedLanguage := 'et'; // Установите значение по умолчанию
except
  on E: Exception do Exit;
end;
end;

destructor TFormMain.Destroy;
begin
try
  try
  FSpeaker.Free;
  except
    //
  end;
  try
  TMessageManager.DefaultManager.Unsubscribe(TMessageResultNotification, InitR);
  except
    //
  end;
  try
  FAppUpdate.Free;
  except
    //
  end;
  inherited;
except
  on E: Exception do Exit;
end;
end;

function GetExtStgPath: string;
var
  Path: JFile;
begin
try
  Path := TJEnvironment.JavaClass.getExternalStorageDirectory;
  Result := JStringToString(Path.getAbsolutePath);
except
  Result := '';
  Exit;
end;
end;

function IsExtStgWritable: Boolean;
var
  State: JString;
begin
try
  State := TJEnvironment.JavaClass.getExternalStorageState;
  Result := State.equals(TJEnvironment.JavaClass.MEDIA_MOUNTED);
except
  Result := False;
  Exit;
end;
end;

function IsOrderIdExists(const OrderId: string): Boolean;
begin
  try
    // Проверяем существование OrderId в базе данных
    with uDMForm do begin
        try
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
        finally
          // Закрываем запрос и освобождаем ресурсы
          if fQuery.Active then
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

procedure TFormMain.InsertTranslation(EstonianWord, RussianTranslation, ExtraData: string; Number: Integer);
begin
  try
    with uDMForm do
    begin
      try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text :=
          'INSERT INTO Translations (EstonianWord, RussianTranslation, ExtraData, Number) ' +
          'VALUES (:EstonianWord, :RussianTranslation, :ExtraData, :Number)';
        fQuery.ParamByName('EstonianWord').AsString := Trim(EstonianWord);
        fQuery.ParamByName('RussianTranslation').AsString := Trim(RussianTranslation);
        fQuery.ParamByName('ExtraData').AsString := ExtraData;
        fQuery.ParamByName('Number').AsInteger := Number;
        fQuery.ExecSQL;
      finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
      end;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Error inserting data into Translations: ' + E.Message);
      Exit;
    end;
  end;
end;


procedure TFormMain.InsertBases(str: string; settings: string);
var
  UniqueOrderId: Integer;
begin
try
  // Генерируем уникальный номер из 7 цифр
  UniqueOrderId := StrToInt(GenerateUniqueOrderId(7));
  try
  with uDMForm do begin
      try
       fConnect.Open;
       fQuery.SQL.Clear;
       fQuery.SQL.Text := 'insert into t_jso_Notes(OrderID, Translate, SettingText) VALUES (:OrderID, :Translate, :SettingText)';
       fQuery.ParamByName('OrderID').AsInteger := UniqueOrderId;
       fQuery.ParamByName('Translate').AsString := Trim(str);
       fQuery.ParamByName('SettingText').AsString := settings;
       fQuery.ExecSQL;
      finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
      end;
  end;
  except
    ShowMessage('Error insert to Bases');
    Exit;
  end;
except
  on E: Exception do begin
     ShowMessage('Error insert ! '+#13#10+E.Message);
     Exit;
  end;
end;
end;

//BASES_CRYPTFILE
procedure TFormMain.SaveCryptoBases;
begin
try
  mmoBases.Lines.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,BASES_CRYPTFILE));
except
  Exit;
end;
end;

procedure TFormMain.SBMenu1Click(Sender: TObject);
begin
try
  ShowNotification('Menu selection', 0);
except
  Exit;
end;
end;

procedure TFormMain.SaveBases(str: string);
var myDate : TDateTime;
begin
    myDate := Now;
try
    if Length(Trim(mmoBases.Lines.Text)) = 0 then begin
    if TFile.Exists(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE)) then
       mmoBases.Lines.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE));
    if mmoBases.Lines.IndexOf(str) = -1 then mmoBases.Lines.Add('['+FormatDateTime('dd/mm/yyyy hh:nn:ss', myDate)+'] {'+str+#13#10+'}');
       mmoBases.Lines.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE));
    if mmoBases.Lines.Count >= 144000 then begin
       mmoBases.Lines.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,BASES_OLD_FILE+'_'+GenerateUniqueOrderId(7)+'.bsb'));
       CompressDatabase;
    end;
    end else begin
    if mmoBases.Lines.IndexOf(str) = -1 then mmoBases.Lines.Add('['+FormatDateTime('dd/mm/yyyy hh:nn:ss', myDate)+'] {'+str+#13#10+'}');
       mmoBases.Lines.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE));
    if mmoBases.Lines.Count >= 144000 then begin
       mmoBases.Lines.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,BASES_OLD_FILE+'_'+GenerateUniqueOrderId(7)+'.bsb'));
       CompressDatabase;
    end;
    end;
    InsertBases('['+FormatDateTime('dd/mm/yyyy hh:nn:ss', myDate)+'] {'+str+#13#10+'}','EE');
    TDialogService.ShowMessage('Data saved!');
except
  Exit;
end;
end;

function GetPackageInfo: JPackageInfo;
var
  Activity: JActivity;
begin
try
  Activity := TJNativeActivity.Wrap(PANativeActivity(System.DelphiActivity)^.clazz);
  Result := Activity.getPackageManager.getPackageInfo(Activity.getPackageName, 0);
except
  Exit;
end;
end;

function BytesToHex(const ABuffer: TBytes): String;
begin
try
  SetLength(Result, Length(ABuffer) * 2);
  BinToHex(PAnsiChar(ABuffer), PChar(Result), Length(ABuffer));
except
  Result := '';
  Exit;
end;
end;

function HexToBytes(const ABuffer: String): TBytes;
begin
try
  SetLength(Result, Length(ABuffer) div 2);
  HexToBin(PChar(ABuffer), PAnsiChar(Result), Length(Result));
except
  Exit;
end;
end;

procedure TFormMain.GetCountLineBases;
begin
  try
    with uDMForm do
    begin
      fConnect.Open;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT COUNT(*) FROM t_jso_Notes';
      fQuery.Open;
      if fQuery.RecordCount > 0 then
      begin
        TThread.CreateAnonymousThread(
          procedure
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                l_Count_db.Text := fQuery.Fields[0].AsString;
              end
            );
            TThread.Sleep(500);
          end
        ).Start; //l_Count_db.Text := IntToStr(fQuery.RecordCount); //fQuery.ParamByName('cnt').AsString; //
      end
      else
      if swtch1.IsChecked then ShowNotification('Bases count is null', 0);
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error get count to bases ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SearchBasesWords(const SearchText: string);
begin
  try
    if Length(TranslationRecords) > 0 then
    begin
      with uDMForm do
      begin
        try
          fConnect.Open;
          fQuery.SQL.Clear;
          // Используем параметризованный запрос для поиска по полю EstonianWord
          fQuery.SQL.Text := 'SELECT * FROM Translations WHERE EstonianWord = :SearchText';
          fQuery.ParamByName('SearchText').AsString := SearchText; // Ищем точное соответствие
          fQuery.Open;
          if fQuery.RecordCount > 0 then
          begin
            CurrentIndex := fQuery.FieldByName('id').AsInteger;
            if CurrentIndex > 1 then CurrentIndex := CurrentIndex-1;
            DisplayWord(CurrentIndex);
          end
          else if swtch1.IsChecked then
            ShowNotification('Nothing found for your search: ' + SearchText, 0);
        finally
          // Закрываем запрос и освобождаем ресурсы
          if fQuery.Active then
             fQuery.Close;
        end;
      end;
    end
    else if swtch1.IsChecked then
      ShowNotification('Count words in databases = 0', 0);
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then
        ShowNotification('Error while searching: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.SearchBases(const SearchText: string);
begin
  try
    with uDMForm do
    begin
     try
      fConnect.Open;
      fQuery.SQL.Clear;
      // Используем параметризованный запрос для поиска по полю Translate
      fQuery.SQL.Text := 'SELECT * FROM t_jso_Notes WHERE Translate LIKE :SearchText';
      fQuery.ParamByName('SearchText').AsString := '%' + SearchText + '%'; // Искать по подстроке
      fQuery.Open;
      if fQuery.RecordCount > 0 then
      begin
        ListView1.Items.BeginUpdate;
        try
          ListView1.Items.Clear; // Очищаем предыдущие результаты
          // Заполняем ListView найденными записями
          fQuery.First;
          while not fQuery.Eof do
          begin
            with ListView1.Items.Add do
            begin
              Text := fQuery.FieldByName('Translate').AsString;
              Detail := fQuery.FieldByName('SettingText').AsString;
              Height := 210;
            end;
            fQuery.Next;
          end;
        finally
          ListView1.Items.EndUpdate;
        end;
      end
      else
      if swtch1.IsChecked then ShowNotification('Nothing found for your search: ' + SearchText, 0);
     finally
      // Закрываем запрос и освобождаем ресурсы
      if fQuery.Active then
         fQuery.Close;
     end;
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error while searching: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.CompressDatabase;
begin
  try
    // Открываем соединение с базой данных
    with uDMForm do
    begin
      fConnect.Open;
      try
       try // Выполняем команду VACUUM для сжатия базы данных
        fQuery.SQL.Text := 'VACUUM';
        fQuery.ExecSQL;
        ShowNotification('The database has been compressed successfully.', 0);
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
       end;
      finally
        fConnect.Close; // Закрываем соединение после завершения работы
      end;
    end;
  except
    on E: Exception do
    begin
      ShowNotification('Error while compressing database ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.LoadBases;
var
  item: TListViewItem;
  imgDeleteDrawable: TListItemImage;
  NoteText, SourceText, TranslationText: string;
  SourcePos, TranslationPos: Integer;
  textDrawable: TListItemText;
  uLen: Integer;
begin
  try
    // Проверяем, существует ли файл базы данных, и загружаем его в mmoBases
    if TFile.Exists(TPath.Combine(TPath.GetDocumentsPath, BASES_FILE)) then
       mmoBases.Lines.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, BASES_FILE));
       uLen := 377;
    // Открываем соединение с базой данных
    with uDMForm do
    begin
     try
      fConnect.Open;
      try
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'SELECT * FROM t_jso_Notes';
        fQuery.Open;
        // Обновляем ListView, если есть записи в базе данных
        if fQuery.RecordCount > 0 then
        begin
          BindSourceDB1.DataSource := TDataSource.Create(Self);
          BindSourceDB1.DataSource.DataSet := fQuery;
          try
            l_Count_db.Text := fQuery.Fields[0].AsString;
          except
            ShowNotification('Error LoadCount', 0);
          end;
          ListView1.BeginUpdate;
          try
            ListView1.Items.Clear; // Очистить все элементы списка
            // Заполняем ListView данными из базы
            fQuery.First;
            while not fQuery.Eof do
            begin
              item := ListView1.Items.Add;
              item.Tag := fQuery.FieldByName('id').AsInteger;
              // Устанавливаем высоту ячейки на основе содержимого
              item.Height := uLen;
              // Получаем текстовые данные из базы
              NoteText := fQuery.FieldByName('Translate').AsString;
              // Находим позиции подстрок "Source:" и "Translation:"
              SourcePos := Pos('Source:', NoteText);
              TranslationPos := Pos('Translation:', NoteText);
              if (SourcePos > 0) and (TranslationPos > 0) then
              begin
                SourceText := Copy(NoteText, SourcePos + Length('Source:'), TranslationPos - SourcePos - Length('Source:'));
                TranslationText := Copy(NoteText, TranslationPos + Length('Translation:'), Length(NoteText) - TranslationPos - Length('Translation:') + 1);
                SourceText := Trim(SourceText);
                TranslationText := Trim(TranslationText);
              end;
                // Удаляем любые лишние символы, включая символ `}`
                TranslationText := StringReplace(TranslationText, '}', '', [rfReplaceAll]);
                // Получаем текстовый элемент из ячейки
                textDrawable := TListItemText(item.Objects.FindDrawable('Translate'));

                // Настраиваем текстовый элемент
                textDrawable.WordWrap := True; // Включаем перенос по словам
                textDrawable.Height := Length(Trim(NoteText)); // Включаем автоматический расчет высоты
                textDrawable.Width := 377;

              if Length(Trim(TranslationText)) > 0 then
                 textDrawable.Text := SourceText + #13#10 + TranslationText
              else
                 textDrawable.Text := NoteText;

                 // Устанавливаем изображение для удаления
                 imgDeleteDrawable := TListItemImage(item.Objects.FindDrawable('imgDelete'));
              if Assigned(imgDeleteDrawable) then
              begin
                imgDeleteDrawable.Bitmap := imgDelete.Bitmap;
                imgDeleteDrawable.TagFloat := fQuery.FieldByName('id').AsInteger;
              end;

              fQuery.Next;
            end;
          finally
            ListView1.EndUpdate;
          end;
        end;
      finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
      end;
     finally
        fConnect.Close; // Закрываем соединение после завершения работы
     end;
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then
         ShowNotification('Error LoadBases: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.DeleteBases;
begin
try
  if TFile.Exists(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE)) then DeleteFile(TPath.Combine(TPath.GetDocumentsPath,BASES_FILE));
  try
    try
      with uDMForm do
      begin
       try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'DROP TABLE IF EXISTS t_jso_Notes';
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
       end;
      end;
    except
      //
    end;
    try
      with uDMForm do
      begin
       try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'DROP TABLE IF EXISTS t_jso_Diary';
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
       end;
      end;
    except
      //
    end;
    try
      with uDMForm do
      begin
       try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'DROP TABLE IF EXISTS Translations';
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
       end;
      end;
    except
      //
    end;
    try
      with uDMForm do
      begin
       try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'CREATE TABLE [t_jso_Notes] ([id] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,[OrderID] INTEGER  UNIQUE NULL,[Translate] TEXT  NULL,[CreateDate] TEXT DEFAULT ''''''CURRENT_TIMESTAMP'''''' NULL,[SettingText] TEXT  NULL)';
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
       end;
      end;
    except
      //
    end;
    try
      with uDMForm do
      begin
       try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'CREATE TABLE [t_jso_Diary] ([id] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,[MessID] INTEGER  UNIQUE NULL,[Message] TEXT  NULL,[CreateDate] DATE DEFAULT CURRENT_DATE NOT NULL)';
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
       end;
      end;
    except
      //
    end;
    try
      with uDMForm do
      begin
        try
          fConnect.Open;
          fQuery.SQL.Clear;
          fQuery.SQL.Text :=
            'CREATE TABLE IF NOT EXISTS Translations (' +
            'ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ' +
            'EstonianWord TEXT NOT NULL, ' +
            'RussianTranslation TEXT NOT NULL, ' +
            'ExtraData TEXT, ' +
            'Number INTEGER, ' +
            'LevelWords TEXT NOT NULL)';
          fQuery.ExecSQL;
        finally
          // Закрываем запрос и освобождаем ресурсы
          if fQuery.Active then
             fQuery.Close;
             fConnect.Close;
        end;
      end;
    except
      //
    end;
  except
    on E: Exception do
    begin
       if swtch1.IsChecked then ShowNotification('Error drop table: ' + E.Message, 0);
    end;
  end;
except
  Exit;
end;
end;

function GetCurrentAppVersionCode: string;
var
  PackageManager: JPackageManager;
  PackageInfo: JPackageInfo;
begin
try
  Result := '';
  // Получаем менеджер пакетов приложений
  PackageManager := TAndroidHelper.Context.getPackageManager;
  // Получаем информацию о текущем пакете (т.е. вашем приложении)
  PackageInfo := PackageManager.getPackageInfo(TAndroidHelper.Context.getPackageName, 0);
  // В PackageInfo содержится информация о версии приложения
  if PackageInfo <> nil then
     Result := JStringToString(PackageInfo.versionName); // Получаем версию приложения (номер версии)
     Result := Trim(Result); // Опционально обрезаем лишние пробелы
except
  Result := '';
  Exit;
end;
end;

procedure TFormMain.LogMessage(const AMessage: string);
begin
try
  TThread.Synchronize(nil,
    procedure
    begin
      mmoInfo.Lines.Add(AMessage);
    end);
except
  if swtch1.IsChecked then ShowNotification('Error Log Message', 0);
  Exit;
end;
end;

procedure CheckAndUpdateAppVersion(const PackageName: string);
var
  Intent: JIntent;
  MarketUrl: JString;
begin
  try
    MarketUrl := StringToJString('market://details?id=' + PackageName);
    Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW, TJnet_Uri.JavaClass.parse(MarketUrl));
    Intent.setFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
    TAndroidHelper.Context.startActivity(Intent);
  except
    on E: Exception do
      TDialogService.ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TFormMain.GetUpdateMyPrg(prg: string);
begin
try
  CheckAndUpdateAppVersion(prg);
  if swtch1.IsChecked then ShowNotification('Update application - Ok', 0);
except
  if swtch1.IsChecked then ShowNotification('Error update application', 0);
  Exit;
end;
end;

procedure TFormMain.PerformUpdate;
begin
try
  // Выполняем реальную логику обновления приложения
  GetUpdateMyPrg('com.stalkersts.tartu');
except
  if swtch1.IsChecked then ShowNotification('Error Perform Update', 0);
  Exit;
end;
end;

procedure TFormMain.StartUpdateTask;
begin
try
  TTask.Run(
    procedure
    begin
      try
        LogMessage('Start Update: ' + TimeToStr(Now));
        PerformUpdate;
        TThread.Synchronize(nil,
          procedure
          begin
            LogMessage('End Update: ' + TimeToStr(Now));
          end);
      except
        on E: Exception do
        begin
          TThread.Synchronize(nil,
            procedure
            begin
              LogMessage('Error during update: ' + E.Message);
              if swtch1.IsChecked then ShowNotification('Error Update Start: ' + E.Message, 0);
            end);
        end;
      end;
    end).Start;
except
  if swtch1.IsChecked then ShowNotification('Error Start Update Task', 0);
  Exit;
end;
end;

procedure TFormMain.CheckForUpdate;
begin
try
  TDialogService.MessageDialog('Check update?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        StartUpdateTask;
      end;
    end);
except
  if swtch1.IsChecked then ShowNotification('Error Check For Update', 0);
  Exit;
end;
end;

procedure TFormMain.chkSoonavebChange(Sender: TObject);
begin
try
  btnGGView.Tag := 100;
  btnGo.Enabled := False;
  btnGGView.Enabled := True;
except
  Exit;
end;
end;

procedure TFormMain.Listening(const AIsListening: Boolean);
begin
try
  if AIsListening then sTouchMe := cTouchMeCaption else sTouchMe := '';
     REnter.Visible := AIsListening;
     BiometricImage.Enabled := not AIsListening;
except
  Exit;
end;
end;

procedure TFormMain.DeleteNoteFromDatabase(OrderID: Integer);
begin
  try
    with uDMForm do
    begin
      fConnect.Open;
      try
       try
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'DELETE FROM t_jso_Notes WHERE id = :OrderID';
        fQuery.ParamByName('OrderID').AsInteger := OrderID;
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
       end;
      finally
        fConnect.Close; // Убедитесь, что соединение закрывается корректно
      end;
    end;
  except
    on E: Exception do
    begin
       ShowMessage('Error deleting record: ' + E.Message);
    end;
  end;
end;

procedure TFormMain.UpdateListView;
begin
  try
    with uDMForm do
    begin
     try
      fConnect.Open;
      try
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'SELECT * FROM t_jso_Notes';
        fQuery.Open;
        ListView1.Items.Clear;
        ListView1.BeginUpdate;
        try
          fQuery.First;
          while not fQuery.Eof do
          begin
            with ListView1.Items.Add do
            begin
              Text := fQuery.FieldByName('Translate').AsString + sLineBreak +
                      fQuery.FieldByName('SettingText').AsString + '[' +
                      fQuery.FieldByName('OrderID').AsString + ']';
              Detail := fQuery.FieldByName('CreateDate').AsString;
              Height := 210;
            end;
            fQuery.Next;
          end;
        finally
          ListView1.EndUpdate;
        end;
      finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
      end;
     finally
       fConnect.Close;
     end;
    end;
  except
    on E: Exception do
    begin
      ShowNotification('Error updating ListView: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
  idToDelete: Integer;
begin
try
  if ItemObject is TListItemImage then
  begin
    if TListItemImage(ItemObject).Name = 'imgDelete' then
    begin
      idToDelete := Trunc(TListItemImage(ItemObject).TagFloat);
      // Удаляем запись из базы данных
      with uDMForm do
      begin
        fConnect.Open;
        try
         try
          fQuery.SQL.Clear;
          fQuery.SQL.Text := 'DELETE FROM t_jso_Notes WHERE id = :id';
          fQuery.ParamByName('id').AsInteger := idToDelete;
          fQuery.ExecSQL;
         finally
          // Закрываем запрос и освобождаем ресурсы
          if fQuery.Active then
             fQuery.Close;
         end;
        finally
          fConnect.Close;
        end;
      end;
      try
        try
          ListView1.Items.Delete(ItemIndex);
          // Перезагружаем данные после удаления
          LoadBases;
        finally
          TDialogService.ShowMessage('The selected data successfully deleted!');
        end;
      except
        mLog.Lines.Add('Error delete data in bases Notes');
      end;
    end;
  end;
except
  ShowNotification('Error ListView1 DELETE', 0);
  Exit;
end;
end;

procedure TFormMain.GetCountMemoText;
begin
try
  if Length(mmo_src.Lines.Text) >= 7000 then mmo_src.Lines.Text := StringReplace(mmo_src.Lines.Text,#13#10,' ',[rfreplaceall]) else
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          lstatus.Text := 'Translation :                           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
      TThread.Synchronize(nil,
        procedure
        begin
          lstatus.Text := 'Translation :                           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
      TThread.Synchronize(nil,
        procedure
        begin
          lstatus.Text := 'Translation :                           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
    end
  ).Start;
except
  ShowNotification('Error GetCountMemoText', 0);
  Exit;
end;
end;

procedure TFormMain.mmo_srcChange(Sender: TObject);
var
  InputText: string;
  CaretPos: TCaretPosition;
begin
try
  if Length(mmo_src.Lines.Text) >= 7000 then mmo_src.Lines.Text := StringReplace(mmo_src.Lines.Text,#13#10,' ',[rfreplaceall]) else
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          lstatus.Text := 'Translation :                           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
      TThread.Synchronize(nil,
        procedure
        begin
          lstatus.Text := 'Translation :                           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
      TThread.Synchronize(nil,
        procedure
        begin
          lstatus.Text := 'Translation :                           '+IntToStr(Length(Trim(mmo_src.Text)))+' / 7000 ['+IntToStr(CountWordsInMemo)+']';
        end
      );
      TThread.Sleep(500);
    end
  ).Start;
  if (btnGGView.Tag = 333) then begin
  if Length(mmo_src.Lines.Text) >= 7000 then mmo_src.Lines.Text := StringReplace(mmo_src.Lines.Text,#13#10,' ',[rfreplaceall]) else
    TThread.CreateAnonymousThread(
      procedure
      begin
        TThread.Synchronize(nil,
          procedure
          begin
             InputText := mmo_src.Lines.Text;
             // Удаляем всё после первого пробела
          if Pos(' ', InputText) > 0 then begin
             mmo_src.Lines.Text := Copy(InputText, 1, Pos(' ', InputText) - 1);
             // Устанавливаем курсор в конец текста
             CaretPos := TCaretPosition.Create(0,0);
             CaretPos.Line := mmo_src.Lines.Count - 1; // Последняя строка
             CaretPos.Pos := Length(mmo_src.Lines.Text); // Конец строки
             mmo_src.CaretPosition := CaretPos;
          end;
          end
        );
        TThread.Sleep(500);
      end
    ).Start;
  end;
except
  Exit;
end;
end;

procedure TFormMain.mmo_srcClick(Sender: TObject);
begin
try
  ShowNotification('Entering text to translate', 0);
except
  Exit;
end;
end;

procedure TFormMain.mmo_trgClick(Sender: TObject);
begin
try
  if Length(Trim(mmo_trg.Lines.Text)) = 0 then begin
     ExampleText.Clear;
     Exit;
  end;
  if (btnGGView.Tag = 333) then begin
     ShowNotification('Translated text', 0);
     if Length(Trim(ExampleText.Text)) > 0 then begin
        mmo_src.Lines.Text := ExampleText.Text;
     end;
  end;
except
  Exit;
end;
end;

procedure TFormMain.MultiViewShown(Sender: TObject);
begin
try
  if not (TabControl1.ActiveTab = uLogger) then begin
     MultiView.HideMaster;
     TabControl1.Tabs[1].Visible := True;
     TabControl1.GotoVisibleTab(1);
     TabControl1.Tabs[0].Visible := False;
     TabControl1.Tabs[2].Visible := False;
     TabControl1.Tabs[3].Visible := False;
     TabControl1.Tabs[4].Visible := False;
     TabControl1.Tabs[5].Visible := False;
     TabControl1.Tabs[6].Visible := False;
     TabControl1.Tabs[7].Visible := False;
     TabControl1.Tabs[8].Visible := False;
     TabControl1.Tabs[1].SetFocus;
     MultiView.HideMaster;
     Exit;
  end;
except
  Exit;
end;
end;

procedure TFormMain.MultiViewStartShowing(Sender: TObject);
begin
try
  if not (TabControl1.ActiveTab = uLogger) then begin
     MultiView.HideMaster;
     TabControl1.Tabs[1].Visible := True;
     TabControl1.GotoVisibleTab(1);
     TabControl1.Tabs[0].Visible := False;
     TabControl1.Tabs[2].Visible := False;
     TabControl1.Tabs[3].Visible := False;
     TabControl1.Tabs[4].Visible := False;
     TabControl1.Tabs[5].Visible := False;
     TabControl1.Tabs[6].Visible := False;
     TabControl1.Tabs[7].Visible := False;
     TabControl1.Tabs[8].Visible := False;
     TabControl1.Tabs[1].SetFocus;
     MultiView.HideMaster;
     Exit;
  end;
except
  Exit;
end;
end;

procedure TFormMain.Verify;
begin
try
  if FBiometric <> nil then
  begin
    if not FBiometric.HasUserInterface then
       Listening(True);
       FBiometric.Verify(cTouchMeCaption, VerificationSuccessResultHandler, VerificationFailResultHandler);
  end;
except
  Exit;
end;
end;

procedure TFormMain.VerificationFailResultHandler(const AFailResult: TBiometricFailResult; const AResultMessage: string);
begin
try
  case AFailResult of
    TBiometricFailResult.Cancelled:
    begin
      Listening(False);
      if swtch1.IsChecked then ShowNotification('Biometric You cancelled', 0);
    end;
    TBiometricFailResult.Denied:
      ShowMessage(Format('Denied! Probably the wrong face/finger: %s', [AResultMessage]));
    TBiometricFailResult.Error:
      ShowMessage(Format('Error: %s', [AResultMessage]));
    TBiometricFailResult.Fallback:
      ShowMessage('You chose the fallback');
    TBiometricFailResult.Help:
      ShowMessage(Format('You may need help: %s', [AResultMessage]));
    TBiometricFailResult.LockedOut:
      ShowMessage(Format('You may need to wait for the biometry to unlock: %s', [AResultMessage]));
  else
    ShowMessage('Unhandled result!');
  end;
except
  Exit;
end;
end;

procedure TFormMain.VerificationSuccessResultHandler;
begin
try
  Listening(False); //ShowMessage('Success!');
except
  Exit;
end;
end;

procedure SetTransparentEdit(Edit: TEdit);
begin
try
  Edit.StyleLookup := 'transpeditstyle'; // Имя созданного стиля
  Edit.Repaint;
except
  Exit;
end;
end;
procedure TFormMain.FormCreate(Sender: TObject);
begin
  try
    idx := 6;
    uX := 3;
    tIDX := 9;
    idTab := 365;
    sContID := 3;
    xAnswer := 1;
    uIndex := 0;
    cEncoding := 'ISO-8859-1';
    cZone := '4';
    idLang := -1;
    idxLang := -1;
    xKusiwer := -1;
    xSettinwer := -1;
    uYout := -1;
    sLevelWords := False;
    uLevelWords := False;
    chkSoundPlay := False;
    privUsers := False;
    ExampleText := TStringList.Create;
    SetTransparentEdit(EditEmail);
    SetTransparentEdit(EditPassword);
    FSheetData := TSheetRowList.Create;
    FSheetPostpositsiooneData := TSheetPostpositsiooneRowList.Create;
    FSheetQuestData := TSheetQuestRowList.Create;
    FSheetExampData := TSheetExampRowList.Create;
    FSheetDataGames := TSheetRowListGames.Create;
    FWebApiKey := FAPIKEY;
    FFilePath := TPath.GetDocumentsPath;
    TabControl1.TabPosition := TTabPosition.None;
    TabControl1.Tabs[0].Visible := True;
    TabControl1.Tabs[1].Visible := False;
    TabControl1.Tabs[2].Visible := False;
    TabControl1.Tabs[3].Visible := False;
    TabControl1.Tabs[4].Visible := False;
    TabControl1.Tabs[5].Visible := False;
    TabControl1.Tabs[6].Visible := False;
    TabControl1.Tabs[7].Visible := False;
    TabControl1.Tabs[8].Visible := False;
    TabControl1.TabIndex := 0;
    TabControl1.ActiveTab := uAuth1;
    lstatus.Text := 'Translation :                                         0 / 7000';
    {$IFDEF MSWINDOWS}
      IdOpenSSLSetLibPath('../../assets/internal'));
    {$ENDIF}
    {$IFDEF ANDROID}
      IdOpenSSLSetLibPath(TPath.GetHomePath);
    {$ENDIF} //if FileExists(TPath.Combine(TPath.GetHomePath, 'libcrypto.so')) then ShowNotification('Lib - Ok', 0) else ShowNotification('Lib - No', 0);
    try
      // Initially, show the front layout
      FSwipe := True;
      FrontLayout.Visible := True;
      BackLayout.Visible := False;
      FSheetUrlData := TSheetUrlRowList.Create;
      // Setup FlipAnimation properties
      FloatAnimationSObjR := TFloatAnimation.Create(CardLayout);
      FloatAnimationSObjR.Parent := CardLayout;
      FloatAnimationSObjR.Duration := 0.3; // Time for half flip
      FloatAnimationSObjR.PropertyName := 'RotationAngle.Y';
      FloatAnimationSObjR.StartValue := 0;
      FloatAnimationSObjR.StopValue := 90;
      ResetSwipeObject(CardBack);
      ResetSwipeObject(CardFront);
      CurrentIndex := 0;
    except
      mLog.Lines.Add('Error FSwipe');
    end;
    try
     SettingsFDMemTable.ResourceOptions.PersistentFileName := TPath.Combine(FFilePath, 'cs_settings_ttm.fds');
     SettingsFDMemTable.ResourceOptions.Persistent := True;
     SettingsFDMemTable.Open;
    except
      mLog.Lines.Add('Error SettingsFDMemTable');
    end;
    try
      FBiometric := TBiometric.Current;
      FBiometric.AllowedAttempts := 1;
    except
      mLog.Lines.Add('Error FBiometric');
    end;
  except
    Exit;
  end;
end;

procedure TFormMain.ModifLocalBases(stat: string);
begin
try
  if stat = 'DROP' then begin
    try
     try
      with uDMForm do
      begin
       try
        fConnect.Open;
        fQuery.SQL.Clear;
        fQuery.SQL.Text := 'DROP TABLE IF EXISTS Translations';
        fQuery.ExecSQL;
       finally
        // Закрываем запрос и освобождаем ресурсы
        if fQuery.Active then
           fQuery.Close;
           fConnect.Close;
       end;
      end;
     finally
       TDialogService.ShowMessage('The table has been cleared successfully.');
     end;
    except
      mLog.Lines.Add('Error drop local bases');
    end;
  end else
  if stat = 'CREATE' then begin
    try
     try
      with uDMForm do
      begin
        try
          fConnect.Open;
          fQuery.SQL.Clear;
          fQuery.SQL.Text :=
            'CREATE TABLE IF NOT EXISTS Translations (' +
            'ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ' +
            'EstonianWord TEXT NOT NULL, ' +
            'RussianTranslation TEXT NOT NULL, ' +
            'ExtraData TEXT NOT NULL, ' +
            'Number INTEGER, ' +
            'LevelWords TEXT NOT NULL)';
          fQuery.ExecSQL;
        finally
          // Закрываем запрос и освобождаем ресурсы
          if fQuery.Active then
             fQuery.Close;
             fConnect.Close;
        end;
      end;
     finally
       TDialogService.ShowMessage('Table created successfully');
     end;
    except
      mLog.Lines.Add('Error create local bases');
    end;
  end;
except
  Exit;
end;
end;

procedure TFormMain.OnServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
var
  PushService: TPushService;
begin
try
    PushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.FCM);
 if TPushService.TChange.DeviceToken in PushChanges then
 begin
     FDeviceToken := PushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
     mLog.Lines.Add('Firebase Token: ' + FDeviceToken);
     mLog.Lines.Add('Firebase device token: token=' + FDeviceToken);
 end;
 if (TPushService.TChange.Status in PushChanges) and (PushService.Status = TPushService.TStatus.StartupError) then
     mLog.Lines.Add('Error: ' + PushService.StartupError);
except
  Exit;
end;
end;
procedure TFormMain.OnReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
begin
try
   mLog.Lines.Add('-----------------------------------------');
   mLog.Lines.Add('DataKey = ' + ServiceNotification.DataKey);
   mLog.Lines.Add('Json = ' + ServiceNotification.Json.ToString);
   mLog.Lines.Add('DataObject = ' + ServiceNotification.DataObject.ToString);
   mLog.Lines.Add('---------------------------------------');
except
  Exit;
end;
end;
procedure TFormMain.SetStyle;
begin
try
  case SettingsFDMemTable.FieldByName('Style').AsInteger of
    0: FormMain.StyleBook := MaterialOxfordBlueSB;
    1: FormMain.StyleBook := MaterialOxfordBlueSB;
  end;
except
  Exit;
end;
end;
procedure TFormMain.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
try
  { show the share sheet }
  if sID = 1 then ShowShareSheetAction1.TextMessage := mmo_src.Text+#13#10+mmo_trg.Text;
  if sID = 2 then ShowShareSheetAction1.TextMessage := mmoBases.Text;
  if sID = 3 then ShowShareSheetAction1.TextMessage := mmoKusi.Text;
  if sID = 5 then ShowShareSheetAction1.TextMessage := aiTextSrc+#13#10+aiTextTrg;
except
  Exit;
end;
end;
procedure TFormMain.FormDestroy(Sender: TObject);
begin
try
  if FBiometric <> nil then FBiometric.Cancel; FSheetData.Free; FSheetQuestData.Free; FSheetPostpositsiooneData.Free; FSheetExampData.Free; FSheetDataGames.Free;
  if ExampleText <> nil then ExampleText.Free;
  inherited;
except
  Exit;
end;
end;
procedure TFormMain.TabControl1Click(Sender: TObject);
begin
try
  WebBrowser1.Visible := True;
except
  Exit;
end;
end;
procedure TFormMain.TakePhotoFromCameraAction1DidFinishTaking(str: string);
begin
try
  { display the picture taken from the camera to the TImage control }
except
  Exit;
end;
end;
// Optional rationale display routine to display permission requirement rationale to the user
procedure TFormMain.DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
var
  I: Integer;
  RationaleMsg: string;
begin
try
  for I := 0 to High(APermissions) do
  begin
    if APermissions[I] = FPermissionReadExternalStorage then
       RationaleMsg := RationaleMsg + 'The app needs to read a photo file from your device';
  end;
  TDialogService.ShowMessage(RationaleMsg,
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end);
except
  Exit;
end;
end;
procedure TFormMain.TakePicturePermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
begin
try
  if ((Length(AGrantResults) > 0) and
      (AGrantResults[0] = TPermissionStatus.Granted) and
      (AGrantResults[1] = TPermissionStatus.Granted))
  then TakePhotoFromCameraAction1.Execute;
except
  Exit;
end;
end;
procedure TFormMain.FormShow(Sender: TObject);
var
 SL: TStringList;
 x: Integer;
begin
try
   try
     StyleBook := MaterialOxfordBlueSB;
   except
     ShowNotification('Error StyleBook', 0);
   end;
   {$IF DEFINED(ANDROID) AND (RTLVersion >= 33)}
   try
     PermissionsCheck;
   except
     ShowNotification('Error PermissionsCheck', 0);
   end;
   {$ENDIF}
   try
    SL := TStringList.Create;
   try
    if TFile.Exists(TPath.Combine(TPath.GetDocumentsPath,TEST_FILE)) then begin
       SL.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath,TEST_FILE));
       x := System.Pos('\',SL.Text);
       if Pos('test@test.tst',Trim(System.Copy(SL.Text,1,x-1))) = 0 then begin
          EditEmail.Text := Trim(System.Copy(SL.Text,1,x-1));
          EditPassword.Text := Trim(System.Copy(SL.Text,x+1,Length(SL.Text)));
          RctSignUp.Enabled := False;
       end;
    end;
   finally
     SL.Free;
   end;
   except
     ShowNotification('Error File.Exists', 0);
   end;
   if Pos('stasbalazuk@gmail.com',Trim(EditEmail.Text)) > 0 then begin swtch1.IsChecked := True; swtch1.Visible := True; end else begin swtch1.IsChecked := False; swtch1.Visible := False; end;
   try
      Self.actGetAccessTokenExecute(Self);
      mLog.Lines.Add('Request GetAccessToken - Ok');
   except
      mLog.Lines.Add('Request GetAccessToken - Error');
      ShowNotification('Request GetAccessToken - Error', 0);
   end;
   try
     BiometricAuth1.IsSupported;
   except
     ShowNotification('Error BiometricAuth', 0);
   end;
   try
     LoadBases;
     GetCountLineBases;
     GetCountMemoText;
     fnLoadingCore(False);
     uLevelWords := False;
     GetLocalBasesWords;
   except
     ShowNotification('Error LoadBases', 0);
   end;
except
  ShowNotification('Error FormShow', 0);
  mmo_src.SetFocus;
  Exit;
end;
end;

procedure TFormMain.imgQRCodeDblClick(Sender: TObject);
begin
   try
    {$IFDEF ANDROID}
      FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
      FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
      if ((not PermissionsService.IsPermissionGranted(FPermissionReadExternalStorage))or(not PermissionsService.IsPermissionGranted(FPermissionWriteExternalStorage))) then
      PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
    {$ENDIF}
      mLog.Lines.Add('Request Permissions - Ok');
   except
      mLog.Lines.Add('Request Permissions - Error');
   end;
end;

procedure TFormMain.acBioClickExecute(Sender: TObject);
begin
try
  if FBiometric <> nil then
  begin
    if FBiometric.CanVerify then Verify else
    if FBiometric.IsBiometryLockedOut then
       FBiometric.RestoreBiometry(VerificationSuccessResultHandler, VerificationFailResultHandler) // or perhaps use a separate handler for Biometry
    else
       if swtch1.IsChecked then ShowNotification('Biometric Unable to verify. If on Android', 0);
  end;
  Self.acBiometriaExecute(Self);
except
  Exit;
end;
end;

procedure TFormMain.acBiometriaExecute(Sender: TObject);
begin
try
     uID := False;
     FloatAnimation7.Start;
  if BiometricAuth1.CanAuthenticate then begin
     BiometricAuth1.GetBiometricAvailability;
     BiometricAuth1.Authenticate;
     uID := True;
  end else begin
     uID := False;
     if swtch1.IsChecked then ShowNotification('Authentication not confirmed', 0);
     Arc1.Fill.Color := TAlphaColorRec.Coral;
  end;
except
     Arc1.Fill.Color := TAlphaColorRec.Coral;
  if swtch1.IsChecked then ShowNotification('Authentication not confirmed', 0);
  Exit;
end;
end;

function TFormMain.getVoiceFromTranslate(FText: String): Boolean;
var str : string; FURL : string;
begin
try
  try
  if mpUI.State = TMediaState.Playing then mpUI.Stop; mpUI.Clear;
  if swtch1.IsChecked then ShowNotification('mpUI - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Code';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Code '+#13#10+str, 0);
   end;
  end;
  try
     if (((idxLang = 0)or(idxLang = 1))and(idLang = 0)) then
     FURL := 'https://translate.google.com/translate_tts?ie=UTF-8&client=gtx&q='+ FText +'&tl=ru-ru'
     else
     if (((idxLang = 0)or(idxLang = 1))and(idLang = 6)) then
     FURL := 'https://translate.google.com/translate_tts?ie=UTF-8&client=gtx&q='+ FText +'&tl=us-us'
     else
     if (((idxLang = 0)or(idxLang = 1))and(idLang = 3)) then
     FURL := 'https://translate.google.com/translate_tts?ie=UTF-8&client=gtx&q='+ FText +'&tl=uk-uk'
     else
     if (((idxLang = 0)or(idxLang = 1))and(idLang in [1,2])) then
     FURL := 'https://translate.google.com/translate_tts?ie=UTF-8&client=gtx&q='+ FText +'&tl=et-et';
     fnDownloadFile(FURL, 'temp.mp3');
     if swtch1.IsChecked then ShowNotification('MP3 file - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error MP3 file';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error MP3 file '+#13#10+str, 0);
   end;
  end; 
  try    
  if FileExists(fnLoadFile('temp.mp3')) then begin
     mpUI.FileName := fnLoadFile('temp.mp3');
     mpUI.Play;
     if swtch1.IsChecked then ShowNotification('MP3 load file - Ok', 0);
  end;
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error MP3 load file';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error MP3 load file '+#13#10+str, 0);
   end;
  end;
  Result := True;
except
  on E: ERESTException do begin
     if Length(Trim(str)) = 0 then str := 'Error :';
        str := str +#13#10+E.Message;
     if swtch1.IsChecked then ShowNotification('Error : '+#13#10+str, 0);
        Result := False;
        Exit;
  end;
end;
end;

function TFormMain.getVoice(FText: String): Boolean;
begin
try
  if idLang in [0,1,2,3] then SpeakText(FText) else getVoiceFromTranslate(FText); Result := True;
except
  Result := False;
  Exit;
end;
end;

procedure TFormMain.acSaveDataExecute(Sender: TObject);
var Service: IFMXPhotoLibrary;
begin
try
  sID := 1;
  if ((Length(Trim(mmo_src.Text)) = 0)and(Length(Trim(mmo_trg.Text)) = 0)) then begin
     TDialogService.ShowMessage('There is no data to save!');
     Exit;
  end else ShowNotification('Saving information', 0);
  if not TPlatformServices.Current.SupportsPlatformService(IFMXPhotoLibrary, Service) then Exit;
    TDialogService.MessageDialog('Save Data?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbNo, 0, procedure(const AResult: TModalResult)
     begin
 	   if (AResult = mrYes) then begin
         try
          {$IFDEF ANDROID}
            FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
            FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
            if ((not PermissionsService.IsPermissionGranted(FPermissionReadExternalStorage))or(not PermissionsService.IsPermissionGranted(FPermissionWriteExternalStorage))) then
            PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
          {$ENDIF}
         except
         end;
         try
           ShowShareSheetAction1.Execute;
         except
         end;
     end else begin
         if ((Length(Trim(mmo_src.Text)) > 0)and(Length(Trim(mmo_trg.Text)) > 0)) then SaveBases(#13#10+'Source:'+#13#10+mmo_src.Text+#13#10+'Translation:'+#13#10+mmo_trg.Text);
         mmo_src.Text := '';
         mmo_trg.Text := '';
     end;
     end);
except
  ShowNotification('Error saving information', 0);
  Exit;
end;
end;

procedure TFormMain.acSwitchExecute(Sender: TObject);
var
  SL : TStringList;
begin
try
   SL := TStringList.Create;
   try
    if not TFile.Exists(TPath.Combine(TPath.GetDocumentsPath,tSwitchFile)) then begin
       if swtch1.IsChecked then SL.Text := 'True' else SL.Text := 'False';
          SL.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,tSwitchFile));
    end else begin
          SL.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath,tSwitchFile));
          if Trim(SL.Text) = 'True' then swtch1.IsChecked := True else swtch1.IsChecked := False;
    end;
   finally
     SL.Free;
   end;
except
  Exit;
end;
end;

procedure OpenURLInBrowser(const URL: string);
var
  Intent: JIntent;
begin
try
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW, StrToJURI(URL));
  TAndroidHelper.Context.startActivity(Intent);
except
  Exit;
end;
end;

procedure TFormMain.actAboutExecute(Sender: TObject);
var
  Info: JPackageInfo;
begin
try
  xKusiwer := 0;
  MultiView.HideMaster;
  ShowNotification('About the program', 0);
  Info := GetPackageInfo;
  {$IFDEF ANDROID}
  TDialogBuilder.Create(Self)
    .SetTitle('Choose an action')
    .SetSingleChoiceItems(
      [
      'About',
      'Additional materials',
      'You can buy us coffee',
      'Tartu Privacy Policy'
    ], xKusiwer)
    .SetPositiveButton('Cancel')
    .SetNegativeButton('Sellect',
      procedure (Dialog: IDialog; Which: Integer) begin
        xKusiwer := Dialog.Builder.CheckedItem;
        try
           Application.ProcessMessages;    // Обновить интерфейс
        if xKusiwer = 0 then begin
           TDialogBuilder.Create(Self)
              .SetTitle('About')
              .SetMessage('Tartu '+#13#10+Format('Update date: "%s", VersionCode: %d', [JStringToString(Info.versionName), Info.versionCode])+#13#10+
                          'Developer StalkerSTS'+#13#10+
                          'Technologies used : REST & JSON & API'+#13#10+
                          'Programming language : Delphi'+#13#10+
                         { 'Detailed API documentation https://api.tartunlp.ai/translation/docs'+#13#10+
                          'An API that provides translations using neural machine translation models.'+
                          'Developed by TartuNLP - the NLP research'+
                          'group of the University of Tartu.'+#13#10+ }
                          'Website: https://topgame.work'+#13#10+
                          'Contacts: stasbalazuk@gmail.com')
              .SetPositiveButton('OK',
                procedure (Dialog: IDialog; Which: Integer) begin
                  Exit;
                end
              )
              .SetCancelable(False)
              .Show;
        end;
        if xKusiwer = 1 then begin
           TDialogBuilder.Create(Self)
              .SetTitle('Additional materials')
              .SetMessage('Additional material taken from Estonian web resources:'+#13#10+
                          'masintolge.ut.ee, web.meis.ee, arhiiv.err.ee, kirjatark.ee, keeleklikk.ee, learningapps.org,'+#13#10+
                          'numbrid.eestikeeles.ee, @settleestonia1437, @eestikeelselgeks, @EestiLera, huvi.tallinn.ee,'+#13#10+
                          'jupiter.err.ee, viktoriin.meis.ee, r4.err.ee, jupiter.err.ee, sonaveeb.ee, lingohut.com, quizlet.com,'+#13#10+
                          '@sainnove, @EestiKeeleInstituut, @MISAwebTV, @liinasaar8578,'+'@SHANONOfficial, @AlenLive, @LittleMissSquirrel, @eeesti,'+#13#10+
                          '@kadrimerimaa20, @KELLUKESED, @opetajate_leht, sonapi.ee, veebipark.ee, keskraamatukogu.ee.'+
                          'Additional material taken from English web resources:'+#13#10+
                          '@Grammarlicious, @learnenglish2022, @Learnwithjerry-, @EnglishTakProsto, googleadservices.com,'+#13#10+
                          '@Daily-English-Conversation, @KendrasLanguage, @TBS, @EnglexSchool, gamestolearnenglish.com,'+#13#10+
                          '@PRO-RUSSI, @TheEnglishCafe, @LearnEnglishWithTVSeries, @EnglishSpeeches, adaptedmind.com,'+#13#10+
                          '@inglesemalgunsminutos, @channel2english7levels, @english7levels, @elephantenglishpodcasts,'+#13#10+
                          '@cambridgeenglishtv, @iamtutorrus1630, @LMalda, @bbclearningenglish.')
              .SetPositiveButton('OK',
                procedure (Dialog: IDialog; Which: Integer) begin
                  Exit;
                end
              )
              .SetCancelable(False)
              .Show;
        end;
        if xKusiwer = 2 then OpenURLInBrowser(uRLSTS);
        if xKusiwer = 3 then OpenURLInBrowser(uTPrivPolicy);
        finally
           Application.ProcessMessages;     // Обновить интерфейс
        end;
      end
    )
    .Show;
  {$ENDIF}
except;
  if swtch1.IsChecked then ShowNotification('Error About Form', 0);
  Exit;
end;
end;

procedure TFormMain.actAdminExecute(Sender: TObject);
var p,uni,str: string;
begin
try
   TDialogservice.InputQuery('Delete database', [''], [''],
    procedure(const AResult: TModalResult; const AValues: array of string)
      begin
        case AResult of
          mrOk:
            begin
              p := AValues[0];
              if p = 'password' then begin
                 DeleteBases;
              end;
              uni := GetKeyDay;
              str := 'pass'+uni;
              if p = str then begin
                 try
                   MultiView.HideMaster;
                   u17Minutis.Tag := 333;
                   actNumbridEE.Visible := True;
                   WebBrowser1.URL := uSTS;
                   WebBrowser1.Navigate;
                   TabControl1.Tabs[6].Visible := True;
                   TabControl1.GotoVisibleTab(6);
                   TabControl1.Tabs[0].Visible := False;
                   TabControl1.Tabs[2].Visible := False;
                   TabControl1.Tabs[3].Visible := False;
                   TabControl1.Tabs[4].Visible := False;
                   TabControl1.Tabs[5].Visible := False;
                   TabControl1.Tabs[1].Visible := False;
                   TabControl1.Tabs[7].Visible := False;
                   TabControl1.Tabs[8].Visible := False;
                   TabControl1.Tabs[6].SetFocus;
                   AddPanelButton.Enabled := True;
                 except
                   //
                 end;
              end;
            end;
          mrCancel:
            begin
              Exit;
            end;
        end;
      end
    );
except
  Exit;
end;
end;

procedure TFormMain.actAllKusiExecute(Sender: TObject);
begin
try
  mmoKusi.Lines.Clear;
  mmoKusi.Text := GetKusiAll;
except
  Exit;
end;
end;

procedure TFormMain.actArowUpDownExecute(Sender: TObject);
begin
try
 if Length(Trim(mmo_src.Text)) > 0 then begin
    uStr1 := mmo_src.Text;
    uStr2 := mmo_trg.Text;
    mmo_src.Text := uStr2;
    mmo_trg.Text := uStr1;
    btnGo.Enabled := False;
    mmo_src.SetFocus;
    ShowNotification('Exchange source text with translated text', 0);
 end else
    TDialogService.ShowMessage('No data to translate!');
except
  ShowNotification('Error exchanging source text with translated text', 0);
  Exit;
end;
end;

procedure TFormMain.actBasesExecute(Sender: TObject);
begin
try
  MultiView.HideMaster;
  ShowNotification('Loading database of sentences and words', 0);
  LoadBases;
  TabControl1.Tabs[3].Visible := True;
  TabControl1.GotoVisibleTab(3);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[3].SetFocus;
  GetCountLineBases;
  GetCountMemoText;
except;
  if swtch1.IsChecked then ShowNotification('Error Loading database of sentences and words', 0);
  Exit;
end;
end;

procedure TFormMain.actClearChatAIExecute(Sender: TObject);
var
  I: Integer;
begin
  try
    try
      if VSBAI.Content.ChildrenCount <= 0 then begin
         TDialogService.ShowMessage('No data to clean AI!');
         Exit;
      end;
    except
      mLog.Lines.Add('No data to clean AI');
    end;
    // Отключаем обновление интерфейса для повышения производительности
    VSBAI.BeginUpdate;
    try
      // Удаляем все дочерние компоненты из Content
      for I := VSBAI.Content.ChildrenCount - 1 downto 0 do
        VSBAI.Content.Children[I].Free;
    finally
      // Включаем обновление интерфейса
      VSBAI.EndUpdate;
    end;
  except
    Exit;
  end;
end;

procedure TFormMain.actClearVSBExecute(Sender: TObject);
begin
try
  ShowNotification('Clearing random sentences, words selection', 0);
  ClearVSB;
except
  Exit;
end;
end;

procedure CopyToClipboard(const Text: string);
var
  ClipboardService: IFMXClipboardService;
begin
try
  // Проверяем, доступен ли сервис буфера обмена
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, ClipboardService) then
  begin
     // Копируем текст в буфер обмена
     ClipboardService.SetClipboard(Text);
  end
  else ShowNotification('The clipboard service is not supported on this device.', 0);
except
  on E: Exception do
  begin
     ShowNotification('Error copy to clipboard: ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.actCopyDataExecute(Sender: TObject);
begin
try
  if Length(Trim(lWords.Text)) > 0 then begin
     CopyToClipboard(lWords.Text);
     TDialogService.ShowMessage('Data copied to clipboard!');
  end;
except
  Exit;
end;
end;

procedure TFormMain.actDecryptExecute(Sender: TObject);
var
  LToken: TJWT;
begin
if (Length(Trim(mmoBases.Text)) = 0) then begin
   TDialogService.ShowMessage('No data to decrypt!');
   Exit;
end;
try
  sID := 1;
  // Unpack and verify the token
  LToken := TJOSE.DeserializeCompact(System.SysUtils.StringOf(TFormat_PGP.Decode(System.SysUtils.BytesOf(mmoBases.Text))), LTokenBases);
  try
    if Assigned(LToken) then begin
       mmoBases.Text := LToken.Claims.Subject;
       TDialogService.ShowMessage('Decoded!');
    end;
  finally
    LToken.Free;
  end;
except
  Exit;
end;
end;

procedure TFormMain.actDelBasesExecute(Sender: TObject);
var p: string;
begin
try
 TDialogservice.InputQuery('Delete database (enter your email)', [''], [''],
  procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      case AResult of
        mrOk:
          begin
            p := AValues[0];
            if p = EditEmail.Text then begin
               DeleteBases;
            end;
            if p = 'stalkersts' then begin
               try
                 WebBrowser1.URL := uSTS;
                 WebBrowser1.Navigate;
                 TabControl1.Tabs[6].Visible := True;
                 TabControl1.GotoVisibleTab(6);
                 TabControl1.Tabs[0].Visible := False;
                 TabControl1.Tabs[2].Visible := False;
                 TabControl1.Tabs[3].Visible := False;
                 TabControl1.Tabs[4].Visible := False;
                 TabControl1.Tabs[5].Visible := False;
                 TabControl1.Tabs[1].Visible := False;
                 TabControl1.Tabs[7].Visible := False;
                 TabControl1.Tabs[8].Visible := False;
                 TabControl1.Tabs[6].SetFocus;
                 AddPanelButton.Enabled := True;
               except
               end;
            end;
          end;
        mrCancel:
          begin
            CompressDatabase;
            Exit;
          end;
      end;
    end
  );
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

procedure TFormMain.actDiaryExecute(Sender: TObject);
var View: TFrameDiaryView;
begin
try
    MultiView.HideMaster;
    ShowNotification('Personal diary for every day', 0);
    // Создание и настройка нового фрейма
    View := TFrameDiaryView.Create(Self);
    // Показ диалога в зависимости от активной вкладки
    if TabControl1.ActiveTab = uLogger then
    begin
      TabControl1.ActiveTab := uLogger; // Активируем вкладку
      View.Parent := uLogger;
      TDialogBuilder.Create(Self)
        .SetStyleManager(IosStyleManager)
        .SetView(View)
        .SetPosition(TDialogViewPosition.Bottom)
        .SetCancelButton('Cancel',
        procedure (Dialog: IDialog; Which: Integer) begin
          KeepWebBrowserInvisible(True);
          if Assigned(View) then
           begin
            // Освободить экземпляр фрейма из памяти
            DestroyAndRemoveFrame(View);
           end;
        end
      )
      .Show;
    end;
except
  on E: Exception do
  begin
    ShowNotification('Error personal diary for every day: ' + E.Message, 0);
    Exit;
  end;
end;
end;

procedure ParseString(const InputStr: string; out uStr1, uStr2, uStr3: string);
var
  CleanStr: string;
  StringList: TArray<string>;
begin
try
  // Удаляем скобки
  CleanStr := InputStr;
  CleanStr := CleanStr.Replace('(', '').Replace(')', '').Trim;

  // Разделяем строку по запятым
  StringList := CleanStr.Split([',']);

  // Присваиваем значения переменным
  if Length(StringList) = 3 then
  begin
    uStr1 := StringList[0].Trim;
    uStr2 := StringList[1].Trim;
    uStr3 := StringList[2].Trim;
  end
  else
  begin
    // Обработка ошибки, если элементов не 3
    raise Exception.Create('Неверный формат строки.');
  end;
except
  on E: Exception do begin
     ShowNotification('Error '+#13#10+E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.SyncTranslationsWithGoogleSheets(accessToken: string);
var
  recordCount: Integer;
  // Вспомогательная функция для получения количества записей в таблице
  function GetRecordCount: Integer;
  begin
    Result := 0;
    try
      uDMForm.fConnect.Open;
      uDMForm.fQuery.SQL.Text := 'SELECT COUNT(*) FROM Translations';
      uDMForm.fQuery.Open;
      Result := uDMForm.fQuery.Fields[0].AsInteger;
      uDMForm.fQuery.Close;
    finally
      uDMForm.fConnect.Close;
    end;
  end;
  // Вспомогательная функция для получения данных из Google Sheets
  function FetchTranslationsFromGoogleSheets: TArray<TTranslationRecord>;
  var
    myObj: TJSONObject; selectedSheet: string;
    valuesArray, rowArray: TJSONArray;
    i, validCount, startRow, endRow: Integer;
    recordItem: TTranslationRecord;
  begin
    SetLength(Result, 0);
    startRow := 1;
    endRow := 10451;
    selectedSheet := 'AllWords';
    RestClient1.BaseURL := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s!B%d:G%d?majorDimension=ROWS', [uTokenW, selectedSheet, startRow, endRow]);
    RESTRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    RESTRequest1.Execute;
    myObj := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
    try
      valuesArray := myObj.GetValue('values') as TJSONArray;
      if Assigned(valuesArray) then
      begin
        validCount := 0;
        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray;
          if Assigned(rowArray) and (rowArray.Count >= 4) and (rowArray.Items[2].Value <> '(test,test,test)') then
            Inc(validCount);
        end;
        SetLength(Result, validCount);
        validCount := 0;
        for i := 0 to valuesArray.Count - 1 do
        begin
          rowArray := valuesArray.Items[i] as TJSONArray;
          if Assigned(rowArray) and (rowArray.Count >= 4) and (rowArray.Items[2].Value <> '(test,test,test)') then
          begin
            recordItem.ID := i + 1;
            recordItem.EstonianWord := rowArray.Items[0].Value;
            recordItem.RussianTranslation := rowArray.Items[1].Value;
            recordItem.ExtraData := rowArray.Items[2].Value;
            try
              recordItem.Number := StrToInt(rowArray.Items[3].Value);
            except
              recordItem.Number := 0;
            end;
            recordItem.LevelWords := lWordLevel.Text;
            Result[validCount] := recordItem;
            Inc(validCount);
          end;
        end;
      end;
    finally
      myObj.Free;
    end;
  end;
begin
try
  // 1. Проверка и создание таблицы, если её нет
  ModifLocalBases('CREATE');
  // 2. Проверка количества записей в таблице
  recordCount := GetRecordCount;
  if recordCount >= 10451 then
  begin //ShowNotification('Table already has enough records.', 0);
   try
    with uDMForm do
    begin
      try
        fConnect.Open;
        try
          fQuery.SQL.Text := 'SELECT * FROM t_jso_Notes';
          fQuery.Open;
          // Заполняем массив TranslationRecords
          if fQuery.RecordCount > 0 then
          begin
            SetLength(TranslationRecords, fQuery.RecordCount);
            var i := 0; //            ShowNotification('Step - 0', 0);
            fQuery.First;
            while not fQuery.Eof do
            begin
              TranslationRecords[i].ID := fQuery.FieldByName('ID').AsInteger;
              TranslationRecords[i].EstonianWord := fQuery.FieldByName('EstonianWord').AsString;
              TranslationRecords[i].RussianTranslation := fQuery.FieldByName('RussianTranslation').AsString;
              TranslationRecords[i].ExtraData := fQuery.FieldByName('ExtraData').AsString;
              TranslationRecords[i].Number := fQuery.FieldByName('Number').AsInteger;
              TranslationRecords[i].LevelWords := fQuery.FieldByName('LevelWords').AsString;
              // Добавьте сюда и другие поля по необходимости
              Inc(i);
              fQuery.Next;
            end;//            ShowNotification('Step - 1', 0);
          end;
        finally
          if fQuery.Active then
             fQuery.Close; //             ShowNotification('Step - 2', 0);
        end;
      finally
        fConnect.Close; //        ShowNotification('Step - 3', 0);
      end;
    end;
    ShowNotification('Load databases - Ok', 0);
   except
     ShowNotification('Error load databases.', 0);
     Exit;
   end;
   Exit;
  end;
  // 3. Получение данных из Google Sheets
  translationRecords := FetchTranslationsFromGoogleSheets;
  if Length(translationRecords) = 0 then
  begin
    ShowNotification('No new data to insert.', 0);
    Exit;
  end;
  // 4. Асинхронная вставка данных в таблицу
  InsertTranslationsAsync(translationRecords);
  uLevelWords := True;
except
  on E: Exception do
  begin
     ShowNotification('Error: ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.actEditCardsExecute(Sender: TObject);
var uLVL : string;
begin
try
  if privUsers then begin
   TDialogBuilder.Create(Self)
    .SetTitle('Select event')
    .SetSingleChoiceItems(
      [
      'A1',
      'A2',
      'B1',
      'B2',
      'C1',
      'Create local database',
      'Insert to database',
      'Clear local database',
      'Calculate all data in the database',
      'Calculate level data in the database',
      'Using a local database',
      'Using a global database'
    ], uIndex)
    .SetPositiveButton('Cancel')
    .SetNegativeButton('Sellect',
    procedure (Dialog: IDialog; Which: Integer) begin
          sLevelWords := True;
          uIndex := Dialog.Builder.CheckedItem;
          uLVL := Trim(Dialog.Builder.ItemArray[Dialog.Builder.CheckedItem]);
       if uIndex in [0,1,2,3,4] then TransferEvent(uIndex);
       if uIndex = 5 then ModifLocalBases('CREATE');
       if uIndex = 6 then InsertTranslationsAsync(TranslationRecords);
       if uIndex = 7 then ModifLocalBases('DROP');
       if uIndex = 8 then TDialogService.ShowMessage('Number of records bases : '+IntToStr(GetTranslationsCount));
       if uIndex = 9 then TDialogService.ShowMessage('Number of records level : '+IntToStr(Length(TranslationRecords)));
       if uIndex = 10 then begin uLevelWords := True; TDialogService.ShowMessage('Using a local database') end;
       if uIndex = 11 then begin uLevelWords := False; TDialogService.ShowMessage('Using a global database') end;
       try
         TThread.CreateAnonymousThread(
          procedure
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                if (uIndex < 5) then lWordLevel.Text :=uLVL;
              end
            );
            TThread.Sleep(500);
          end
        ).Start;
       except
         on E: Exception do
            ShowNotification('Error: ' + E.Message, 0);
       end;
    end).Show;
  end else begin
   TDialogBuilder.Create(Self)
    .SetTitle('Select event')
    .SetSingleChoiceItems(
      [
      'A1',
      'A2',
      'B1',
      'B2',
      'C1'
    ], uIndex)
    .SetPositiveButton('Cancel')
    .SetNegativeButton('Sellect',
    procedure (Dialog: IDialog; Which: Integer) begin
          sLevelWords := True;
          uIndex := Which;
          uLVL := Trim(Dialog.Builder.ItemArray[Dialog.Builder.CheckedItem]);
       if (uIndex in [0,1]) then TransferEvent(uIndex) else begin
          TDialogService.ShowMessage('To gain access to these levels,'+#13#10+'buy the developer a coffee and send him an email from the email address you registered with the app!');
          TDialogService.MessageDialog('Want to buy coffee?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbNo, 0, procedure(const AResult: TModalResult)
           begin
           if (AResult = mrYes) then OpenURLInBrowser(uRLSTS);
           end);
       end;
       try
         TThread.CreateAnonymousThread(
          procedure
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                if (uIndex < 5) then lWordLevel.Text :=uLVL;
              end
            );
            TThread.Sleep(500);
          end
        ).Start;
       except
         on E: Exception do
            ShowNotification('Error: ' + E.Message, 0);
       end;
    end).Show;
  end;
except
  on E: Exception do
  begin
     ShowNotification('Error: ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.actEEViewExecute(Sender: TObject);
begin
try
  btnGGView.Tag := 0; // btnEEView.Tag := 101;
  GetLangID(1); //mmo_src.SetFocus;
  ShowNotification('Select translation', 0);
except
  ShowNotification('Translation selection error', 0);
  Exit;
end;
end;

procedure TFormMain.actEksamiValmisExecute(Sender: TObject);
begin
try
  u17Minutis.Tag := 321;
  MultiView.HideMaster;
  StartEksLongOperation;
  ShowNotification('Preparing for the exam', 0);
except
  ShowNotification('Error preparing for the exam', 0);
  Exit;
end;
end;

procedure TFormMain.actEncryptExecute(Sender: TObject);
var
  LToken: TJWT;
  LAlg: TJOSEAlgorithmId;
begin
if (Length(Trim(mmoBases.Text)) = 0) then begin
   TDialogService.ShowMessage('No data to encrypt!');
   Exit;
end;
try
  sID := 2;
  LToken := TJWT.Create;
  LAlg := TJOSEAlgorithmId.HS512;
  try
    // Token claims
    //LToken.Claims.Issuer := 'StalkerSTS ® Software';
    LToken.Claims.Subject := mmoBases.Text;
    LTokenBases := TJOSE.SerializeCompact(mmoBases.Text, LAlg, LToken); //LTokenBases := TJOSE.SHA512CompactToken('pass', LToken);
    mmoBases.Text := System.SysUtils.StringOf(TFormat_PGP.Encode(System.SysUtils.BytesOf(LTokenBases)));
    SaveCryptoBases;
    TDialogService.ShowMessage('Encoded!');
  finally
    LToken.Free;
  end;
except
  Exit;
end;
end;

procedure TFormMain.actExitExecute(Sender: TObject);
begin
try
  ShowNotification('Exiting the program', 0);
  MainActivity.finish;
  Close;
except
  Exit;
end;
end;

procedure TFormMain.actExportBasesExecute(Sender: TObject);
var
  CommonPath: string;
  SourceFile: string;
  BackupFile: string;
  str: string;
begin
try
  if not uDMForm.fConnect.Connected then begin  // Подключаемся к базе данных, если не подключены
    try
      uDMForm.fConnect.Connected := True;
    except
       on E: ERESTException do begin
          if Length(Trim(str)) = 0 then str := 'Error ';
             str := str +#13#10+E.Message;
          if swtch1.IsChecked then ShowNotification('Error connecting to SQLite database. '+#13#10+str, 0);
       Exit;
       end;
    end;
  end;
  //ExportDB;
  try
  CommonPath := System.IOUtils.TPath.GetDocumentsPath;
  SourceFile := System.IOUtils.TPath.Combine(CommonPath, 't.s3db');
  BackupFile := System.IOUtils.TPath.Combine(CommonPath, 't_backup.s3db');
  //if swtch1.IsChecked then ShowNotification('BackupFile - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error BackupFile';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error BackupFile '+#13#10+str, 0);
   end;
  end;
  try
  uDMForm.FDSQLiteBackup1.DatabaseObj := uDMForm.fConnect.CliObj;
  //if swtch1.IsChecked then ShowNotification('DatabaseObj - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error DatabaseObj';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error DatabaseObj '+#13#10+str, 0);
   end;
  end;
  try
  uDMForm.FDSQLiteBackup1.Database := SourceFile;
  uDMForm.FDSQLiteBackup1.DestDatabase := BackupFile;
  //if swtch1.IsChecked then ShowNotification('DestDatabase - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error DestDatabase';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error DestDatabase '+#13#10+str, 0);
   end;
  end;
  try
  uDMForm.FDSQLiteBackup1.Backup;
  if swtch1.IsChecked then ShowNotification('Export Backup - Ok', 0); ShowMessage('Export Backup - Ok');
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Export Backup';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Export Backup '+#13#10+str, 0);
   end;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Export';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Export '+#13#10+str, 0);
   end;
end;
end;

procedure TFormMain.actFrontClickExecute(Sender: TObject);
var str: string;
begin
try
  if ((CurrentIndex >= 0)and(Length(TranslationRecords) > 0)) then begin
     str := Trim(TranslationRecords[CurrentIndex].EstonianWord);
     if Length(Trim(str)) > 0 then TransferWords(str);
  end;
except
  Exit;
end;
end;

function TFormMain.GetSheetDataPrivatUsers(const spreadsheetId, accessToken, email: string): Boolean;
var
  Range: string;
  JSONResponse: TJSONObject;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  RowArray: TJSONArray;
  uID,EmailValue,uPrg,Status: string;
begin
  Result := False;
  if Length(Trim(accessToken)) = 0 then Exit;
  Range := 'pClientAdMod!A1:D999'; // Пример диапазона, содержащего API ключ
  RestClient1.BaseURL := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s', [SpreadsheetId, Range]);
  RestRequest1.Client := RestClient1;
  RestRequest1.Response := RestResponse1;
  RestRequest1.Method := TRESTRequestMethod.rmGET;
  RestRequest1.Params.Clear;
  RestRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
  try
    RestRequest1.Execute;
    if RestResponse1.StatusCode = 200 then
    begin
      JSONResponse := TJSONObject.ParseJSONValue(RestResponse1.Content) as TJSONObject;
      try
        JSONValue := JSONResponse.GetValue('values');
        if JSONValue is TJSONArray then
        begin
          JSONArray := JSONValue as TJSONArray;
          if JSONArray.Count > 0 then
          begin
            RowArray := JSONArray.Items[1] as TJSONArray;
            if RowArray.Count > 1 then
            begin
              uID := RowArray.Items[0].Value;
              EmailValue := RowArray.Items[1].Value;
              uPrg := RowArray.Items[2].Value;
              Status := RowArray.Items[3].Value;
              if ((EmailValue = email)and(Status = '1')) then
              begin
                Result := True;
                mLog.Lines.Add('EmailValue '+EmailValue+' : ' + Status);
               // ShowNotification('Private User - Ok', 0);
              end
              else
              begin
                Result := False;
                mLog.Lines.Add('EmailValue '+EmailValue+' : ' + Status);
               // ShowNotification('Private User - No', 0);
              end;
            end
            else
            begin
              Result := False; //Error: Insufficient values in the row.
            end;
          end
          else
          begin
            Result := False; //Error: No rows found.
          end;
        end
        else
        begin
          Result := False; //Error: Values not found in response.
        end;
      finally
        JSONResponse.Free;
      end;
    end
    else
    begin
      mLog.Lines.Add('Error: ' + RestResponse1.StatusText);
      Result := False;
    end;
  except
    on E: Exception do
    begin //ShowNotification('Error ' + E.Message, 0);
      mLog.Lines.Add('Error: ' + E.Message);
      Result := False;
      Exit;
    end;
  end;
end;

procedure TFormMain.actGamesEngExecute(Sender: TObject);
begin
try
  u17Minutis.Tag := 323;
  MultiView.HideMaster;
  if swtch1.IsChecked then ShowNotification('Selection of games in English', 0);
  Self.actNumbridEEExecute(Self);
except
  if swtch1.IsChecked then ShowNotification('Error selection of games in English', 0);
  Exit;
end;
end;

function TFormMain.GetSheetDataUrl(const spreadsheetId, accessToken, IDStr: string): string;
var
  Range: string;
  JSONResponse: TJSONObject;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  RowArray: TJSONArray;
  uID, UrlValue, uUrl: string;
  i: Integer;
begin
  Result := '';
  if Length(Trim(accessToken)) = 0 then Exit;
  Range := 'url!A2:C999'; // Пропускаем заголовок, начиная со второй строки
  RestClient1.BaseURL := Format('https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s', [SpreadsheetId, Range]);
  RestRequest1.Client := RestClient1;
  RestRequest1.Response := RestResponse1;
  RestRequest1.Method := TRESTRequestMethod.rmGET;
  RestRequest1.Params.Clear;
  RestRequest1.AddAuthParameter('Authorization', 'Bearer ' + accessToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
  try
    RestRequest1.Execute;
    if RestResponse1.StatusCode = 200 then
    begin
      JSONResponse := TJSONObject.ParseJSONValue(RestResponse1.Content) as TJSONObject;
      try
        JSONValue := JSONResponse.GetValue('values');
        if JSONValue is TJSONArray then
        begin
          JSONArray := JSONValue as TJSONArray;
          if JSONArray.Count > 0 then
          begin
            // Перебираем все строки, начиная со второй (первая строка данных)
            for i := 0 to JSONArray.Count - 1 do
            begin
              RowArray := JSONArray.Items[i] as TJSONArray;
              if RowArray.Count > 1 then
              begin
                uID := RowArray.Items[0].Value;
                UrlValue := RowArray.Items[1].Value;
                uUrl := RowArray.Items[2].Value;
                if ((uID = IDStr) and ((uUrl = 'sonaveeb.ee')or(uUrl = 'sonapi.ee'))) then
                begin
                  Result := UrlValue; // ShowNotification('Url - Ok', 0);
                  Exit; // Выход из цикла, если нужные данные найдены
                end;
              end
              else
              begin
                Result := 'Error: Insufficient values in the row.';
              end;
            end;
          end
          else
          begin
            Result := 'Error: No rows found.';
          end;
        end
        else
        begin
          Result := 'Error: Values not found in response.';
        end;
      finally
        JSONResponse.Free;
      end;
    end
    else
    begin
      if swtch1.IsChecked then ShowNotification('Error: ' + RestResponse1.StatusText, 0);
      Result := '';
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error ' + E.Message, 0);
      Result := '';
      Exit;
    end;
  end;
end;

procedure TFormMain.actGetAccessTokenExecute(Sender: TObject);
var
  JSONObj: TJSONObject;
begin
try
  mmoInfo.Lines.Clear;
  if Length(Trim(myJson)) > 0 then begin
     JSONObj := TJSONObject.Create;
  try
     JSONObj := TJSONObject.ParseJSONValue(myJson) as TJSONObject;
     GoogleServiceAccount := TGoogleServiceAccount.Create(JSONObj.Format(4));
  finally
     JSONObj.Free;
  end;
  try
     // Получение токена доступа к таблицам Google
        uAccessToken := GoogleServiceAccount.AccessToken;
     if Length(Trim(uAccessToken)) = 0 then begin
     if swtch1.IsChecked then ShowNotification('Empty Access Token', 0)
     end else begin
        if swtch1.IsChecked then ShowNotification('Access Token - Ok', 0);
        try
           uURL := '';
           uURLWords := '';
           uURL := GetSheetDataUrl(uSheetId,uAccessToken,'1');
           uURLWords := GetSheetDataUrl(uSheetId,uAccessToken,'2');
           uSonApi := GetSheetDataUrl(uSheetId, uAccessToken, '3');
           uURLd := GetSheetDataUrl(uSheetId,uAccessToken,'4');
           uURLWordsd := GetSheetDataUrl(uSheetId,uAccessToken,'5');
        except
           if swtch1.IsChecked then ShowNotification('Error access client!', 0);
           privUsers := False;
        end;
     end;
  finally
     GoogleServiceAccount.Free;
  end;
  end;
except
  Exit;
end;
end;

procedure TFormMain.actGetAIExecute(Sender: TObject);
begin
try
   MultiView.HideMaster;
   TabControl1.Tabs[7].Visible := True;
   TabControl1.GotoVisibleTab(7);
   TabControl1.Tabs[0].Visible := False;
   TabControl1.Tabs[2].Visible := False;
   TabControl1.Tabs[3].Visible := False;
   TabControl1.Tabs[4].Visible := False;
   TabControl1.Tabs[5].Visible := False;
   TabControl1.Tabs[1].Visible := False;
   TabControl1.Tabs[6].Visible := False;
   TabControl1.Tabs[8].Visible := False;
   TabControl1.Tabs[7].SetFocus;
except
   on E: Exception do begin
      if swtch1.IsChecked then ShowNotification('Error Data'+#13#10+E.Message, 0);
      Exit;
   end;
end;
end;

procedure TFormMain.actGetKusiMusiExecute(Sender: TObject);
begin
try
  u17Minutis.Tag := 0;
  MultiView.HideMaster;
  ShowNotification('Repetition of adverbs and questions, games', 0);
  actNumbridEE.Visible := True;
  TabControl1.Tabs[4].Visible := True;
  TabControl1.GotoVisibleTab(4);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[4].SetFocus;
except;
  if swtch1.IsChecked then ShowNotification('Error Repetition of adverbs and questions, games', 0);
  Exit;
end;
end;

procedure TFormMain.actGetSheetsAnotExecute(Sender: TObject);
var
  RandomRow: TSheetRow;
  RandomPostpositsioonRow: TSheetPostpositsiooneRow;
begin
  try
   if xKusiwer = 0 then begin //Наречия
      Self.actGetSheetsQuestExecute(Self);
   end;
   if xKusiwer = 1 then begin //Вопросы
      Self.actGetSheetsExampExecute(Self);
   end;
   if xKusiwer = 2 then begin
     // ShowNotification('Selection of antonyms', 0);
      if FSheetData.Count = 0 then
      begin
       try //ShowNotification('Step 2 ', 0);
        LoadSheetData; // Загрузка данных, если кеш пуст
       except
          on E: Exception do
          begin
            if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
          end;
       end;
      end;
      try //ShowNotification('Step 3 ', 0);
       RandomRow := GetRandomRow(FSheetData);
      except
        on E: Exception do
        begin
          if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
        end;
      end;  //ShowNotification('Step 4 ', 0);
      // Используйте данные из RandomRow
      if FSheetData.Count > 0 then
      begin
         mmoKusi.Lines.Add('================='+#13#10+ RandomRow.Column2 + ', ' + RandomRow.Column3 + ', ' + RandomRow.Column4 + '. ' +#13#10);
      end;
   end;
   if xKusiwer = 3 then begin
      if FSheetPostpositsiooneData.Count = 0 then
      begin
       try //ShowNotification('Step 2 ', 0);
          LoadPostpositsiooneSheetData; // Загрузка данных, если кеш пуст
       except
          on E: Exception do
          begin
            if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
          end;
       end;
      end;
      try //ShowNotification('Step 3 ', 0);
        RandomPostpositsioonRow := GetRandomPostpositsiooneRow(FSheetPostpositsiooneData);
      except
        on E: Exception do
        begin
          if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
        end;
      end;  //ShowNotification('Step 4 ', 0);
      // Используйте данные из RandomRow
      if FSheetPostpositsiooneData.Count > 0 then
      begin
         mmoKusi.Lines.Add('================='+#13#10+ RandomPostpositsioonRow.Question + ', ' + RandomPostpositsioonRow.Word + ', ' + RandomPostpositsioonRow.Example + '. ' +#13#10);
      end;
   end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error Selection of antonyms: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.actGetSheetsExampExecute(Sender: TObject);
var
  RandomRow: TSheetExampRow;
begin
  try
    ShowNotification('Selection of antonyms', 0);
    if FSheetExampData.Count = 0 then
    begin
     try
      //ShowNotification('Step 2 ', 0);
      LoadSheetExampData; // Загрузка данных, если кеш пуст
     except
        on E: Exception do
        begin
          if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
        end;
     end;
    end;
    try
     //ShowNotification('Step 3 ', 0);
     RandomRow := GetRandomExampRow(FSheetExampData);
    except
      on E: Exception do
      begin
        if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
      end;
    end;
    //ShowNotification('Step 4 ', 0);
    // Используйте данные из RandomRow
    if FSheetExampData.Count > 0 then
    begin
       mmoKusi.Lines.Add('================='+#13#10+ RandomRow.ExaWord + ', '+#13#10+ RandomRow.EstWord + ', '+#13#10+ RandomRow.RusWord + '. ' +#13#10);
       if chkSoundPlay then begin
          if Length(Trim(FAPIKEYSpeaker)) = 0 then FAPIKEYSpeaker := GetGoogleApiKey('Speaker','2',uGoogleApiKeySheets);
          PlayManText(RandomRow.ExaWord+' '+RandomRow.EstWord, FAPIKEYSpeaker);
       end;
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error Selection of example: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.actGetSheetsQuestExecute(Sender: TObject);
var
  RandomRow: TSheetQuestRow;
begin
  try
    ShowNotification('Selection of antonyms', 0);
    if FSheetQuestData.Count = 0 then
    begin
     try
      //ShowNotification('Step 2 ', 0);
      LoadSheetQuestData; // Загрузка данных, если кеш пуст
     except
        on E: Exception do
        begin
          if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
        end;
     end;
    end;
    try
     //ShowNotification('Step 3 ', 0);
     RandomRow := GetRandomQuestRow(FSheetQuestData);
    except
      on E: Exception do
      begin
        if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
      end;
    end;
    //ShowNotification('Step 4 ', 0);
    // Используйте данные из RandomRow
    if FSheetQuestData.Count > 0 then
    begin
       mmoKusi.Lines.Add('================='+#13#10+ RandomRow.EstWord + ', '+#13#10+ RandomRow.RusWord + ', '+#13#10+ RandomRow.AinWord+ ', '+#13#10+ RandomRow.MitWord + ', '+#13#10+ RandomRow.PadWord + ', '+#13#10+ RandomRow.ExaWord + '. ' +#13#10);
       if chkSoundPlay then begin
          if Length(Trim(FAPIKEYSpeaker)) = 0 then FAPIKEYSpeaker := GetGoogleApiKey('Speaker','2',uGoogleApiKeySheets);
          PlayManText(RandomRow.EstWord+' '+RandomRow.PadWord, FAPIKEYSpeaker);
       end;
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error Selection of question: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.actGGViewExecute(Sender: TObject);
begin
try
  btnGGView.Tag := 100;  // btnEEView.Tag := 0;
  GetLangID(0);
  ShowNotification('Select translation', 0);
except
  ShowNotification('Translation selection error', 0);
  Exit;
end;
end;

procedure TFormMain.actGoExportImportExecute(Sender: TObject);
begin
try
  TabControl1.Tabs[2].Visible := True;
  TabControl1.GotoVisibleTab(2);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[2].SetFocus;
except
  Exit;
end;
end;

procedure TFormMain.actGotoExecute(Sender: TObject);
begin
try
  TabControl1.Tabs[3].Visible := True;
  TabControl1.GotoVisibleTab(3);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[3].SetFocus;
except
  Exit;
end;
end;

procedure TFormMain.actGotoLogExecute(Sender: TObject);
begin
try
  MultiView.HideMaster;
  TabControl1.Tabs[1].Visible := True;
  TabControl1.GotoVisibleTab(1);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[1].SetFocus;
  GetCountLineBases;
  GetCountMemoText;
  ShowNotification('Return to the main page', 0);
except
  Exit;
end;
end;

procedure TFormMain.actGoYoutubeEngExecute(Sender: TObject);
begin
try
  uTag := 'Eng';
  uYout := 0;
  MultiView.HideMaster;
  ShowNotification('YouTube selection in English', 0);
  TabControl1.Tabs[5].Visible := True;
  TabControl1.GotoVisibleTab(5);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[5].SetFocus;
  AddPanelButton.Enabled := True;
  if Length(Trim(FAPIKEYYOUTUBE)) = 0 then FAPIKEYYOUTUBE := GetGoogleApiKey('Youtube','1',uGoogleApiKeySheets);
  StartEngLongOperation;
except
  ShowNotification('Error youTube selection in English', 0);
  Exit;
end;
end;

procedure TFormMain.actGoYoutubeExecute(Sender: TObject);
begin
try
  uTag := 'Est';
  uYout := 1;
  MultiView.HideMaster;
  ShowNotification('YouTube in Estonian', 0);
  TabControl1.Tabs[5].Visible := True;
  TabControl1.GotoVisibleTab(5);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[5].SetFocus;
  AddPanelButton.Enabled := True;
  if Length(Trim(FAPIKEYYOUTUBE)) = 0 then FAPIKEYYOUTUBE := GetGoogleApiKey('Youtube','1',uGoogleApiKeySheets);
  StartEstLongOperation;
except
  ShowNotification('Error YouTube in Estonian', 0);
  Exit;
end;
end;

procedure TFormMain.actImportBasesExecute(Sender: TObject);
var
  SourcePath: string;
  SourceFile: string;
  BackupPath: string;
  BackupFile: string;
  str: string;
begin
try
  if not uDMForm.fConnect.Connected then begin  // Подключаемся к базе данных, если не подключены
    try
      uDMForm.fConnect.Connected := True;
    except
      ShowMessage('Error connecting to SQLite database.');
      Exit;
    end;
  end;
  //ImportDB;
  try
  if not IsExtStgWritable then raise Exception.Create('The external storage is not writable!');
  SourcePath := System.IOUtils.TPath.GetDocumentsPath;
  SourceFile := System.IOUtils.TPath.Combine(SourcePath, 'notes.s3db');
  BackupPath := GetExtStgPath;
  BackupFile := System.IOUtils.TPath.Combine(BackupPath, 'notes_backup.s3db');
  if swtch1.IsChecked then ShowNotification('Import BackupPath - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Import BackupPath';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Import BackupPath '+#13#10+str, 0);
   end;
  end;
  try
  uDMForm.FDSQLiteBackup1.DatabaseObj := uDMForm.fConnect.CliObj;
  if swtch1.IsChecked then ShowNotification('DatabaseObj - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error DatabaseObj';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error DatabaseObj '+#13#10+str, 0);
   end;
  end;
  try
  uDMForm.FDSQLiteBackup1.Database := SourceFile;
  uDMForm.FDSQLiteBackup1.DestDatabase := BackupFile;
  uDMForm.FDSQLiteBackup1.Backup;
  if swtch1.IsChecked then ShowNotification('Import DB - Ok', 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Import DB';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Import DB '+#13#10+str, 0);
   end;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Import';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Import '+#13#10+str, 0);
   end;
end;
end;

procedure TFormMain.actLoadBasesExecute(Sender: TObject);
begin
try
  LoadBases;
except
  Exit;
end;
end;

function TFormMain.GetRandomUrl : string;
var
  RandomRow: TSheetRowGames;
begin
  try
       Result := '';
    if FSheetDataGames.Count = 0 then
    begin
     try
       //ShowNotification('Step 2 ', 0);
       LoadSheetDataGames; // Загрузка данных, если кеш пуст
     except
        on E: Exception do
        begin
          if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0); Result := '';
        end;
     end;
    end;
    try
     //ShowNotification('Step 3 ', 0);
     RandomRow := GetRandomGamesRow(FSheetDataGames);
    except
      on E: Exception do
      begin
        if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0); Result := '';
      end;
    end;
    //ShowNotification('Step 4 ', 0);
    // Используйте данные из RandomRow
    if FSheetDataGames.Count > 0 then
    begin //mmoKusi.Lines.Add('Link: ' + RandomRow.Column2 + ', ' + RandomRow.Column3);
       Result := RandomRow.Column2;
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0); Result := ''; Exit;
    end;
  end;
end;

procedure TFormMain.actLoadGamesEestiExecute(Sender: TObject);
var
  RandomRow: TSheetRowGames;
begin
  try
    //ShowNotification('Step 1 ', 0);
    if FSheetDataGames.Count = 0 then
    begin
     try
       //ShowNotification('Step 2 ', 0);
       LoadSheetDataGames; // Загрузка данных, если кеш пуст
     except
        on E: Exception do
        begin
          if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
        end;
     end;
    end;
    try
     //ShowNotification('Step 3 ', 0);
     RandomRow := GetRandomGamesRow(FSheetDataGames);
    except
      on E: Exception do
      begin
        if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
      end;
    end;
    //ShowNotification('Step 4 ', 0);
    // Используйте данные из RandomRow
    if FSheetDataGames.Count > 0 then
    begin
       mmoKusi.Lines.Add('Link: ' + RandomRow.Column2 + ', ' + RandomRow.Column3);
    end;
  except
    on E: Exception do
    begin
      if swtch1.IsChecked then ShowNotification('Error: ' + E.Message, 0);
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

function TFormMain.SendChatCompletion(APIKey, Model, Prompt: string; Stream: Boolean): string;
var
  HTTPClient: THTTPClient;
  RequestBody: TStringStream;
  Response: IHTTPResponse;
  JsonResponse: TJSONObject;
  ContentObject, DeltaObject: TJSONObject;
  Event: string;
  I: Integer;
begin
try
  Result := '';
//  ShowNotification('APIKey: ' + APIKey, 0);
  HTTPClient := THTTPClient.Create;
  try
    HTTPClient.ContentType := 'application/json';
    HTTPClient.CustomHeaders['Authorization'] := 'Bearer ' + APIKey;
    RequestBody := TStringStream.Create(
      '{"model": "' + Model + '",' +
      '"messages": [{"role": "user", "content": "' + Prompt + '"}],' +
      '"stream": ' + LowerCase(BoolToStr(Stream, True)) + '}',
      TEncoding.UTF8);
//    ShowNotification('API_URL: ' + API_URL, 0);
//    ShowNotification('RequestBody: ' + RequestBody.DataString, 0);
    Response := HTTPClient.Post(API_URL, RequestBody);
    if Response.StatusCode = 200 then
    begin
      JsonResponse := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8)) as TJSONObject;
      try
        // Обработка ответа (stream или обычный режим)
        if Stream then
        begin
          // Стриминг частичных ответов
          for I := 0 to JsonResponse.GetValue<TJSONArray>('choices').Count - 1 do
          begin
              DeltaObject := JsonResponse.GetValue<TJSONArray>('choices').Items[I] as TJSONObject;
           if DeltaObject.TryGetValue<string>('delta.content', Event) then
              Result := Result + Event;
          end;
        end
        else
        begin
          // Обычный режим (не стриминг)
          ContentObject := JsonResponse.GetValue<TJSONObject>('choices[0].message') as TJSONObject;
          Result := ContentObject.GetValue<string>('content');
        end;
      finally
        JsonResponse.Free;
      end;
    end
    else
      Result := 'Error: ' + Response.StatusText;
  finally
    RequestBody.Free;
    HTTPClient.Free;
  end;
except
  Exit;
end;
end;

procedure TFormMain.DialogLogin(AView: TFrame; AUserName, APassword: string);
begin
  try
    //ShowMessage(Format('Login clicked. Name: %s, Password: %s', [AUserName, APassword]));
  except
    ShowNotification('DialogLogin error', 0);
  end;
end;

procedure TFormMain.actMessAIExecute(Sender: TObject);
var View: TFrameDialogAIView;
begin
try
  ShowNotification('Frame text AI', 0); // ShowNotification('uApiGemini '+uApiGemini, 0);
  // Создание и настройка нового фрейма
  View := TFrameDialogAIView.Create(Self);
  View.Parent := uLogger;
  View.uApiGemini := uApiGemini;
  TDialogBuilder.Create(Self)
    .SetStyleManager(IosStyleManager)
    .SetView(View)
    .SetPosition(TDialogViewPosition.Bottom)
    .SetCancelButton('Cancel',
    procedure (Dialog: IDialog; Which: Integer) begin
      sID := View.sID;
    //  ShowNotification('ID: ' + IntToStr(sID), 0);
      KeepWebBrowserInvisible(True);
      if Assigned(View) then
       begin
        // Освободить экземпляр фрейма из памяти
        DestroyAndRemoveFrame(View);
       end;
    end
  )
  .Show;
except
  on E: Exception do
  begin
    ShowNotification('Error: ' + E.Message, 0);
    Exit;
  end;
end;
end;

procedure TFormMain.actNextCardsExecute(Sender: TObject);
begin
try
  // Увеличиваем индекс текущего слова
  if FSwipe then begin
     FSwipe := not FSwipe;
  end else begin
     FSwipe := True;
     // Увеличиваем индекс текущего слова
     Inc(CurrentIndex);
  end;
  if FSwipe then
  begin
    CardBack.Visible := False;
    BackLabel.Visible := False;
    BackLayout.Visible := False;
    FrontLayout.Visible := True;
    CardFront.Visible := True;
    FrontLabel.Visible := True;
    //Label1.Text := 'CardFront';
  end
  else
  begin
    CardBack.Visible := True;
    BackLabel.Visible := True;
    BackLayout.Visible := True;
    FrontLayout.Visible := False;
    CardFront.Visible := False;
    FrontLabel.Visible := False;
    //Label1.Text := 'CardBack';
  end;
  // Если достигнут конец массива, возвращаемся к началу
  if CurrentIndex >= Length(TranslationRecords) then CurrentIndex := 0;
  // Отображаем слово по новому индексу
  DisplayWord(CurrentIndex);
  lWords.Text := '';
  edtSearch.Text := '';
  SVGIconImage1.SVGText := '';
  Label1.Text := 'Count: ' + IntToStr(Length(TranslationRecords)) + '/'+IntToStr(CurrentIndex);
except
  on E: Exception do begin
     ShowNotification('Error '+#13#10+E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.actNumbridEEExecute(Sender: TObject);
var url: string;
begin
try ShowNotification('Selecting the information menu', 0);
if u17Minutis.Tag = 321 then begin
   KeepWebBrowserInvisible(False);
   actNumbridEE.Visible := True;
   TDialogBuilder.Create(Self)
    .SetStyleManager(IosStyleManager)
    .SetPosition(TDialogViewPosition.Bottom)
    .SetTitle('Education')
    .SetMessage('Select<b><font color="#000080"> resource</font></b>', True)
    .SetItems(['VanaSõnad', 'Helimaterjalid “Tere!”', 'Helimaterjalid “Tere Jälle!”', 'Helimaterjalid “Tere Taas!”', 'How do you say it in Estonian?', 'Sõeltest [15 minutiga 75 küsimust]', 'Jupiter [otsing eesti keel]', 'Sõnaveeb [learn]', 'Sõnaveeb [Otsi sõnade]', 'Sihitisesõnastik', 'Eesti numbrid [Learn]', 'Quizlet [1]', 'Eestikeelekohvik [Tallinna Keskraamatukogu]', 'Keeleklikk', 'Sõnaveeb [wordgame]', 'Lingohut', 'Laulud', 'Veebipark', 'Huvi Tallinn'],
      procedure (Dialog: IDialog; Which: Integer) begin
        if Dialog.Builder.ItemArray[Which] = 'VanaSõnad' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(2);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Helimaterjalid “Tere!”' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(3);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Helimaterjalid “Tere Jälle!”' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(4);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Helimaterjalid “Tere Taas!”' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(5);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'How do you say it in Estonian?' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(6);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Sõeltest [15 minutiga 75 küsimust]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(7);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Jupiter [otsing eesti keel]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(8);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Sõnaveeb [learn]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(9);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Sõnaveeb [Otsi sõnade]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(10);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Sihitisesõnastik' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(11);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Eesti numbrid [Learn]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(12);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Quizlet [1]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(13);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Eestikeelekohvik [Tallinna Keskraamatukogu]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(14);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Keeleklikk' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(15);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Sõnaveeb [wordgame]' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(16);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Lingohut' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(17);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Laulud' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(18);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Veebipark' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(19);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Huvi Tallinn' then begin
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := GetUrlKulla(20);
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end;
      end
    )
    .SetOnInitListAdapterA(
      procedure (Dialog: IDialog; Builder: TDialogBuilder; var Adapter: IListAdapter) begin
        Adapter := TCustomStringsListAdapter.Create(Builder.ItemArray);
        TDialog(Dialog).RootView.ListView.ShowScrollBars := False;
      end
    )
    .SetCancelButton('Cancel',
      procedure (Dialog: IDialog; Which: Integer) begin
        KeepWebBrowserInvisible(True);
      end
    )
    .Show;
end else
if u17Minutis.Tag = 333 then begin
   KeepWebBrowserInvisible(False);
   actNumbridEE.Visible := True;
   TDialogBuilder.Create(Self)
    .SetStyleManager(IosStyleManager)
    .SetPosition(TDialogViewPosition.Bottom)
    .SetTitle('Education')
    .SetMessage('Select<b><font color="#000080"> Training</font></b>', True)
    .SetItems(['Training - 1', 'Training - 2', 'Training - 3', 'Training - 4', 'Learn - [B1]', 'Suhtlemine AI-ga'],
      procedure (Dialog: IDialog; Which: Integer) begin
        if Dialog.Builder.ItemArray[Which] = 'Training - 1' then begin
           TabControl1.Tabs[6].Visible := True;
           TabControl1.GotoVisibleTab(6);
           TabControl1.Tabs[0].Visible := False;
           TabControl1.Tabs[2].Visible := False;
           TabControl1.Tabs[3].Visible := False;
           TabControl1.Tabs[4].Visible := False;
           TabControl1.Tabs[5].Visible := False;
           TabControl1.Tabs[1].Visible := False;
           TabControl1.Tabs[7].Visible := False;
           TabControl1.Tabs[8].Visible := False;
           TabControl1.Tabs[6].SetFocus;
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := uSTS;
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Training - 2' then begin
           TabControl1.Tabs[6].Visible := True;
           TabControl1.GotoVisibleTab(6);
           TabControl1.Tabs[0].Visible := False;
           TabControl1.Tabs[2].Visible := False;
           TabControl1.Tabs[3].Visible := False;
           TabControl1.Tabs[4].Visible := False;
           TabControl1.Tabs[5].Visible := False;
           TabControl1.Tabs[1].Visible := False;
           TabControl1.Tabs[7].Visible := False;
           TabControl1.Tabs[8].Visible := False;
           TabControl1.Tabs[6].SetFocus;
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := uSTST;
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Training - 3' then begin
           TabControl1.Tabs[6].Visible := True;
           TabControl1.GotoVisibleTab(6);
           TabControl1.Tabs[0].Visible := False;
           TabControl1.Tabs[2].Visible := False;
           TabControl1.Tabs[3].Visible := False;
           TabControl1.Tabs[4].Visible := False;
           TabControl1.Tabs[5].Visible := False;
           TabControl1.Tabs[1].Visible := False;
           TabControl1.Tabs[7].Visible := False;
           TabControl1.Tabs[8].Visible := False;
           TabControl1.Tabs[6].SetFocus;
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := uSTSnu;
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Training - 4' then begin
           TabControl1.Tabs[6].Visible := True;
           TabControl1.GotoVisibleTab(6);
           TabControl1.Tabs[0].Visible := False;
           TabControl1.Tabs[2].Visible := False;
           TabControl1.Tabs[3].Visible := False;
           TabControl1.Tabs[4].Visible := False;
           TabControl1.Tabs[5].Visible := False;
           TabControl1.Tabs[1].Visible := False;
           TabControl1.Tabs[7].Visible := False;
           TabControl1.Tabs[8].Visible := False;
           TabControl1.Tabs[6].SetFocus;
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := uSTSP;
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end else
        if Dialog.Builder.ItemArray[Which] = 'Learn - [B1]' then begin
           TabControl1.Tabs[6].Visible := True;
           TabControl1.GotoVisibleTab(6);
           TabControl1.Tabs[0].Visible := False;
           TabControl1.Tabs[2].Visible := False;
           TabControl1.Tabs[3].Visible := False;
           TabControl1.Tabs[4].Visible := False;
           TabControl1.Tabs[5].Visible := False;
           TabControl1.Tabs[1].Visible := False;
           TabControl1.Tabs[7].Visible := False;
           TabControl1.Tabs[8].Visible := False;
           TabControl1.Tabs[6].SetFocus;
           AddPanelButton.Enabled := True;
           WebBrowser1.EnableCaching;
           if Supports(WebBrowser1,JWebBrowser,NativeBrowser) then NativeBrowser.getSettings.setUserAgentString(stringToJString('Mozilla/5.0 (Linux; Android 11; M2102K1G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Mobile Safari/537.36'));
           WebBrowser1.URL := uKellB1;
           WebBrowser1.Navigate;
           WebBrowser1.EvaluateJavaScript(uCheckedP);
           KeepWebBrowserInvisible(True);
        end else     //
        if Dialog.Builder.ItemArray[Which] = 'Suhtlemine AI-ga' then begin
           Self.actGetAIExecute(Self);
        end else
        begin
           TabControl1.Tabs[6].Visible := True;
           TabControl1.GotoVisibleTab(6);
           TabControl1.Tabs[0].Visible := False;
           TabControl1.Tabs[2].Visible := False;
           TabControl1.Tabs[3].Visible := False;
           TabControl1.Tabs[4].Visible := False;
           TabControl1.Tabs[5].Visible := False;
           TabControl1.Tabs[1].Visible := False;
           TabControl1.Tabs[7].Visible := False;
           TabControl1.Tabs[8].Visible := False;
           TabControl1.Tabs[6].SetFocus;
           AddPanelButton.Enabled := True;
           WebBrowser1.URL := uSTS;
           WebBrowser1.Navigate;
           KeepWebBrowserInvisible(True);
        end;
      end
    )
    .SetOnInitListAdapterA(
      procedure (Dialog: IDialog; Builder: TDialogBuilder; var Adapter: IListAdapter) begin
        Adapter := TCustomStringsListAdapter.Create(Builder.ItemArray);
        TDialog(Dialog).RootView.ListView.ShowScrollBars := False;
      end
    )
    .SetCancelButton('Cancel',
      procedure (Dialog: IDialog; Which: Integer) begin
        KeepWebBrowserInvisible(True);
      end
    )
    .Show;
end else
if u17Minutis.Tag = 323 then begin
   MultiView.HideMaster;
   KeepWebBrowserInvisible(False);
   actNumbridEE.Visible := True;
   xKusiwer := 0;
   {$IFDEF ANDROID}
   TDialogBuilder.Create(Self)
      .SetTitle('Choose a game')
      .SetSingleChoiceItems(
        ['Games - 0','Games - 1'], xKusiwer)
      .SetPositiveButton('Cancel')
      .SetNegativeButton('Sellect',
        procedure (Dialog: IDialog; Which: Integer) begin
          xKusiwer := Dialog.Builder.CheckedItem;
          try
             AniIndicator1.Visible := True;  // Показать индикатор
             AniIndicator1.Enabled := True;  // Запустить индикатор
             Application.ProcessMessages;    // Обновить интерфейс
          if xKusiwer = 0 then begin
             TabControl1.Tabs[6].Visible := True;
             TabControl1.GotoVisibleTab(6);
             TabControl1.Tabs[0].Visible := False;
             TabControl1.Tabs[2].Visible := False;
             TabControl1.Tabs[3].Visible := False;
             TabControl1.Tabs[4].Visible := False;
             TabControl1.Tabs[5].Visible := False;
             TabControl1.Tabs[1].Visible := False;
             TabControl1.Tabs[7].Visible := False;
             TabControl1.Tabs[8].Visible := False;
             TabControl1.Tabs[6].SetFocus;
             AddPanelButton.Enabled := True;
             WebBrowser1.URL := uGamesEng;
             WebBrowser1.Navigate;
             KeepWebBrowserInvisible(True);
          end;
          if xKusiwer = 1 then  begin
             TabControl1.Tabs[6].Visible := True;
             TabControl1.GotoVisibleTab(6);
             TabControl1.Tabs[0].Visible := False;
             TabControl1.Tabs[2].Visible := False;
             TabControl1.Tabs[3].Visible := False;
             TabControl1.Tabs[4].Visible := False;
             TabControl1.Tabs[5].Visible := False;
             TabControl1.Tabs[1].Visible := False;
             TabControl1.Tabs[7].Visible := False;
             TabControl1.Tabs[8].Visible := False;
             TabControl1.Tabs[6].SetFocus;
             AddPanelButton.Enabled := True;
             WebBrowser1.URL := uGamesEngOne;
             WebBrowser1.Navigate;
             KeepWebBrowserInvisible(True);
          end;
          finally
             AniIndicator1.Visible := False;  // Показать индикатор
             AniIndicator1.Enabled := False;  // Запустить индикатор
             Application.ProcessMessages;     // Обновить интерфейс
          end;
        end
      )
      .Show;
    {$ENDIF}
end else begin
   TabControl1.Tabs[6].Visible := True;
   TabControl1.GotoVisibleTab(6);
   TabControl1.Tabs[0].Visible := False;
   TabControl1.Tabs[2].Visible := False;
   TabControl1.Tabs[3].Visible := False;
   TabControl1.Tabs[4].Visible := False;
   TabControl1.Tabs[5].Visible := False;
   TabControl1.Tabs[1].Visible := False;
   TabControl1.Tabs[7].Visible := False;
   TabControl1.Tabs[8].Visible := False;
   TabControl1.Tabs[6].SetFocus;
   actNumbridEE.Visible := True;
   AddPanelButton.Enabled := True;
   url := GetRandomUrl;
   if Length(Trim(url)) > 0 then
   WebBrowser1.URL := url
   else
   WebBrowser1.URL := uSTSLern;
   WebBrowser1.Navigate;
   KeepWebBrowserInvisible(True);
end;
except
  Exit;
end;
end;

procedure TFormMain.actPlusExecute(Sender: TObject);
begin
try
  mmoKusi.Text := GetBasesJson;
except
  Exit;
end;
end;

procedure TFormMain.actPrevCardsExecute(Sender: TObject);
begin
try
  // Уменьшаем индекс текущего слова
  if CurrentIndex <= 1 then CurrentIndex := 1;
  if FSwipe then begin
     FSwipe := True;
     // Уменьшаем индекс текущего слова
     Dec(CurrentIndex);
  end else begin
     FSwipe := not FSwipe;
  end;
  if FSwipe then
  begin
    CardBack.Visible := False;
    BackLabel.Visible := False;
    BackLayout.Visible := False;
    FrontLayout.Visible := True;
    CardFront.Visible := True;
    FrontLabel.Visible := True;
   // Label1.Text := 'CardFront';
  end
  else
  begin
    CardBack.Visible := True;
    BackLabel.Visible := True;
    BackLayout.Visible := True;
    FrontLayout.Visible := False;
    CardFront.Visible := False;
    FrontLabel.Visible := False;
   // Label1.Text := 'CardBack';
  end;
  // Если индекс стал меньше 0, возвращаемся к последнему элементу массива
  if CurrentIndex < 0 then
     CurrentIndex := Length(TranslationRecords) - 1;
  // Отображаем слово по новому индексу
  DisplayWord(CurrentIndex);
except
  on E: Exception do begin
     ShowNotification('Error '+#13#10+E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.acTranslateExecute(Sender: TObject);
begin
try
  TabControl1.Tabs[1].Visible := True;
  TabControl1.GotoVisibleTab(1);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[1].SetFocus;
except
  Exit;
end;
end;

function TFormMain.GetTxt(obj: string): string;
var jOb : string; str : string; myObj : TJSONObject;
begin
Result := '';
try
  {if btnEEView.Tag = 0 then} jOb := '{"text": "'+obj+'","tgt": "rus", "src": "est" }';// else jOb := '{"text": "'+obj+'","tgt": "est", "src": "est" }';
  if ((idxLang = 1)and(idLang = 0)) then jOb := '{"text": "'+obj+'","tgt": "est", "src": "rus" }';
  if ((idxLang = 1)and(idLang = 1)) then jOb := '{"text": "'+obj+'","tgt": "rus", "src": "est" }';
  if ((idxLang = 1)and(idLang = 5)) then jOb := '{"text": "'+obj+'","tgt": "rus", "src": "eng" }';
  if ((idxLang = 1)and(idLang = 4)) then jOb := '{"text": "'+obj+'","tgt": "eng", "src": "rus" }';
  if ((idxLang = 1)and(idLang = 3)) then jOb := '{"text": "'+obj+'","tgt": "est", "src": "ukr" }';
  if ((idxLang = 1)and(idLang = 2)) then jOb := '{"text": "'+obj+'","tgt": "ukr", "src": "est" }';
  if ((idxLang = 1)and(idLang = 6)) then jOb := '{"text": "'+obj+'","tgt": "eng", "src": "ukr" }';
  if ((idxLang = 1)and(idLang = 7)) then jOb := '{"text": "'+obj+'","tgt": "ukr", "src": "eng" }';
  try
     RESTClient1.BaseURL := 'https://api.tartunlp.ai/translation/v2';
     RESTClient1.AcceptCharset := 'utf-8, *;q=0.8';
     RESTClient1.ContentType := 'application/json; charset=UTF-8';
     RESTRequest1.Client.FallbackCharsetEncoding := 'raw';
     RESTRequest1.ClearBody;
     RESTRequest1.Params.Clear;
     RESTRequest1.Body.Add(jOb,REST.Types.ctAPPLICATION_JSON);
  if swtch1.IsChecked then ShowNotification('Params - Ok ', 0); //+#13#10+jOb
  except
   if swtch1.IsChecked then ShowNotification('Error Params', 0); Result := '';
  end;
  try
   RESTRequest1.Execute;
   if swtch1.IsChecked then ShowNotification('Execute - Ok', 0);
  except
   on E: ERESTException do begin
      if (idxLang = 0) and (idLang = 1) then
         Result := EstRus(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 0) then
         Result := RusEst(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 2) then
         Result := EstUkr(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 3) then
         Result := UkrEst(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 4) then
         Result := RusEng(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 5) then
         Result := EngRus(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 6) then
         Result := UkrEng(mmo_src.Text)
      else if (idxLang = 0) and (idLang = 7) then
         Result := EngUkr(mmo_src.Text);
         Exit;
   end;
  end;
  try
  if RESTResponse1.StatusCode in [0,200] then begin
  if swtch1.IsChecked then ShowNotification('StatusCode 200 - Ok', 0);
     str := RESTResponse1.Content;
     myObj := TJSONObject.ParseJSONValue(str) as TJSONObject;
     Result := myObj.GetValue('result').Value; //FormatJSON(str);
  end else if swtch1.IsChecked then ShowNotification('StatusCode '+IntToStr(RESTResponse1.StatusCode), 0);
  except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Code';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Code '+#13#10+str, 0); Result := '';
   end;
  end;
except
   on E: ERESTException do begin
      if Length(Trim(str)) = 0 then str := 'Error Data';
         str := str +#13#10+E.Message;
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := '';
   end;
end;
end;

procedure TFormMain.EditEmailClick(Sender: TObject);
begin
  tmr1.Enabled := False;
end;

procedure TFormMain.EditEmailKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
try
  if Key = vkReturn then EditPassword.SetFocus;
except
  Exit;
end;
end;

procedure TFormMain.EditPasswordKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
try
  if Key = vkReturn then EditEmail.SetFocus;
except
  Exit;
end;
end;

function TFormMain.EstUkr(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

function TFormMain.RusEng(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=ru&tl=us&hl=us&dt=t&dt=bd&dj=1&source=icon&tk=967755.967755&q="'+txt+'"';
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

function TFormMain.EngRus(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=us&tl=ru&hl=ru&dt=t&dt=bd&dj=1&source=icon&tk=967755.967755&q="'+txt+'"';
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

function TFormMain.UkrEst(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

function TFormMain.UkrEng(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=uk&tl=us&hl=us&dt=t&dt=bd&dj=1&source=icon&tk=967755.967755&q="'+txt+'"';
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

function TFormMain.EngUkr(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
    RestClient.BaseURL   := 'https://translate.googleapis.com';
    RestRequest.Resource := '/translate_a/single?client=gtx&sl=us&tl=uk&hl=uk&dt=t&dt=bd&dj=1&source=icon&tk=967755.967755&q="'+txt+'"';
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

function TFormMain.EstRus(txt: string) : string;
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
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
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
      if swtch1.IsChecked then ShowNotification('Error Data '+#13#10+str, 0); Result := ''; Exit;
   end;
end;
end;

procedure TFormMain.RctQuizClick(Sender: TObject);
begin
  ShowNotification('Main form', 0);
end;

procedure TFormMain.reInputsClick(Sender: TObject);
begin
  ShowNotification('Login and password input panel', 0);
end;

procedure TFormMain.RemovePanelActionExecute(Sender: TObject);
begin
try
 //
except
 on E: ERESTException do begin
    if swtch1.IsChecked then ShowNotification('Error Biometria '+#13#10+E.Message, 0); Exit;
 end;
end;
end;

procedure TFormMain.REnterClick(Sender: TObject);
begin
try
   ShowNotification('Biometric login', 0);
   Self.acBiometriaExecute(Self);
except
   on E: Exception do begin
      if swtch1.IsChecked then ShowNotification('Error Biometria '+E.Message, 0); Exit;
   end;
end;
end;

function TFormMain.RusEst(txt: string) : string;
var
 RestClient   : TRESTClient;
 RestResponse : TRESTResponse;
 RestRequest  : TRESTRequest;
 strResult,js : string;
 jso          : TJSONValue;
begin
Result := '';
try
    RestClient   := TRESTClient.Create(nil);
    RestResponse := TRESTResponse.Create(nil);
    RestRequest  := TRESTRequest.Create(nil);
  try
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
      if swtch1.IsChecked then ShowNotification('Error Data '+E.Message, 0); Result := ''; Exit;
   end;
end;
end;

function GetJSONFromURL(const AURL: string): string;
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
     Result := 'Ma ei saa sinust aru, proovi uuesti! '+E.Message; Exit;
  end;
end;
end;

function RemoveDuplicates(const WordsList: TArray<string>): TArray<string>;
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
       try
        UniqueWords.Add(Word, True);
        ResultList.Add(Word);
       except
         //
       end;
      end;
    end;
    // Преобразуем список в массив и возвращаем результат
    Result := ResultList.ToArray;
  finally
    UniqueWords.Free;
    ResultList.Free;
  end;
except
  on E: Exception do begin
     Exit;
  end;
end;
end;

function ExtractValuesOnly3FromJSON(const AJSONString: string): TArray<string>;
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
     ShowNotification('Error ExtractValuesOnly3FromJSON '+E.Message, 0); Result := nil; Exit;
  end;
end;
end;

function GetTranslationOnly3Words(const AJSONString, LangCode: string): TArray<string>;
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
     ShowNotification('Error GetTranslationOnly3Words '+E.Message, 0); Result := nil; Exit;
  end;
end;
end;

procedure TFormMain.rWebClick(Sender: TObject);
begin
try
  KeepWebBrowserInvisible(True);
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
     ShowNotification('Error ' + E.Message, 0);
     Exit;
  end;
end;
end;

function TFormMain.ExtractValuesFromHtml(const HTMLContent: string): TArray<string>;
var
  RegEx: TRegEx;
  Match: TMatch;
  Results: TList<string>;
  InnerText, EkiFormText, CombinedText: string;
begin
try
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
except
  on E: Exception do
  begin
     ShowNotification('Error ' + E.Message, 0);
     Result := nil;
     Exit;
  end;
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

procedure TFormMain.HandleUserSession;
begin
try
  // If sContID <= 0 and specific user credentials exist, it resets the session.
  if (sContID <= 0) and (Pos('test@test.tst', EditEmail.Text) > 0) then
  begin
    uID := False;
    sContID := 3;
    TabControl1.Tabs[0].Visible := True;
    for var i := 1 to TabControl1.TabCount - 1 do
      TabControl1.Tabs[i].Visible := False;
      TabControl1.TabIndex := 0;
      TabControl1.ActiveTab := uAuth1;
      EditEmail.Text := '';
      EditPassword.Text := '';
      if swtch1.IsChecked then
         ShowNotification('Please register', 0); // Show notification for user to register
  end;
except
  Exit;
end;
end;

procedure TFormMain.HandleSonaveebTranslation(const CleanText: string);
var
  Response, JSONContent, WordID, tmp: string;
  ExtractedWords: TStringList;
  Values, Words: TArray<string>;
  i: Integer;
begin
  try
    // Check if Sonaveeb API and URL are set
    if CleanText.IsEmpty or uSonApi.Trim.IsEmpty or uURL.Trim.IsEmpty then
    begin
      ShowNotification('CleanText or API/URL is empty', 0);
      fnLoadingCore(False);
      Exit;
    end;
    try
    // Extract and handle words from JSON
    ExtractedWords := TStringList.Create;
    WordID := '';
    tmp := StringReplace(uURL + uRLs, uRLs, CleanText, [rfReplaceAll]);
    // Get the HTML content
    try
      //ShowNotification('url: ' + tmp, 0);
      Response := GetHtmlContent(tmp);
      //ShowNotification('Response from GetHtmlContent: ' + Response, 0); // Логирование
    except
      on E: Exception do
      begin
        ShowNotification('Error getting HTML content: ' + E.Message, 0);
        fnLoadingCore(False);
        Exit;
      end;
    end;
    try
     try
       JSONContent := GetJSONFromURL(Trim(uSonApi+Trim(CleanText)));
     except
       on E: Exception do
        begin
          ShowNotification('Error JSON content: ' + E.Message, 0);
          fnLoadingCore(False);
          Exit;
        end;
     end;
     //ShowNotification('JSON Content: ' + JSONContent, 0); // Логирование
     if Pos('404',JSONContent) > 0 then begin fnLoadingCore(False); ShowNotification('404: ' + JSONContent, 0); Exit end;
     if Pos('Error',JSONContent) > 0 then begin fnLoadingCore(False); ShowNotification('Error: ' + JSONContent, 0); Exit end;
     try
      Values := ExtractValuesOnly3FromJSON(JSONContent);
     except
       on E: Exception do
        begin
          fnLoadingCore(False);
          ShowNotification('Error ExtractValuesOnly3FromJSON: ' + E.Message, 0);
        end;
     end;
     try
      Words := GetTranslationOnly3Words(JSONContent, 'rus');
     except
       on E: Exception do
        begin
          fnLoadingCore(False);
          ShowNotification('Error GetTranslationOnly3Words: ' + E.Message, 0);
        end;
     end;
     mmo_trg.Lines.Add('Sõnavormid:');
     try
     for i := 0 to Length(Values) - 1 do
         ExtractedWords.Add(Values[i]);
     except
       on E: Exception do
        begin
          fnLoadingCore(False);
          ShowNotification('Error ExtractedWords.Add(Values[i]): ' + E.Message, 0);
        end;
     end;
     try
      for i := 0 to Length(Words) - 1 do
          ExtractedWords.Add(Words[i]);
     except
       on E: Exception do
        begin
          fnLoadingCore(False);
          ShowNotification('Error ExtractedWords.Add(Words[i]): ' + E.Message, 0);
        end;
     end;
      mmo_trg.Lines.Add(ExtractedWords.Text);
      mmo_trg.Lines.Add('-----------------------------------------');
    finally
      if ExtractedWords <> nil then ExtractedWords.Free;
    end;
    except
      on E: Exception do
      begin
         fnLoadingCore(False);
      end;
    end;
    try
    // Extract WordID if no error in the response
    if Pos('Error', Response) = 0 then
       WordID := ExtractWordID(Response);
    except
      on E: Exception do
      begin
        fnLoadingCore(False);
        ShowNotification('Error WordID: ' + E.Message, 0);
      end;
    end;
    try
    // Further processing if WordID is extracted
    if not WordID.IsEmpty then
    begin
     try
      tmp := StringReplace(uURLWords + uRLWords, uRLWords, WordID, [rfReplaceAll]);
      Response := GetHtmlContent(tmp);
     except
      on E: Exception do
       begin
         fnLoadingCore(False);
         ShowNotification('Error GetHtmlContent(tmp): ' + E.Message, 0);
       end;
     end;
     try
      if not Response.IsEmpty then
      begin
        tmp := DecodeURL(ExtractWordFromHTML(Response, 'title="vene"', '</div>'));
        mmo_trg.Lines.Add(tmp);
        if Pos('Error', Response) = 0 then
        begin
          mmo_trg.Lines.Add('Example:');
          ExampleText.Add(ExampleWords(Response, '<span class="example-text-value">', '</span>'));
          mmo_trg.Lines.Add(ExampleText.Text);
        end;
      end;
     except
      on E: Exception do
       begin
         fnLoadingCore(False);
         ShowNotification('Error not Response.IsEmpty: ' + E.Message, 0);
       end;
     end;
    end;
    except
      on E: Exception do
      begin
         fnLoadingCore(False);
         ShowNotification('Error ExampleText: ' + E.Message, 0);
      end;
    end;
  except
    on E: Exception do begin
       fnLoadingCore(False);
       ShowNotification('Error during Sonaveeb translation: ' + E.Message, 0);
    end;
  end;
end;

function TFormMain.HandleLanguageSpecificTranslation(const Text: string): string;
begin
 try
  Result := ''; // Изначально устанавливаем результат
  // Вызов функции перевода в фоновом потоке
  TTask.Run(procedure
  var
    Translated: string;
  begin
    try
     if not uApiTartu then begin
      if (idxLang = 0) and (idLang = 1) then
        Translated := EstRus(Text)
      else if (idxLang = 0) and (idLang = 0) then
        Translated := RusEst(Text)
      else if (idxLang = 0) and (idLang = 2) then
        Translated := EstUkr(Text)
      else if (idxLang = 0) and (idLang = 3) then
        Translated := UkrEst(Text)
      else if (idxLang = 0) and (idLang = 4) then
        Translated := RusEng(Text)
      else if (idxLang = 0) and (idLang = 5) then
        Translated := EngRus(Text)
      else if (idxLang = 0) and (idLang = 6) then
        Translated := UkrEng(Text)
      else if (idxLang = 0) and (idLang = 7) then
        Translated := EngUkr(Text);
     end else begin
        try
         if Length(Trim(mmo_src.Text)) > 0 then mmo_src.Text := Trim(mmo_src.Text);
            Translated := GetTxt(Trim(mmo_src.Text));
        except
         on E: Exception do
            ShowNotification('Tartu Translated Text is Null: ' + E.Message, 0);
        end;
     end;
      TThread.Queue(nil, procedure
      begin
        mmo_trg.Text := Translated;
      end);
    except
      on E: Exception do
         ShowNotification('Error in translation function: ' + E.Message, 0);
    end;
  end);
 except
   on E: Exception do
      ShowNotification('Error in HandleLanguageSpecificTranslation: ' + E.Message, 0);
 end;
end;

procedure TFormMain.SaveBasesIfNecessary(src: string; trg: string);
begin
try
  if Length(Trim(src)) = 0 then src := mmo_src.Text;
  if Length(Trim(trg)) = 0 then trg := mmo_trg.Text;
  SaveBases(#13#10 + 'Source:' + #13#10 + src + #13#10 + 'Translation:' + #13#10 + trg);
  ShowNotification('Save data in bases - Ok', 0);
except
  on E: Exception do begin
     ShowNotification('Error SaveBasesIfNecessary: ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.PlayVoiceIfNeeded(const Text: string);
begin
try
  if chkSoundPlay then  // Assuming chkSoundPlay is a checkbox to enable/disable voice playback
  begin
    try
      // Use a text-to-speech function or service here to play the voice
      // Example: Call a method to convert text to speech
      getVoice(Text);  // Assuming getVoice is a function you already have to play text as voice
    except
      on E: Exception do
        ShowNotification('Error playing voice: ' + E.Message, 0);
    end;
  end;
except
  Exit;
end;
end;

procedure TFormMain.StartTranslation(const Text: string);
var
  TranslatedText: string;
begin
try
  // Убедитесь, что метод запускается в фоновом потоке
  TTask.Run(procedure
  begin
    try
      TranslatedText := HandleLanguageSpecificTranslation(Text); // Вызов перевода
    except
      TranslatedText := 'Error during translation'; // Обработка ошибок
    end;

    // Обновление UI должно выполняться в основном потоке
    TThread.Synchronize(nil, procedure
    begin
      mmo_trg.Text := TranslatedText; // Обновление текста в интерфейсе
    end);
  end);
except
  Exit;
end;
end;

procedure TFormMain.GetTranslateData;
var
  CleanText: string;
begin
try
  // Early exit if no text is entered
  if mmo_src.Text.Trim.IsEmpty then
  begin
    TDialogService.ShowMessage('Enter text to translate!');
    fnLoadingCore(False);
    Exit;
  end;
  try
  // Normalize the input once
  mmo_src.Text := StringReplace(mmo_src.Text, #13#10, '', [rfReplaceAll]);
  CleanText := RemoveNonPrintableChars(mmo_src.Text);
  except
    on E: Exception do begin
       fnLoadingCore(False); //errormess := 'Error RemoveNonPrintableChars :' + E.Message;
    end;
  end;
  // Update the cleaned text in the memo
  mmo_src.Text := CleanText;
  try
  Dec(sContID);
  // Proceed with the rest of your logic
  if sContID <= 0 then
  begin
     HandleUserSession;
  end;
  except
    on E: Exception do begin
       fnLoadingCore(False); //errormess := 'Error HandleUserSession :' + E.Message;
    end;
  end;
  try
    if Length(Trim(CleanText)) > 0 then begin
       StartTranslation(CleanText);
       PlayVoiceIfNeeded(CleanText); // Проигрывание текста, если необходимо
    end;
  except
    on E: Exception do begin
       fnLoadingCore(False); //errormess := 'Error StartTranslation :' + E.Message;
    end;
  end;
except
  on E: Exception do begin
     fnLoadingCore(False); //errormess := 'Error Translation of text :' + E.Message;
  end;
end;
end;

procedure TFormMain.acTranslateTxTExecute(Sender: TObject);
var CleanText: string;
begin
try
  TTask.Run(procedure
  begin
   try
    fnLoadingCore(True);
    try
      GetTranslateData;
    except
      on E: Exception do
         TThread.Queue(nil, procedure
          begin
            fnLoadingCore(False);
          end);
    end;
    try
    // Handle the API-based translation
    if (btnGGView.Tag = 333) then
    begin
      Self.mmo_srcChange(Self);
      // Normalize the input once
      mmo_src.Text := LowerCase(Trim(mmo_src.Text));
      mmo_src.Text := StringReplace(mmo_src.Text.ToLower.Trim, #13#10, '', [rfReplaceAll]);
      CleanText := RemoveNonPrintableChars(mmo_src.Text);
      HandleSonaveebTranslation(CleanText);
    end;
    except
      on E: Exception do begin
         fnLoadingCore(False);
      end;
    end;
   finally
     fnLoadingCore(False);
   end;
  end).Start;
except
  Exit;
end;
end;

procedure TFormMain.acTrashExecute(Sender: TObject);
begin
try
 if ((Length(Trim(mmo_src.Text)) > 0)or(Length(Trim(mmo_trg.Text)) > 0 )) then begin
    mmo_src.Text := '';
    mmo_trg.Text := '';
    DelayedSetFocus(mmo_src);
    mmo_src.SetFocus;
 end else
    TDialogService.ShowMessage('No data to clear!');
    ShowNotification('Clearing information', 0);
except
    ShowNotification('Error clearing information', 0);
    Exit;
end;
end;

procedure TFormMain.actResetPassExecute(Sender: TObject);
var
  FirebaseAuth: IFirebaseAuth;
  JsonAnswer: string;
begin
try
  mLog.Lines.Add('Reset Password');
  ShowNotification('Reset Password', 0);
  if Length(Trim(EditEmail.Text)) = 0 then Exit;
  if Pos('test@test.tst',EditEmail.Text) > 0 then begin
     TDialogService.ShowMessage('You cannot reset your password on a test account!');
     Exit;
  end else begin
    SettingsFDMemTable.Edit;
    SettingsFDMemTable.FieldByName('Style').AsInteger := IfThen(SettingsFDMemTable.FieldByName('Style').AsInteger=0,1,0);
    SettingsFDMemTable.Post;
    SetStyle;
    FirebaseAuth := TFirebaseAuth.Create(NetHTTPClient1, FWebApiKey);  //GetDecryptAES(FWebApiKey,uKeyEnc,uVectEnc)
    mLog.Lines.Clear;
    TTask.Run(
    procedure
    begin
      TabControl1.GotoVisibleTab(2);
      JsonAnswer := FirebaseAuth.ResetPassword(EditEmail.Text);
      TThread.Synchronize(nil,
        procedure
        var
          ConnectionResult: string;
        begin
          ConnectionResult := TFirebaseAuth.ParseJsonForResult(JsonAnswer);
          if ConnectionResult = 'error' then begin
             TDialogService.ShowMessage('Attention! Reset password !');
             RctSignIn.Fill.Color := TAlphaColorRec.Coral;
          end else begin
             TDialogService.ShowMessage('The letter has been sent to the specified email, check your email!');
             mLog.Text := JsonAnswer;
          end;
        end);
    end);
    FloatAnimation7.Start;
    RctResetPassWord.Fill.Color := TAlphaColorRec.Green;
  end;
except
  RctResetPassWord.Fill.Color := TAlphaColorRec.Coral;
  Exit;
end;
end;

procedure TFormMain.actSaveBasesTxTExecute(Sender: TObject);
begin
try
  if Length(Trim(mmo_trg.Text)) > 0 then
     SaveBasesIfNecessary(Trim(mmo_src.Text),Trim(mmo_trg.Text)); // Сохранение базы, если это необходимо
except
  Exit;
end;
end;

procedure TFormMain.actSaveDataKusiExecute(Sender: TObject);
var Service: IFMXPhotoLibrary;
begin
try
  sID := 3;
  if (Length(Trim(mmoKusi.Text)) = 0) then begin
     TDialogService.ShowMessage('No data to save!');
     Exit;
  end;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXPhotoLibrary, Service) then Exit;
    TDialogService.MessageDialog('Save Data?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbNo, 0, procedure(const AResult: TModalResult)
     begin
 	   if (AResult = mrYes) then begin
         try
          {$IFDEF ANDROID}
            FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
            FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
            if ((not PermissionsService.IsPermissionGranted(FPermissionReadExternalStorage))or(not PermissionsService.IsPermissionGranted(FPermissionWriteExternalStorage))) then
            PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
          {$ENDIF}
         except
         end;
         try
           ShowShareSheetAction1.Execute;
         except
         end;
     end else mmoKusi.Text := '';
     end);
except
  Exit;
end;
end;

procedure TFormMain.actSaveEncryptBasesExecute(Sender: TObject);
var Service: IFMXPhotoLibrary;
begin
try
  sID := 2;
  if (Length(Trim(mmoBases.Text)) = 0) then begin
     TDialogService.ShowMessage('No data to save!');
     Exit;
  end;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXPhotoLibrary, Service) then Exit;
    TDialogService.MessageDialog('Save Data?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbNo, 0, procedure(const AResult: TModalResult)
     begin
 	   if (AResult = mrYes) then begin
         try
          {$IFDEF ANDROID}
            FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
            FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
            if ((not PermissionsService.IsPermissionGranted(FPermissionReadExternalStorage))or(not PermissionsService.IsPermissionGranted(FPermissionWriteExternalStorage))) then
            PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
          {$ENDIF}
         except
         end;
         try
           ShowShareSheetAction1.Execute;
         except
         end;
     end;
     end);
except
  Exit;
end;
end;

procedure TFormMain.actSaveToBasesExecute(Sender: TObject);
begin
try
  if ((Length(Trim(mmo_src.Text)) > 0)and(Length(Trim(mmo_trg.Text)) > 0)) then SaveBases(#13#10+'Source:'+#13#10+mmo_src.Text+#13#10+'Translation:'+#13#10+mmo_trg.Text);
except
  Exit;
end;
end;

procedure TFormMain.actSearchExecute(Sender: TObject);
begin
try
  SearchBases('');
except
  Exit;
end;
end;

procedure TFormMain.actSearchWordsExecute(Sender: TObject);
begin
try
  if (Length(Trim(edtSearch.Text)) > 0) then begin
     edtSearch.Text := LowerCase(edtSearch.Text);
     SearchBasesWords(Trim(edtSearch.Text));
  end;
except
  Exit;
end;
end;

procedure TFormMain.ScrollToBottom;
var
  TargetPosition: Single;
begin
try
  TargetPosition := VSB.ContentBounds.Height - VSB.Height;
  TAnimator.AnimateFloat(VSB, 'ViewportPosition.Y', TargetPosition, 0.2); // 0.2 — это длительность анимации в секундах
except
  Exit;
end;
end;

procedure TFormMain.AddMessage(const AText: String; AAlignLayout: TAlignLayout; ACalloutPosition: TCalloutPosition);
var
  CR: TCalloutRectangle;
  L: TLabel;
  TmpImg: TCircle;
  LabelWidth, LabelHeight, xTop: Single;
begin
  try
    CR := TCalloutRectangle.Create(Self);
    CR.Parent := VSB;
    CR.Align := TAlignLayout.Top;
    CR.CalloutPosition := ACalloutPosition;
    CR.Margins.Top := 10;
    CR.Margins.Bottom := 10;
    CR.Margins.Left := 5;
    CR.XRadius := 25;
    CR.YRadius := CR.XRadius;
    CR.Position.Y := 999999;
    CR.Fill.Kind := TBrushKind.None;
    CR.Stroke.Color := TAlphaColorRec.Yellow;

    // Создаем временный TLabel для вычисления ширины и высоты текста
    L := TLabel.Create(Self);
    L.Text := AText;
    L.WordWrap := True;
    L.AutoSize := True;
    L.Visible := False; // Делаем невидимым, чтобы не мешал
    L.Parent := CR;

    // Вычисляем оптимальные ширину и высоту для контейнера по ширине и высоте текста
    LabelWidth := L.Canvas.TextWidth(L.Text) + 21; // Добавляем немного отступа
    LabelHeight := L.Canvas.TextHeight(L.Text) + 21; // Добавляем немного отступа
    if LabelWidth < 100 then
      LabelWidth := 100; // Минимальная ширина
    if LabelHeight < 50 then
      LabelHeight := 50; // Минимальная высота

    // Освобождаем временный TLabel
    L.Free;
    if Length(Trim(AText)) >= 189 then xTop := Length(Trim(AText)) / 2 else xTop := 55;
    // Устанавливаем оптимальные ширину и высоту для контейнера
    CR.Width := LabelWidth + xTop; // Увеличиваем ширину для предотвращения выхода текста за пределы
    CR.Height := LabelHeight + xTop+55; // Увеличиваем высоту для предотвращения выхода текста за пределы
    L := TLabel.Create(Self);
    L.Parent := CR;
    L.Align := TAlignLayout.Client;
    L.Text := AText;
    L.Margins.Right := 10;
    L.Margins.Left := 10; // Увеличиваем отступы по бокам для эстетичного вида
    L.WordWrap := True;
    L.AutoSize := True;
    L.OnPaint := LabelPaint;

    TmpImg := TCircle.Create(Self);
    TmpImg.Parent := CR;
    TmpImg.Align := AAlignLayout;
    TmpImg.Fill.Kind := TBrushKind.Bitmap;
    case AAlignLayout of
      TAlignLayout.Left: TmpImg.Fill.Bitmap.Bitmap.Assign(Image1.Bitmap);
      TAlignLayout.Right: TmpImg.Fill.Bitmap.Bitmap.Assign(Image2.Bitmap);
    end;
    TmpImg.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
    TmpImg.Width := 75;
    TmpImg.Margins.Left := 15;
    TmpImg.Margins.Right := 15;
    TmpImg.Margins.Top := 15;
    TmpImg.Margins.Bottom := 15;
    VSB.BeginUpdate;
    try
     VSB.ScrollBy(0, -Round(CR.Height) - 21); // Скроллим вверх на высоту контейнера плюс немного отступа
    finally
     VSB.EndUpdate;
    end;
  except
    Exit;
  end; //ShowMessage(IntToStr(Length(Trim(AText))));
end;

procedure TFormMain.ShowPopupFrame(const SourceText, TranslationText: string);
begin
try
  if Length(Trim(SourceText)) > 0 then begin
     mmoKusi.Lines.Text := SourceText;
  // Дополнительные действия
  if Length(Trim(FAPIKEYSpeaker)) = 0 then FAPIKEYSpeaker := GetGoogleApiKey('Speaker','2',uGoogleApiKeySheets);
  if chkSoundPlay then PlayManText(SourceText, FAPIKEYSpeaker);
  end;
except
  Exit;
end;
end;

procedure TFormMain.AddPanelActionExecute(Sender: TObject);
var
  NoteText, SourceText, TranslationText: string;
  SourcePos, TranslationPos: Integer;
begin
try
    if not uDMForm.fConnect.Connected then
    begin
      try
        uDMForm.fConnect.Connected := True;
      except
        on E: ERESTException do
        begin
          if swtch1.IsChecked then
            ShowNotification('Error ' + #13#10 + E.Message, 0);
          Exit;
        end;
      end;
    end;
    with uDMForm do
    begin
     try
      fConnect.Open;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT Translate FROM t_jso_Notes ORDER BY RANDOM() LIMIT 1';
      fQuery.Open;
      if fQuery.RecordCount > 0 then
      begin
        AddPanelButton.Enabled := False;
        NoteText := fQuery.FieldByName('Translate').AsString;
        // Найти позиции подстрок "Source:" и "Translation:"
        SourcePos := Pos('Source:', NoteText);
        TranslationPos := Pos('Translation:', NoteText);
        if (SourcePos > 0) and (TranslationPos > 0) then
        begin
          // Извлечь текст между "Source:" и "Translation:"
          SourceText := Copy(NoteText, SourcePos + Length('Source:'), TranslationPos - SourcePos - Length('Source:'));
          // Извлечь текст после "Translation:"
          TranslationText := Copy(NoteText, TranslationPos + Length('Translation:'), Length(NoteText) - TranslationPos - Length('Translation:') + 1);

          // Очистить от лишних символов и пробелов
          SourceText := StringReplace(SourceText, 'Source:', '', []);
          TranslationText := StringReplace(TranslationText, 'Translation:', '', []);

          // Удалить начальные и конечные пробелы
          SourceText := Trim(SourceText);
          TranslationText := TrimRight(TranslationText);
          TranslationText := StringReplace(TranslationText, '}', '', [rfReplaceAll]);
          TranslationText := Trim(TranslationText);

          if Length(Trim(SourceText)) > 0 then begin
           try
             ShowPopupFrame(SourceText,TranslationText);
           except
             if Length(Trim(FAPIKEYSpeaker)) = 0 then FAPIKEYSpeaker := GetGoogleApiKey('Speaker','2',uGoogleApiKeySheets);
             PlayManText(SourceText,FAPIKEYSpeaker);
           end;
          end;
        end;
      end
      else
      begin
        if swtch1.IsChecked then ShowNotification('Frame is Null', 0);
           AddPanelButton.Enabled := False; Exit;
      end;
     finally
      // Закрываем запрос и освобождаем ресурсы
      if fQuery.Active then
         fQuery.Close;
     end;
     AddPanelButton.Enabled := True;
    end;
except
   on E: ERESTException do begin
      if swtch1.IsChecked then ShowNotification('Error '+#13#10+E.Message, 0); AddPanelButton.Enabled := True; Exit;
   end;
end;
end;

procedure TFormMain.AddMessageAsync(const AText: String; AAlignLayout: TAlignLayout; ACalloutPosition: TCalloutPosition);
begin
try
  TThread.CreateAnonymousThread(procedure
  begin
    TThread.Synchronize(nil, procedure
    begin
      AddMessage(AText, AAlignLayout, ACalloutPosition);
      ScrollToBottom; // Прокрутить к последнему добавленному сообщению
    end);
  end).Start;
except
   on E: Exception do begin
      if swtch1.IsChecked then ShowNotification('Error '+#13#10+E.Message, 0); Exit;
   end;
end;
end;

procedure TFormMain.FriendMessage(const S: String);
begin
try //AddMessage(S, TAlignLayout.Left, TCalloutPosition.Left);
  AddMessageAsync(S, TAlignLayout.Left, TCalloutPosition.Left);
except
  Exit;
end;
end;
procedure TFormMain.YourMessage(const S: String);
begin
try //AddMessage(S, TAlignLayout.Right, TCalloutPosition.Right);
  AddMessageAsync(S, TAlignLayout.Right, TCalloutPosition.Right);
except
  Exit;
end;
end;

procedure TFormMain.AddMessageAI(const AText: String; AAlignLayout: TAlignLayout; ACalloutPosition: TCalloutPosition; index: Integer);
const
  MIN_WIDTH = 100;
  MIN_HEIGHT = 50;
  PADDING = 21;
  EXTRA_SPACE = 55;
var
  CR: TCalloutRectangle;
  L: TLabel;
  TmpImg: TCircle;
  TextRect: TRectF;
  Width, Height, xTop: Single;
begin
  try
    // Создаем контейнер TCalloutRectangle
    CR := TCalloutRectangle.Create(Self);
    CR.Parent := VSBAI;
    CR.Align := TAlignLayout.MostTop;
    CR.CalloutPosition := ACalloutPosition;
    CR.Margins.Top := 10;
    CR.Margins.Bottom := 10;
    CR.Margins.Left := 5;
    CR.Margins.Right := 5;
    CR.XRadius := 25;
    CR.YRadius := CR.XRadius;
    CR.Position.Y := VSBAI.ContentBounds.Height;
    CR.Fill.Kind := TBrushKind.None;
    CR.Stroke.Color := TAlphaColorRec.White;

    // Создаем временный TLabel для вычисления ширины и высоты текста
    L := TLabel.Create(Self);
    try
      L.Text := AText;
      L.WordWrap := True;
      L.AutoSize := True;
      L.Visible := False;
      L.Parent := CR;

      // Используем Canvas для вычисления размеров текста
      TextRect := TRectF.Create(0, 0, CR.Width, CR.Height);
      L.Canvas.MeasureText(TextRect, AText, True, [], TTextAlign.Leading, TTextAlign.Leading);

      // Определяем размеры контейнера
      Width := Max(MIN_WIDTH, TextRect.Width + PADDING);
      Height := Max(MIN_HEIGHT, TextRect.Height + PADDING);

      // Освобождаем временный TLabel
      L.Free;

      // Определяем дополнительное пространство на основе длины текста
      xTop := IfThen(Length(Trim(AText)) >= 189, Length(Trim(AText)) / 2, 55);

      // Устанавливаем размеры контейнера
      CR.Width := Width + xTop + EXTRA_SPACE;
      CR.Height := Height + xTop + EXTRA_SPACE;

      // Создаем основной TLabel для отображения текста
      L := TLabel.Create(Self);
      L.Parent := CR;
      L.Align := TAlignLayout.Client;
      L.Text := AText;
      L.Margins.Left := 10;
      L.Margins.Right := 10;
      L.Margins.Top := 10; // Увеличиваем отступы для лучшего отображения
      L.Margins.Bottom := 10;
      L.WordWrap := True;
      L.AutoSize := False; // Ставим False, чтобы работали выравнивания
      L.VertTextAlign := TTextAlign.Center; // Выравнивание по центру вертикально
      L.TextAlign := TTextAlign.Leading; // Выравнивание по центру горизонтально

      // Устанавливаем цвет текста
      L.TextSettings.FontColor := IfThen(index = 0, TAlphaColorRec.Yellow, TAlphaColorRec.Gold);

      // Создаем и настраиваем изображение
      TmpImg := TCircle.Create(Self);
      TmpImg.Parent := CR;
      TmpImg.Align := AAlignLayout;
      TmpImg.Fill.Kind := TBrushKind.Bitmap;
      case AAlignLayout of
        TAlignLayout.Left: TmpImg.Fill.Bitmap.Bitmap.Assign(Image1.Bitmap);
        TAlignLayout.Right: TmpImg.Fill.Bitmap.Bitmap.Assign(Image2.Bitmap);
      end;
      TmpImg.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      TmpImg.Width := 75;
      TmpImg.Margins.Left := 15;
      TmpImg.Margins.Right := 15;
      TmpImg.Margins.Top := 15;
      TmpImg.Margins.Bottom := 15;

      // Скроллим вверх на высоту контейнера плюс немного отступа
      VSBAI.ScrollBy(0, -Round(CR.Height) - 5);
    except
      on E: Exception do
         ShowNotification('Error TLabel.Create: ' + E.Message, 0);
    end;
  except
    on E: Exception do
       ShowNotification('Error AddMessage: ' + E.Message, 0);
  end;
end;

procedure TFormMain.FriendMessageAI(const S: String);
begin
try
  if Length(Trim(aiTextTrg)) = 0 then aiTextTrg := S else aiTextTrg := aiTextTrg +#13#10+S;
  AddMessageAI(S, TAlignLayout.Left, TCalloutPosition.Left, 1);
except
  Exit;
end;
end;

procedure TFormMain.YourMessageAI(const S: String);
begin
try
  if Length(Trim(aiTextSrc)) = 0 then aiTextSrc := S else aiTextSrc := aiTextSrc +#13#10+S;
  AddMessageAI(S, TAlignLayout.Right, TCalloutPosition.Right, 0);
except
  Exit;
end;
end;

procedure TFormMain.LabelPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
try
  //..
except
  Exit;
end;
end;

procedure TFormMain.ClearVSB;
var
  I: Integer;
begin
try
  try
    if VSB.Content.ChildrenCount <= 0 then begin
       TDialogService.ShowMessage('No data to clean!');
       Exit;
    end;
  except
    mLog.Lines.Add('No data to clean');
  end;
  // Отключаем обновление интерфейса для повышения производительности
  VSB.BeginUpdate;
  try
    // Удаляем все дочерние компоненты из Content
    for I := VSB.Content.ChildrenCount - 1 downto 0 do
      VSB.Content.Children[I].Free;
  finally
    // Включаем обновление интерфейса
    VSB.EndUpdate;
  end;
except
  Exit;
end;
end;

procedure TFormMain.ComboBoxItemChange(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedPlaylist: TPlaylistItem;
begin
try
  SelectedIndex := ComboBoxItem.ItemIndex;
  // Проверяем, что индекс выбранного элемента корректен
  if (SelectedIndex < 0) or (SelectedIndex >= Length(PlaylistItems)) then
  begin
    ShowNotification('Invalid playlist selection', 0);
    Exit;
  end else begin
   try
     SelectedPlaylist := PlaylistItems[SelectedIndex];
     // Дальнейшие действия с выбранным плейлистом
     if uTag = 'Eng' then ListarEngVideos(SelectedPlaylist.PlaylistID);
     if uTag = 'Est' then begin uList := True; ListarEstVideos(SelectedPlaylist.PlaylistID); end;
   except
     ShowNotification('Error SelectedPlaylist', 0);
   end;
  end;
except
  ShowNotification('Error SelectedPlaylist', 0);
  Exit;
end;
end;

procedure TFormMain.ComboBoxItemClick(Sender: TObject);
begin
  ShowNotification('Selection of YouTube videos', 0);
end;

procedure TFormMain.actSendCryptoTextExecute(Sender: TObject);
var
  NoteText, SourceText, TranslationText: string;
  SourcePos, TranslationPos: Integer;
begin
  try
    ShowNotification('Random selection of recorded sentences, words', 0);
    if not uDMForm.fConnect.Connected then
    begin
      try
        uDMForm.fConnect.Connected := True;
      except
        on E: ERESTException do
        begin
          if swtch1.IsChecked then
            ShowNotification('Error ' + #13#10 + E.Message, 0);
          Exit;
        end;
      end;
    end;
    with uDMForm do
    begin
     try
      fConnect.Open;
      fQuery.SQL.Clear;
      fQuery.SQL.Text := 'SELECT Translate FROM t_jso_Notes ORDER BY RANDOM() LIMIT 1';
      fQuery.Open;
      if fQuery.RecordCount > 0 then
      begin
        NoteText := fQuery.FieldByName('Translate').AsString;
        // Найти позиции подстрок "Source:" и "Translation:"
        SourcePos := Pos('Source:', NoteText);
        TranslationPos := Pos('Translation:', NoteText);
        if (SourcePos > 0) and (TranslationPos > 0) then
        begin
          // Извлечь текст между "Source:" и "Translation:"
          SourceText := Copy(NoteText, SourcePos + Length('Source:'), TranslationPos - SourcePos - Length('Source:'));
          // Извлечь текст после "Translation:"
          TranslationText := Copy(NoteText, TranslationPos + Length('Translation:'), Length(NoteText) - TranslationPos - Length('Translation:') + 1);

          // Очистить от лишних символов и пробелов
          SourceText := StringReplace(SourceText, 'Source:', '', []);
          TranslationText := StringReplace(TranslationText, 'Translation:', '', []);

          // Удалить начальные и конечные пробелы
          SourceText := Trim(SourceText);
          TranslationText := TrimRight(TranslationText);
          TranslationText := StringReplace(TranslationText, '}', '', [rfReplaceAll]);
          TranslationText := Trim(TranslationText);

          if Length(Trim(SourceText)) > 0 then begin
            // Отображаем результат
             YourMessage(SourceText);
             FriendMessage(TranslationText);
             if Length(Trim(FAPIKEYSpeaker)) = 0 then FAPIKEYSpeaker := GetGoogleApiKey('Speaker','2',uGoogleApiKeySheets);
             if ((chkSoundPlay)and(Length(Trim(FAPIKEYSpeaker)) > 0)) then PlayManText(SourceText,FAPIKEYSpeaker);
          end;
        end;
      end
      else
      begin
        if swtch1.IsChecked then begin
           TDialogService.ShowMessage('No data in bases!');
           ShowNotification('No data in bases', 0);
           Exit;
        end;
      end;
     finally
      // Закрываем запрос и освобождаем ресурсы
      if fQuery.Active then
         fQuery.Close;
     end;
    end;
  except
    if swtch1.IsChecked then
       ShowNotification('Error Count Data', 0);
       Exit;
  end;
end;

procedure TFormMain.actSignInExecute(Sender: TObject);
var
  FirebaseAuth: IFirebaseAuth;
  JsonAnswer: string;
  SL: TStringList;
begin
try
  mLog.Lines.Add('Login');
  ShowNotification('Login', 0);
  tmr1.Enabled := False;
  FirebaseAuth := TFirebaseAuth.Create(NetHTTPClient1, FWebApiKey);  //GetDecryptAES(FWebApiKey,uKeyEnc,uVectEnc)
  mLog.Lines.Clear;
  TTask.Run(
	procedure
	begin
  	FEmail := EditEmail.Text;
    if Length(Trim(EditEmail.Text)) = 0 then Exit;
  	JsonAnswer := FirebaseAuth.SignInWithEmailAndPassword(EditEmail.Text, EditPassword.Text);
  	TThread.Synchronize(nil,
    	procedure
    	var
      	ConnectionResult: string;
    	begin
      	ConnectionResult := TFirebaseAuth.ParseJsonForResult(JsonAnswer);
      	if ConnectionResult = 'error' then begin
           TDialogService.ShowMessage('Attention! Wrong password or login!');
           RctSignIn.Fill.Color := TAlphaColorRec.Coral;
      	end else if ConnectionResult = 'email' then begin
            if Pos('test@test.tst',EditEmail.Text) = 0 then begin
              try
               SL := TStringList.Create;
               try
                 SL.Append(EditEmail.Text+'\'+EditPassword.Text);
                 SL.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,TEST_FILE));
               finally
                 SL.Free;
               end;
              except
                 mLog.Text := 'Error save login.txt';
              end;
            end;
            try
               BannerAd1.AdUnitID := 'ca-app-pub-3779339533209227/1385054305';
               BannerAd1.TestMode := False;
               BannerAd1.LoadAd;
               mLog.Lines.Add('Load bannerAd - Ok');
            except
               mLog.Lines.Add('Error load bannerAd');
            end;
            try
            if Length(Trim(uAccessToken)) > 0 then
            if GetSheetDataPrivatUsers(uPrivUsers,uAccessToken,EditEmail.Text) then begin
               privUsers := True;
               BannerAd1.Visible := False;
               BannerAd1.TestMode := False;
               ButtonsAdMob.Visible := False;
            end else begin
               privUsers := False;
               BannerAd1.Visible := True;
               BannerAd1.TestMode := False;
               ButtonsAdMob.Visible := True;
            end;
            except //ShowNotification('Error access client!', 0);
               privUsers := False;
               mLog.Lines.Add('Error ButtonsAdMob');
            end;
            TabControl1.Tabs[1].Visible := True;
            TabControl1.GotoVisibleTab(1);
            TabControl1.Tabs[0].Visible := False;
            TabControl1.Tabs[2].Visible := False;
            TabControl1.Tabs[3].Visible := False;
            TabControl1.Tabs[4].Visible := False;
            TabControl1.Tabs[5].Visible := False;
            TabControl1.Tabs[6].Visible := False;
            TabControl1.Tabs[7].Visible := False;
            TabControl1.Tabs[8].Visible := False;
            TabControl1.Tabs[1].SetFocus;
      	    mLog.Text := JsonAnswer;
        end;
    	end);
	end);
  FloatAnimation7.Start;
  RctSignIn.Fill.Color := TAlphaColorRec.Green;
except
  RctSignIn.Fill.Color := TAlphaColorRec.Coral;
  RctResetPassWord.Enabled := True;
  Exit;
end;
end;

procedure TFormMain.actSignUpExecute(Sender: TObject);
var
  FirebaseAuth: IFirebaseAuth;
  JsonAnswer: string;
begin
try
  mLog.Lines.Add('Registration');
  ShowNotification('Registration', 0);
  FirebaseAuth := TFirebaseAuth.Create(NetHTTPClient1, FWebApiKey);  //GetDecryptAES(FWebApiKey,uKeyEnc,uVectEnc)
  mLog.Lines.Clear;
  TTask.Run(
	procedure
	begin
    if Length(Trim(EditEmail.Text)) = 0 then Exit;
  	JsonAnswer := FirebaseAuth.SignUpWithEmailAndPassword(EditEmail.Text, EditPassword.Text);
  	TThread.Synchronize(nil,
    	procedure
    	var
      	ConnectionResult: string;
    	begin
      	TabControl1.GotoVisibleTab(1);
      	mLog.Text := JsonAnswer;
      	ConnectionResult := TFirebaseAuth.ParseJsonForResult(JsonAnswer);
      	if ConnectionResult = 'error' then begin
           TDialogService.ShowMessage('Attention! Wrong password or login or account created!');
           RctSignUp.Fill.Color := TAlphaColorRec.Coral;
      	end else if ConnectionResult = 'email' then begin
        	 TDialogService.ShowMessage('Account created!');
           Self.actSignInExecute(Self);
        end;
    	end);
	end);
  FloatAnimation7.Start;
  RctSignUp.Fill.Color := TAlphaColorRec.Green;
except
  RctSignUp.Fill.Color := TAlphaColorRec.Coral;
  Exit;
end;
end;

procedure TFormMain.KeepWebBrowserInvisible(stat: Boolean);
begin
  try
    WebBrowser1.Visible := stat;
  except
    Exit;
  end;
end;

procedure TFormMain.actTranslateCoreExecute(Sender: TObject);
var View: TFrameTranslateView;
begin
try
  ShowNotification('Text translation frame', 0);
  // Создание и настройка нового фрейма
  View := TFrameTranslateView.Create(Self);
  View.Parent := uLogger;
  View.uApiTartu := uApiTartu;
  TDialogBuilder.Create(Self)
    .SetStyleManager(IosStyleManager)
    .SetView(View)
    .SetPosition(TDialogViewPosition.Bottom)
    .SetCancelButton('Cancel',
    procedure (Dialog: IDialog; Which: Integer) begin
      KeepWebBrowserInvisible(True);
      if Assigned(View) then
       begin
        // Освободить экземпляр фрейма из памяти
        DestroyAndRemoveFrame(View);
       end;
    end
  )
  .Show;
  try
    GetCountLineBases;
    GetCountMemoText;
  except
    on E: Exception do ShowNotification('Error: ' + E.Message, 0);
  end;
except
  on E: Exception do
  begin
     ShowNotification('Error: ' + E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.actTranslateExecute(Sender: TObject);
var View: TFrameTranslateView;
begin
try
    ShowNotification('Text translation frame', 0);
    // Создание и настройка нового фрейма
    View := TFrameTranslateView.Create(Self);
    // Показ диалога в зависимости от активной вкладки
    if TabControl1.ActiveTab = uKusi then
    begin
      TabControl1.ActiveTab := uKusi; // Активируем вкладку
      View.Parent := uKusi;
      TDialogBuilder.Create(Self)
        .SetStyleManager(IosStyleManager)
        .SetView(View)
        .SetPosition(TDialogViewPosition.Bottom)
        .SetCancelButton('Cancel',
        procedure (Dialog: IDialog; Which: Integer) begin
          KeepWebBrowserInvisible(True);
          if Assigned(View) then
           begin
            // Освободить экземпляр фрейма из памяти
            DestroyAndRemoveFrame(View);
           end;
        end
      )
      .Show;
    end
    else
    if TabControl1.ActiveTab = uWordCorrect then
    begin
      TabControl1.ActiveTab := uWordCorrect; // Активируем вкладку
      View.Parent := uWordCorrect;
      TDialogBuilder.Create(Self)
        .SetStyleManager(IosStyleManager)
        .SetView(View)
        .SetPosition(TDialogViewPosition.Bottom)
        .SetCancelButton('Cancel',
        procedure (Dialog: IDialog; Which: Integer) begin
          KeepWebBrowserInvisible(True);
          if Assigned(View) then
           begin
            // Освободить экземпляр фрейма из памяти
            DestroyAndRemoveFrame(View);
           end;
        end
      )
      .Show;
    end
    else
    if TabControl1.ActiveTab = Core then
    begin
      TabControl1.ActiveTab := Core; // Активируем вкладку
      View.Parent := Core;
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
           end;
        end
      )
      .Show;
    end
    else
    begin
      TabControl1.ActiveTab := u17Minutis; // Активируем вкладку
      KeepWebBrowserInvisible(False);
      View.Parent := uKusi;
      TDialogBuilder.Create(Self)
        .SetStyleManager(IosStyleManager)
        .SetView(View)
        .SetPosition(TDialogViewPosition.Bottom)
        .SetCancelButton('Cancel',
        procedure (Dialog: IDialog; Which: Integer) begin
          KeepWebBrowserInvisible(True);
          if Assigned(View) then
           begin
            // Освободить экземпляр фрейма из памяти
            DestroyAndRemoveFrame(View);
           end;
        end
      )
      .Show;
    end;
except
  on E: Exception do
  begin
    ShowNotification('Error: ' + E.Message, 0);
    KeepWebBrowserInvisible(True);
    Exit;
  end;
end;
end;

procedure TFormMain.actUpdatePrgExecute(Sender: TObject);
begin
try
  CheckForUpdate;
except
  if swtch1.IsChecked then ShowNotification('Error Update Programm', 0);
  Exit;
end;
end;

procedure TFormMain.actViewCardsExecute(Sender: TObject);
begin
  try
    Dec(uX);
    if privUsers then begin
    if uX <= 0 then begin
       Exit;
    end else
       MyUrl := '';
    end else TDialogService.ShowMessage('You do not have access to update cards!'+#13#10+'Write to the administrator to open access!');
  except
    on E: Exception do
    begin
       ShowNotification('FormShow Error: ' + E.Message, 0);
    end;
  end;
end;

procedure TFormMain.actViewChatExecute(Sender: TObject);
begin
try
  MultiView.HideMaster;
  ShowNotification('Repeating written sentences and words', 0);
  TabControl1.Tabs[2].Visible := True;
  TabControl1.GotoVisibleTab(2);
  TabControl1.Tabs[0].Visible := False;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.Tabs[2].SetFocus;
  mmoInfo.Lines.Clear;
except;
  if swtch1.IsChecked then ShowNotification('Error Repeating written sentences and words', 0);
  Exit;
end;
end;

procedure TFormMain.actViewKusiExecute(Sender: TObject);
begin
try
  xKusiwer := 0;
  mmoKusi.Lines.Clear;
  ShowNotification('Selection of adverbs, questions, games', 0);
  {$IFDEF ANDROID}
  TDialogBuilder.Create(Self)
    .SetTitle('Choose an action')
    .SetSingleChoiceItems(
      [
      'Adverbid (Наречия)',           //0
      'Küsimused (Вопросы)',          //1
      'Antonüümid (Антонимы)',        //2
      'Postpositsioonid (Послелоги)', //3
      'Mängud (Игры)',                //4
      'AI Dialoog'                    //5
    ], xKusiwer)
    .SetPositiveButton('Cancel')
    .SetNegativeButton('Sellect',
      procedure (Dialog: IDialog; Which: Integer) begin
        xKusiwer := Dialog.Builder.CheckedItem;
        if xKusiwer = 0 then begin
          // cbb1.Items.Clear; cbb1.Items.Text := GetKusi; if Length(Trim(jsonTxT)) = 0 then jsonTxT := GetKusiMAAll;
           LoadSheetQuestData;
           TDialogService.ShowMessage('Adverbid on!');
        end;
        if xKusiwer = 1 then  begin
          // cbb1.Items.Clear; cbb1.Items.Text := GetKusiM;
           LoadSheetExampData;
           TDialogService.ShowMessage('Küsimused on!');
        end;
        if xKusiwer = 2 then begin
           LoadSheetData;
           TDialogService.ShowMessage('Antonüümid on!');
        end;
        if xKusiwer = 3 then begin
           LoadPostpositsiooneSheetData;
           TDialogService.ShowMessage('Postpositsioone on!');
        end;
        if xKusiwer = 4 then Self.actNumbridEEExecute(Self);
        if xKusiwer = 5 then begin
           try
            if Length(Trim(uApiGemini)) = 0 then uApiGemini := FormMain.GetKeyGemini('Lama8b','4',uGoogleApiGemeni);
               Self.actGetAIExecute(Self);
           except
            ShowNotification('Api AI error', 0);
            Exit;
           end;
        end;
      end
    )
    .Show;
  {$ENDIF}
except
  on E: EExternalException do begin
     ShowNotification('Error selection '+E.Message, 0);
     Exit;
  end;
end;
end;

procedure TFormMain.actViewSettingsExecute(Sender: TObject);
begin
try
  xSettinwer := 0;
  MultiView.HideMaster;
  ShowNotification('Selecting program settings', 0);
  {$IFDEF ANDROID}
  TDialogBuilder.Create(Self)
    .SetTitle('Choose an action')
    .SetSingleChoiceItems(
      [
      'Program update',        //0
      'Delete bases',          //1
      'Turn on the voice',     //2
      'Turn off the voice',    //3
      'Turn on use api Tartu', //4
      'Turn off use api Tartu'
    ], xSettinwer)
    .SetPositiveButton('Cancel')
    .SetNegativeButton('Sellect',
      procedure (Dialog: IDialog; Which: Integer) begin
        xSettinwer := Dialog.Builder.CheckedItem;
        if xSettinwer = 0 then Self.actUpdatePrgExecute(Self);
        if xSettinwer = 1 then Self.actAdminExecute(Self);
        if xSettinwer = 2 then begin chkSoundPlay := True; TDialogService.ShowMessage('Turn on the voice!'); end;
        if xSettinwer = 3 then begin chkSoundPlay := False; TDialogService.ShowMessage('Turn off the voice!'); end;
        if xSettinwer = 4 then begin uApiTartu := True; TDialogService.ShowMessage('Turn on use api Tartu!'); end;
        if xSettinwer = 5 then begin uApiTartu := False; TDialogService.ShowMessage('Turn off use api Tartu!'); end;
      end
    )
    .Show;
  {$ENDIF}
except
  ShowNotification('Error selecting program settings', 0);
  Exit;
end;
end;

procedure TFormMain.actWordCorrectExecute(Sender: TObject);
begin
try
  if (Pos('test@test.tst', EditEmail.Text) > 0) then begin
     Dec(sContID);
     TDialogService.ShowMessage('Please register for the program!');
  end;
  if ((sContID <= 0)and(Pos('test@test.tst', EditEmail.Text) > 0)) then
  begin
   uID := False;
   sContID := 3;
   MultiView.HideMaster;
   TabControl1.Tabs[0].Visible := True;
   for var i := 1 to TabControl1.TabCount - 1 do
    TabControl1.Tabs[i].Visible := False;
    TabControl1.TabIndex := 0;
    TabControl1.ActiveTab := uAuth1;
    EditEmail.Text := '';
    EditPassword.Text := '';
    if swtch1.IsChecked then
       ShowNotification('Please register', 0); // Show notification for user to register
  end else begin
    MyUrl := '';
    MultiView.HideMaster;
    TabControl1.Tabs[8].Visible := True;
    TabControl1.GotoVisibleTab(8);
    TabControl1.Tabs[0].Visible := False;
    TabControl1.Tabs[1].Visible := False;
    TabControl1.Tabs[2].Visible := False;
    TabControl1.Tabs[4].Visible := False;
    TabControl1.Tabs[5].Visible := False;
    TabControl1.Tabs[6].Visible := False;
    TabControl1.Tabs[7].Visible := False;
    TabControl1.Tabs[3].Visible := False;
    TabControl1.Tabs[8].SetFocus;
    if not sLevelWords then begin
       sLevelWords := True;
       TransferEvent(0);
    end;
  end;
except
  Exit;
end;
end;

procedure TFormMain.BiometricAuth1AuthenticateFail(Sender: TObject;
  const FailReason: TBiometricFailReason; const ResultMessage: string);
begin
try
  uID := False;
  TabControl1.Tabs[0].Visible := True;
  TabControl1.Tabs[1].Visible := False;
  TabControl1.Tabs[2].Visible := False;
  TabControl1.Tabs[3].Visible := False;
  TabControl1.Tabs[4].Visible := False;
  TabControl1.Tabs[5].Visible := False;
  TabControl1.Tabs[6].Visible := False;
  TabControl1.Tabs[7].Visible := False;
  TabControl1.Tabs[8].Visible := False;
  TabControl1.TabIndex := 0;
  TabControl1.ActiveTab := uAuth1;
  if swtch1.IsChecked then ShowNotification('Authentication Fail'+#13#10+ResultMessage, 0);
except
  Exit;
end;
end;

procedure TFormMain.BiometricAuth1AuthenticateSuccess(Sender: TObject);
begin
   if uID then begin
      TabControl1.Tabs[1].Visible := True;
      TabControl1.GotoVisibleTab(1);
      TabControl1.TabIndex := 1;
      TabControl1.Tabs[0].Visible := False;
      TabControl1.Tabs[2].Visible := False;
      TabControl1.Tabs[3].Visible := False;
      TabControl1.Tabs[4].Visible := False;
      TabControl1.Tabs[5].Visible := False;
      TabControl1.Tabs[6].Visible := False;
      TabControl1.Tabs[7].Visible := False;
      TabControl1.Tabs[8].Visible := False;
      TabControl1.Tabs[1].SetFocus;
      Arc1.Fill.Color := TAlphaColorRec.Green;
      if swtch1.IsChecked then ShowNotification('Authentication', 0);
   end;
   if swtch1.IsChecked then ShowNotification('Authentication Success', 0);
end;

procedure TFormMain.btnVolumeFrontClick(Sender: TObject);
begin
if Length(Trim(FrontLabel.Text)) = 0 then Exit;
try
   if privUsers then begin
      FSelectedLanguage := 'et';
      SpeakText(FrontLabel.Text);
   end else TDialogService.ShowMessage('You do not have access to play cards!'+#13#10+'Write to the administrator to open access!');
except
   on E: Exception do begin
      ShowNotification('Error SpeakText '+#13#10+E.Message, 0);
      Exit;
   end;
end;
end;

initialization
  IdSSLOpenSSLHeaders.Load;

end.
