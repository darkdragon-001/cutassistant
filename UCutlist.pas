unit UCutlist;

interface

uses
  Contnrs, Settings_dialog, Movie, UCutApplicationBase;

const
  cutlist_Extension= '.cutlist';

type
  TCutlist = class;

  Tcut = class
  private
  public
    index: integer;
    pos_from, pos_to: double;
    frame_from, frame_to: integer;
    function DurationFrames: integer;
  end;

  TCutlistMode = (clmCutOut, clmCrop);
  TCutlistSaveMode = (csmNeverAsk, csmAskBeforeOverwrite, csmAskWhenSavingFirstTime, csmAlwaysAsk);

  TCutlistCallBackMethod = procedure(cutlist: TCutlist) of object;

  TCutlist = class(TObjectLIst)
  private
    FSettings: TSettings;
    FMovieInfo: TMovieInfo;
    FIDOnServer: String;
    FHasChanged: boolean;
    FRefreshCallBack: TCutlistCallBackMethod;
    FMode: TCutlistMode;
    FSuggestedMovieName: string;
    function GetCut(iCut: Integer): TCut;
    procedure SetIDOnServer(const Value: string);
    procedure FillCutPosArray(var CutPosArray: array of double);
    procedure SetRefreshCallBack(const Value: TCutlistCallBackMethod);
    procedure SetMode(const Value: TCutlistMode);
    procedure SetSuggestedMovieName(const Value: string);
    function CutApplication: TCutApplicationBase;
  public
    //Info
    RatingByAuthor: Integer;
    RatingByAuthorPresent: boolean;
    EPGError,
    MissingBeginning, MissingEnding,
    MissingVideo, MissingAudio,
    OtherError: boolean;
    ActualContent, OtherErrorDescription,
    UserComment, Author: string;

    FramesPresent: boolean;
    SavedToFilename: string;
    RatingSent: boolean;
    constructor create(Settings: TSettings; MovieInfo: TMovieInfo);
    property RefreshCallBack: TCutlistCallBackMethod read FRefreshCallBack write SetRefreshCallBack;
    procedure RefreshGUI;
    property Cut[iCut: Integer]:TCut read GetCut; default;
    function AddCut(pos_from, pos_to: double): boolean;
    function ReplaceCut(pos_from, pos_to: double; CutToReplace: integer): boolean;
    function DeleteCut(dCut: Integer): boolean;
    property Mode: TCutlistMode read FMode write SetMode;

    property IDOnServer: string read FIDOnServer write SetIDOnServer;
    property HasChanged: boolean read FHasChanged;
    function UserShouldSendRating: boolean;
    function CutCommand: String;
    function cut_times_valid(var pos_from, pos_to: double; do_not_test_cut: integer; var interfering_cut: integer): boolean;
    function FilenameSuggestion: string;
    property SuggestedMovieName: string read FSuggestedMovieName write SetSuggestedMovieName;
    function TotalDurationOfCuts: double;
    function NextCutPos(CurrentPos: double): double;
    function PreviousCutPos(CurrentPos: double): double;

    function clear_after_confirm: boolean;
    procedure init;
    procedure sort;
    function convert: TCutlist;
    function LoadFromFile(Filename: String): boolean;
    function EditInfo: boolean;
    function Save(AskForPath: boolean): boolean;
    function SaveAs(Filename: String): boolean;
  end;


implementation

uses
  Forms, windows, dialogs, sysutils, cutlistINfo_dialog, controls, iniFiles, strutils,
  utils, UCutApplicationAsfbin, UCutApplicationMP4Box;

{ TCutlist }

function TCutlist.AddCut(pos_from, pos_to: double): boolean;
var
  cut : TCut;
  icut: integer;
begin
  result := false;
  if not cut_times_valid(pos_from, pos_to, -1, iCut) then exit;

  cut := Tcut.Create;
  cut.pos_from := pos_from;
  cut.pos_to := pos_to;
  cut.index := self.Add(cut);
  self.FHasChanged := true;
  self.FramesPresent := false;
  result := true;

  self.sort;
  self.RefreshGUI;
end;

function TCutlist.clear_after_confirm: boolean;
//true if cleared, false if cancelled
var
  message_string: string;
  CanClear: boolean;
begin
  result := false;

  canClear := true;
  if self.HasChanged then begin
    message_string := 'Save changes in current cutlist?';
    case application.messagebox(PChar(message_string), 'Cutlist not saved', MB_YESNOCANCEL + MB_DEFBUTTON3 + MB_ICONQUESTION) of
      IDYES: begin
          CanClear := self.Save(false);      //Can Clear if saved successfully
        end;
      IDNO: begin
          CanClear := true;
        end;
      else begin
          CanClear := false;
        end;
    end;
  end;
  if CanClear then begin
    self.init;
  end;
  result := CanClear;
end;

function TCutlist.convert: TCutlist;
var
  newCutlist: TcutLIst;
  iCut: integer;
  pos_Prev, dur, _pos_From : double;
  Frame_prev: integer;
  newCut: TCut;
begin
  self.sort;
  newCutlist := TCutlist.Create(FSettings, FMovieInfo);
  newCutlist.FHasChanged := self.HasChanged;
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
  newCutlist.RatingSent := self.RatingSent;

  if self.Count > 0 then begin
    pos_prev := 0;
    Frame_prev := 0;
    for iCut := 0 to self.Count-1 do begin
      dur := self[iCut].pos_from - pos_prev;
      if dur > 0 then begin
        newCut := TCut.Create;
        newCut.pos_from := pos_prev;
        newCut.pos_to := self[iCut].pos_from - self.FMovieInfo.frame_duration;
        if self.FramesPresent then begin
          newCut.frame_from := frame_prev;
          newCut.frame_to := self[iCut].frame_from - 1;
        end;
        newCut.index := newCutlist.Add(newCut);
      end;
      pos_prev := self[iCut].pos_to + self.FMovieInfo.frame_duration;
      frame_prev := self[iCut].frame_to + 1;
    end;

    //rest to End of File
    _pos_From :=  self.FMovieInfo.current_file_duration + self.FMovieInfo.frame_duration;
    dur := _pos_From - pos_prev;
    if dur > 0 then begin
        newCut := TCut.Create;
        newCut.pos_from := pos_prev;
        newCut.pos_to := _pos_From - self.FMovieInfo.frame_duration;
        if self.FramesPresent then begin
          newCut.frame_from := frame_prev;
          newCut.frame_to := round(self.FMovieInfo.current_file_duration/self.FMovieInfo.frame_duration);   // this could be more accurate
        end;
        newCut.index := newCutlist.Add(newCut);
    end;
  end;
  if self.Mode = clmCutOut then
    newcutlist.FMode := clmCrop
  else
    newcutlist.FMode := clmCutOut;

  result := newcutlist;
end;

constructor TCutlist.create(Settings: TSettings; MovieInfo: TMovieInfo);
begin
  inherited create;
  FSettings := Settings;
  FMovieInfo := MovieInfo;
  self.init;
end;

function TCutlist.CutApplication: TCutApplicationBase;
begin
  result := FSettings.GetCutApplicationByMovieType(FMovieInfo.MovieType);
end;

function TCutlist.CutCommand: String;
var
  command: string;
  iCut : integer;
  ConvertedCutlist: TCutlist;
begin
  if self.Count = 0 then begin
    showmessage('No cuts defined.');
    result := '';
    exit;
  end;

  if self.Mode = clmCrop then begin
    command := '';
    self.sort;
    for iCut := 0 to self.Count-1 do begin
      command := command + ' -start ' + FMovieInfo.FormatPosition(self[iCut].pos_from);
      command := command + ' -duration ' + FMovieInfo.FormatPosition(self[iCut].pos_to - self[iCut].pos_from);
    end;
  end else begin
    ConvertedCutlist := self.convert;
    command := ConvertedCutlist.CutCommand;
    ConvertedCutlist.Free;
  end;

  result := command;
end;

function TCutlist.cut_times_valid(var pos_from, pos_to: double;
  do_not_test_cut: integer; var interfering_cut: integer): boolean;
var
  icut: integer;
begin
  result := false;

  if pos_to <= pos_from then exit;
  if (pos_from > FMovieInfo.current_file_duration) or (pos_to < 0) then exit;
  if pos_from < 0 then pos_from := 0;
  if pos_to > FMovieInfo.current_file_duration then begin
    pos_to := FMovieInfo.current_file_duration;
  end;

  for iCut := 0 to self.Count -1 do begin
   if iCut <> do_not_test_cut then begin
    if not ((pos_from > self[iCut].pos_to) OR (pos_to < self[iCut].pos_from)) then begin
    {if ((pos_from >= (self[iCut] as TCut).pos_from)
    AND (pos_from <= (self[iCut] as TCut).pos_to))
    OR ((pos_to >= (self[iCut] as TCut).pos_from)
    AND (pos_to <= (self[iCut] as TCut).pos_to)) then begin }
      showmessage('Planned Cut is overlapping with cut # ' + inttostr(iCut)+'. Cut cannot be added.');
      interfering_cut := icut;
//      self.Lcutlist.Selected := self.Lcutlist.items[iCut];
//      self.DeleteCut.Enabled := true;
      exit;
    end;
    {if ((pos_from <= (self[iCut] as TCut).pos_from)
    AND (pos_to >= (self[iCut] as TCut).pos_to)) then begin
      showmessage('Planned Cut is overlapping with cut # ' + inttostr(iCut)+'. Cut cannot be added.');
      self.Lcutlist.Selected := self.Lcutlist.items[iCut];
      self.DeleteCut.Enabled := true;
      exit;
    end; }
   end;
  end;
  result := true;
end;

function TCutlist.DeleteCut(dCut: Integer): boolean;
var
  iCut: Integer;
begin
  self.Delete(dCut);
  self.FHasChanged := true;
  for icut := 0 to self.Count-1 do begin
    self.Cut[iCut].index := iCut;
  end;
  result := true;
  self.RefreshGUI;
end;

function TCutlist.EditInfo: boolean;
begin
  FCutlistInfo.original_movie_filename := FMovieInfo.current_filename;
  FCutlistInfo.CBFramesPresent.Checked := (self.FramesPresent and not self.HasChanged);
  if self.Author = '' then
    FCutlistInfo.LAuthor.Caption := 'Cutlist Author unknown'
  else
    FCutlistInfo.LAuthor.Caption := 'Cutlist by ' + self.Author;
  if self.RatingByAuthorPresent then
    FCutlistInfo.RGRatingByAuthor.ItemIndex := self.RatingByAuthor
  else
    FCutlistInfo.RGRatingByAuthor.ItemIndex := -1;
  FCutlistInfo.CBEPGError.Checked := self.EPGError;
  if self.EPGError then
    FCutlistInfo.EActualContent.Text := self.ActualContent
  else
    FCutlistInfo.EActualContent.Text := '';
  FCutlistInfo.CBMissingBeginning.Checked := self.MissingBeginning;
  FCutlistInfo.CBMissingEnding.Checked := self.MissingEnding;
  FCutlistInfo.CBMissingVideo.Checked := self.MissingVideo;
  FCutlistInfo.CBMissingAudio.Checked := self.MissingAudio;
  FCutlistInfo.CBOtherError.Checked := self.OtherError;
  if self.OtherError then
    FCutlistInfo.EOtherErrorDescription.Text := self.OtherErrorDescription
  else
    FCutlistInfo.EOtherErrorDescription.Text := '';
  FCutlistInfo.EUserComment.Text := self.UserComment;
  FCutlistInfo.EMovieName.Text := self.SuggestedMovieName;

  if FCutlistInfo.ShowModal = mrOK then begin
    self.FHasChanged := true;
    if FCutlistInfo.RGRatingByAuthor.ItemIndex = -1 then begin
      self.RatingByAuthorPresent := false;
      result := false;
      exit;
    end else begin
      self.RatingByAuthorPresent := true;
      self.RatingByAuthor := FCutlistInfo.RGRatingByAuthor.ItemIndex;
    end;
    self.EPGError := FCutlistInfo.CBEPGError.Checked;
    if self.EPGError then
      self.ActualContent := FCutlistInfo.EActualContent.Text
    else
      self.ActualContent := '';
    self.MissingBeginning := FCutlistInfo.CBMissingBeginning.Checked ;
    self.MissingEnding    := FCutlistInfo.CBMissingEnding.Checked    ;
    self.MissingVideo     := FCutlistInfo.CBMissingVideo.Checked     ;
    self.MissingAudio     := FCutlistInfo.CBMissingAudio.Checked     ;
    self.OtherError       := FCutlistInfo.CBOtherError.Checked       ;
    if self.OtherError then
      self.OtherErrorDescription := FCutlistInfo.EOtherErrorDescription.Text
    else
      self.OtherErrorDescription := '';
    self.UserComment := FCutlistInfo.EUserComment.Text;
    self.SuggestedMovieName := FCutlistInfo.EMovieName.Text;
    result := true;
    self.RefreshGUI;
  end else begin
    result := false;
  end;
end;

function TCutlist.FilenameSuggestion: string;
begin
  if FMovieInfo.current_filename<>'' then begin
    result := ChangeFileExt(extractfilename(FMovieInfo.current_filename), cutlist_Extension);
  end else
    result := 'Cutlist_01.cutlist';
end;

procedure TCutlist.FillCutPosArray(var CutPosArray: array of double);
var
  iCut: integer;
begin
  self.sort;
  for iCut := 0 to self.Count -1 do begin
    CutPosArray[iCut*2] := self.Cut[iCut].pos_from;
    CutPosArray[iCut*2+1] := self.Cut[iCut].pos_to;
  end;
end;

function TCutlist.GetCut(iCut: Integer): TCut;
begin
  result := (self.items[iCut] as TCut);
end;

procedure TCutlist.init;
begin
  self.Clear;
  self.FHasChanged := false;
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
  self.RatingSent := false;
  
  self.RefreshGUI;
end;

function TCutlist.LoadFromFile(Filename: String): boolean;
var
  section: string;
  apply_to_file, intended_options, intendedCutApp, myCutApp, myOptions: string;
  message_string: string;
  Temp_DecimalSeparator: char;
  cutlistfile: TInifile;
  iCUt, cCuts, ACut : integer;
  cut : TCut;
  _pos_from, _pos_to: double;
  _frame_from, _frame_to: integer;
begin
  result := false;
  if not fileexists(filename) then begin
      showmessage('File not found:' + #13#10 + filename);
      exit;
  end;

  if not self.clear_after_confirm then exit;

  cutlistfile := TInifile.Create(filename);
  section := 'General';
  apply_to_file := cutlistfile.ReadString(section, 'ApplyToFile', '(Not found)');
  if (not ansiSameText(apply_to_file, extractfilename(FMovieInfo.current_filename))) and (not batchmode) then begin
    message_string := 'Cut List File is intended for file:' + #13#10 + apply_to_file +#13#10+
                      'However, current file is: '+ #13#10 + extractfilename(FMovieInfo.current_filename) +#13#10+
                      'Continue anyway?';
    if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
      cutlistfile.free;
      exit;
    end;
  end;

  //App + version
  if self.CutApplication <> nil then begin
    intendedCutApp := cutlistfile.ReadString(section, 'IntendedCutApplication', '');
    intendedCutApp := intendedCutApp + ' ' + cutlistfile.ReadString(section, 'IntendedCutApplicationVersion', '');
    myCutApp := extractfilename(CutApplication.Path) + ' ' + CutApplication.Version;
    if not ansiSameText(intendedCutApp, myCutApp) then begin
      message_string := 'Cut List File is intended for Cut Application:' + #13#10 + IntendedCutApp +#13#10+
                        'However, current Cut Application is: '+ #13#10 + myCutApp +#13#10+
                        'Continue anyway?';
      if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
        cutlistfile.free;
        exit;
      end;
    end;
  end;

  //options
  if FMovieInfo.MovieType = mtWMV then begin
    myOptions := (Fsettings.GetCutApplicationbyName('Asfbin') as TCutApplicationAsfbin).CommandLineOptions;
    intended_options := cutlistfile.ReadString(section, 'IntendedCutApplicationOptions', myOptions);
    if not ansiSameText(intended_options, myOptions) and (not batchmode) then begin
      message_string := 'Loaded options for external cut application are:' + #13#10 + intended_options +#13#10+
                        'However, current options are: '+ #13#10 + myOptions +#13#10+
                        'Replace current options by loaded options?';
      if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES then begin
        (Fsettings.GetCutApplicationbyName('Asfbin') as TCutApplicationAsfbin).CommandLineOptions := intended_options;
      end;
    end;
  end;

  //Number of Cuts
  cCuts := cutlistfile.ReadInteger(section, 'NoOfCuts', 0);

  //info
  section := 'Info';
  self.Author := cutlistfile.ReadString(section, 'Author', '');
  self.RatingByAuthor := cutlistfile.ReadInteger(section, 'RatingByAuthor', -1);
  if self.RatingByAuthor = -1 then
    self.RatingByAuthorPresent := false
  else
    self.RatingByAuthorPresent := true;
  self.EPGError := cutlistfile.ReadBool(section, 'EPGError', false);
  if self.EPGError then
    self.ActualContent := cutlistfile.ReadString(section, 'ActualContent', '')
  else
    self.ActualContent := '';
  self.MissingBeginning := cutlistfile.ReadBool(section, 'MissingBeginning', false);
  self.MissingEnding := cutlistfile.ReadBool(section, 'MissingEnding', false);
  self.MissingVideo := cutlistfile.ReadBool(section, 'MissingVideo', false);
  self.MissingAudio := cutlistfile.ReadBool(section, 'MissingAudio', false);
  self.OtherError := cutlistfile.ReadBool(section, 'OtherError', false);
  if self.OtherError then
    self.OtherErrorDescription := cutlistfile.ReadString(section, 'OtherErrorDescription', '')
  else
    self.OtherErrorDescription := '';
  self.SuggestedMovieName := cutlistfile.ReadString(section, 'SuggestedMovieName', '');
  self.UserComment := cutlistfile.ReadString(section, 'UserComment', '');


  Temp_DecimalSeparator := DecimalSeparator;
  DecimalSeparator := '.';

  self.FramesPresent := true;

  for iCut := 0 to cCuts-1 do begin
    section := 'Cut' + inttostr(iCut);
    _pos_from := cutlistfile.ReadFloat(section, 'Start',0);
    _pos_to := _pos_from + cutlistfile.ReadFloat(section, 'Duration', 0) - FMovieInfo.frame_duration;
    _Frame_from := cutlistfile.ReadInteger(section, 'StartFrame', -1);
    _Frame_to := _frame_from + cutlistfile.ReadInteger(section, 'DurationFrames', -1) - 1;

    if self.cut_times_valid(_pos_from, _pos_to, -1, aCut) then begin
      cut := Tcut.Create;
      cut.pos_from := _pos_from;
      cut.pos_to := _pos_to;
      if (_frame_from <0) or (_frame_to <0) then begin
        self.FramesPresent := false;
      end else begin
        cut.frame_from := _Frame_from;
        cut.frame_to := _frame_to;
      end;
      cut.index := self.Add(cut);
    end;
  end;

  DecimalSeparator := Temp_DecimalSeparator;
  cutlistfile.Free;
  self.FMode := clmCrop;
  self.FHasChanged := false;
  self.SavedToFilename := filename;
  result := true;
  if not batchmode then begin
    showmessage(inttostr(self.Count) + ' of ' + inttostr(cCuts) + ' Cuts loaded.');
  end;
  self.RefreshGUI;
end;

function TCutlist.NextCutPos(CurrentPos: double): double;
var
  CutPosArray: array of double;
  iPos: integer;
begin
  result := -1;
  setlength(CutPosArray, self.Count * 2);
  self.FillCutPosArray(CutPosArray);
  for iPos := 0 to 2*self.Count -1 do begin
    if CutPosArray[iPos] > CurrentPos then begin
      result:= CutPosArray[iPos];
      break;
    end;
  end;
end;

function TCutlist.PreviousCutPos(CurrentPos: double): double;
var
  CutPosArray: array of double;
  iPos: integer;
begin
  result := -1;
  setlength(CutPosArray, self.Count * 2);
  self.FillCutPosArray(CutPosArray);
  for iPos := 2*self.Count -1 downto 0 do begin
    if CutPosArray[iPos] < CurrentPos then begin
      result:= CutPosArray[iPos];
      break;
    end;
  end;
end;

procedure TCutlist.RefreshGUI;
begin
  if assigned(self.FRefreshCallBack) then RefreshCallBack(self);
end;

function TCutlist.ReplaceCut(pos_from, pos_to: double;
  CutToReplace: integer): boolean;
var
  icut: integer;
begin
  if cut_times_valid(pos_from, pos_to, CutToReplace, iCut) then begin
    self[CutToReplace].pos_from := pos_from;
    self[CutToReplace].pos_to := pos_to;
    self.FHasChanged := true;
    self.FramesPresent := false;
    result := true;
    self.sort;
    self.RefreshGUI;
  end else begin
    result := false;
  end;
end;

function TCutlist.Save(AskForPath: boolean): boolean;
var
  cutlist_path, target_file : string;
  message_string: string;
  saveDlg: TSaveDialog;
begin
  result := false;
  if self.Count = 0 then begin
    showmessage('No cuts defined.');
    exit;
  end;

  if self.SavedToFilename = '' then begin
    case FSettings.SaveCutlistMode of
      smWithSource: begin    //with source
           cutlist_path := extractFilePath(FMovieInfo.current_filename);
         end;
      smGivenDir: begin    //in given Dir
           cutlist_path := includeTrailingBackslash(FSettings.CutlistSaveDir);
         end;
      else begin       //with source
           cutlist_path := extractFilePath(FMovieInfo.current_filename);
         end;
    end;
    target_file := cutlist_path + self.FilenameSuggestion;
  end else begin
    target_file := self.SavedToFilename;
  end;

  if (self.SavedToFilename = '') or AskForPath then begin
    //Display Save Dialog?
    AskForPath := AskForPath or FSettings.CutlistNameAlwaysConfirm;
    if fileexists(target_File) AND (NOT AskForPath) then begin
      message_string := 'Target file already exists:' + #13#10 + #13#10 + target_file + #13#10 +  #13#10 + 'Overwrite?' ;
      if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_DEFBUTTON2 + MB_ICONWARNING) <> IDYES then begin
        AskForPath := true;
      end;
    end;
    if AskForPath then begin
      saveDlg := TSaveDialog.Create(Application.MainForm);
      saveDlg.Filter := 'Cutlists|*' + cutlist_Extension + '|All Files|*.*';
      saveDlg.FilterIndex := 1;
      saveDlg.Title := 'Save cutlist as...';
      saveDlg.InitialDir := cutlist_path;
      saveDlg.filename := self.FilenameSuggestion;
      saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
      if saveDlg.Execute then begin
        target_file := saveDlg.FileName;
        saveDlg.Free;
      end else begin
        saveDlg.Free;
        exit;
      end;
    end;

    if fileexists(target_File) then begin
      if not deletefile(target_file) then begin
        showmessage('Could not delete existing file ' + target_file + '. Abort.');
        exit;
      end;
    end;
  end;

  result := self.SaveAs(target_file);
end;

function TCutlist.SaveAs(Filename: String): boolean;
//true if saved successfully
var
  cutlistfile: TIniFile;
  section, cutApp, cutAppVer, cutAppOptions, cutCommand, message_string, OutputFileName : string;
  iCut, writtenCuts : integer;
  temp_DecimalSeparator: char;
  convertedCutlist: TCutlist;
  fps: double;
  CutApplication: TCutApplicationBase;
  iCommandLine: Integer;
begin
  result := false;
  {if self.Count = 0 then begin
    showmessage('No cuts defined.');
    exit;
  end; }

  if (not self.RatingByAuthorPresent) then begin
    if not self.EditInfo then exit;
  end;

  if self.Mode = clmCrop then begin
    self.sort;

    Temp_DecimalSeparator := DecimalSeparator;
    DecimalSeparator := '.';

    cutlistfile := TInifile.Create(Filename);
    section := 'General';
    cutlistfile.WriteString(section, 'Application', Application_name);
    cutlistfile.WriteString(section, 'Version', Application_version);
    cutlistfile.WriteString(section, 'comment1', 'The following parts of the movie will be kept, the rest will be cut out.');
    cutlistfile.WriteString(section, 'comment2', 'All values are given in seconds.');
    cutlistfile.WriteString(section, 'ApplyToFile', extractfilename(FMovieInfo.current_filename));
    cutlistfile.WriteInteger(section, 'OriginalFileSizeBytes', FMovieInfo.current_filesize);
    if FMovieInfo.frame_duration > 0 then fps := 1/FMovieInfo.Frame_Duration else fps := 0;
    cutlistfile.WriteFloat(section, 'FramesPerSecond', fps);

    CutApplication := FSettings.GetCutApplicationByMovieType(FMovieInfo.MovieType);
    if assigned(CutApplication) then begin
      CutApplication.WriteCutlistInfo(CutlistFile, section);

      //Write Command Line Only for Cut Apps which do not require script files (Asfbin and MP4Box).
      //For other Apps (VD or Avidemux) this would be useless / problematic because:
      //- with these apps all commands are in the scripts
      //- the command would show the full path to the script files  (privacy of user!)
      //- the script files written while "prepareCutting" had to be deleted afterwards.
      if (CutApplication is TCutApplicationAsfbin)
      or (CutApplication is TCutApplicationMP4Box) then begin
        OutputFileName := FMovieInfo.target_filename;
        if OutputFileName = '' then OutputFileName := self.FSuggestedMovieName;
        if OutputFileName = '' then OutputFileName := '<OutputFile>';

        //Fill CommandLine List
        CutApplication.PrepareCutting(extractfilename(extractFileName(FMovieInfo.current_filename)), OutputFileName, self);
        CutApplication.CommandLines.Delimiter := '|';
        CutApplication.CommandLines.QuoteChar := ' ';
        cutCommand := CutApplication.CommandLines.DelimitedText;
        cutlistfile.WriteString(section, 'CutCommandLine', cutCommand);
      end;
    end else begin
      cutApp := '';
      cutAppVer := '';
      cutAppOptions := '';
      cutCommand := '';

      cutlistfile.WriteString(section, 'IntendedCutApplication', cutApp);
      cutlistfile.WriteString(section, 'IntendedCutApplicationVersion', cutAppVer);
      cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', cutAppOptions);
      cutlistfile.WriteString(section, 'CutCommandLine', cutCommand);
    end;

    section := 'Info';
    if self.HasChanged then begin
      if self.Author = '' then
        self.Author := Fsettings.UserName
      else begin
        if self.Author <> Fsettings.UserName then begin
          message_string := 'Do you want to replace the Author name of this cutlist' + #13#10 + '"' + self.Author +'"'+#13#10+
                            'by your own User Name?';
          if  (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
            self.Author := Fsettings.UserName;
          end;
        end;
      end;
    end;
    cutlistfile.WriteString(section, 'Author', self.Author);
    if self.RatingByAuthorPresent then cutlistfile.WriteInteger(section, 'RatingByAuthor', self.RatingByAuthor);
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

    for iCut := 0 to self.Count-1 do begin
      section := 'Cut' + inttostr(writtenCuts);
      inc(writtenCuts);
      cutlistfile.WriteFloat(section, 'Start', self[iCut].pos_from);
      if self.FramesPresent then
        cutlistfile.WriteInteger(section, 'StartFrame', self[iCut].frame_from)
      else
        if cutlistfile.ValueExists(section, 'StartFrame') then cutlistfile.DeleteKey(section, 'StartFrame');
      cutlistfile.WriteFloat(section, 'Duration', self[iCut].pos_to - self[iCut].pos_from + FMovieInfo.frame_duration);
      if self.FramesPresent then
        cutlistfile.WriteInteger(section, 'DurationFrames', self[iCut].DurationFrames)
      else
        if cutlistfile.ValueExists(section, 'DurationFrames') then cutlistfile.DeleteKey(section, 'DurationFrames');
    end;
    cutlistfile.WriteInteger('General', 'NoOfCuts', writtenCuts);
    cutlistfile.Free;
    result := true;
    self.FHasChanged := false;
    self.SavedToFilename := filename;

    DecimalSeparator := Temp_DecimalSeparator;
  end else begin
    ConvertedCutlist := self.convert;
    result := ConvertedCutlist.SaveAs(filename);
    self.FHasChanged := ConvertedCutlist.HasChanged;
    self.SavedToFilename := ConvertedCutlist.SavedToFilename;
    ConvertedCutlist.Free;
  end;
end;

procedure TCutlist.SetIDOnServer(const Value: string);
begin
  FIDOnServer := Value;
end;

procedure TCutlist.SetMode(const Value: TCutlistMode);
begin
  FMode := Value;
  self.RefreshGUI;
end;

procedure TCutlist.SetRefreshCallBack(const Value: TCutlistCallBackMethod);
begin
  FRefreshCallBack := Value;
end;

procedure TCutlist.SetSuggestedMovieName(const Value: string);
begin
  FSuggestedMovieName := AnsiReplaceStr(Value, '"', '''');
end;

procedure TCutlist.sort;
var
  Acut: TCut;
  iCut, jCut: integer;
begin
  Acut := TCut.Create;
  for iCut := 0 to self.Count-2 do begin
    Acut.pos_from := self[iCut].pos_from;
    Acut.index := iCut;
    for jcut := icut+1 to self.Count-1 do begin
      if self[jcut].pos_from < Acut.pos_from then begin
        Acut.pos_from := self[jCut].pos_from;
        Acut.index := jCut;
      end;
    end;
    if Acut.index <> iCut then begin
      Acut.pos_to  := self[acut.index].pos_to;
      self[acut.index].pos_from := self[iCut].pos_from;
      self[acut.index].pos_to := self[iCut].pos_to;
      self[iCut].pos_from := Acut.pos_from;
      self[iCut].pos_to := Acut.pos_to;
    end;
  end;
  Acut.Free;
end;

function TCutlist.TotalDurationOfCuts: double;
var
  iCut: Integer;
  dur: double;
begin
  dur := 0;
  for iCut := 0 to self.Count-1 do
    dur := dur + Cut[iCut].pos_to - Cut[iCut].pos_from;
  result := dur;
end;

function TCutlist.UserShouldSendRating: boolean;
begin
  result := (not self.RatingSent and (self.IDOnServer > ''));
end;

{ Tcut }


function Tcut.DurationFrames: integer;
begin
  result := self.frame_to - self.frame_from +1;
end;


end.
