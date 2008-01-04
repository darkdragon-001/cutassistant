UNIT Base64;

(*
 ================================================================
                    This software is FREEWARE
                    -------------------------
  If this software works, it was surely written by Dirk Claessens
                       <dirkcl@yucom.be>
               <dirk.claessens.dc@belgium.agfa.com>
  (If it does'nt, I don't know anything about it.)
 ================================================================
*)

INTERFACE
USES SysUtils, windows;

FUNCTION BufferToString(CONST pBuffer: Pointer; Size: DWORD): STRING;
PROCEDURE StringToBuffer(CONST s: STRING; VAR pBuffer: Pointer; VAR Size: DWORD);

FUNCTION BufferToBase64(CONST pBuffer: Pointer; Size: DWORD): STRING;
PROCEDURE Base64ToBuffer(CONST B64: STRING; VAR pBuffer: Pointer; VAR Size: DWORD);
FUNCTION StrTobase64(Buf: STRING): STRING;
FUNCTION Base64ToStr(B64: STRING): STRING;

IMPLEMENTATION

CONST
  Base64Code                       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    + 'abcdefghijklmnopqrstuvwxyz'
    + '0123456789+/';
  Pad                              = '=';

TYPE
  EBase64Error = Exception;

  //*****************************************************************************

FUNCTION BufferToString(CONST pBuffer: Pointer; Size: DWORD): STRING;
{var
  b: byte;
  i: DWORD;
  s: string;
  p: PChar;   }
BEGIN
  setString(result, PChar(PBuffer), Size);

  { //OLD VERSION:

    p := PChar(pBuffer);
    s := '';
    for i := 0 to Size-1 do begin
      s := s + p^;
      inc(p);
    end;
    result := s;}
END;

//*****************************************************************************

PROCEDURE StringToBuffer(CONST s: STRING; VAR pBuffer: Pointer; VAR Size: DWORD);
VAR
  i                                : DWORD;
  p                                : PChar;
BEGIN
  size := length(s);
  getMem(pBuffer, size);
  p := PChar(pBuffer);
  FOR i := 1 TO size DO BEGIN
    p^ := s[i];
    inc(p);
  END;
END;

//*****************************************************************************

PROCEDURE Base64ToBuffer(CONST B64: STRING; VAR pBuffer: Pointer; VAR Size: DWORD);
BEGIN
  StringToBuffer(Base64ToStr(B64), pBuffer, Size);
END;

//*****************************************************************************

FUNCTION BufferToBase64(CONST pBuffer: Pointer; Size: DWORD): STRING;
BEGIN
  result := StrToBase64(BufferToString(pBuffer, Size));
END;

//*****************************************************************************

FUNCTION StrTobase64(Buf: STRING): STRING;
VAR
  //  B3            : string[3];
  i                                : integer;
  x1, x2, x3, x4                   : byte;
  PadCount                         : integer;
BEGIN
  PadCount := 0;

  // we need at least 3 input bytes...
  WHILE length(Buf) < 3 DO BEGIN
    Buf := Buf + #0;
    inc(PadCount);
  END;

  // ...and all input must be an even multiple of 3
  WHILE (length(Buf) MOD 3) <> 0 DO BEGIN
    Buf := Buf + #0; // if not, zero padding is added
    inc(PadCount);
  END;

  Result := '';
  i := 1;

  // process 3-byte blocks or 24 bits
  WHILE i <= length(Buf) - 2 DO BEGIN
    // each 3 input bytes are transformed into 4 index values
    // in the range of  0..63, by taking 6 bits each step

    // 6 high bytes of first char
    x1 := (Ord(Buf[i]) SHR 2) AND $3F;

    // 2 low bytes of first char + 4 high bytes of second char
    x2 := ((Ord(Buf[i]) SHL 4) AND $3F)
      OR Ord(Buf[i + 1]) SHR 4;

    // 4 low bytes of second char + 2 high bytes of third char
    x3 := ((Ord(Buf[i + 1]) SHL 2) AND $3F)
      OR Ord(Buf[i + 2]) SHR 6;

    // 6 low bytes of third char
    x4 := Ord(Buf[i + 2]) AND $3F;

    // the index values point into the code array
    Result := Result
      + Base64Code[x1 + 1]
      + Base64Code[x2 + 1]
      + Base64Code[x3 + 1]
      + Base64Code[x4 + 1];
    inc(i, 3);
  END;

  // if needed, finish by forcing padding chars ('=')
  // at end of string
  IF PadCount > 0 THEN
    FOR i := Length(Result) DOWNTO 1 DO BEGIN
      Result[i] := Pad;
      dec(PadCount);
      IF PadCount = 0 THEN BREAK;
    END;

END;

//*****************************************************************************
// helper : given a char, returns the index in code table

FUNCTION Char2IDx(c: char): byte;
VAR
  i                                : integer;
BEGIN
  FOR i := 1 TO Length(Base64Code) DO
    IF Base64Code[i] = c THEN BEGIN
      Result := pred(i);
      EXIT;
    END;
  Result := Ord(Pad);
END;

//*****************************************************************************

FUNCTION Base64ToStr(B64: STRING): STRING;
VAR
  i,
    PadCount                       : integer;
  Block                            : STRING[3];
  x1, x2, x3                       : byte;
BEGIN
  // input _must_ be at least 4 chars long,
  // or multiple of 4 chars
  IF (Length(B64) < 4)
    OR (Length(B64) MOD 4 <> 0) THEN
    RAISE EBase64Error.Create('Base64ToStr: illegal input length!');
  //
  PadCount := 0;
  i := Length(B64);
  // count padding chars, if any
  WHILE (B64[i] = Pad)
    AND (i > 0) DO BEGIN
    inc(PadCount);
    dec(i);
  END;
  //
  Result := '';
  i := 1;
  SetLength(Block, 3);
  WHILE i <= Length(B64) - 3 DO BEGIN
    // reverse process of above
    x1 := (Char2Idx(B64[i]) SHL 2) OR (Char2IDx(B64[i + 1]) SHR 4);
    Result := Result + Chr(x1);
    x2 := (Char2Idx(B64[i + 1]) SHL 4) OR (Char2IDx(B64[i + 2]) SHR 2);
    Result := Result + Chr(x2);
    x3 := (Char2Idx(B64[i + 2]) SHL 6) OR (Char2IDx(B64[i + 3]));
    Result := Result + Chr(x3);
    inc(i, 4);
  END;

  // delete padding, if any
  WHILE PadCount > 0 DO BEGIN
    Delete(Result, Length(Result), 1);
    dec(PadCount);
  END;

END;

END.
