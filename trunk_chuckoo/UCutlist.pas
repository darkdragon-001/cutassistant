UNIT UCutlist;

INTERFACE

USES
  Contnrs, Settings_dialog, Movie, UCutApplicationBase;

CONST
  cutlist_Extension                = '.cutlist';

TYPE
  TCutlist = CLASS;

  Tcut = CLASS
  PRIVATE
  PUBLIC
    index: integer;
    pos_from, pos_to: double;
    frame_from, frame_to: integer;
    FUNCTION DurationFrames: integer;
  END;

  TCutlistMode = (clmCutOut, clmCrop);
  TCutlistSaveMode = (csmNeverAsk, csmAskBeforeOverwrite, csmAskWhenSavingFirstTime, csmAlwaysAsk);

  TCutlistCallBackMethod = PROCEDURE(cutlist: TCutlist) OF OBJECT;

  TCutlist = CLASS(TObjectLIst)
  PRIVATE
    FSettings: TSettings;
    FMovieInfo: TMovieInfo;
    FIDOnServer: STRING;
    FRatingOnServer: double;
    FHasChanged: boolean;
    FRefreshCallBack: TCutlistCallBackMethod;
    FMode: TCutlistMode;
    FSuggestedMovieName: STRING;
    FFrameDuration, FFrameRate: double;
    FUNCTION GetCut(iCut: Integer): TCut;
    PROCEDURE SetIDOnServer(CONST Value: STRING);
    PROCEDURE FillCutPosArray(VAR CutPosArray: ARRAY OF double);
    PROCEDURE SetRefreshCallBack(CONST Value: TCutlistCallBackMethod);
    PROCEDURE SetMode(CONST Value: TCutlistMode);
    PROCEDURE SetSuggestedMovieName(CONST Value: STRING);
    FUNCTION CutApplication: TCutApplicationBase;
    PROCEDURE SetFrameDuration(d: double);
    PROCEDURE SetFrameRate(d: double);
  PUBLIC
    //Info
    RatingByAuthor: Integer;
    RatingByAuthorPresent: boolean;
    EPGError,
      MissingBeginning, MissingEnding,
      MissingVideo, MissingAudio,
      OtherError: boolean;
    ActualContent, OtherErrorDescription,
      UserComment, Author: STRING;

    FramesPresent: boolean;
    SavedToFilename: STRING;
    RatingSent: boolean;
    CONSTRUCTOR create(Settings: TSettings; MovieInfo: TMovieInfo);
    PROPERTY FrameDuration: double READ FFrameDuration WRITE SetFrameDuration;
    PROPERTY FrameRate: double READ FFrameRate WRITE SetFrameRate;
    PROPERTY RefreshCallBack: TCutlistCallBackMethod READ FRefreshCallBack WRITE SetRefreshCallBack;
    PROCEDURE RefreshGUI;
    PROPERTY Cut[iCut: Integer]: TCut READ GetCut; DEFAULT;
    FUNCTION AddCut(pos_from, pos_to: double): boolean;
    FUNCTION ReplaceCut(pos_from, pos_to: double; CutToReplace: integer): boolean;

    //HG
    FUNCTION GetCutNr(pos_curr: double): integer;
    //HG

    FUNCTION DeleteCut(dCut: Integer): boolean;
    PROPERTY Mode: TCutlistMode READ FMode WRITE SetMode;

    PROPERTY IDOnServer: STRING READ FIDOnServer WRITE SetIDOnServer;
    PROPERTY HasChanged: boolean READ FHasChanged;
    FUNCTION UserShouldSendRating: boolean;
    FUNCTION CutCommand: STRING;
    FUNCTION cut_times_valid(VAR pos_from, pos_to: double; do_not_test_cut: integer; VAR interfering_cut: integer): boolean;
    FUNCTION FilenameSuggestion: STRING;
    PROPERTY SuggestedMovieName: STRING READ FSuggestedMovieName WRITE SetSuggestedMovieName;
    FUNCTION TotalDurationOfCuts: double;
    FUNCTION NextCutPos(CurrentPos: double): double;
    FUNCTION PreviousCutPos(CurrentPos: double): double;

    FUNCTION clear_after_confirm: boolean;
    PROCEDURE init;
    PROCEDURE sort;
    FUNCTION convert: TCutlist;
    FUNCTION LoadFromFile(Filename: STRING): boolean;
    FUNCTION EditInfo: boolean;
    FUNCTION Save(AskForPath: boolean): boolean;
    FUNCTION SaveAs(Filename: STRING): boolean;

    PROPERTY RatingOnServer: double READ FRatingOnServer WRITE FRatingOnServer;
  END;


IMPLEMENTATION

USES
  Forms, windows, dialogs, sysutils, cutlistINfo_dialog, controls, iniFiles, strutils,
  utils, UCutApplicationAsfbin, UCutApplicationMP4Box;

{ TCutlist }

PROCEDURE TCutlist.SetFrameDuration(d: double);
BEGIN
  IF d < 0 THEN d := 0;
  FFrameDuration := d;
  IF d > 0 THEN FFrameRate := 1 / d
  ELSE FFrameRate := 0;
END;

PROCEDURE TCutlist.SetFrameRate(d: double);
BEGIN
  IF d < 0 THEN d := 0;
  FFrameRate := d;
  IF d > 0 THEN FFrameDuration := 1 / d
  ELSE FFrameDuration := 0;
END;

FUNCTION TCutlist.AddCut(pos_from, pos_to: double): boolean;
VAR
  cut                              : TCut;
  icut                             : integer;
BEGIN
  result := false;
  IF NOT cut_times_valid(pos_from, pos_to, -1, iCut) THEN exit;

  cut := Tcut.Create;
  cut.pos_from := pos_from;
  cut.pos_to := pos_to;
  cut.index := self.Add(cut);
  self.FHasChanged := true;
  self.IDOnServer := '';
  self.FramesPresent := false;
  result := true;

  self.sort;
  self.RefreshGUI;
END;


//HG
//    function GetCutNr(pos_curr: double;): integer;

FUNCTION TCutlist.GetCutNr(pos_curr: double): integer;
VAR
  icut                             : integer;
  ckcut                            : integer;


BEGIN
  ckcut := -1;

  FOR iCut := 0 TO self.Count - 1 DO BEGIN

    // suche ob position innerhalb eines cuts liegt
    IF (Cut[iCut].pos_to >= pos_curr) AND (Cut[iCut].pos_from <= pos_curr) THEN BEGIN
      ckcut := iCut;
      break;
    END ELSE
      ckcut := -1;
  END;

  // -1 auuserhalb der cuts 0... nummer des cuts in dem die pos liegt
  result := ckcut;

END;









//>HG



FUNCTION TCutlist.ReplaceCut(pos_from, pos_to: double;
  CutToReplace: integer): boolean;
VAR
  icut                             : integer;
BEGIN
  IF cut_times_valid(pos_from, pos_to, CutToReplace, iCut) THEN BEGIN
    self[CutToReplace].pos_from := pos_from;
    self[CutToReplace].pos_to := pos_to;
    self.FHasChanged := true;
    self.IDOnServer := '';
    self.FramesPresent := false;
    result := true;
    self.sort;
    self.RefreshGUI;
  END ELSE BEGIN
    result := false;
  END;
END;

FUNCTION TCutlist.DeleteCut(dCut: Integer): boolean;
VAR
  iCut                             : Integer;
BEGIN
  self.Delete(dCut);
  self.FHasChanged := true;
  self.IDOnServer := '';
  FOR icut := 0 TO self.Count - 1 DO BEGIN
    self.Cut[iCut].index := iCut;
  END;
  result := true;
  self.RefreshGUI;
END;

FUNCTION TCutlist.clear_after_confirm: boolean;
//true if cleared, false if cancelled
VAR
  message_string                   : STRING;
  CanClear                         : boolean;
BEGIN
  canClear := true;
  IF self.HasChanged THEN BEGIN
    message_string := 'Save changes in current cutlist?';
    CASE application.messagebox(PChar(message_string), 'Cutlist not saved', MB_YESNOCANCEL + MB_DEFBUTTON3 + MB_ICONQUESTION) OF
      IDYES: BEGIN
          CanClear := self.Save(false); //Can Clear if saved successfully
        END;
      IDNO: BEGIN
          CanClear := true;
        END;
    ELSE BEGIN
        CanClear := false;
      END;
    END;
  END;
  IF CanClear THEN BEGIN
    self.init;
  END;
  result := CanClear;
END;

FUNCTION TCutlist.convert: TCutlist;
VAR
  newCutlist                       : TcutLIst;
  iCut                             : integer;
  pos_Prev, dur, _pos_From         : double;
  Frame_prev                       : integer;
  newCut                           : TCut;
BEGIN
  self.sort;
  newCutlist := TCutlist.Create(FSettings, FMovieInfo);
  newCutlist.FFrameRate := self.FFrameRate;
  newCutlist.FFrameDuration := self.FFrameDuration;
  newCutlist.FramesPresent := self.FramesPresent;
  newCutlist.SavedToFilename := self.SavedToFilename;
  newCutlist.Author := self.Author;
  newCutlist.RatingByAuthorPresent := self.RatingByAuthorPresent;
  newCutlist.RatingByAuthor := self.RatingByAuthor;
  newCutlist.EPGError := self.EPGError;
  newCutlist.ActualContent := self.ActualContent;
  newCutlist.MissingBeginning := self.MissingBeginning;
  newCutlist.MissingEnding := self.MissingEnding;
  newCutlist.MissingVideo := self.MissingVideo;
  newCutlist.MissingAudio := self.MissingAudio;
  newCutlist.OtherError := self.OtherError;
  newCutlist.OtherErrorDescription := self.OtherErrorDescription;
  newCutlist.SuggestedMovieName := self.SuggestedMovieName;
  newCutlist.UserComment := self.UserComment;
  newCutlist.IDOnServer := self.IDOnServer;
  newCutlist.RatingOnServer := self.RatingOnServer;
  newCutlist.RatingSent := self.RatingSent;

  IF self.Count > 0 THEN BEGIN
    pos_prev := 0;
    Frame_prev := 0;
    FOR iCut := 0 TO self.Count - 1 DO BEGIN
      dur := self[iCut].pos_from - pos_prev;
      IF dur > 0 THEN BEGIN
        newCut := TCut.Create;
        newCut.pos_from := pos_prev;
        newCut.pos_to := self[iCut].pos_from - FrameDuration;
        IF self.FramesPresent THEN BEGIN
          newCut.frame_from := frame_prev;
          newCut.frame_to := self[iCut].frame_from - 1;
        END;
        newCut.index := newCutlist.Add(newCut);
      END;
      pos_prev := self[iCut].pos_to + FrameDuration;
      frame_prev := self[iCut].frame_to + 1;
    END;

    //rest to End of File
    _pos_From := self.FMovieInfo.current_file_duration + FrameDuration;
    dur := _pos_From - pos_prev;
    IF dur > 0 THEN BEGIN
      newCut := TCut.Create;
      newCut.pos_from := pos_prev;
      newCut.pos_to := _pos_From - FrameDuration;
      IF self.FramesPresent THEN BEGIN
        newCut.frame_from := frame_prev;
        newCut.frame_to := round(self.FMovieInfo.current_file_duration * FrameRate); // this could be more accurate
      END;
      newCut.index := newCutlist.Add(newCut);
    END;
  END;
  IF self.Mode = clmCutOut THEN
    newcutlist.FMode := clmCrop
  ELSE
    newcutlist.FMode := clmCutOut;
  newCutlist.FHasChanged := self.HasChanged;
  newCutlist.FIDOnServer := self.FIDOnServer;

  result := newcutlist;
END;

CONSTRUCTOR TCutlist.create(Settings: TSettings; MovieInfo: TMovieInfo);
BEGIN
  INHERITED create;
  FSettings := Settings;
  FMovieInfo := MovieInfo;
  self.init;
END;

FUNCTION TCutlist.CutApplication: TCutApplicationBase;
BEGIN
  result := FSettings.GetCutApplicationByMovieType(FMovieInfo.MovieType);
END;

FUNCTION TCutlist.CutCommand: STRING;
VAR
  command                          : STRING;
  iCut                             : integer;
  ConvertedCutlist                 : TCutlist;
BEGIN
  IF self.Count = 0 THEN BEGIN
    showmessage('No cuts defined.');
    result := '';
    exit;
  END;

  IF self.Mode = clmCrop THEN BEGIN
    command := '';
    self.sort;
    FOR iCut := 0 TO self.Count - 1 DO BEGIN
      command := command + ' -start ' + FMovieInfo.FormatPosition(self[iCut].pos_from);
      command := command + ' -duration ' + FMovieInfo.FormatPosition(self[iCut].pos_to - self[iCut].pos_from);
    END;
  END ELSE BEGIN
    ConvertedCutlist := self.convert;
    command := ConvertedCutlist.CutCommand;
    FreeAndNIL(ConvertedCutlist);
  END;

  result := command;
END;

FUNCTION TCutlist.cut_times_valid(VAR pos_from, pos_to: double;
  do_not_test_cut: integer; VAR interfering_cut: integer): boolean;
VAR
  icut                             : integer;
BEGIN
  result := false;

  IF pos_to <= pos_from THEN exit;
  IF (pos_from > FMovieInfo.current_file_duration) OR (pos_to < 0) THEN exit;
  IF pos_from < 0 THEN pos_from := 0;
  IF pos_to > FMovieInfo.current_file_duration THEN BEGIN
    pos_to := FMovieInfo.current_file_duration;
  END;

  FOR iCut := 0 TO self.Count - 1 DO BEGIN
    IF iCut <> do_not_test_cut THEN BEGIN
      IF NOT ((pos_from > self[iCut].pos_to) OR (pos_to < self[iCut].pos_from)) THEN BEGIN
        {if ((pos_from >= (self[iCut] as TCut).pos_from)
        AND (pos_from <= (self[iCut] as TCut).pos_to))
        OR ((pos_to >= (self[iCut] as TCut).pos_from)
        AND (pos_to <= (self[iCut] as TCut).pos_to)) then begin }
        showmessage('Planned Cut is overlapping with cut # ' + inttostr(iCut) + '. Cut cannot be added.');
        interfering_cut := icut;
        //      self.Lcutlist.Selected := self.Lcutlist.items[iCut];
        //      self.DeleteCut.Enabled := true;
        exit;
      END;
      {if ((pos_from <= (self[iCut] as TCut).pos_from)
      AND (pos_to >= (self[iCut] as TCut).pos_to)) then begin
        showmessage('Planned Cut is overlapping with cut # ' + inttostr(iCut)+'. Cut cannot be added.');
        self.Lcutlist.Selected := self.Lcutlist.items[iCut];
        self.DeleteCut.Enabled := true;
        exit;
      end; }
    END;
  END;
  result := true;
END;

FUNCTION TCutlist.EditInfo: boolean;
BEGIN
  FCutlistInfo.original_movie_filename := FMovieInfo.current_filename;
  FCutlistInfo.CBFramesPresent.Checked := (self.FramesPresent AND NOT self.HasChanged);
  FCutlistInfo.lblFrameRate.Caption := FMovieInfo.FormatFrameRate(self.FrameDuration, 'C');
  IF self.Author = '' THEN
    FCutlistInfo.LAuthor.Caption := 'Cutlist Author unknown'
  ELSE
    FCutlistInfo.LAuthor.Caption := 'Cutlist by ' + self.Author;
  IF self.RatingByAuthorPresent THEN
    FCutlistInfo.RGRatingByAuthor.ItemIndex := self.RatingByAuthor
  ELSE
    FCutlistInfo.RGRatingByAuthor.ItemIndex := -1;
  FCutlistInfo.CBEPGError.Checked := self.EPGError;
  IF self.EPGError THEN
    FCutlistInfo.EActualContent.Text := self.ActualContent
  ELSE
    FCutlistInfo.EActualContent.Text := '';
  FCutlistInfo.CBMissingBeginning.Checked := self.MissingBeginning;
  FCutlistInfo.CBMissingEnding.Checked := self.MissingEnding;
  FCutlistInfo.CBMissingVideo.Checked := self.MissingVideo;
  FCutlistInfo.CBMissingAudio.Checked := self.MissingAudio;
  FCutlistInfo.CBOtherError.Checked := self.OtherError;
  IF self.OtherError THEN
    FCutlistInfo.EOtherErrorDescription.Text := self.OtherErrorDescription
  ELSE
    FCutlistInfo.EOtherErrorDescription.Text := '';
  FCutlistInfo.EUserComment.Text := self.UserComment;
  FCutlistInfo.EMovieName.Text := self.SuggestedMovieName;

  IF FCutlistInfo.ShowModal = mrOK THEN BEGIN
    self.FHasChanged := true;
    IF FCutlistInfo.RGRatingByAuthor.ItemIndex = -1 THEN BEGIN
      self.RatingByAuthorPresent := false;
      result := false;
    END ELSE BEGIN
      self.RatingByAuthorPresent := true;
      self.RatingByAuthor := FCutlistInfo.RGRatingByAuthor.ItemIndex;
      result := true;
    END;
    self.EPGError := FCutlistInfo.CBEPGError.Checked;
    IF self.EPGError THEN
      self.ActualContent := FCutlistInfo.EActualContent.Text
    ELSE
      self.ActualContent := '';
    self.MissingBeginning := FCutlistInfo.CBMissingBeginning.Checked;
    self.MissingEnding := FCutlistInfo.CBMissingEnding.Checked;
    self.MissingVideo := FCutlistInfo.CBMissingVideo.Checked;
    self.MissingAudio := FCutlistInfo.CBMissingAudio.Checked;
    self.OtherError := FCutlistInfo.CBOtherError.Checked;
    IF self.OtherError THEN
      self.OtherErrorDescription := FCutlistInfo.EOtherErrorDescription.Text
    ELSE
      self.OtherErrorDescription := '';
    self.UserComment := FCutlistInfo.EUserComment.Text;
    self.SuggestedMovieName := FCutlistInfo.EMovieName.Text;

    self.RefreshGUI;
  END ELSE BEGIN
    result := false;
  END;
END;

FUNCTION TCutlist.FilenameSuggestion: STRING;
BEGIN
  IF FMovieInfo.current_filename <> '' THEN BEGIN
    result := ChangeFileExt(extractfilename(FMovieInfo.current_filename), cutlist_Extension);
  END ELSE
    result := 'Cutlist_01.cutlist';
END;

PROCEDURE TCutlist.FillCutPosArray(VAR CutPosArray: ARRAY OF double);
VAR
  iCut                             : integer;
BEGIN
  self.sort;
  FOR iCut := 0 TO self.Count - 1 DO BEGIN
    CutPosArray[iCut * 2] := self.Cut[iCut].pos_from;
    CutPosArray[iCut * 2 + 1] := self.Cut[iCut].pos_to;
  END;
END;

FUNCTION TCutlist.GetCut(iCut: Integer): TCut;
BEGIN
  result := (self.items[iCut] AS TCut);
END;

PROCEDURE TCutlist.init;
BEGIN
  self.Clear;
  self.FFrameRate := 0;
  self.FFrameDuration := 0;
  self.FramesPresent := false;
  self.SavedToFilename := '';
  self.Author := Fsettings.UserName;
  self.RatingByAuthorPresent := false;
  self.RatingByAuthor := 3;
  self.EPGError := false;
  self.ActualContent := '';
  self.MissingBeginning := false;
  self.MissingEnding := false;
  self.MissingVideo := false;
  self.MissingAudio := false;
  self.OtherError := false;
  self.OtherErrorDescription := '';
  self.SuggestedMovieName := '';
  self.UserComment := '';
  self.IDOnServer := '';
  self.FRatingOnServer := -1;
  self.RatingSent := false;
  self.FHasChanged := false;

  self.RefreshGUI;
END;

FUNCTION TCutlist.LoadFromFile(Filename: STRING): boolean;
VAR
  section                          : STRING;
  apply_to_file, intended_options, intendedCutApp, intendedCutAppVersionStr, myCutApp, myOptions: STRING;
  myCutAppVersionWords, intendedCutAppVersionWords: ARFileVersion;
  message_string                   : STRING;
  Temp_DecimalSeparator            : char;
  cutlistfile                      : TCustomIniFile;
  iCUt, cCuts, ACut                : integer;
  cut                              : TCut;
  _pos_from, _pos_to               : double;
  _frame_from, _frame_to           : integer;
  CutAppAsfBin                     : TCutApplicationAsfbin;
BEGIN
  result := false;
  IF NOT fileexists(filename) THEN BEGIN
    showmessage('File not found:' + #13#10 + filename);
    exit;
  END;

  IF NOT self.clear_after_confirm THEN exit;

  cutlistfile := TInifile.Create(filename);
  Temp_DecimalSeparator := DecimalSeparator;
  DecimalSeparator := '.';
  TRY
    section := 'General';
    apply_to_file := cutlistfile.ReadString(section, 'ApplyToFile', '(Not found)');
    IF (NOT ansiSameText(apply_to_file, extractfilename(FMovieInfo.current_filename))) AND (NOT batchmode) THEN BEGIN
      message_string := 'Cut List File is intended for file:' + #13#10 + apply_to_file + #13#10 +
        'However, current file is: ' + #13#10 + extractfilename(FMovieInfo.current_filename) + #13#10 +
        'Continue anyway?';
      IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
        exit;
      END;
    END;

    //App + version
    IF self.CutApplication <> NIL THEN BEGIN
      intendedCutApp := cutlistfile.ReadString(section, 'IntendedCutApplication', '');
      intendedCutAppVersionStr := cutlistfile.ReadString(section, 'IntendedCutApplicationVersion', '');
      intendedCutAppVersionWords := Parse_File_Version(intendedCutAppVersionStr);
      myCutApp := extractfilename(CutApplication.Path);
      myCutAppVersionWords := Parse_File_Version(CutApplication.Version);

      IF (NOT batchmode) THEN BEGIN
        IF NOT ansiSameText(intendedCutApp, myCutApp) THEN BEGIN
          message_string := 'Cut List File is intended for Cut Application:' + #13#10 + IntendedCutApp + #13#10 +
            'However, current Cut Application is: ' + #13#10 + myCutApp + #13#10 +
            'Continue anyway?';
          IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
            exit;
          END;
        END ELSE IF (myCutAppVersionWords[0] <> intendedCutAppVersionWords[0])
          OR (myCutAppVersionWords[1] <> intendedCutAppVersionWords[1])
          OR (myCutAppVersionWords[2] < intendedCutAppVersionWords[2]) THEN BEGIN
          message_string := 'Cut List File is intended for Cut Application:' + #13#10
            + IntendedCutApp + ' ' + intendedCutAppVersionStr + #13#10 +
            'However, current Cut Application Version is: ' + #13#10 + CutApplication.Version + #13#10 +
            'Continue anyway?';
          IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
            exit;
          END;
        END;
      END;

      //options for asfbin
      IF self.CutApplication IS TCutApplicationAsfbin THEN BEGIN
        CutAppAsfBin := self.CutApplication AS TCutApplicationAsfbin;
        myOptions := CutAppAsfBin.CommandLineOptions;
        intended_options := cutlistfile.ReadString(section, 'IntendedCutApplicationOptions', myOptions);
        IF NOT ansiSameText(intended_options, myOptions) AND (NOT batchmode) THEN BEGIN
          message_string := 'Loaded options for external cut application are:' + #13#10 + intended_options + #13#10 +
            'However, current options are: ' + #13#10 + myOptions + #13#10 +
            'Replace current options by loaded options?';
          IF application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES THEN BEGIN
            CutAppAsfBin.CommandLineOptions := intended_options;
          END;
        END;
      END;
    END;

    //Number of Cuts
    cCuts := cutlistfile.ReadInteger(section, 'NoOfCuts', 0);
    FrameRate := cutlistfile.ReadFloat(section, 'FramesPerSecond', 0);

    IF (FrameRate > 0) AND (FMovieInfo.frame_duration > 0) THEN BEGIN
      IF (NOT batchmode) AND (FMovieInfo.FrameCount <> Trunc(FrameRate * FMovieInfo.current_file_duration)) THEN BEGIN
        message_string := 'The frame rate of the cutlist differs from the frame rate of the movie file.'
          + #13#10 + 'If the rate of the movie file is used, you may get a different result'
          + #13#10 + 'as expected by the author of the cutlist.'
          + #13#10
          + #13#10 + 'Frame rate of cutlist:    %.6f'#9'Frame rate of movie file: %.6f'
          + #13#10
          + #13#10 + 'Do you want to use the frame rate of the cutlist?'
          + #13#10 + '(Selecting "No" will use the frame rate of the movie file)';
        IF Application.MessageBox(
          PChar(Format(message_string, [FrameRate, 1 / FMovieInfo.frame_duration])),
          'Frame rate difference',
          MB_YESNO + MB_ICONEXCLAMATION + MB_DEFBUTTON2
          ) = IDNO THEN BEGIN
          FrameDuration := FMovieInfo.frame_duration;
        END;
      END;
    END
    ELSE BEGIN
      FrameDuration := FMovieInfo.frame_duration;
    END;

    //info
    section := 'Info';
    self.Author := cutlistfile.ReadString(section, 'Author', '');
    self.RatingByAuthor := cutlistfile.ReadInteger(section, 'RatingByAuthor', -1);
    IF self.RatingByAuthor = -1 THEN
      self.RatingByAuthorPresent := false
    ELSE
      self.RatingByAuthorPresent := true;
    self.EPGError := cutlistfile.ReadBool(section, 'EPGError', false);
    IF self.EPGError THEN
      self.ActualContent := cutlistfile.ReadString(section, 'ActualContent', '')
    ELSE
      self.ActualContent := '';
    self.MissingBeginning := cutlistfile.ReadBool(section, 'MissingBeginning', false);
    self.MissingEnding := cutlistfile.ReadBool(section, 'MissingEnding', false);
    self.MissingVideo := cutlistfile.ReadBool(section, 'MissingVideo', false);
    self.MissingAudio := cutlistfile.ReadBool(section, 'MissingAudio', false);
    self.OtherError := cutlistfile.ReadBool(section, 'OtherError', false);
    IF self.OtherError THEN
      self.OtherErrorDescription := cutlistfile.ReadString(section, 'OtherErrorDescription', '')
    ELSE
      self.OtherErrorDescription := '';
    self.SuggestedMovieName := cutlistfile.ReadString(section, 'SuggestedMovieName', '');
    self.UserComment := cutlistfile.ReadString(section, 'UserComment', '');

    self.FramesPresent := true;

    FOR iCut := 0 TO cCuts - 1 DO BEGIN
      section := 'Cut' + inttostr(iCut);
      _pos_from := cutlistfile.ReadFloat(section, 'Start', 0);
      _pos_to := _pos_from + cutlistfile.ReadFloat(section, 'Duration', 0) - FrameDuration;
      _Frame_from := cutlistfile.ReadInteger(section, 'StartFrame', -1);
      _Frame_to := _frame_from + cutlistfile.ReadInteger(section, 'DurationFrames', -1) - 1;

      IF self.cut_times_valid(_pos_from, _pos_to, -1, aCut) THEN BEGIN
        cut := Tcut.Create;
        cut.pos_from := _pos_from;
        cut.pos_to := _pos_to;
        IF (_frame_from < 0) OR (_frame_to < 0) THEN BEGIN
          self.FramesPresent := false;
        END ELSE BEGIN
          cut.frame_from := _Frame_from;
          cut.frame_to := _frame_to;
        END;
        cut.index := self.Add(cut);
      END;
    END;

  FINALLY
    DecimalSeparator := Temp_DecimalSeparator;
    FreeAndNil(cutlistfile);
  END;

  self.FMode := clmCrop;
  self.FHasChanged := false;
  self.SavedToFilename := filename;
  result := true;
  IF NOT batchmode THEN BEGIN
     IF not FSettings.NotifyOnSave then
    showmessage(inttostr(self.Count) + ' of ' + inttostr(cCuts) + ' Cuts loaded.');
  END;
  self.RefreshGUI;
END;

FUNCTION TCutlist.NextCutPos(CurrentPos: double): double;
VAR
  CutPosArray                      : ARRAY OF double;
  iPos                             : integer;
BEGIN
  result := -1;
  setlength(CutPosArray, self.Count * 2);
  self.FillCutPosArray(CutPosArray);
  FOR iPos := 0 TO 2 * self.Count - 1 DO BEGIN
    IF CutPosArray[iPos] > CurrentPos THEN BEGIN
      result := CutPosArray[iPos];
      break;
    END;
  END;
END;

FUNCTION TCutlist.PreviousCutPos(CurrentPos: double): double;
VAR
  CutPosArray                      : ARRAY OF double;
  iPos                             : integer;
BEGIN
  result := -1;
  setlength(CutPosArray, self.Count * 2);
  self.FillCutPosArray(CutPosArray);
  FOR iPos := 2 * self.Count - 1 DOWNTO 0 DO BEGIN
    IF CutPosArray[iPos] < CurrentPos THEN BEGIN
      result := CutPosArray[iPos];
      break;
    END;
  END;
END;

PROCEDURE TCutlist.RefreshGUI;
BEGIN
  IF assigned(self.FRefreshCallBack) THEN RefreshCallBack(self);
END;

FUNCTION TCutlist.Save(AskForPath: boolean): boolean;
VAR
  cutlist_path, target_file        : STRING;
  message_string                   : STRING;
  saveDlg                          : TSaveDialog;
BEGIN
  result := false;
  IF self.Count = 0 THEN BEGIN
    showmessage('No cuts defined.');
    exit;
  END;

  IF self.SavedToFilename = '' THEN BEGIN
    CASE FSettings.SaveCutlistMode OF
      smWithSource: BEGIN //with source
          cutlist_path := extractFilePath(FMovieInfo.current_filename);
        END;
      smGivenDir: BEGIN //in given Dir
          cutlist_path := IncludeTrailingPathDelimiter(FSettings.CutlistSaveDir);
        END;
    ELSE BEGIN //with source
        cutlist_path := extractFilePath(FMovieInfo.current_filename);
      END;
    END;
    target_file := cutlist_path + self.FilenameSuggestion;
  END ELSE BEGIN
    target_file := self.SavedToFilename;
  END;

  IF (self.SavedToFilename = '') OR AskForPath THEN BEGIN
    //Display Save Dialog?
    AskForPath := AskForPath OR FSettings.CutlistNameAlwaysConfirm;
    IF fileexists(target_File) AND (NOT AskForPath) THEN BEGIN
      message_string := 'Target file already exists:' + #13#10 + #13#10 + target_file + #13#10 + #13#10 + 'Overwrite?';
      IF application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_DEFBUTTON2 + MB_ICONWARNING) <> IDYES THEN BEGIN
        AskForPath := true;
      END;
    END;
    IF AskForPath THEN BEGIN
      saveDlg := TSaveDialog.Create(Application.MainForm);
      saveDlg.Filter := 'Cutlists|*' + cutlist_Extension + '|All Files|*.*';
      saveDlg.FilterIndex := 1;
      saveDlg.Title := 'Save cutlist as...';
      saveDlg.InitialDir := cutlist_path;
      saveDlg.filename := self.FilenameSuggestion;
      saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
      IF saveDlg.Execute THEN BEGIN
        target_file := saveDlg.FileName;
        FreeAndNIL(saveDlg);
      END ELSE BEGIN
        FreeAndNIL(saveDlg);
        exit;
      END;
    END;

    cutlist_path := ExtractFilePath(target_file);
    IF NOT ForceDirectories(cutlist_path) THEN BEGIN
      IF NOT batchmode THEN
        showmessage('Could not create cutlist path ' + cutlist_path + '. Abort.');
      exit;
    END;
    IF fileexists(target_File) THEN BEGIN
      IF NOT deletefile(target_file) THEN BEGIN
        showmessage('Could not delete existing file ' + target_file + '. Abort.');
        exit;
      END;
    END;
  END;

  result := self.SaveAs(target_file);
END;

FUNCTION TCutlist.SaveAs(Filename: STRING): boolean;
//true if saved successfully
VAR
  cutlistfile                      : TCustomIniFile;
  section, cutApp, cutAppVer, cutAppOptions, cutCommand, message_string, OutputFileName: STRING;
  iCut, writtenCuts                : integer;
  temp_DecimalSeparator            : char;
  convertedCutlist                 : TCutlist;
  CutApplication                   : TCutApplicationBase;
  //iCommandLine: Integer;
BEGIN
  result := false;

  IF (NOT self.RatingByAuthorPresent) THEN BEGIN
    IF NOT self.EditInfo THEN exit;
  END;

  IF self.Mode = clmCrop THEN BEGIN
    self.sort;

    IF self.HasChanged THEN BEGIN
      IF self.Author = '' THEN BEGIN
        self.Author := Fsettings.UserName;
        RefreshGUI;
      END ELSE BEGIN
        IF self.Author <> Fsettings.UserName THEN BEGIN
          message_string := 'Do you want to replace the Author name of this cutlist' + #13#10 + '"' + self.Author + '"' + #13#10 +
            'by your own User Name?';
          IF (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
            self.Author := Fsettings.UserName;
            RefreshGUI;
          END;
        END;
      END;
    END;

    Temp_DecimalSeparator := DecimalSeparator;
    DecimalSeparator := '.';

    cutlistfile := TIniFile.Create(Filename);
    TRY
      section := 'General';
      cutlistfile.WriteString(section, 'Application', Application_name);
      cutlistfile.WriteString(section, 'Version', Application_version);
      cutlistfile.WriteString(section, 'comment1', 'The following parts of the movie will be kept, the rest will be cut out.');
      cutlistfile.WriteString(section, 'comment2', 'All values are given in seconds.');
      cutlistfile.WriteString(section, 'ApplyToFile', extractfilename(FMovieInfo.current_filename));
      cutlistfile.WriteInteger(section, 'OriginalFileSizeBytes', FMovieInfo.current_filesize);
      IF (FrameRate = 0) OR (FrameDuration = 0) THEN
        FrameDuration := FMovieInfo.frame_duration;
      cutlistfile.WriteFloat(section, 'FramesPerSecond', FrameRate);

      CutApplication := FSettings.GetCutApplicationByMovieType(FMovieInfo.MovieType);
      IF assigned(CutApplication) THEN BEGIN
        CutApplication.WriteCutlistInfo(CutlistFile, section);

        //Write Command Line Only for Cut Apps which do not require script files (Asfbin and MP4Box).
        //For other Apps (VD or Avidemux) this would be useless / problematic because:
        //- with these apps all commands are in the scripts
        //- the command would show the full path to the script files  (privacy of user!)
        //- the script files written while "prepareCutting" had to be deleted afterwards.
        IF (CutApplication IS TCutApplicationAsfbin)
          OR (CutApplication IS TCutApplicationMP4Box) THEN BEGIN
          OutputFileName := FMovieInfo.target_filename;
          IF OutputFileName = '' THEN OutputFileName := self.FSuggestedMovieName;
          IF OutputFileName = '' THEN OutputFileName := '<OutputFile>';

          //Fill CommandLine List
          CutApplication.PrepareCutting(extractfilename(extractFileName(FMovieInfo.current_filename)), OutputFileName, self);
          CutApplication.CommandLines.Delimiter := '|';
          CutApplication.CommandLines.QuoteChar := ' ';
          cutCommand := CutApplication.CommandLines.DelimitedText;
          cutlistfile.WriteString(section, 'CutCommandLine', cutCommand);
        END;
      END ELSE BEGIN
        cutApp := '';
        cutAppVer := '';
        cutAppOptions := '';
        cutCommand := '';

        cutlistfile.WriteString(section, 'IntendedCutApplication', cutApp);
        cutlistfile.WriteString(section, 'IntendedCutApplicationVersion', cutAppVer);
        cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', cutAppOptions);
        cutlistfile.WriteString(section, 'CutCommandLine', cutCommand);
      END;

      section := 'Info';
      cutlistfile.WriteString(section, 'Author', self.Author);
      IF self.RatingByAuthorPresent THEN
        cutlistfile.WriteInteger(section, 'RatingByAuthor', self.RatingByAuthor);
      cutlistfile.WriteBool(section, 'EPGError', self.EPGError);
      cutlistfile.WriteString(section, 'ActualContent', self.ActualContent);
      cutlistfile.WriteBool(section, 'MissingBeginning', self.MissingBeginning);
      cutlistfile.WriteBool(section, 'MissingEnding', self.MissingEnding);
      cutlistfile.WriteBool(section, 'MissingVideo', self.MissingVideo);
      cutlistfile.WriteBool(section, 'MissingAudio', self.MissingAudio);
      cutlistfile.WriteBool(section, 'OtherError', self.OtherError);
      cutlistfile.WriteString(section, 'OtherErrorDescription', self.OtherErrorDescription);
      cutlistfile.WriteString(section, 'SuggestedMovieName', self.SuggestedMovieName);
      cutlistfile.WriteString(section, 'UserComment', self.UserComment);

      writtenCuts := 0;

      FOR iCut := 0 TO self.Count - 1 DO BEGIN
        section := 'Cut' + inttostr(writtenCuts);
        inc(writtenCuts);
        cutlistfile.WriteFloat(section, 'Start', self[iCut].pos_from);
        IF self.FramesPresent THEN
          cutlistfile.WriteInteger(section, 'StartFrame', self[iCut].frame_from)
        ELSE IF cutlistfile.ValueExists(section, 'StartFrame') THEN
          cutlistfile.DeleteKey(section, 'StartFrame');
        cutlistfile.WriteFloat(section, 'Duration', self[iCut].pos_to - self[iCut].pos_from + FMovieInfo.frame_duration);
        IF self.FramesPresent THEN
          cutlistfile.WriteInteger(section, 'DurationFrames', self[iCut].DurationFrames)
        ELSE IF cutlistfile.ValueExists(section, 'DurationFrames') THEN
          cutlistfile.DeleteKey(section, 'DurationFrames');
      END;
      cutlistfile.WriteInteger('General', 'NoOfCuts', writtenCuts);
      result := true;

      IF self.FHasChanged THEN BEGIN
        self.FIDOnServer := '';
        self.FHasChanged := false;
      END;
      self.SavedToFilename := filename;

    FINALLY
      DecimalSeparator := Temp_DecimalSeparator;
      FreeAndNil(cutlistfile);
    END;
  END ELSE BEGIN
    ConvertedCutlist := self.convert;
    TRY
      result := ConvertedCutlist.SaveAs(filename);
      self.FHasChanged := ConvertedCutlist.HasChanged;
      self.SavedToFilename := ConvertedCutlist.SavedToFilename;
      self.IDOnServer := convertedCutlist.IDOnServer;
    FINALLY
      FreeAndNil(ConvertedCutlist);
    END;
  END;
END;

PROCEDURE TCutlist.SetIDOnServer(CONST Value: STRING);
BEGIN
  FIDOnServer := Value;
END;

PROCEDURE TCutlist.SetMode(CONST Value: TCutlistMode);
BEGIN
  FMode := Value;
  self.RefreshGUI;
END;

PROCEDURE TCutlist.SetRefreshCallBack(CONST Value: TCutlistCallBackMethod);
BEGIN


  FRefreshCallBack := Value;


END;

PROCEDURE TCutlist.SetSuggestedMovieName(CONST Value: STRING);
BEGIN
  FSuggestedMovieName := AnsiReplaceStr(Value, '"', '''');
END;

PROCEDURE TCutlist.sort;
VAR
  Acut                             : TCut;
  iCut, jCut                       : integer;
BEGIN
  Acut := TCut.Create;
  FOR iCut := 0 TO self.Count - 2 DO BEGIN
    Acut.pos_from := self[iCut].pos_from;
    Acut.index := iCut;
    FOR jcut := icut + 1 TO self.Count - 1 DO BEGIN
      IF self[jcut].pos_from < Acut.pos_from THEN BEGIN
        Acut.pos_from := self[jCut].pos_from;
        Acut.index := jCut;
      END;
    END;
    IF Acut.index <> iCut THEN BEGIN
      Acut.pos_to := self[acut.index].pos_to;
      self[acut.index].pos_from := self[iCut].pos_from;
      self[acut.index].pos_to := self[iCut].pos_to;
      self[iCut].pos_from := Acut.pos_from;
      self[iCut].pos_to := Acut.pos_to;
    END;
  END;
  FreeAndNIL(Acut);
END;

FUNCTION TCutlist.TotalDurationOfCuts: double;
VAR
  iCut                             : Integer;
  dur                              : double;
BEGIN
  dur := 0;
  FOR iCut := 0 TO self.Count - 1 DO
    dur := dur + Cut[iCut].pos_to - Cut[iCut].pos_from;
  result := dur;
END;

FUNCTION TCutlist.UserShouldSendRating: boolean;
BEGIN
  result := (NOT self.RatingSent AND (self.IDOnServer > ''));
END;

{ Tcut }

FUNCTION Tcut.DurationFrames: integer;
BEGIN
  result := self.frame_to - self.frame_from + 1;
END;


END.
