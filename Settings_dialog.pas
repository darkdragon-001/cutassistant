unit Settings_dialog;

interface

{$WARN UNIT_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, COntnrs,
  Dialogs, FileCtrl, StdCtrls, ComCtrls, ExtCtrls, IniFiles, Utils, CodecSettings, MMSystem,
  Movie, UCutApplicationBase,

  DirectShow9, DSPack, DSUtil, CheckLst, Mask, JvExMask, JvSpin,
  JvExStdCtrls, JvCheckBox;

const
  //Settings Save...Mode
  smWithSource = $00;  //How to Save Cutlists and cut movies
  smGivenDir = $01;
  smAutoSaveBeforeCutting = $40;      //Only Cutlist
  smAlwaysAsk = $80;

type

  TFSettings = class(TForm)
    cmdCancel: TButton;
    cmdOK: TButton;
    pgSettings: TPageControl;
    tabUserData: TTabSheet;
    lblUsername: TLabel;
    lblUserID: TLabel;
    edtUserName_nl: TEdit;
    edtUserID_nl: TEdit;
    tabSaveMovie: TTabSheet;
    lblCutMovieExtension: TLabel;
    rgSaveCutMovieMode: TRadioGroup;
    edtCutMovieSaveDir_nl: TEdit;
    edtCutMovieExtension_nl: TEdit;
    cmdCutMovieSaveDir: TButton;
    tabSaveCutlist: TTabSheet;
    rgSaveCutlistMode: TRadioGroup;
    edtCutListSaveDir_nl: TEdit;
    cmdCutlistSaveDir: TButton;
    tabURLs: TTabSheet;
    lblServerUrl: TLabel;
    lblInfoUrl: TLabel;
    lblHelpUrl: TLabel;
    lblUploadUrl: TLabel;
    edtURL_Cutlist_Home_nl: TEdit;
    edtURL_Info_File_nl: TEdit;
    edtURL_Cutlist_Upload_nl: TEdit;
    edtURL_Help_nl: TEdit;
    grpProxy: TGroupBox;
    lblProxyServer: TLabel;
    lblProxyPort: TLabel;
    lblProxyPass: TLabel;
    lblProxyUser: TLabel;
    lblProxyPassWarning: TLabel;
    edtProxyServerName_nl: TEdit;
    edtProxyPort_nl: TEdit;
    edtProxyPassword_nl: TEdit;
    edtProxyUserName_nl: TEdit;
    tabInfoCheck: TTabSheet;
    grpInfoCheck: TGroupBox;
    lblCheckInterval: TLabel;
    ECheckInfoInterval_nl: TEdit;
    TabExternalCutApplication: TTabSheet;
    lblCutWithWMV: TLabel;
    lblCutWithAvi: TLabel;
    lblCutWithOther: TLabel;
    lblSelectCutApplication: TLabel;
    CBWmvApp_nl: TComboBox;
    CBAviApp_nl: TComboBox;
    CBOtherApp_nl: TComboBox;
    lblCutWithMP4: TLabel;
    cbMP4App_nl: TComboBox;
    tabSourceFilter: TTabSheet;
    cmbSourceFilterListAVI_nl: TComboBox;
    cmbSourceFilterListMP4_nl: TComboBox;
    cmbSourceFilterListOther_nl: TComboBox;
    cmdRefreshFilterList: TButton;
    lblSourceFilter: TLabel;
    lblSourceFilterAvi: TLabel;
    lblSourceFilterMP4: TLabel;
    lblSourceFilterOther: TLabel;
    lblSourceFilterWmv: TLabel;
    cmbSourceFilterListWMV_nl: TComboBox;
    pnlPleaseWait_nl: TPanel;
    pnlButtons: TPanel;
    lbchkBlackList_nl: TCheckListBox;
    lblBlacklist: TLabel;
    lblFramesSize: TLabel;
    edtFrameWidth_nl: TEdit;
    lblFramesSizex_nl: TLabel;
    edtFrameHeight_nl: TEdit;
    lblFramesCount: TLabel;
    edtFrameCount_nl: TEdit;
    lblFramesSizeChangeHint: TLabel;
    lblFramesCountChangeHint: TLabel;
    rgCutMode: TRadioGroup;
    lblAutoCloseCuttingWindow: TLabel;
    spnWaitTimeout: TJvSpinEdit;
    lblWaitTimeout: TLabel;
    edtSmallSkip_nl: TEdit;
    lblSmallSkip: TLabel;
    lblLargeSkip: TLabel;
    edtLargeSkip_nl: TEdit;
    lblSmallSkipSecs: TLabel;
    lblLargeSkipSecs: TLabel;
    lblFramesSizey_nl: TLabel;
    edtNetTimeout_nl: TEdit;
    lblNetTimeout: TLabel;
    lblNetTimeoutSecs: TLabel;
    cmbCodecWmv_nl: TComboBox;
    btnCodecConfigWmv: TButton;
    btnCodecAboutWmv: TButton;
    cmbCodecAvi_nl: TComboBox;
    btnCodecConfigAvi: TButton;
    btnCodecAboutAvi: TButton;
    cmbCodecMP4_nl: TComboBox;
    btnCodecConfigMP4: TButton;
    btnCodecAboutMP4: TButton;
    cmbCodecOther_nl: TComboBox;
    btnCodecConfigOther: TButton;
    btnCodecAboutOther: TButton;
    lblSmartRenderingCodec: TLabel;
    lblCutWithHQAvi: TLabel;
    CBHQAviApp_nl: TComboBox;
    cmbCodecHQAvi_nl: TComboBox;
    btnCodecConfigHQAvi: TButton;
    btnCodecAboutHQAvi: TButton;
    lblSourceFilterHQAvi: TLabel;
    cmbSourceFilterListHQAVI_nl: TComboBox;
    lblLanguage: TLabel;
    cmbLanguage_nl: TComboBox;
    lblLanguageChangeHint: TLabel;
    cbAutoMuteOnSeek: TJvCheckBox;
    cbExceptionLogging: TJvCheckBox;
    cbMovieNameAlwaysConfirm: TJvCheckBox;
    cbUseMovieNameSuggestion: TJvCheckBox;
    cbCutlistNameAlwaysConfirm: TJvCheckBox;
    cbCutlistAutoSaveBeforeCutting: TJvCheckBox;
    CBInfoCheckStable: TJvCheckBox;
    CBInfoCheckBeta: TJvCheckBox;
    CBInfoCheckMessages: TJvCheckBox;
    CBInfoCheckEnabled: TJvCheckBox;
    cbAutoSearchCutlists: TJvCheckBox;
    cbSearchLocalCutlists: TJvCheckBox;
    cbSearchServerCutlists: TJvCheckBox;
    procedure cmdCutMovieSaveDirClick(Sender: TObject);
    procedure cmdCutlistSaveDirClick(Sender: TObject);
    procedure edtProxyPort_nlKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

    procedure ECheckInfoInterval_nlKeyPress(Sender: TObject; var Key: Char);
    procedure tabSourceFilterShow(Sender: TObject);
    procedure cmdRefreshFilterListClick(Sender: TObject);
    procedure lbchkBlackList_nlClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtFrameWidth_nlExit(Sender: TObject);
    procedure cmbCodecChange(Sender: TObject);
    procedure btnCodecConfigClick(Sender: TObject);
    procedure btnCodecAboutClick(Sender: TObject);
    procedure cbCutAppChange(Sender: TObject);
    procedure cmbSourceFilterListChange(Sender: TObject);
  private
    { Private declarations }
    HQAviAppSettings, AviAppSettings, WmvAppSettings, MP4AppSettings, OtherAppSettings: RCutAppSettings;
    EnumFilters: TSysDevEnum;
    procedure FillBlackList;
    function GetCodecList: TCodecList;
    property CodecList: TCodecList read GetCodecList;
  private
    function GetMovieTypeFromControl(const Sender: TObject; var MovieType: TMovieType): boolean;
    function GetCodecSettingsControls(const Sender: TObject;
      var cbx: TComboBox; var btnConfig, btnAbout: TButton): boolean; overload;
    function GetCodecSettingsControls(const MovieType: TMovieType;
      var cbx: TComboBox; var btnConfig, btnAbout: TButton): boolean; overload;
  public
    procedure Init;
    function GetCodecNameByFourCC(FourCC: DWord): string;
    procedure GetCutAppSettings(const MovieType: TMovieType; var ASettings: RCutAppSettings);
    procedure SetCutAppSettings(const MovieType: TMovieType; var ASettings: RCutAppSettings);
    { Public declarations }
  end;

  //deprecated:
  TCutApp = (caAsfBin = 0, caVirtualDub = 1,  caAviDemux = 2);

  TSettings = class (TObject)
  private
     SourceFilterList: TSourceFilterList;
    _SaveCutListMode, _SaveCutMovieMode: byte;
    _NewSettingsCreated: boolean;
    FCodecList: TCodecList;
    FLanguageList: TStringList;
    function GetLanguageIndex: integer;
    function GetLanguageByIndex(index: integer): string;
    function GetLangDesc(const langFile: TFileName): string;
    function GetLanguageFile: string;
    function GetLanguageList: TStrings;
    function GetFilter(Index: Integer): TFilCatNode;
    property CodecList: TCodecList read FCodecList;
  public
    // window state
    MainFormBounds, FramesFormBounds, PreviewFormBounds, LoggingFormBounds: TRect;
    MainFormWindowState, FramesFormWindowState, PreviewFormWindowState: TWindowState;
    LoggingFormVisible: boolean;

    //CutApplications
    CutApplicationList: TObjectList;

    //User
    UserName, UserID: string;

    // Preview frame window
    FramesWidth, FramesHeight, FramesCount: integer;

    //General
    CutlistSaveDir, CutMovieSaveDir, CutMovieExtension, CurrentMovieDir: string;
    UseMovieNameSuggestion: boolean;
    DefaultCutMode: integer;
    SmallSkipTime, LargeSkipTime: integer;
    NetTimeout: integer;
    AutoMuteOnSeek: boolean;
    AutoSearchCutlists: boolean;
    SearchLocalCutlists: boolean;
    SearchServerCutlists: boolean;

    //Warnings
    WarnOnWrongCutApp: boolean;

    //Mplayer
    MPlayerPath: String;

    //CutApps
    CuttingWaitTimeout: integer;

    //SourceFilter, CodecSettings
    CutAppSettingsAvi, CutAppSettingsWmv, CutAppSettingsMP4, CutAppSettingsOther: RCutAppSettings;
    CutAppSettingsHQAvi: RCutAppSettings;

    //Blacklist of Filters
    FilterBlackList: TGUIDList;

    //URLs and Proxy
    url_cutlists_home,
    url_cutlists_upload,
    url_info_file,
    url_help: string;
    proxyServerName, proxyUserName, proxyPassword: String;
    proxyPort: Integer;

    //Other settings
    OffsetSecondsCutChecking: Integer;
    InfoCheckInterval: Integer;
    InfoLastChecked: TDate;
    InfoShowMessages, InfoShowStable, InfoShowBeta: boolean;
    ExceptionLogging: boolean;

    // UI Language
    Language: string;

    procedure UpdateLanguageList;
    property LanguageList: TStrings read GetLanguageList;
    property LanguageFile: string read GetLanguageFile;

    function CheckInfos: boolean;

    constructor Create;
    destructor Destroy; override;

  protected
    //deprecated
    function GetCutAppNameByCutAppType(CAType: TCutApp): String;
  public
    function GetCutAppName(MovieType: TMovieType): String;
    function GetCutApplicationByName(CAName: string): TCutApplicationBase;
    function GetCutAppSettingsByMovieType(MovieType: TMovieType): RCutAppSettings;
    function GetCutApplicationByMovieType(MovieType: TMovieType): TCutApplicationBase;

    function GetPreferredSourceFilterByMovieType(MovieType: TMovieType): TGUID;
    function SaveCutlistMode: byte;
    function SaveCutMovieMode: byte;
    function MovieNameAlwaysConfirm: boolean;
    function CutlistNameAlwaysConfirm: boolean;
    function CutlistAutoSaveBeforeCutting: boolean;
    function FilterIsInBlackList(ClassID: TGUID): boolean;

    procedure load;
    procedure edit;
    procedure save;
  published
    property NewSettingsCreated: boolean read _NewSettingsCreated;
  public
    function GetCodecNameByFourCC(FourCC: DWord): string;
    property GetFilterInfo[Index: Integer]: TFilCatNode read GetFilter;
  end;

var
  FSettings: TFSettings;

implementation

uses
  Math, Types,
  Main,
  UCutApplicationAsfbin,
  UCutApplicationVirtualDub,
  UCutApplicationAviDemux,
  UCutApplicationMP4Box,
  UCutlist, VFW, CAResources,
  uFreeLocalizer, StrUtils;

var
  EmptyRect: TRect;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

function TFSettings.GetCodecList: TCodecList;
begin
  Result := Settings.CodecList;
end;

function TFSettings.GetCodecNameByFourCC(FourCC: DWord): string;
begin
  Result := Settings.GetCodecNameByFourCC(FourCC);
end;

function TSettings.GetCodecNameByFourCC(FourCC: DWord): string;
var
  idx: integer;
  codec: TICInfoObject;
begin
  codec := nil;
  idx := FCodecList.IndexOfCodec(FourCC);
  if idx > -1 then
    codec := FCodecList.CodecInfoObject[idx];
  if Assigned(codec) then Result := codec.Name
  else Result := '';
end;

procedure TFSettings.cmdCutMovieSaveDirClick(Sender: TObject);
var
  newDir: String;
  currentDir: string;
begin
  newDir := self.edtCutMovieSaveDir_nl.Text;
  currentDir := self.edtCutMovieSaveDir_nl.Text;
  if not IsPathRooted(currentDir) then
    currentDir := '';
  if SelectDirectory(CAResources.RSTitleCutMovieDestinationDirectory, currentDir, newDir) then
    self.edtCutMovieSaveDir_nl.Text := newDir;
end;

procedure TFSettings.cmdCutlistSaveDirClick(Sender: TObject);
var
  newDir: String;
  currentDir: string;
begin
  newDir := self.edtCutlistSaveDir_nl.Text;
  currentDir := self.edtCutlistSaveDir_nl.Text;
  if not IsPathRooted(currentDir) then
    currentDir := '';
  if SelectDirectory(CAResources.RSTitleCutlistDestinationDirectory, currentDir, newDir) then
    self.edtCutlistSaveDir_nl.Text := newDir;
end;

procedure TFSettings.edtProxyPort_nlKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#0 .. #31, '0'..'9']) then
    key := chr(0);
end;

{ TSettings }

function TSettings.GetLangDesc(const langFile: TFileName): string;
const
  DESC_PATTERN = 'description:';
var
  f: TextFile;
  line: string;
  idx: integer;
begin
  Result := ExtractFileName(langFile);
  AssignFile(f, langFile);
{$I-}
  FileMode := fmOpenRead;
  Reset(f);
  if IOResult <> 0 then
    Exit;
  while IOResult = 0 do begin
    ReadLn(f, line);
    if (IOResult <> 0) or (line = '') then
      Break;
    if not AnsiStartsText(';', line) then
      Continue;
    idx := AnsiPos(DESC_PATTERN, AnsiLowerCase(line));
    if idx < 1 then
      Continue;
    Delete(line, 1, idx + Length(DESC_PATTERN));
    idx := AnsiPos('=', line);
    if idx > 0 then
      Delete(line, idx, MaxInt);
    Result := Trim(line);
    Break;
  end;
  CloseFile(f);
{$I+}
end;

procedure TSettings.UpdateLanguageList;
var
  lang_dir, lang_desc: string;
  lang_found: boolean;
  sr: TSearchRec;
begin
  lang_dir := IncludeTrailingPathDelimiter(FreeLocalizer.LanguageDir);
  FLanguageList.Clear;
  lang_found := self.Language = '';
  if FindFirst(lang_dir + ChangeFileExt(Application_File,'.*.lng'), faReadOnly, sr) = 0 then begin
    repeat
      lang_desc := GetLangDesc(lang_dir + sr.Name);
      if AnsiSameText(sr.Name, self.Language) then
        lang_found := true;
      FLanguageList.Add(lang_desc + ' (' + sr.Name + ')');
    until FindNext(sr) <> 0;
  end;
  if not lang_found then
      FLanguageList.Add(self.Language + ' (' + self.Language + ')');
  FLanguageList.Sort;
  FLanguageList.Insert(0, 'Standard');
end;

function TSettings.GetLanguageFile: string;
begin
  Result := self.Language;
  //if Result = '' then
  //  Result := ChangeFileExt(Application_File, '.lng');
end;

function TSettings.GetLanguageList: TStrings;
begin
  Result := FLanguageList;
end;

function TSettings.GetLanguageIndex: integer;
var
  idx: integer;
  lang: string;
begin
  if self.Language = '' then begin
    Result := 0;
    Exit;
  end;
  lang := '(' + self.Language + ')';
  idx := 0;
  while idx < FLanguageList.Count do begin
    if AnsiEndsText(lang, FLanguageList[idx]) then
      Break;
    Inc(idx);
  end;
  Result := idx;
end;

function TSettings.GetLanguageByIndex(index: integer): string;
var
  lang: string;
  idx: integer;
begin
  lang := FLanguageList[index];
  idx := Pos('(', lang);
  if idx = 0 then idx := MaxInt;
  Delete(lang, 1, idx);
  Delete(lang, Pos(')', lang), MaxInt);
  Result := lang;
end;

function TSettings.CheckInfos: boolean;
begin
  result := (self.InfoCheckInterval >= 0);
end;

constructor TSettings.create;
begin
  inherited;

  Language := '';
  ExceptionLogging := false;

  FLanguageList := TStringList.Create;
  FLanguageList.CaseSensitive := false;
  UpdateLanguageList;

  FCodecList := TCodecList.Create;
  //FCodecList.Fill;

  CutApplicationList := TObjectList.Create;
  CutApplicationList.Add(TCutApplicationAsfbin.Create);
  CutApplicationList.Add(TCutApplicationVirtualDub.Create);
  CutApplicationList.Add(TCutApplicationAviDemux.Create);
  CutApplicationList.Add(TCutApplicationMP4Box.Create);

  SourceFilterList:= TSourceFilterList.create;
  FilterBlackList := TGUIDList.Create;

  CutAppSettingsWmv.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsAvi.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsHQAvi.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsMP4.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsOther.PreferredSourceFilter := GUID_NULL;
end;

function TSettings.GetFilter(Index: Integer): TFilCatNode;
begin
  Result := SourceFilterList.GetFilterInfo[Index];
end;

function TSettings.CutlistAutoSaveBeforeCutting: boolean;
begin
  result := ((_SaveCutlistMOde AND smAutoSaveBeforeCutting) >0);
end;

function TSettings.CutlistNameAlwaysConfirm: boolean;
begin
  result := ((_SaveCutlistMode AND smAlwaysAsk) > 0 );
end;

destructor TSettings.destroy;
begin
  FreeAndNil(FLanguageList);
  FreeAndNil(FCodecList);
  FreeAndNIL(FilterBlackList);
  FreeAndNIL(SourceFilterList);
  FreeAndNIL(CutApplicationList);
  inherited;
end;

procedure TSettings.edit;
var
  message_string: string;
  newLanguage: string;
  Data_Valid: boolean;
  iTabSheet: Integer;
  TabSheet: TTabSheet;
  FrameClass: TCutApplicationFrameClass;
begin
  for iTabSheet := 0 to FSettings.pgSettings.PageCount -1 do begin
    TabSheet := FSettings.pgSettings.Pages[iTabSheet];
    if TabSheet.Tag <> 0 then begin
      FrameClass := TCutApplicationFrameClass(TabSheet.Tag);
      (FSettings.pgSettings.Pages[iTabSheet].Controls[0] as FrameClass).Init;
    end;
  end;

  FSettings.SetCutAppSettings(mtWMV, self.CutAppSettingsWmv);
  FSettings.SetCutAppSettings(mtAVI, self.CutAppSettingsAvi);
  FSettings.SetCutAppSettings(mtHQAVI, self.CutAppSettingsHQAvi);
  FSettings.SetCutAppSettings(mtMP4, self.CutAppSettingsMP4);
  FSettings.SetCutAppSettings(mtUnknown, self.CutAppSettingsOther);

  FSettings.spnWaitTimeout.AsInteger               := self.CuttingWaitTimeout;
  FSettings.rgSaveCutMovieMode.ItemIndex           := self.SaveCutMovieMode;
  FSettings.edtCutMovieSaveDir_nl.Text             := self.CutMovieSaveDir;
  FSettings.edtCutMovieExtension_nl.Text           := self.CutMovieExtension;
  FSettings.cbUseMovieNameSuggestion.Checked       := self.UseMovieNameSuggestion;
  FSettings.cbMovieNameAlwaysConfirm.Checked       := self.MovieNameAlwaysConfirm;
  FSettings.rgSaveCutlistMode.ItemIndex            := self.SaveCutlistMode;
  FSettings.edtCutlistSaveDir_nl.Text              := self.CutlistSaveDir;
  FSettings.cbCutlistNameAlwaysConfirm.Checked     := self.CutlistNameAlwaysConfirm;
  Fsettings.cbCutlistAutoSaveBeforeCutting.Checked := self.CutlistAutoSaveBeforeCutting;
  Fsettings.rgCutMode.ItemIndex                    := self.DefaultCutMode;
  FSettings.edtSmallSkip_nl.Text                   := IntToStr(self.SmallSkipTime);
  FSettings.edtLargeSkip_nl.Text                   := IntToStr(self.LargeSkipTime);
  FSettings.edtNetTimeout_nl.Text                  := IntToStr(self.NetTimeout);
  FSettings.cbAutoMuteOnSeek.Checked               := self.AutoMuteOnSeek;
  FSettings.cbExceptionLogging.Checked             := self.ExceptionLogging;

  FSettings.cbAutoSearchCutlists.Checked           := self.AutoSearchCutlists;
  FSettings.cbSearchLocalCutlists.Checked          := self.SearchLocalCutlists;
  FSettings.cbSearchServerCutlists.Checked         := self.SearchServerCutlists;

  Fsettings.edtURL_Cutlist_Home_nl.Text            := self.url_cutlists_home;
  Fsettings.edtURL_Info_File_nl.Text               := self.url_info_file;
  Fsettings.edtURL_Cutlist_Upload_nl.Text          := self.url_cutlists_upload;
  Fsettings.edtURL_Help_nl.Text                    := self.url_help;

  FSettings.edtProxyServerName_nl.Text             := self.proxyServerName;
  FSettings.edtProxyPort_nl.Text                   := IntToStr(self.proxyPort);
  FSettings.edtProxyUserName_nl.Text               := self.proxyUserName;
  FSettings.edtProxyPassword_nl.Text               := self.proxyPassword;

  Fsettings.edtUserName_nl.Text                    := self.UserName;
  Fsettings.edtUserID_nl.Text                      := self.UserID;

  FSettings.edtFrameWidth_nl.Text                  := IntToStr(self.FramesWidth);
  FSettings.edtFrameHeight_nl.Text                 := IntToStr(self.FramesHeight);
  FSettings.edtFrameCount_nl.Text                  := IntToStr(self.FramesCount);

  FSettings.cmbLanguage_nl.Items.Assign(self.FLanguageList);
  FSettings.cmbLanguage_nl.ItemIndex               := self.GetLanguageIndex;

  FSettings.CBInfoCheckMessages.Checked   := self.InfoShowMessages            ;
  FSettings.CBInfoCheckStable.Checked     := self.InfoShowStable              ;
  FSettings.CBInfoCheckBeta.Checked       := self.InfoShowBeta                ;
  if self.CheckInfos then
    FSettings.ECheckInfoInterval_nl.Text      := inttostr(self.InfoCheckInterval)
  else
    FSettings.ECheckInfoInterval_nl.Text      := '0';
  FSettings.CBInfoCheckEnabled.Checked := self.CheckInfos;

  FSettings.Init;

  Data_Valid := false;
  while not Data_Valid do begin
    if FSettings.ShowModal <> mrOK then break;     //User Cancelled
    Data_Valid := true;
    if (Fsettings.rgSaveCutMovieMode.ItemIndex = 1) then
    begin
      if IsPathRooted(FSettings.edtCutMovieSaveDir_nl.Text) and (not DirectoryExists(FSettings.edtCutMovieSaveDir_nl.Text)) then
      begin
        message_string := Format(CAResources.RsCutMovieDirectoryMissing, [ FSettings.edtCutMovieSaveDir_nl.Text ]);
        if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
          Data_Valid := forceDirectories(FSettings.edtCutMovieSaveDir_nl.Text);
        end else begin
          Data_Valid := false;
          FSettings.pgSettings.ActivePage := Fsettings.tabSaveMovie;
          FSettings.ActiveControl := FSettings.edtCutMovieSaveDir_nl;
        end;
      end;
    end;
    if Data_Valid AND (Fsettings.rgSaveCutlistMode.ItemIndex = 1) then
    begin
      if IsPathRooted(FSettings.edtCutlistSaveDir_nl.Text) and (not DirectoryExists(FSettings.edtCutlistSaveDir_nl.Text)) then
      begin
        message_string := Format(CAResources.RsCutlistDirectoryMissing, [ FSettings.edtCutlistSaveDir_nl.Text ]);
        if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
          Data_Valid := forceDirectories(FSettings.edtCutlistSaveDir_nl.Text);
        end else begin
          Data_Valid := false;
          FSettings.pgSettings.ActivePage := Fsettings.TabSaveCutlist;
          FSettings.ActiveControl := FSettings.edtCutlistSaveDir_nl;
        end;
      end;
    end;
    if Data_Valid then begin  //Apply new settings and save them

      self.CuttingWaitTimeout := FSettings.spnWaitTimeout.AsInteger;

      FSettings.GetCutAppSettings(mtWMV, self.CutAppSettingsWmv);
      FSettings.GetCutAppSettings(mtAVI, self.CutAppSettingsAvi);
      FSettings.GetCutAppSettings(mtHQAVI, self.CutAppSettingsHQAvi);
      FSettings.GetCutAppSettings(mtMP4, self.CutAppSettingsMP4);
      FSettings.GetCutAppSettings(mtUnknown, self.CutAppSettingsOther);

      case FSettings.rgSaveCutMovieMode.ItemIndex of
        1: _SaveCutMovieMode := smGivenDir;
        else _SaveCutMovieMode := smWithSource;
      end;
      CutMovieSaveDir                                       := FSettings.edtCutMovieSaveDir_nl.Text                ;
      CutMovieExtension                                     := FSettings.edtCutMovieExtension_nl.Text              ;
      if FSettings.cbMovieNameAlwaysConfirm.Checked then _SaveCutMovieMode := _saveCutMovieMode OR smAlwaysAsk;
      UseMovieNameSuggestion := FSettings.CBUseMovieNameSuggestion.Checked;

      case FSettings.rgSaveCutlistMode.ItemIndex of
        1: _SaveCutlistMode := smGivenDir;
        else _SaveCutlistMode := smWithSource;
      end;
      CutlistSaveDir                                        := FSettings.edtCutlistSaveDir_nl.Text                 ;
      if FSettings.cbCutlistNameAlwaysConfirm.Checked then     _SaveCutlistMode := _SaveCutlistMode OR smAlwaysAsk;
      if Fsettings.cbCutlistAutoSaveBeforeCutting.Checked then _SaveCutlistMOde := _SaveCutlistMOde OR smAutoSaveBeforeCutting;

      DefaultCutMode := Fsettings.rgCutMode.ItemIndex;

      self.url_cutlists_home           := Fsettings.edtURL_Cutlist_Home_nl.Text           ;
      self.url_info_file               := Fsettings.edtURL_Info_File_nl.Text   ;
      self.url_cutlists_upload         := Fsettings.edtURL_Cutlist_Upload_nl.Text         ;
      self.url_help                    := Fsettings.edtURL_Help_nl.Text                   ;

      self.proxyServerName             := FSettings.edtProxyServerName_nl.Text            ;
      self.proxyPort                   := strToIntDef(FSettings.edtProxyPort_nl.Text, self.proxyPort);
      self.proxyUserName               := FSettings.edtProxyUserName_nl.Text              ;
      self.proxyPassword               := FSettings.edtProxyPassword_nl.Text              ;

      self.UserName                    := Fsettings.edtUserName_nl.Text;

      self.FramesWidth                 := StrToInt(FSettings.edtFrameWidth_nl.Text);
      self.FramesHeight                := StrToInt(FSettings.edtFrameHeight_nl.Text);
      self.FramesCount                 := StrToInt(FSettings.edtFrameCount_nl.Text);

      self.SmallSkipTime               := StrToInt(FSettings.edtSmallSkip_nl.Text);
      self.LargeSkipTime               := StrToInt(FSettings.edtLargeSkip_nl.Text);
      self.NetTimeout                  := StrToInt(FSettings.edtNetTimeout_nl.Text);
      self.AutoMuteOnSeek              := FSettings.cbAutoMuteOnSeek.Checked;
      self.ExceptionLogging            := FSettings.cbExceptionLogging.Checked;

      self.AutoSearchCutlists := FSettings.cbAutoSearchCutlists.Checked;
      self.SearchLocalCutlists := FSettings.cbSearchLocalCutlists.Checked;
      self.SearchServerCutlists := FSettings.cbSearchServerCutlists.Checked;

      newLanguage                      := GetLanguageByIndex(FSettings.cmbLanguage_nl.ItemIndex);
      if self.Language <> newLanguage then begin
        self.Language                  := newLanguage;
        //ShowMessage(CAResources.RsChangeLanguageNeedsRestart);
      end;

      self.InfoShowMessages            := FSettings.CBInfoCheckMessages.Checked  ;
      self.InfoShowStable              := FSettings.CBInfoCheckStable.Checked    ;
      self.InfoShowBeta                := FSettings.CBInfoCheckBeta.Checked      ;
      if FSettings.CBInfoCheckEnabled.Checked then begin
        self.InfoCheckInterval :=  strToIntDef(FSettings.ECheckInfoInterval_nl.Text, 0);
      end else begin
        self.InfoCheckInterval := -1;
      end;

      for iTabSheet := 0 to FSettings.pgSettings.PageCount -1 do begin
        TabSheet := FSettings.pgSettings.Pages[iTabSheet];
        if TabSheet.Tag <> 0 then begin
          FrameClass := TCutApplicationFrameClass(TabSheet.Tag);
          (FSettings.pgSettings.Pages[iTabSheet].Controls[0] as FrameClass).Apply;
        end;
      end;

      self.save;
    end;
  end;
end;

function TSettings.FilterIsInBlackList(ClassID: TGUID): boolean;
begin
  result := FilterBlackList.IsInList(ClassID);
end;

function TSettings.GetCutApplicationByMovieType(
  MovieType: TMovieType): TCutApplicationBase;
begin
  result := self.GetCutApplicationByName(GetCutAppName(MovieType));
  if Assigned(Result) then
    result.CutAppSettings := GetCutAppSettingsByMovieType(MovieType);
end;

function TSettings.GetCutApplicationByName(
  CAName: string): TCutApplicationBase;
var
  iCutApplication: Integer;
  FoundCutApplication: TCutApplicationBase;
begin
  result := nil;
  for iCutApplication := 0 to CutApplicationList.Count - 1 do begin
    FoundCutApplication := (CutApplicationList[iCutApplication] as TCutApplicationBase);
    if AnsiSameText(FoundCutApplication.Name, CAName) then begin
      result := FoundCutApplication;
      break;
    end;
  end;
end;

function TSettings.GetCutAppSettingsByMovieType(
  MovieType: TMovieType): RCutAppSettings;
begin
  Case MovieType of
    mtWMV:   result := self.CutAppSettingsWmv;
    mtAVI:   result := self.CutAppSettingsAvi;
    mtHQAVI: result := self.CutAppSettingsHQAvi;
    mtMP4:   result := self.CutAppSettingsMP4;
    else     result := self.CutAppSettingsOther;
  end;
end;

function TSettings.GetCutAppName(MovieType: TMovieType): String;
begin
  Result := GetCutAppSettingsByMovieType(MovieType).CutAppName;
end;

function TSettings.GetPreferredSourceFilterByMovieType(
  MovieType: TMovieType): TGUID;
begin
  Result := GetCutAppSettingsByMovieType(MovieType).PreferredSourceFilter;
end;

function TSettings.GetCutAppNameByCutAppType(CAType: TCutApp): String;
//deprecated
begin
  Case CAType of
    caAsfBin: result := 'AsfBin';
    caVirtualDub: result := 'VirtualDub';
    caAviDemux: result := 'AviDemux';
    else result := '';
  end;
end;


procedure TSettings.load;
var
  ini: TCustomIniFile;
  FileName: String;
  section: string;
  iFilter, iCutApplication: integer;

  procedure ReadOldCutAppName(var ASettings: RCutAppSettings;
    const s1: string; t1: TCutApp; s2, default: string);
  begin
    with ASettings do begin
      //defaults and old ini files (belw 0.9.11.6)
      if CutAppName = '' then
        CutAppName := ini.ReadString(section, s2, '');
      //old ini Files (for Compatibility with versions below 0.9.9):
      if (CutAppName = '') and (s1 <> '') then
        CutAppName   := GetCutAppNameByCutAppType(TCutApp(ini.ReadInteger(section, s1, integer(t1))));
      if CutAppName = '' then
        CutAppName := default;
    end;
  end;
begin
  FileName := ChangeFileExt( Application.ExeName, '.ini' );
  self._NewSettingsCreated := not FileExists(FileName);
  ini := TIniFile.Create(FileName);
  try
    section := 'General';
    UserName :=  ini.ReadString(section, 'UserName', '');
    UserID :=  ini.ReadString(section, 'UserID', '');
    Language := ini.ReadString(section, 'Language', '');
    ExceptionLogging := ini.ReadBool(section, 'ExceptionLogging', false);

    section := 'FrameWindow';
    FramesWidth := ini.ReadInteger(section, 'Width', 180);
    FramesHeight := ini.ReadInteger(section, 'Height', 135);
    FramesCount := ini.ReadInteger(section, 'Count', 12);

    section := 'WMV Files';
    ReadCutAppSettings(ini, section, CutAppSettingsWmv);

    section := 'AVI Files';
    ReadCutAppSettings(ini, section, CutAppSettingsAVI);

    section := 'HQ AVI Files';
    ReadCutAppSettings(ini, section, CutAppSettingsHQAVI);

    section := 'MP4 Files';
    ReadCutAppSettings(ini, section, CutAppSettingsMP4);

    section := 'OtherMediaFiles';
    ReadCutAppSettings(ini, section, CutAppSettingsOther);

    section := 'External Cut Application';
    self.CuttingWaitTimeout := ini.ReadInteger(section, 'CuttingWaitTimeout', 20);
    ReadOldCutAppName(self.CutAppSettingsWmv, 'CutAppWmv', caAsfBin, 'CutAppNameWmv', 'AsfBin');
    ReadOldCutAppName(self.CutAppSettingsAvi, 'CutAppAvi', caVirtualDub, 'CutAppNameAvi', 'VirtualDub');
    ReadOldCutAppName(self.CutAppSettingsAvi, 'CutAppHQAvi', caVirtualDub, 'CutAppNameHQAvi', 'VirtualDub');
    ReadOldCutAppName(self.CutAppSettingsMP4, '', TCutApp(0), 'CutAppNameMP4', 'MP4Box');
    ReadOldCutAppName(self.CutAppSettingsOther, 'CutAppOther', caVirtualDub, 'CutAppNameOther', 'VirtualDub');

    //provisorisch
    section := 'Filter Blacklist';
    for iFilter := 0 to ini.ReadInteger(section, 'Count', 0) - 1 do begin
      self.FilterBlackList.AddFromString(ini.ReadString(section, 'Filter_'+inttostr(iFilter), ''));
    end;

    section := 'Files';
    _SaveCutlistMode := ini.ReadInteger(section, 'SaveCutlistMode', smWithSource OR smAlwaysAsk);
    CutlistSaveDir := ini.ReadString(section, 'CutlistSaveDir', '');
    _SaveCutMovieMode := ini.ReadInteger(section, 'SaveCutMovieMode', smWithSource);
    self.UseMovieNameSuggestion := ini.ReadBool(section, 'UseMovieNameSuggestion', false);

    CutMovieSaveDir := ini.ReadString(section, 'CutMovieSaveDir', '');
    CutMovieExtension := ini.ReadString(section, 'CutMovieExtension', '.cut');

    section := 'URLs';
    self.url_cutlists_home := ini.ReadString(section, 'CutlistServerHome', 'http://www.cutlist.de/');
    self.url_cutlists_upload := ini.ReadString(section, 'CutlistServerUpload', 'http://www.cutlist.de/index.php?upload=2');
    self.url_info_file := ini.ReadString(section, 'ApplicationInfoFile', 'http://cutlist.de/assistant/download/cut_assistant_info.xml');
    self.url_help := ini.ReadString(section, 'ApplicationHelp', 'http://wiki.onlinetvrecorder.com/index.php/Cut_Assistant');

    section := 'Connection';
    self.NetTimeout := ini.ReadInteger(section, 'Timeout', 20);
    self.proxyServerName := ini.ReadString(section, 'ProxyServerName', '');
    self.proxyPort := ini.ReadInteger(section, 'ProxyPort', 0);
    self.proxyUserName := ini.ReadString(section, 'ProxyUserName', '');
    self.proxyPassword := ini.ReadString(section, 'ProxyPassword', '');

    section := 'Settings';
    self.OffsetSecondsCutChecking := ini.ReadInteger(section, 'OffsetSecondsCutChecking', 2);
    self.CurrentMovieDir := ini.ReadString(section, 'CurrentMovieDir', extractfilepath(application.ExeName));
    self.InfoCheckInterval := ini.ReadInteger(section, 'InfoCheckIntervalDays', 1);
    self.InfoLastChecked := ini.ReadDate(section, 'InfoLastChecked', 0);
    self.InfoShowMessages := ini.ReadBool(section, 'InfoShowMessages', true);
    self.InfoShowStable := ini.ReadBool(section, 'InfoShowStable', true);
    self.InfoShowBeta := ini.ReadBool(section, 'InfoShowBeta', false);
    self.DefaultCutMode := ini.ReadInteger(section, 'DefaultCutMode', integer(clmTrim));
    self.SmallSkipTime := ini.ReadInteger(section, 'SmallSkipTime', 2);
    self.LargeSkipTime := ini.ReadInteger(section, 'LargeSkipTime', 25);
    self.AutoMuteOnSeek := ini.ReadBool(section, 'AutoMuteOnSeek', false);
    self.AutoSearchCutlists := ini.ReadBool(section, 'AutoSearchCutlists', false);
    self.SearchLocalCutlists := ini.ReadBool(section, 'SearchLocalCutlists', false);
    self.SearchServerCutlists := ini.ReadBool(section, 'SearchServerCutlists', true);

    section := 'Warnings';
    self.WarnOnWrongCutApp := ini.ReadBool(section, 'WarnOnWrongCutApp', true);

    section := 'WindowStates';
    self.MainFormWindowState := TWindowState(ini.ReadInteger(section, 'Main_WindowState', integer(wsNormal)));
    self.MainFormBounds := iniReadRect(ini, section, 'Main', EmptyRect);
    self.FramesFormWindowState := TWindowState(ini.ReadInteger(section, 'Frames_WindowState', integer(wsNormal)));
    self.FramesFormBounds := iniReadRect(ini, section, 'Frames', EmptyRect);
    self.PreviewFormWindowState := TWindowState(ini.ReadInteger(section, 'Preview_WindowState', integer(wsNormal)));
    self.PreviewFormBounds := iniReadRect(ini, section, 'Preview', EmptyRect);
    self.LoggingFormBounds := iniReadRect(ini, section, 'Logging', EmptyRect);
    self.LoggingFormVisible := ini.ReadBool(section, 'LoggingFormVisible', false);

    for iCutApplication := 0 to CutApplicationList.Count - 1 do begin
      TCutApplicationBase(CutApplicationList[iCutApplication]).LoadSettings(ini);
    end;

  finally
    FreeAndNil(ini);
  end;

  if userID = '' then begin
    //Generade Random ID and save it immediately
    userID := rand_string;
    self.save;
  end;
end;

function TSettings.MovieNameAlwaysConfirm: boolean;
begin
  result := ((_SaveCutMovieMode AND smAlwaysAsk) > 0 );
end;

procedure TSettings.save;
var
  ini: TCustomIniFile;
  FileName: string;
  section: String;
  iCutApplication: integer;
  iFilter: integer;
begin
  FileName := ChangeFileExt( Application.ExeName, '.ini' );
  ini := TIniFile.Create(FileName);
  try
    section := 'General';
    ini.WriteString(section, 'Version', Application_version);
    ini.WriteString(section, 'UserName', UserName);
    ini.WriteString(section, 'UserID', UserID);
    ini.WriteString(section, 'Language', Language);

    if not ExceptionLogging then ini.DeleteKey(section, 'ExceptionLogging')
    else ini.WriteBool(section, 'ExceptionLogging', true);

    section := 'FrameWindow';
    ini.WriteInteger(section, 'Width', FramesWidth);
    ini.WriteInteger(section, 'Height', FramesHeight);
    ini.WriteInteger(section, 'Count', FramesCount);

    section := 'External Cut Application';
    ini.WriteInteger(section, 'CuttingWaitTimeout', self.CuttingWaitTimeout);

    section := 'WMV Files';
    WriteCutAppSettings(ini, section, CutAppSettingsWmv);

    section := 'AVI Files';
    WriteCutAppSettings(ini, section, CutAppSettingsAvi);

    section := 'HQ AVI Files';
    WriteCutAppSettings(ini, section, CutAppSettingsHQAvi);

    section := 'MP4 Files';
    WriteCutAppSettings(ini, section, CutAppSettingsMP4);

    section := 'OtherMediaFiles';
    WriteCutAppSettings(ini, section, CutAppSettingsOther);

    section := 'Filter Blacklist';
    ini.WriteInteger(section, 'Count', self.FilterBlackList.Count);
    for iFilter := 0 to self.FilterBlackList.Count - 1 do begin
      ini.WriteString(section, 'Filter_'+IntToStr(iFilter), GUIDToString(self.FilterBlackList.Item[iFilter]));
    end;

    section := 'Files';
    ini.WriteInteger(section, 'SaveCutlistMode', _SaveCutlistMode);
    ini.WriteString(section, 'CutlistSaveDir', CutlistSaveDir);
    ini.WriteInteger(section, 'SaveCutMovieMode', _SaveCutMovieMode);
    ini.WriteBool(section, 'UseMovieNameSuggestion', UseMovieNameSuggestion);
    ini.WriteString(section, 'CutMovieSaveDir', CutMovieSaveDir);
    ini.WriteString(section, 'CutMovieExtension', CutMovieExtension);

    section := 'URLs';
    ini.WriteString(section, 'CutlistServerHome', url_cutlists_home);
    ini.WriteString(section, 'CutlistServerUpload', url_cutlists_upload);
    ini.WriteString(section, 'ApplicationInfoFile', url_info_file);
    ini.WriteString(section, 'ApplicationHelp', url_help );

    section := 'Connection';
    ini.WriteString(section, 'ProxyServerName', ProxyServerName);
    ini.WriteInteger(section, 'ProxyPort', ProxyPort);
    ini.WriteString(section, 'ProxyUserName', ProxyUserName);
    ini.WriteString(section, 'ProxyPassword', ProxyPassword);
    ini.WriteInteger(section, 'Timeout', NetTimeout);

    section := 'Settings';
    ini.WriteInteger(section, 'OffsetSecondsCutChecking', OffsetSecondsCutChecking);
    ini.WriteString(section, 'CurrentMovieDir', self.CurrentMovieDir);
    ini.WriteInteger(section, 'InfoCheckIntervalDays', self.InfoCheckInterval);
    ini.WriteDate(section, 'InfoLastChecked', self.InfoLastChecked);
    ini.WriteBool(section, 'InfoShowMessages', self.InfoShowMessages);
    ini.WriteBool(section, 'InfoShowBeta', self.InfoShowBeta);
    ini.WriteBool(section, 'InfoShowStable', self.InfoShowStable);
    ini.WriteInteger(section, 'DefaultCutMode', self.DefaultCutMode);
    ini.WriteInteger(section, 'SmallSkipTime', self.SmallSkipTime);
    ini.WriteInteger(section, 'LargeSkipTime', self.LargeSkipTime);
    ini.WriteBool(section, 'AutoMuteOnSeek', self.AutoMuteOnSeek);
    ini.WriteBool(section, 'AutoSearchCutlists', self.AutoSearchCutlists);
    ini.WriteBool(section, 'SearchLocalCutlists', self.SearchLocalCutlists);
    ini.WriteBool(section, 'SearchServerCutlists', self.SearchServerCutlists);

    section := 'Warnings';
    ini.WriteBool(section, 'WarnOnWrongCutApp', WarnOnWrongCutApp);

    section := 'WindowStates';
    ini.WriteInteger(section, 'Main_WindowState', integer(self.MainFormWindowState));
    iniWriteRect(ini, section, 'Main', self.MainFormBounds);
    if self.FramesFormWindowState <> wsNormal then
      ini.WriteInteger(section, 'Frames_WindowState', integer(self.FramesFormWindowState));
    iniWriteRect(ini, section, 'Frames', self.FramesFormBounds);
    if self.PreviewFormWindowState <> wsNormal then
      ini.WriteInteger(section, 'Preview_WindowState', integer(self.PreviewFormWindowState));
    iniWriteRect(ini, section, 'Preview', self.PreviewFormBounds);
    iniWriteRect(ini, section, 'Logging', self.LoggingFormBounds);
    ini.WriteBool(section, 'LoggingFormVisible', self.LoggingFormVisible);

    for iCutApplication := 0 to CutApplicationList.Count - 1 do begin
      (CutApplicationList[iCutApplication] as TCutApplicationBase).SaveSettings(ini);
    end;

  finally
    FreeAndNil(ini);
    self._NewSettingsCreated := not FileExists(FileName);
  end;
end;

function TSettings.SaveCutlistMode: byte;
begin
  result := self._SaveCutListMode AND $0F;
end;

function TSettings.SaveCutMovieMode: byte;
begin
  result := self._SaveCutMovieMode AND $0F;
end;

procedure TFSettings.FormCreate(Sender: TObject);
var
  frame: TfrmCutApplicationBase;
  newTabsheet: TTabsheet;
  iCutApplication: integer;
  CutApplication: TCutApplicationBase;
  MinSize: TSizeConstraints;
begin
  CBOtherApp_nl.Items.Clear;
  MinSize := tabURLs.Constraints;
  EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters

  for iCutApplication := 0 to Settings.CutApplicationList.Count - 1 do begin
    CutApplication := (Settings.CutApplicationList[iCutApplication] as TCutApplicationBase);
    newTabsheet := TTabsheet.Create(pgSettings);
    newTabsheet.PageControl := pgSettings;
    newTabsheet.Caption := CutApplication.Name;
    newTabsheet.Tag := Integer(CutApplication.FrameClass);
    frame := CutApplication.FrameClass.Create(newTabsheet);
    frame.Parent := newTabsheet;
    frame.Align := alClient;
    frame.CutApplication := CutApplication;
    frame.Init;

    newTabsheet.Constraints := frame.Constraints;
    MinSize.MinWidth := Max(MinSize.MinWidth, frame.Constraints.MinWidth);
    MinSize.MinHeight := Max(MinSize.MinHeight, frame.Constraints.MinHeight);

    CBOtherApp_nl.Items.Add(CutApplication.Name);
  end;

  if tabUserData.Height < MinSize.MinHeight then
    self.Constraints.MinHeight := self.Height - ( tabUserData.Height - MinSize.MinHeight);
  if tabUserData.Width < MinSize.MinWidth then
    self.Constraints.MinWidth := self.Width - ( tabUserData.Width - MinSize.MinWidth);

  CBWmvApp_nl.Items.Assign(CBOtherApp_nl.Items);
  CBAviApp_nl.Items.Assign(CBOtherApp_nl.Items);
  CBHQAviApp_nl.Items.Assign(CBOtherApp_nl.Items);
  CBMP4App_nl.Items.Assign(CBOtherApp_nl.Items);

  CodecList.Fill;
  cmbCodecWmv_nl.Items := CodecList;
  cmbCodecAvi_nl.Items := CodecList;
  cmbCodecHQAvi_nl.Items := CodecList;
  cmbCodecMP4_nl.Items := CodecList;
  cmbCodecOther_nl.Items := CodecList;
end;


procedure TFSettings.FormDestroy(Sender: TObject);
begin
  if EnumFilters <> nil then
    FreeAndNil(EnumFilters);
end;

procedure TFSettings.ECheckInfoInterval_nlKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in [#0 .. #31, '0'..'9']) then key := chr(0);
end;

procedure TFSettings.edtFrameWidth_nlExit(Sender: TObject);
var
  val: integer;
  Edit: TEdit;
begin
  Edit := Sender as TEdit;
  if Edit = nil then exit;
  val := StrToIntDef(Edit.Text, -1);
  if val < 1 then begin
    ActiveControl := Edit;
    raise EConvertError.CreateFmt(CAResources.RsErrorInvalidValue, [ Edit.Text ]);
  end
end;

procedure TFSettings.lbchkBlackList_nlClickCheck(Sender: TObject);
var
  FilterGuid: TGUID;
  idx: integer;
begin
  if not assigned(EnumFilters) then exit;

  idx := lbchkBlackList_nl.ItemIndex;
  if idx = -1 then
    exit;
  if idx < EnumFilters.CountFilters then
    FilterGuid := StringToFilterGUID(lbchkBlackList_nl.Items[idx])
  else
    FilterGuid := EnumFilters.Filters[idx].CLSID;
  if lbchkBlackList_nl.Checked[idx] then
  begin
    Settings.FilterBlackList.Add(FilterGuid);
  end
  else
  begin
    Settings.FilterBlackList.Delete(FilterGuid);
  end;
end;

procedure TFSettings.FillBlackList;
var
  i, filterCount: Integer;
  filterInfo: TFilCatNode;
  blackList: TGUIDList;
begin
  blackList := TGUIDList.Create;
  for I := 0 to Settings.FilterBlackList.Count - 1 do
    blackList.Add(Settings.FilterBlackList.Item[i]);
  try
    lbchkBlackList_nl.Clear;
    if EnumFilters <> nil then
      FreeAndNil(EnumFilters);
    EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
    if not assigned(EnumFilters) then exit;

    filterCount := EnumFilters.CountFilters;
    For i := 0 to filterCount - 1 do
    begin
      filterInfo := EnumFilters.Filters[i];
      if blackList.IsInList(filterInfo.CLSID) then
        blackList.Delete(filterInfo.CLSID);
      lbchkBlackList_nl.AddItem(FilterInfoToString(filterInfo), nil);
      lbchkBlackList_nl.Checked[lbchkBlackList_nl.Count - 1] := Settings.FilterIsInBlackList(filterInfo.CLSID);
      lbchkBlackList_nl.ItemEnabled[lbchkBlackList_nl.Count - 1] := not IsEqualGUID(GUID_NULL, filterInfo.CLSID);
    end;
    filterInfo.FriendlyName := '???';
    for I := 0 to blackList.Count - 1 do
    begin
      filterInfo.CLSID := blackList.Item[i];
      lbchkBlackList_nl.AddItem(FilterInfoToString(filterInfo), nil);
      lbchkBlackList_nl.Checked[lbchkBlackList_nl.Count - 1] := true;
      lbchkBlackList_nl.ItemEnabled[lbchkBlackList_nl.Count - 1] := not IsEqualGUID(GUID_NULL, filterInfo.CLSID);
    end;
  finally
    FreeAndNil(blackList);
  end;
end;

procedure TFSettings.tabSourceFilterShow(Sender: TObject);
var
  i: Integer;
  filterInfo: TFilCatNode;
begin
  if lbchkBlackList_nl.Count = 0 then
  begin
    FillBlackList;
  end;
  if Settings.SourceFilterList.count = 0 then begin
    cmbSourceFilterListWMV_nl.Enabled := false;
    cmbSourceFilterListAVI_nl.Enabled := false;
    cmbSourceFilterListHQAVI_nl.Enabled := false;
    cmbSourceFilterListMP4_nl.Enabled := false;
    cmbSourceFilterListOther_nl.Enabled := false;

    cmbSourceFilterListWMV_nl.Items.Clear;
    cmbSourceFilterListWMV_nl.ItemIndex := -1;
    cmbSourceFilterListAVI_nl.Items.Clear;
    cmbSourceFilterListAVI_nl.ItemIndex := -1;
    cmbSourceFilterListHQAVI_nl.Items.Clear;
    cmbSourceFilterListHQAVI_nl.ItemIndex := -1;
    cmbSourceFilterListMP4_nl.Items.Clear;
    cmbSourceFilterListMP4_nl.ItemIndex := -1;
    cmbSourceFilterListOther_nl.Items.Clear;
    cmbSourceFilterListOther_nl.ItemIndex := -1;
  end else if self.cmbSourceFilterListOther_nl.Items.Count = 0 then
  begin
    // lazy initialize
    for i := 0 to Settings.SourceFilterList.count-1 do begin
      filterInfo := Settings.SourceFilterList.GetFilterInfo[i];
      self.cmbSourceFilterListOther_nl.AddItem(FilterInfoToString(filterInfo), nil);
    end;
    cmbSourceFilterListWMV_nl.Items.Assign(cmbSourceFilterListOther_nl.Items);
    cmbSourceFilterListAVI_nl.Items.Assign(cmbSourceFilterListOther_nl.Items);
    cmbSourceFilterListHQAVI_nl.Items.Assign(cmbSourceFilterListOther_nl.Items);
    cmbSourceFilterListMP4_nl.Items.Assign(cmbSourceFilterListOther_nl.Items);

    cmbSourceFilterListWMV_nl.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsWmv.PreferredSourceFilter);
    cmbSourceFilterListChange(cmbSourceFilterListWMV_nl);
    cmbSourceFilterListAVI_nl.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsAvi.PreferredSourceFilter);
    cmbSourceFilterListChange(cmbSourceFilterListAVI_nl);
    cmbSourceFilterListHQAVI_nl.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsHQAvi.PreferredSourceFilter);
    cmbSourceFilterListChange(cmbSourceFilterListHQAVI_nl);
    cmbSourceFilterListMP4_nl.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsMP4.PreferredSourceFilter);
    cmbSourceFilterListChange(cmbSourceFilterListMP4_nl);
    cmbSourceFilterListOther_nl.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsOther.PreferredSourceFilter);
    cmbSourceFilterListChange(cmbSourceFilterListOther_nl);

    cmbSourceFilterListWMV_nl.Enabled := true;
    cmbSourceFilterListAVI_nl.Enabled := true;
    cmbSourceFilterListHQAVI_nl.Enabled := true;
    cmbSourceFilterListMP4_nl.Enabled := true;
    cmbSourceFilterListOther_nl.Enabled := true;
  end;
end;

procedure TFSettings.cmdRefreshFilterListClick(Sender: TObject);
var
  cur: TCursor;
begin
  cur := self.Cursor;
  try
    screen.cursor := crHourglass;
    self.pnlPleaseWait_nl.Visible := true;
    application.ProcessMessages;

    cmbSourceFilterListWMV_nl.Clear;
    cmbSourceFilterListAVI_nl.Clear;
    cmbSourceFilterListHQAVI_nl.Clear;
    cmbSourceFilterListMP4_nl.Clear;
    cmbSourceFilterListOther_nl.Clear;

    FillBlackList;
    Settings.SourceFilterList.Fill(pnlPleaseWait_nl, Settings.FilterBlackList);

    tabSourceFilterShow(sender);
  finally
    screen.cursor := cur;
    self.pnlPleaseWait_nl.Visible := false;
  end;
end;

function TFSettings.GetMovieTypeFromControl(const Sender: TObject; var MovieType: TMovieType): boolean;
begin
  if (Sender = cmbSourceFilterListWMV_nl) or (Sender = CBWmvApp_nl) or (Sender = cmbCodecWmv_nl) or (Sender = btnCodecConfigWmv) or (Sender = btnCodecAboutWmv) then
  begin
    MovieType := mtWMV;
    Result := true;
  end
  else if (Sender = cmbSourceFilterListAVI_nl) or (Sender = CBAviApp_nl) or (Sender = cmbCodecAvi_nl) or (Sender = btnCodecConfigAvi) or (Sender = btnCodecAboutAvi) then
  begin
    MovieType := mtAVI;
    Result := true;
  end
  else if (Sender = cmbSourceFilterListHQAVI_nl) or (Sender = CBHQAviApp_nl) or (Sender = cmbCodecHQAvi_nl) or (Sender = btnCodecConfigHQAvi) or (Sender = btnCodecAboutHQAvi) then
  begin
    MovieType := mtHQAvi;
    Result := true;
  end
  else if (Sender = cmbSourceFilterListMP4_nl) or (Sender = CBMP4App_nl) or (Sender = cmbCodecMP4_nl) or (Sender = btnCodecConfigMP4) or (Sender = btnCodecAboutMP4) then
  begin
    MovieType := mtMP4;
    Result := true;
  end
  else if (Sender = cmbSourceFilterListOther_nl) or (Sender = CBOtherApp_nl) or (Sender = cmbCodecOther_nl) or (Sender = btnCodecConfigOther) or (Sender = btnCodecAboutOther) then
  begin
    MovieType := mtUnknown;
    Result := true;
  end
  else
  begin
    Result := false;
  end;
end;

function TFSettings.GetCodecSettingsControls(const Sender: TObject;
      var cbx: TComboBox; var btnConfig, btnAbout: TButton): boolean;
var
    MovieType: TMovieType;
begin
  Result := GetMovieTypeFromControl(Sender, MovieType);
  if Result then
    Result := GetCodecSettingsControls(MovieType, cbx, btnConfig, btnAbout);
end;

function TFSettings.GetCodecSettingsControls(const MovieType: TMovieType;
      var cbx: TComboBox; var btnConfig, btnAbout: TButton): boolean;
begin
  case MovieType of
    mtWMV: begin
      cbx := cmbCodecWmv_nl;
      btnConfig := btnCodecConfigWmv;
      btnAbout := btnCodecAboutWmv;
      Result := true;
      end;
    mtAVI: begin
      cbx := cmbCodecAvi_nl;
      btnConfig := btnCodecConfigAvi;
      btnAbout := btnCodecAboutAvi;
      Result := true;
      end;
    mtHQAVI: begin
      cbx := cmbCodecHQAvi_nl;
      btnConfig := btnCodecConfigHQAvi;
      btnAbout := btnCodecAboutHQAvi;
      Result := true;
      end;
    mtMP4: begin
      cbx := cmbCodecMP4_nl;
      btnConfig := btnCodecConfigMP4;
      btnAbout := btnCodecAboutMP4;
      Result := true;
      end;
    mtUnknown: begin
      cbx := cmbCodecOther_nl;
      btnConfig := btnCodecConfigOther;
      btnAbout := btnCodecAboutOther;
      Result := true;
      end;
    else
      Result := false;
  end;
end;


procedure TFSettings.Init;
begin
  CBWmvApp_nl.ItemIndex      := CBWmvApp_nl.Items.IndexOf(WmvAppSettings.CutAppName);
  CBAviApp_nl.ItemIndex      := CBAviApp_nl.Items.IndexOf(AviAppSettings.CutAppName);
  CBHQAviApp_nl.ItemIndex    := CBHQAviApp_nl.Items.IndexOf(HQAviAppSettings.CutAppName);
  CBMP4App_nl.ItemIndex     := CBMP4App_nl.Items.IndexOf(MP4AppSettings.CutAppName);
  CBOtherApp_nl.ItemIndex    := CBOtherApp_nl.Items.IndexOf(OtherAppSettings.CutAppName);

  cmbCodecWmv_nl.ItemIndex   := CodecList.IndexOfCodec(WmvAppSettings.CodecFourCC);
  cmbCodecAvi_nl.ItemIndex   := CodecList.IndexOfCodec(AviAppSettings.CodecFourCC);
  cmbCodecHQAvi_nl.ItemIndex := CodecList.IndexOfCodec(HQAviAppSettings.CodecFourCC);
  cmbCodecMP4_nl.ItemIndex   := CodecList.IndexOfCodec(MP4AppSettings.CodecFourCC);
  cmbCodecOther_nl.ItemIndex := CodecList.IndexOfCodec(OtherAppSettings.CodecFourCC);

  cbCutAppChange(CBWmvApp_nl);
  cbCutAppChange(CBAviApp_nl);
  cbCutAppChange(CBHQAviApp_nl);
  cbCutAppChange(CBMP4App_nl);
  cbCutAppChange(CBOtherApp_nl);

  cmbCodecChange(CBWmvApp_nl);
  cmbCodecChange(CBAviApp_nl);
  cmbCodecChange(CBHQAviApp_nl);
  cmbCodecChange(CBMP4App_nl);
  cmbCodecChange(CBOtherApp_nl);
end;

procedure TFSettings.SetCutAppSettings(const MovieType: TMovieType; var ASettings: RCutAppSettings);
begin
  case MovieType of
    mtWMV:      WmvAppSettings := ASettings;
    mtAVI:      AviAppSettings := ASettings;
    mtHQAVI:    HQAviAppSettings := ASettings;
    mtMP4:      MP4AppSettings := ASettings;
    mtUnknown:  OtherAppSettings := ASettings;
  end;
end;

procedure TFSettings.GetCutAppSettings(const MovieType: TMovieType; var ASettings: RCutAppSettings);
begin
  case MovieType of
    mtWMV: begin
      WmvAppSettings.CutAppName := CBWmvApp_nl.Text;
      ASettings := WmvAppSettings;
    end;
    mtAVI: begin
      AviAppSettings.CutAppName := CBAviApp_nl.Text;
      ASettings := AviAppSettings;
    end;
    mtHQAvi: begin
      HQAviAppSettings.CutAppName := CBHQAviApp_nl.Text;
      ASettings := HQAviAppSettings;
    end;
    mtMP4: begin
      MP4AppSettings.CutAppName := CBMP4App_nl.Text;
      ASettings := MP4AppSettings;
    end;
    mtUnknown: begin
      OtherAppSettings.CutAppName := CBOtherApp_nl.Text;
      ASettings := OtherAppSettings;
    end;
  end;
end;

procedure TFSettings.cmbCodecChange(Sender: TObject);
var
  Codec: TICInfoObject;
  cmbCodec: TComboBox;
  btnConfig, btnAbout: TButton;
  MovieType: TMovieType;
  CutAppSettings: RCutAppSettings;
begin
  if not GetMovieTypeFromControl(Sender, MovieType) then
    Exit;
  if not GetCodecSettingsControls(MovieType, cmbCodec, btnConfig, btnAbout) then
    Exit;

  GetCutAppSettings(MovieType, CutAppSettings);

  CutAppSettings.CodecName := cmbCodec.Text;
  // Reset codec settings ...
  CutAppSettings.CodecSettingsSize := 0;
  CutAppSettings.CodecSettings := '';

  Codec := nil;
  if cmbCodec.ItemIndex >= 0 then
  begin
    Codec := (cmbCodec.Items.Objects[cmbCodec.ItemIndex] as TICInfoObject);
  end;
  if Assigned(Codec) then begin
    CutAppSettings.CodecFourCC := Codec.ICInfo.fccHandler;
    CutAppSettings.CodecVersion := Codec.ICInfo.dwVersion;
    btnConfig.Enabled := cmbCodec.Enabled and Codec.HasConfigureBox;
    btnAbout.Enabled := cmbCodec.Enabled and Codec.HasAboutBox;
  end else begin
    CutAppSettings.CodecFourCC := 0;
    CutAppSettings.CodecVersion := 0;
    btnConfig.Enabled := false;
    btnAbout.Enabled := false;
  end;
  // only set settings, if sender is codec combo (else called from init)
  if Sender = cmbCodec then
    SetCutAppSettings(MovieType, CutAppSettings);
end;

procedure TFSettings.btnCodecConfigClick(Sender: TObject);
var
  Codec: TICInfoObject;
  cmbCodec: TComboBox;
  btnConfig, btnAbout: TButton;
  MovieType: TMovieType;
  CutAppSettings: RCutAppSettings;
begin
  if not GetMovieTypeFromControl(Sender, MovieType) then
    Exit;
  if not GetCodecSettingsControls(MovieType, cmbCodec, btnConfig, btnAbout) then
    Exit;
  Codec := nil;
  if cmbCodec.ItemIndex >= 0 then
    Codec := (cmbCodec.Items.Objects[cmbCodec.ItemIndex] as TICInfoObject);
  if Assigned(Codec) then begin
    GetCutAppSettings(MovieType, CutAppSettings);
    Assert(CutAppSettings.CodecFourCC = Codec.ICInfo.fccHandler);
    if (CutAppSettings.CodecVersion <> Codec.ICInfo.dwVersion) then begin
      // Reset settings, if codec version changes ...
      // TODO: Log message or ask user.
      CutAppSettings.CodecVersion := Codec.ICInfo.dwVersion;
      CutAppSettings.CodecSettings := '';
      CutAppSettings.CodecSettingsSize := 0;
    end;
    if Codec.Config(self.Handle, CutAppSettings.CodecSettings, CutAppSettings.CodecSettingsSize) then begin
      SetCutAppSettings(MovieType, CutAppSettings);
    end;
  end;
end;

procedure TFSettings.btnCodecAboutClick(Sender: TObject);
var
  Codec: TICInfoObject;
  cmbCodec: TComboBox;
  btnConfig, btnAbout: TButton;
begin
  if not GetCodecSettingsControls(Sender, cmbCodec, btnConfig, btnAbout) then
    Exit;
  Codec := nil;
  if cmbCodec.ItemIndex >= 0 then
    Codec := (cmbCodec.Items.Objects[cmbCodec.ItemIndex] as TICInfoObject);
  if Assigned(Codec) then begin
    if Codec.HasAboutBox then
      Codec.About(self.Handle);
  end;
end;

procedure TFSettings.cbCutAppChange(Sender: TObject);
var
  cbx, cmbCodec: TComboBox;
  btnConfig, btnAbout: TButton;
  CutApp: TCutApplicationBase;
begin
  cbx := Sender as TComboBox;
  if not Assigned(cbx) then exit;
  if not GetCodecSettingsControls(Sender, cmbCodec, btnConfig, btnAbout) then
    Exit;

  CutApp := Settings.GetCutApplicationByName(cbx.Text);
  cmbCodec.Enabled := Assigned(CutApp) and CutApp.HasSmartRendering;
  // enable / disable controls
  cmbCodecChange(Sender);
end;

procedure TFSettings.cmbSourceFilterListChange(Sender: TObject);
var
  idx: integer;
  cbx: TComboBox;
  MovieType: TMovieType;
  CutAppSettings: RCutAppSettings;
begin
  cbx := Sender as TComboBox;
  if not Assigned(cbx) then exit;
  if not GetMovieTypeFromControl(Sender, MovieType) then
    Exit;
  GetCutAppSettings(MovieType, CutAppSettings);
  idx := cbx.ItemIndex;
  if idx >= 0 then
     CutAppSettings.PreferredSourceFilter := Settings.GetFilterInfo[idx].CLSID
  else
    CutAppSettings.PreferredSourceFilter := GUID_NULL;
  SetCutAppSettings(MovieType, CutAppSettings);
end;

initialization
begin
  EmptyRect := Rect(-1, -1, -1, -1);
end;

end.


