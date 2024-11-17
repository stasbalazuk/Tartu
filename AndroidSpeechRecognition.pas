unit AndroidSpeechRecognition;

interface

procedure StartSpeechRecognition;

implementation

uses
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  FMX.Helpers.Android,
  Androidapi.JNI.Speech,
  Androidapi.JNI.JavaTypes;

procedure StartSpeechRecognition;
var
  Intent: JIntent;
  Prompt, LanguagesString: string;
begin
  Intent := TJIntent.Create;
  Intent.setAction(TJRecognizerIntent.JavaClass.ACTION_RECOGNIZE_SPEECH);

  Prompt := 'SPEAK Now';
  Intent.putExtra(TJRecognizerIntent.JavaClass.EXTRA_PROMPT, StringToJString(Prompt));

  // Формируем строку с языками, разделенными запятыми
  LanguagesString := 'uk-UA,ru-RU,en-US,et-EE';

  // Передаем строку с языками в EXTRA_LANGUAGE_MODELS
  Intent.putExtra(TJRecognizerIntent.JavaClass.EXTRA_LANGUAGE_MODEL, TJRecognizerIntent.JavaClass.LANGUAGE_MODEL_FREE_FORM);
  Intent.putExtra(TJRecognizerIntent.JavaClass.EXTRA_LANGUAGE, StringToJString(LanguagesString));

  SharedActivity.startActivityForResult(Intent, 0);
end;
end.
