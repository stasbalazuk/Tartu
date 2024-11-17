unit libeay32;

{
  Import unit for the OpenSSL libeay32.dll library.
  Originally based on the work by Marco Ferrante.
    http://www.csita.unige.it/
    http://www.disi.unige.it/
  then on the Indy libraries
  and, of course, the C source code from http://www.openssl.org

  Only the parts that we need to use have been translated/imported. There are
  a whole load of functions in the library that aren't included here

  2010-03-11 Why re-invent the wheel. Indy has done a large chunk of this
  already so use it - IdSSLOpenSSLHeaders
  Now we generally just include stuff that isn't available in the Indy code.
  Primarily encryption stuff rather than SSL stuff.
}

interface

uses
  System.SysUtils, Windows,
  IdSSLOpenSSLHeaders;

const
  {$IFDEF MSWINDOWS}
  LIBEAY_DLL_NAME = 'libeay32.dll';
  {$ENDIF}
  {$ifdef Android}
  LIBEAY_DLL_NAME = 'libcrypto.so';
  {$endif Android}
  PROC_ADD_ALL_ALGORITHMS_NOCONF = 'OPENSSL_add_all_algorithms_noconf';
  PROC_ADD_ALL_ALGORITHMS = 'OpenSSL_add_all_algorithms';

  EVP_PKEY_RSA = IdSSLOpenSSLHeaders.EVP_PKEY_RSA;
  PKCS5_SALT_LEN = IdSSLOpenSSLHeaders.PKCS5_SALT_LEN;
  EVP_MAX_KEY_LENGTH = IdSSLOpenSSLHeaders.EVP_MAX_KEY_LENGTH;
  EVP_MAX_IV_LENGTH = IdSSLOpenSSLHeaders.EVP_MAX_IV_LENGTH;
  EVP_MAX_MD_SIZE = IdSSLOpenSSLHeaders.EVP_MAX_MD_SIZE;

type
  PEVP_PKEY = IdSSLOpenSSLHeaders.PEVP_PKEY;
  PRSA = IdSSLOpenSSLHeaders.PRSA;
  EVP_MD_CTX = IdSSLOpenSSLHeaders.EVP_MD_CTX;
  EVP_CIPHER_CTX = IdSSLOpenSSLHeaders.EVP_CIPHER_CTX;
  PEVP_CIPHER = IdSSLOpenSSLHeaders.PEVP_CIPHER;
  PEVP_MD = IdSSLOpenSSLHeaders.PEVP_MD;

type
  TSSLProgressCallbackFunction = procedure (status: integer; value: integer; cb_arg: pointer);
  TSSLPasswordCallbackFunction = function (buffer: TBytes; size: integer; rwflag: integer; u: pointer): integer; cdecl;
  TOpenSSL_InitFunction = procedure; cdecl;

type
  PEK_ARRAY = ^EK_ARRAY;
  EK_ARRAY = array of PByteArray;
  PUBK_ARRAY = array of PEVP_PKEY;
  PPUBK_ARRAY = ^PUBK_ARRAY;

function EVP_aes_256_cbc: PEVP_CIPHER; cdecl;
function EVP_md5: PEVP_MD; cdecl;
function EVP_sha1: PEVP_MD; cdecl;
function EVP_sha256: PEVP_MD; cdecl;
function EVP_PKEY_assign(pkey: PEVP_PKEY; key_type: integer; key: Pointer): integer; cdecl;
function EVP_PKEY_new: PEVP_PKEY; cdecl;
procedure EVP_PKEY_free(key: PEVP_PKEY); cdecl;
function EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; key: PRSA): integer;
function EVP_PKEY_size(pkey: PEVP_PKEY): integer; cdecl;

procedure EVP_CIPHER_CTX_init(a: PEVP_CIPHER_CTX); cdecl;
function EVP_CIPHER_CTX_cleanup(a: PEVP_CIPHER_CTX): integer; cdecl;
function EVP_CIPHER_CTX_block_size(ctx: PEVP_CIPHER_CTX): integer; cdecl;
procedure EVP_MD_CTX_init(ctx: PEVP_MD_CTX); cdecl;
function EVP_MD_CTX_cleanup(ctx: PEVP_MD_CTX): integer; cdecl;
function EVP_BytesToKey(cipher_type: PEVP_CIPHER; md: PEVP_MD; salt: PByte; data: PByte; datal: integer; count: integer; key: PByte; iv: PByte): integer; cdecl;
function EVP_EncryptInit_ex(ctx: PEVP_CIPHER_CTX; cipher_type: PEVP_CIPHER; impl: PENGINE; key: PByte; iv: PByte): integer; cdecl;
function EVP_EncryptInit(ctx: PEVP_CIPHER_CTX; cipher_type: PEVP_CIPHER; key: PByte; iv: PByte): integer; cdecl;
function EVP_EncryptUpdate(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer; data_in: PByte; inl: integer): integer; cdecl;
function EVP_EncryptFinal(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer): integer; cdecl;
function EVP_DecryptInit_ex(ctx: PEVP_CIPHER_CTX; cipher_type: PEVP_CIPHER; impl: PENGINE; key: PByte; iv: PByte): integer; cdecl;
function EVP_DecryptInit(ctx: PEVP_CIPHER_CTX; cipher_type: PEVP_CIPHER; key: PByte; iv: PByte): integer; cdecl;
function EVP_DecryptUpdate(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer; data_in: PByte; inl: integer): integer; cdecl;
function EVP_DecryptFinal(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer): integer; cdecl;
function EVP_SealInit(ctx: PEVP_CIPHER_CTX; cipher_type: PEVP_CIPHER; ek: PEK_ARRAY; ekl: PIntegerArray; iv: PByte; pubk: PPUBK_ARRAY; npubk: integer): integer; cdecl;
function EVP_SealUpdate(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer; data_in: PByte; inl: integer): integer;
function EVP_SealFinal(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer): integer; cdecl;
function EVP_OpenInit(ctx: PEVP_CIPHER_CTX; cipher_type: PEVP_CIPHER; ek: PByte; ekl: integer; iv: PByte; priv: PEVP_PKEY): integer; cdecl;
function EVP_OpenUpdate(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer; data_in: PByte; inl: integer): integer;
function EVP_OpenFinal(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer): integer; cdecl;
procedure EVP_DigestInit(ctx: PEVP_MD_CTX; md: PEVP_MD); cdecl;
function EVP_DigestInit_ex(ctx: PEVP_MD_CTX; md: PEVP_MD; impl: PENGINE): integer; cdecl;
function EVP_DigestUpdate(ctx: PEVP_MD_CTX; data: PByte; cnt: integer): integer; cdecl;
function EVP_DigestFinal(ctx: PEVP_MD_CTX; md: PByte; var s: cardinal): integer; cdecl;
function EVP_DigestFinal_ex(ctx: PEVP_MD_CTX; md: PByte; var s: cardinal): integer; cdecl;
procedure EVP_SignInit(ctx: PEVP_MD_CTX; md: PEVP_MD);
function EVP_SignInit_ex(ctx: PEVP_MD_CTX; md: PEVP_MD; impl: PENGINE): integer;
function EVP_SignUpdate(ctx: PEVP_MD_CTX; data: PByte; cnt: integer): integer;
function EVP_SignFinal(ctx: PEVP_MD_CTX; sig: PByte; var s: integer; pkey: PEVP_PKEY): integer; cdecl;
procedure EVP_VerifyInit(ctx: PEVP_MD_CTX; md: PEVP_MD);
function EVP_VerifyInit_ex(ctx: PEVP_MD_CTX; md: PEVP_MD; impl: PENGINE): integer;
function EVP_VerifyUpdate(ctx: PEVP_MD_CTX; data: PByte; cnt: integer): integer;
function EVP_VerifyFinal(ctx: PEVP_MD_CTX; sig: PByte; s: integer; pkey: PEVP_PKEY): integer; cdecl;

function X509_get_pubkey(cert: PX509): PEVP_PKEY; cdecl;

procedure BIO_free_all(a: PBIO); cdecl;

function PEM_write_bio_RSA_PUBKEY(bp: PBIO; x: PRSA): integer; cdecl;
function PEM_read_bio_PUBKEY(bp: PBIO; x: PPEVP_PKEY; cb: TSSLPasswordCallbackFunction; u: pointer): PEVP_PKEY; cdecl;
function PEM_write_bio_PUBKEY(bp: PBIO; x: PEVP_PKEY): integer; cdecl;

function RAND_load_file(const filename: PAnsiChar; max_bytes: longint): integer; cdecl;
function RAND_bytes(buf: PByte; num: integer): integer; cdecl;
function RAND_pseudo_bytes(buf: PByte; num: integer): integer; cdecl;

function RSA_generate_key(num: integer; e: Cardinal; cb: TSSLProgressCallbackFunction; cb_arg: pointer): PRSA; cdecl;
procedure RSA_free(r: PRSA); cdecl;

implementation

resourcestring
  sLibeay32NotLoaded = 'libeay32.dll not loaded';
  sAddAllAlgorithmsProcNotFound = 'OpenSSL_add_all_algorithms procedure not defined in libeay32.dll';


function EVP_aes_256_cbc: PEVP_CIPHER; cdecl external LIBEAY_DLL_NAME;
function EVP_md5; cdecl external LIBEAY_DLL_NAME;
function EVP_sha1; cdecl external LIBEAY_DLL_NAME;
function EVP_sha256; cdecl external LIBEAY_DLL_NAME;
function EVP_PKEY_assign; cdecl external LIBEAY_DLL_NAME;
function EVP_PKEY_new; cdecl external LIBEAY_DLL_NAME;
procedure EVP_PKEY_free; cdecl external LIBEAY_DLL_NAME;
function EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; key: PRSA): integer;
begin
  // Implemented as a macro in evp.h
  result := EVP_PKEY_assign(pkey, EVP_PKEY_RSA, PAnsiChar(key));
end;
function EVP_PKEY_size; cdecl external LIBEAY_DLL_NAME;

procedure EVP_CIPHER_CTX_init; cdecl external LIBEAY_DLL_NAME;
function EVP_CIPHER_CTX_cleanup; cdecl external LIBEAY_DLL_NAME;
function EVP_CIPHER_CTX_block_size; cdecl external LIBEAY_DLL_NAME;
function EVP_BytesToKey; cdecl external LIBEAY_DLL_NAME;
function EVP_EncryptInit_ex; cdecl external LIBEAY_DLL_NAME;
function EVP_EncryptInit; cdecl external LIBEAY_DLL_NAME;
function EVP_EncryptUpdate; cdecl external LIBEAY_DLL_NAME;
function EVP_EncryptFinal; cdecl external LIBEAY_DLL_NAME;
function EVP_DecryptInit_ex; cdecl external LIBEAY_DLL_NAME;
function EVP_DecryptInit; cdecl external LIBEAY_DLL_NAME;
function EVP_DecryptUpdate; cdecl external LIBEAY_DLL_NAME;
function EVP_DecryptFinal; cdecl external LIBEAY_DLL_NAME;
function EVP_SealInit; cdecl external LIBEAY_DLL_NAME;
function EVP_SealUpdate(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer; data_in: PByte; inl: integer): integer;
begin
  // EVP_SealUpdate is #defined to EVP_EncryptUpdate in evp.h
  result := EVP_EncryptUpdate(ctx, data_out, outl, data_in, inl);
end;
function EVP_SealFinal; cdecl external LIBEAY_DLL_NAME;
function EVP_OpenInit; cdecl external LIBEAY_DLL_NAME;
function EVP_OpenUpdate(ctx: PEVP_CIPHER_CTX; data_out: PByte; var outl: integer; data_in: PByte; inl: integer): integer;
begin
  // EVP_OpenUpdate is #defined to EVP_DecryptUpdate in evp.h
  result := EVP_DecryptUpdate(ctx, data_out, outl, data_in, inl);
end;
function EVP_OpenFinal; cdecl external LIBEAY_DLL_NAME;
procedure EVP_MD_CTX_init; cdecl external LIBEAY_DLL_NAME;
function EVP_MD_CTX_cleanup; cdecl external LIBEAY_DLL_NAME;
procedure EVP_DigestInit; external LIBEAY_DLL_NAME;
function EVP_DigestInit_ex; external LIBEAY_DLL_NAME;
function EVP_DigestUpdate; external LIBEAY_DLL_NAME;
function EVP_DigestFinal; external LIBEAY_DLL_NAME;
function EVP_DigestFinal_ex; external LIBEAY_DLL_NAME;
procedure EVP_SignInit(ctx: PEVP_MD_CTX; md: PEVP_MD);
begin
  // Defined as a macro in evp.h
  EVP_DigestInit(ctx, md);
end;
function EVP_SignInit_ex(ctx: PEVP_MD_CTX; md: PEVP_MD; impl: PENGINE): integer;
begin
  // Defined as a macro in evp.h
  result := EVP_DigestInit_ex(ctx, md, impl);
end;
function EVP_SignUpdate(ctx: PEVP_MD_CTX; data: PByte; cnt: integer): integer;
begin
  // Defined as a macro in evp.h
  result := EVP_DigestUpdate(ctx, data, cnt);
end;
function EVP_SignFinal; cdecl external LIBEAY_DLL_NAME;
procedure EVP_VerifyInit(ctx: PEVP_MD_CTX; md: PEVP_MD);
begin
  // Defined as a macro in evp.h
  EVP_DigestInit(ctx, md);
end;
function EVP_VerifyInit_ex(ctx: PEVP_MD_CTX; md: PEVP_MD; impl: PENGINE): integer;
begin
  // Defined as a macro in evp.h
  result := EVP_DigestInit_ex(ctx, md, impl);
end;
function EVP_VerifyUpdate(ctx: PEVP_MD_CTX; data: PByte; cnt: integer): integer;
begin
  // Defined as a macro in evp.h
  result := EVP_DigestUpdate(ctx, data, cnt);
end;
function EVP_VerifyFinal; cdecl external LIBEAY_DLL_NAME;

function X509_get_pubkey; cdecl; external LIBEAY_DLL_NAME;

procedure BIO_free_all; cdecl external LIBEAY_DLL_NAME;

function PEM_write_bio_RSA_PUBKEY; cdecl external LIBEAY_DLL_NAME;
function PEM_read_bio_PUBKEY; cdecl external LIBEAY_DLL_NAME;
function PEM_write_bio_PUBKEY; cdecl external LIBEAY_DLL_NAME;

function RAND_load_file; cdecl external LIBEAY_DLL_NAME;
function RAND_bytes; cdecl external LIBEAY_DLL_NAME;
function RAND_pseudo_bytes; cdecl external LIBEAY_DLL_NAME;

function RSA_generate_key; cdecl external LIBEAY_DLL_NAME;
procedure RSA_free; cdecl external LIBEAY_DLL_NAME;

end.