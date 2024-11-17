unit ssl_lib;

interface

var
  {$IFDEF MSWINDOWS}
    SSL_C_LIB : AnsiString = 'libeay32.dll';
  {$ENDIF MSWINDOWS}
  {$ifdef Android}
    SSL_C_LIB : string = 'libcrypto.so';
  {$endif Android}
  {$ifdef Defined(DARWIN) or Defined(MACOS)}
    SSL_C_LIB : string = 'libcrypto.dylib';
  {$endif Defined(DARWIN) or Defined(MACOS)}
  {$ifdef Defined(UNIX)}
    SSL_C_LIB : AnsiString = 'libcrypto.so';
  {$endif Defined(UNIX)}



function SSLCryptHandle: THandle;
function LoadSSLCrypt: Boolean;
function LoadFunctionCLib(const FceName: String; const ACritical : Boolean = True): Pointer;

implementation

uses
  QRS.Main,
  {$IFDEF UNIX}
    dynlibs,
  {$ELSE}
    {$IFDEF MSWINDOWS}
      Windows,
    {$ELSE}
      Posix.Dlfcn,
    {$ENDIF MSWINDOWS}
  {$ENDIF UNIX}
  System.IOUtils,
  System.SysUtils;


var hCrypt: THandle = 0;

function SSLCryptHandle: THandle;
begin
  Result := hCrypt;
end;

function LoadSSLCrypt: Boolean;
var AppPath,FileName: string;
begin
  if FileExists(TPath.Combine(TPath.GetHomePath, SSL_C_LIB)) then begin
     AppPath := TPath.GetHomePath;
     FileName := TPath.Combine(AppPath, SSL_C_LIB);
     FormMain.MemoLog.Lines.Add('Init SSL Lib : '+FileName);
  end else begin
     AppPath := 'assets\internal\';
     FileName := TPath.Combine(AppPath, SSL_C_LIB);
     FormMain.MemoLog.Lines.Add('Init SSL Lib : '+FileName);
  end;
  {$IFDEF UNIX}
    hCrypt := LoadLibrary(SSL_C_LIB);
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    hCrypt := LoadLibraryA(PAnsiChar(SSL_C_LIB));
  {$ENDIF}
  {$IFDEF Android}
    hCrypt := LoadLibrary(PChar(FileName));
  {$ENDIF}
  Result := hCrypt <> 0;
end;


function LoadFunctionCLib(const FceName: String; const ACritical : Boolean = True): Pointer;
begin
 if SSLCryptHandle = 0 then
  LoadSSLCrypt;
  {$IFNDEF MSWINDOWS}
   Result := GetProcAddress(SSLCryptHandle, PChar(FceName));
  {$ELSE}
  Result := Windows.GetProcAddress(SSLCryptHandle, PChar(FceName));
  {$ENDIF}
  if ACritical then
  begin
    if Result = nil then begin
{$ifdef fpc}
     raise Exception.CreateFmt('Error loading library. Func %s'#13#10'%s', [FceName, SysErrorMessage(GetLastOSError)]);
{$else}
     raise Exception.CreateFmt('Error loading library. Func %s'#13#10'%s', [FceName, SysErrorMessage(GetLastError)]);
{$endif}
    end;
  end;
end;


initialization

finalization
 if hCrypt <> 0 then
 {$IF not Defined(FPC) and Defined(MACOS)}
  dlclose(hCrypt);
 {$ELSE}
  FreeLibrary(hCrypt);
 {$ENDIF}

end.
