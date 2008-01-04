UNIT Settings_dialog;

INTERFACE

{$WARN UNIT_PLATFORM OFF}

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, COntnrs,
  Dialogs, FileCtrl, StdCtrls, ComCtrls, ExtCtrls, IniFiles, Utils, CodecSettings, MMSystem,
  Movie, UCutApplicationBase,

  DirectShow9, DSPack, DSUtil, CheckLst, Mask, JvExMask, JvSpin;

CONST
  //Settings Save...Mode
  smWithSource                     = $00; //How to Save Cutlists and cut movies
  smGivenDir                       = $01;
  smAutoSaveBeforeCutting          = $40; //Only Cutlist
  smAlwaysAsk                      = $80;


TYPE

  TFSettings = CLASS(TForm)
    Cancel: TButton;
    OK: TButton;
    pgSettings: TPageControl;
    tabUserData: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    EUserName: TEdit;
    EUserID: TEdit;
    TabSaveMovie: TTabSheet;
    Label3: TLabel;
    SaveCutMovieMode: TRadioGroup;
    MovieNameAlwaysConfirm: TCheckBox;
    CutMovieSaveDir: TEdit;
    CutMovieExtension: TEdit;
    BCutMovieSaveDir: TButton;
    CBUseMovieNameSuggestion: TCheckBox;
    TabSaveCutlist: TTabSheet;
    SaveCutlistMode: TRadioGroup;
    CutlistNameAlwaysConfirm: TCheckBox;
    CutListSaveDir: TEdit;
    CutlistAutoSaveBeforeCutting: TCheckBox;
    BCUtlistSaveDir: TButton;
    tabURLs: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EURL_Cutlist_Home: TEdit;
    EURL_Info_File: TEdit;
    EURL_Cutlist_Upload: TEdit;
    EURL_Help: TEdit;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    EProxyServerName: TEdit;
    EProxyPort: TEdit;
    EProxyPassword: TEdit;
    EProxyUserName: TEdit;
    TabSheet3: TTabSheet;
    GBInfoCheck: TGroupBox;
    Label26: TLabel;
    CBInfoCheckStable: TCheckBox;
    EChceckInfoInterval: TEdit;
    CBInfoCheckBeta: TCheckBox;
    CBInfoCheckMessages: TCheckBox;
    CBInfoCheckEnabled: TCheckBox;
    TabExternalCutApplication: TTabSheet;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CBWmvApp: TComboBox;
    CBAviApp: TComboBox;
    CBOtherApp: TComboBox;
    Label1: TLabel;
    cbMP4App: TComboBox;
    tsSourceFilter: TTabSheet;
    cbxSourceFilterListAVI: TComboBox;
    cbxSourceFilterListMP4: TComboBox;
    cbxSourceFilterListOther: TComboBox;
    btnRefreshFilterList: TButton;
    lblSourceFilter: TLabel;
    Label2: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    cbxSourceFilterListWMV: TComboBox;
    pnlPleaseWait: TPanel;
    pnlButtons: TPanel;
    lbchkBlackList: TCheckListBox;
    Label15: TLabel;
    Label16: TLabel;
    EFrameWidth: TEdit;
    Label17: TLabel;
    EFrameHeight: TEdit;
    Label22: TLabel;
    EFrameCount: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    RCutMode: TRadioGroup;
    Label29: TLabel;
    spnWaitTimeout: TJvSpinEdit;
    Label30: TLabel;
    edtSmallSkip: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    edtLargeSkip: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    edtNetTimeout: TEdit;
    Label37: TLabel;
    Label38: TLabel;
    cbAutoMuteOnSeek: TCheckBox;
    cbxCodecWmv: TComboBox;
    btnCodecConfigWmv: TButton;
    btnCodecAboutWmv: TButton;
    cbxCodecAvi: TComboBox;
    btnCodecConfigAvi: TButton;
    btnCodecAboutAvi: TButton;
    cbxCodecMP4: TComboBox;
    btnCodecConfigMP4: TButton;
    btnCodecAboutMP4: TButton;
    cbxCodecOther: TComboBox;
    btnCodecConfigOther: TButton;
    btnCodecAboutOther: TButton;
    lblSmartRenderingCodec: TLabel;
    Label31: TLabel;
    CBHQAviApp: TComboBox;
    cbxCodecHQAvi: TComboBox;
    btnCodecConfigHQAvi: TButton;
    btnCodecAboutHQAvi: TButton;
    Label39: TLabel;
    cbxSourceFilterListHQAVI: TComboBox;
    PROCEDURE BCutMovieSaveDirClick(Sender: TObject);
    PROCEDURE BCutlistSaveDirClick(Sender: TObject);
    PROCEDURE EProxyPortKeyPress(Sender: TObject; VAR Key: Char);
    PROCEDURE FormCreate(Sender: TObject);

    PROCEDURE EChceckInfoIntervalKeyPress(Sender: TObject; VAR Key: Char);
    PROCEDURE tsSourceFilterShow(Sender: TObject);
    PROCEDURE btnRefreshFilterListClick(Sender: TObject);
    PROCEDURE lbchkBlackListClickCheck(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE EFrameWidthExit(Sender: TObject);
    PROCEDURE cbxCodecChange(Sender: TObject);
    PROCEDURE btnCodecConfigClick(Sender: TObject);
    PROCEDURE btnCodecAboutClick(Sender: TObject);
    PROCEDURE cbCutAppChange(Sender: TObject);
    PROCEDURE cbxSourceFilterListChange(Sender: TObject);
  PRIVATE
    { Private declarations }
    HQAviAppSettings, AviAppSettings, WmvAppSettings, MP4AppSettings, OtherAppSettings: RCutAppSettings;
    EnumFilters: TSysDevEnum;
    PROCEDURE FillBlackList;
    FUNCTION GetCodecList: TCodecList;
    PROPERTY CodecList: TCodecList READ GetCodecList;
  PRIVATE
    FUNCTION GetMovieTypeFromControl(CONST Sender: TObject; VAR MovieType: TMovieType): boolean;
    FUNCTION GetCodecSettingsControls(CONST Sender: TObject;
      VAR cbx: TComboBox; VAR btnConfig, btnAbout: TButton): boolean; OVERLOAD;
    FUNCTION GetCodecSettingsControls(CONST MovieType: TMovieType;
      VAR cbx: TComboBox; VAR btnConfig, btnAbout: TButton): boolean; OVERLOAD;
  PUBLIC
    PROCEDURE Init;
    FUNCTION GetCodecNameByFourCC(FourCC: DWord): STRING;
    PROCEDURE GetCutAppSettings(CONST MovieType: TMovieType; VAR ASettings: RCutAppSettings);
    PROCEDURE SetCutAppSettings(CONST MovieType: TMovieType; VAR ASettings: RCutAppSettings);
    { Public declarations }
  END;

  //deprecated:
  TCutApp = (caAsfBin = 0, caVirtualDub = 1, caAviDemux = 2);

  TSettings = CLASS(TObject)
  PRIVATE
    SourceFilterList: TSourceFilterList;
    _SaveCutListMode, _SaveCutMovieMode: byte;
    _NewSettingsCreated: boolean;
    FCodecList: TCodecList;
    FUNCTION GetFilter(Index: Integer): TFilCatNode;
    PROPERTY CodecList: TCodecList READ FCodecList;
  PUBLIC
    // window state
    MainFormBounds, FramesFormBounds, PreviewFormBounds, LoggingFormBounds: TRect;
    MainFormWindowState, FramesFormWindowState, PreviewFormWindowState: TWindowState;
    LoggingFormVisible: boolean;

    //CutApplications
    CutApplicationList: TObjectList;

    //User
    UserName, UserID: STRING;

    // Preview frame window
    FramesWidth, FramesHeight, FramesCount: integer;

    //General
    CutlistSaveDir, CutMovieSaveDir, CutMovieExtension, CurrentMovieDir: STRING;
    UseMovieNameSuggestion: boolean;
    DefaultCutMode: integer;
    SmallSkipTime, LargeSkipTime: integer;
    NetTimeout: integer;
    AutoMuteOnSeek: boolean;

    //Warnings
    WarnOnWrongCutApp: boolean;

    //Mplayer
    MPlayerPath: STRING;

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
      url_help: STRING;
    proxyServerName, proxyUserName, proxyPassword: STRING;
    proxyPort: Integer;

    //Other settings
    OffsetSecondsCutChecking: Integer;
    InfoCheckInterval: Integer;
    InfoLastChecked: TDate;
    InfoShowMessages, InfoShowStable, InfoShowBeta: boolean;

    FUNCTION CheckInfos: boolean;

    CONSTRUCTOR Create;
    DESTRUCTOR Destroy; OVERRIDE;
  PROTECTED
    //deprecated
    FUNCTION GetCutAppNameByCutAppType(CAType: TCutApp): STRING;
  PUBLIC
    FUNCTION GetCutAppName(MovieType: TMovieType): STRING;
    FUNCTION GetCutApplicationByName(CAName: STRING): TCutApplicationBase;
    FUNCTION GetCutAppSettingsByMovieType(MovieType: TMovieType): RCutAppSettings;
    FUNCTION GetCutApplicationByMovieType(MovieType: TMovieType): TCutApplicationBase;

    FUNCTION GetPreferredSourceFilterByMovieType(MovieType: TMovieType): TGUID;
    FUNCTION SaveCutlistMode: byte;
    FUNCTION SaveCutMovieMode: byte;
    FUNCTION MovieNameAlwaysConfirm: boolean;
    FUNCTION CutlistNameAlwaysConfirm: boolean;
    FUNCTION CutlistAutoSaveBeforeCutting: boolean;
    FUNCTION FilterIsInBlackList(ClassID: TGUID): boolean;

    PROCEDURE load;
    PROCEDURE edit;
    PROCEDURE save;
  PUBLISHED
    PROPERTY NewSettingsCreated: boolean READ _NewSettingsCreated;
  PUBLIC
    FUNCTION GetCodecNameByFourCC(FourCC: DWord): STRING;
    PROPERTY GetFilterInfo[Index: Integer]: TFilCatNode READ GetFilter;
  END;

VAR
  FSettings                        : TFSettings;

IMPLEMENTATION

USES
  Math, Types,
  Main,
  UCutApplicationAsfbin,
  UCutApplicationVirtualDub,
  UCutApplicationAviDemux,
  UCutApplicationMP4Box,
  UCutlist, VFW;

VAR
  EmptyRect                        : TRect;

{$R *.dfm}

FUNCTION TFSettings.GetCodecList: TCodecList;
BEGIN
  Result := Settings.CodecList;
END;

FUNCTION TFSettings.GetCodecNameByFourCC(FourCC: DWord): STRING;
BEGIN
  Result := Settings.GetCodecNameByFourCC(FourCC);
END;

FUNCTION TSettings.GetCodecNameByFourCC(FourCC: DWord): STRING;
VAR
  idx                              : integer;
  codec                            : TICInfoObject;
BEGIN
  codec := NIL;
  idx := FCodecList.IndexOfCodec(FourCC);
  IF idx > -1 THEN
    codec := FCodecList.CodecInfoObject[idx];
  IF Assigned(codec) THEN Result := codec.Name
  ELSE Result := '';
END;

PROCEDURE TFSettings.BCutMovieSaveDirClick(Sender: TObject);
VAR
  newDir                           : STRING;
  currentDir                       : STRING;
BEGIN
  newDir := self.CutMovieSaveDir.Text;
  currentDir := self.CutMovieSaveDir.Text;
  IF NOT IsPathRooted(currentDir) THEN
    currentDir := '';
  IF selectdirectory('Destination directory for cut movies:', currentDir, newDir) THEN
    self.CutMovieSaveDir.Text := newDir;
END;

PROCEDURE TFSettings.BCUtlistSaveDirClick(Sender: TObject);
VAR
  newDir                           : STRING;
  currentDir                       : STRING;
BEGIN
  newDir := self.CutlistSaveDir.Text;
  currentDir := self.CutlistSaveDir.Text;
  IF NOT IsPathRooted(currentDir) THEN
    currentDir := '';
  IF selectdirectory('Destination directory for cutlists:', currentDir, newDir) THEN
    self.CutlistSaveDir.Text := newDir;
END;

PROCEDURE TFSettings.EProxyPortKeyPress(Sender: TObject; VAR Key: Char);
BEGIN
  IF NOT (key IN [#0..#31, '0'..'9']) THEN key := chr(0);
END;

{ TSettings }

FUNCTION TSettings.CheckInfos: boolean;
BEGIN
  result := (self.InfoCheckInterval >= 0);
END;

CONSTRUCTOR TSettings.create;
BEGIN
  INHERITED;
  FCodecList := TCodecList.Create;
  FCodecList.Fill;
  CutApplicationList := TObjectList.Create;
  CutApplicationList.Add(TCutApplicationAsfbin.Create);
  CutApplicationList.Add(TCutApplicationVirtualDub.Create);
  CutApplicationList.Add(TCutApplicationAviDemux.Create);
  CutApplicationList.Add(TCutApplicationMP4Box.Create);

  SourceFilterList := TSourceFilterList.create;
  FilterBlackList := TGUIDList.Create;

  CutAppSettingsWmv.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsAvi.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsHQAvi.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsMP4.PreferredSourceFilter := GUID_NULL;
  CutAppSettingsOther.PreferredSourceFilter := GUID_NULL;
END;

FUNCTION TSettings.GetFilter(Index: Integer): TFilCatNode;
BEGIN
  Result := SourceFilterList.GetFilterInfo[Index];
END;

FUNCTION TSettings.CutlistAutoSaveBeforeCutting: boolean;
BEGIN
  result := ((_SaveCutlistMOde AND smAutoSaveBeforeCutting) > 0);
END;

FUNCTION TSettings.CutlistNameAlwaysConfirm: boolean;
BEGIN
  result := ((_SaveCutlistMode AND smAlwaysAsk) > 0);
END;

DESTRUCTOR TSettings.destroy;
BEGIN
  FreeAndNil(FCodecList);
  FreeAndNIL(FilterBlackList);
  FreeAndNIL(SourceFilterList);
  FreeAndNIL(CutApplicationList);
  INHERITED;
END;

PROCEDURE TSettings.edit;
VAR
  message_string                   : STRING;
  Data_Valid                       : boolean;
  iTabSheet                        : Integer;
  TabSheet                         : TTabSheet;
  FrameClass                       : TCutApplicationFrameClass;
BEGIN
  FOR iTabSheet := 0 TO FSettings.pgSettings.PageCount - 1 DO BEGIN
    TabSheet := FSettings.pgSettings.Pages[iTabSheet];
    IF TabSheet.Tag <> 0 THEN BEGIN
      FrameClass := TCutApplicationFrameClass(TabSheet.Tag);
      (FSettings.pgSettings.Pages[iTabSheet].Controls[0] AS FrameClass).Init;
    END;
  END;

  FSettings.SetCutAppSettings(mtWMV, self.CutAppSettingsWmv);
  FSettings.SetCutAppSettings(mtAVI, self.CutAppSettingsAvi);
  FSettings.SetCutAppSettings(mtHQAVI, self.CutAppSettingsHQAvi);
  FSettings.SetCutAppSettings(mtMP4, self.CutAppSettingsMP4);
  FSettings.SetCutAppSettings(mtUnknown, self.CutAppSettingsOther);

  FSettings.spnWaitTimeout.AsInteger := CuttingWaitTimeout;
  FSettings.SaveCutMovieMode.ItemIndex := SaveCutMovieMode;
  FSettings.CutMovieSaveDir.Text := CutMovieSaveDir;
  FSettings.CutMovieExtension.Text := CutMovieExtension;
  FSettings.CBUseMovieNameSuggestion.Checked := UseMovieNameSuggestion;
  FSettings.MovieNameAlwaysConfirm.Checked := MovieNameAlwaysConfirm;
  FSettings.SaveCutlistMode.ItemIndex := SaveCutlistMode;
  FSettings.CutlistSaveDir.Text := CutlistSaveDir;
  FSettings.CutlistNameAlwaysConfirm.Checked := CutlistNameAlwaysConfirm;
  Fsettings.CutlistAutoSaveBeforeCutting.Checked := CutlistAutoSaveBeforeCutting;
  Fsettings.RCutMode.ItemIndex := DefaultCutMode;
  FSettings.edtSmallSkip.Text := IntToStr(SmallSkipTime);
  FSettings.edtLargeSkip.Text := IntToStr(LargeSkipTime);
  FSettings.edtNetTimeout.Text := IntToStr(NetTimeout);
  FSettings.cbAutoMuteOnSeek.Checked := AutoMuteOnSeek;

  Fsettings.EURL_Cutlist_Home.Text := self.url_cutlists_home;
  Fsettings.EURL_Info_File.Text := self.url_info_file;
  Fsettings.EURL_Cutlist_Upload.Text := self.url_cutlists_upload;
  Fsettings.EURL_Help.Text := self.url_help;

  FSettings.EProxyServerName.Text := self.proxyServerName;
  FSettings.EProxyPort.Text := IntToStr(self.proxyPort);
  FSettings.EProxyUserName.Text := self.proxyUserName;
  FSettings.EProxyPassword.Text := self.proxyPassword;

  Fsettings.EUserName.Text := self.UserName;
  Fsettings.EUserID.Text := self.UserID;

  FSettings.EFrameWidth.Text := IntToStr(self.FramesWidth);
  FSettings.EFrameHeight.Text := IntToStr(self.FramesHeight);
  FSettings.EFrameCount.Text := IntToStr(self.FramesCount);

  FSettings.CBInfoCheckMessages.Checked := self.InfoShowMessages;
  FSettings.CBInfoCheckStable.Checked := self.InfoShowStable;
  FSettings.CBInfoCheckBeta.Checked := self.InfoShowBeta;
  IF self.CheckInfos THEN
    FSettings.EChceckInfoInterval.Text := inttostr(self.InfoCheckInterval)
  ELSE
    FSettings.EChceckInfoInterval.Text := '0';
  FSettings.CBInfoCheckEnabled.Checked := self.CheckInfos;

  FSettings.Init;

  Data_Valid := false;
  WHILE NOT Data_Valid DO BEGIN
    IF FSettings.ShowModal <> mrOK THEN break; //User Cancelled
    Data_Valid := true;
    IF (Fsettings.SaveCutMovieMode.ItemIndex = 1) THEN BEGIN
      IF IsPathRooted(FSettings.CutMovieSaveDir.Text) AND (NOT DirectoryExists(FSettings.CutMovieSaveDir.Text)) THEN BEGIN
        message_string := 'Cut movie directory does not exist:' + #13#10 + #13#10 + FSettings.CutMovieSaveDir.Text + #13#10 + #13#10 + 'Create?';
        IF application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONWARNING) = IDYES THEN BEGIN
          Data_Valid := forceDirectories(FSettings.CutMovieSaveDir.Text);
        END ELSE BEGIN
          Data_Valid := false;
          FSettings.pgSettings.ActivePage := Fsettings.TabSaveMovie;
          FSettings.ActiveControl := FSettings.CutMovieSaveDir;
        END;
      END;
    END;
    IF Data_Valid AND (Fsettings.SaveCutlistMode.ItemIndex = 1) THEN BEGIN
      IF IsPathRooted(FSettings.CutlistSaveDir.Text) AND (NOT DirectoryExists(FSettings.CutlistSaveDir.Text)) THEN BEGIN
        message_string := 'Cutlist save directory does not exist:' + #13#10 + #13#10 + FSettings.CutlistSaveDir.Text + #13#10 + #13#10 + 'Create?';
        IF application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONWARNING) = IDYES THEN BEGIN
          Data_Valid := forceDirectories(FSettings.CutlistSaveDir.Text);
        END ELSE BEGIN
          Data_Valid := false;
          FSettings.pgSettings.ActivePage := Fsettings.TabSaveCutlist;
          FSettings.ActiveControl := FSettings.CutlistSaveDir;
        END;
      END;
    END;
    IF Data_Valid THEN BEGIN //Apply new settings and save them

      self.CuttingWaitTimeout := FSettings.spnWaitTimeout.AsInteger;

      FSettings.GetCutAppSettings(mtWMV, self.CutAppSettingsWmv);
      FSettings.GetCutAppSettings(mtAVI, self.CutAppSettingsAvi);
      FSettings.GetCutAppSettings(mtHQAVI, self.CutAppSettingsHQAvi);
      FSettings.GetCutAppSettings(mtMP4, self.CutAppSettingsMP4);
      FSettings.GetCutAppSettings(mtUnknown, self.CutAppSettingsOther);

      CASE FSettings.SaveCutMovieMode.ItemIndex OF
        1: _SaveCutMovieMode := smGivenDir;
      ELSE _SaveCutMovieMode := smWithSource;
      END;
      CutMovieSaveDir := FSettings.CutMovieSaveDir.Text;
      CutMovieExtension := FSettings.CutMovieExtension.Text;
      IF FSettings.MovieNameAlwaysConfirm.Checked THEN _SaveCutMovieMode := _saveCutMovieMode OR smAlwaysAsk;
      UseMovieNameSuggestion := FSettings.CBUseMovieNameSuggestion.Checked;

      CASE FSettings.SaveCutlistMode.ItemIndex OF
        1: _SaveCutlistMode := smGivenDir;
      ELSE _SaveCutlistMode := smWithSource;
      END;
      CutlistSaveDir := FSettings.CutlistSaveDir.Text;
      IF FSettings.CutlistNameAlwaysConfirm.Checked THEN _SaveCutlistMode := _SaveCutlistMode OR smAlwaysAsk;
      IF Fsettings.CutlistAutoSaveBeforeCutting.Checked THEN _SaveCutlistMOde := _SaveCutlistMOde OR smAutoSaveBeforeCutting;

      DefaultCutMode := Fsettings.RCutMode.ItemIndex;

      self.url_cutlists_home := Fsettings.EURL_Cutlist_Home.Text;
      self.url_info_file := Fsettings.EURL_Info_File.Text;
      self.url_cutlists_upload := Fsettings.EURL_Cutlist_Upload.Text;
      self.url_help := Fsettings.EURL_Help.Text;

      self.proxyServerName := FSettings.EProxyServerName.Text;
      self.proxyPort := strToIntDef(FSettings.EProxyPort.Text, self.proxyPort);
      self.proxyUserName := FSettings.EProxyUserName.Text;
      self.proxyPassword := FSettings.EProxyPassword.Text;

      self.UserName := Fsettings.EUserName.Text;

      self.FramesWidth := StrToInt(FSettings.EFrameWidth.Text);
      self.FramesHeight := StrToInt(FSettings.EFrameHeight.Text);
      self.FramesCount := StrToInt(FSettings.EFrameCount.Text);

      self.SmallSkipTime := StrToInt(FSettings.edtSmallSkip.Text);
      self.LargeSkipTime := StrToInt(FSettings.edtLargeSkip.Text);
      self.NetTimeout := StrToInt(FSettings.edtNetTimeout.Text);
      self.AutoMuteOnSeek := FSettings.cbAutoMuteOnSeek.Checked;

      self.InfoShowMessages := FSettings.CBInfoCheckMessages.Checked;
      self.InfoShowStable := FSettings.CBInfoCheckStable.Checked;
      self.InfoShowBeta := FSettings.CBInfoCheckBeta.Checked;
      IF FSettings.CBInfoCheckEnabled.Checked THEN BEGIN
        self.InfoCheckInterval := strToIntDef(FSettings.EChceckInfoInterval.Text, 0);
      END ELSE BEGIN
        self.InfoCheckInterval := -1;
      END;

      FOR iTabSheet := 0 TO FSettings.pgSettings.PageCount - 1 DO BEGIN
        TabSheet := FSettings.pgSettings.Pages[iTabSheet];
        IF TabSheet.Tag <> 0 THEN BEGIN
          FrameClass := TCutApplicationFrameClass(TabSheet.Tag);
          (FSettings.pgSettings.Pages[iTabSheet].Controls[0] AS FrameClass).Apply;
        END;
      END;

      self.save;
    END;
  END;
END;

FUNCTION TSettings.FilterIsInBlackList(ClassID: TGUID): boolean;
BEGIN
  result := FilterBlackList.IsInList(ClassID);
END;

FUNCTION TSettings.GetCutApplicationByMovieType(
  MovieType: TMovieType): TCutApplicationBase;
BEGIN
  result := self.GetCutApplicationByName(GetCutAppName(MovieType));
  IF Assigned(Result) THEN
    result.CutAppSettings := GetCutAppSettingsByMovieType(MovieType);
END;

FUNCTION TSettings.GetCutApplicationByName(
  CAName: STRING): TCutApplicationBase;
VAR
  iCutApplication                  : Integer;
  FoundCutApplication              : TCutApplicationBase;
BEGIN
  result := NIL;
  FOR iCutApplication := 0 TO CutApplicationList.Count - 1 DO BEGIN
    FoundCutApplication := (CutApplicationList[iCutApplication] AS TCutApplicationBase);
    IF AnsiSameText(FoundCutApplication.Name, CAName) THEN BEGIN
      result := FoundCutApplication;
      break;
    END;
  END;
END;

FUNCTION TSettings.GetCutAppSettingsByMovieType(
  MovieType: TMovieType): RCutAppSettings;
BEGIN
  CASE MovieType OF
    mtWMV: result := self.CutAppSettingsWmv;
    mtAVI: result := self.CutAppSettingsAvi;
    mtHQAVI: result := self.CutAppSettingsHQAvi;
    mtMP4: result := self.CutAppSettingsMP4;
  ELSE result := self.CutAppSettingsOther;
  END;
END;

FUNCTION TSettings.GetCutAppName(MovieType: TMovieType): STRING;
BEGIN
  Result := GetCutAppSettingsByMovieType(MovieType).CutAppName;
END;

FUNCTION TSettings.GetPreferredSourceFilterByMovieType(
  MovieType: TMovieType): TGUID;
BEGIN
  Result := GetCutAppSettingsByMovieType(MovieType).PreferredSourceFilter;
END;

FUNCTION TSettings.GetCutAppNameByCutAppType(CAType: TCutApp): STRING;
//deprecated
BEGIN
  CASE CAType OF
    caAsfBin: result := 'AsfBin';
    caVirtualDub: result := 'VirtualDub';
    caAviDemux: result := 'AviDemux';
  ELSE result := '';
  END;
END;


PROCEDURE TSettings.load;
VAR
  ini                              : TCustomIniFile;
  FileName                         : STRING;
  section                          : STRING;
  iFilter, iCutApplication         : integer;

  PROCEDURE ReadOldCutAppName(VAR ASettings: RCutAppSettings;
    CONST s1: STRING; t1: TCutApp; s2, default: STRING);
  BEGIN
    WITH ASettings DO BEGIN
      //defaults and old ini files (belw 0.9.11.6)
      IF CutAppName = '' THEN
        CutAppName := ini.ReadString(section, s2, '');
      //old ini Files (for Compatibility with versions below 0.9.9):
      IF (CutAppName = '') AND (s1 <> '') THEN
        CutAppName := GetCutAppNameByCutAppType(TCutApp(ini.ReadInteger(section, s1, integer(t1))));
      IF CutAppName = '' THEN
        CutAppName := default;
    END;
  END;
BEGIN
  FileName := ChangeFileExt(Application.ExeName, '.ini');
  self._NewSettingsCreated := NOT FileExists(FileName);
  ini := TIniFile.Create(FileName);
  TRY
    section := 'General';
    UserName := ini.ReadString(section, 'UserName', '');
    UserID := ini.ReadString(section, 'UserID', '');

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
    FOR iFilter := 0 TO ini.ReadInteger(section, 'Count', 0) - 1 DO BEGIN
      self.FilterBlackList.AddFromString(ini.ReadString(section, 'Filter_' + inttostr(iFilter), ''));
    END;

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
    self.DefaultCutMode := ini.ReadInteger(section, 'DefaultCutMode', integer(clmCrop));
    self.SmallSkipTime := ini.ReadInteger(section, 'SmallSkipTime', 2);
    self.LargeSkipTime := ini.ReadInteger(section, 'LargeSkipTime', 25);
    self.AutoMuteOnSeek := ini.ReadBool(section, 'AutoMuteOnSeek', false);

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

    FOR iCutApplication := 0 TO CutApplicationList.Count - 1 DO BEGIN
      TCutApplicationBase(CutApplicationList[iCutApplication]).LoadSettings(ini);
    END;

  FINALLY
    FreeAndNil(ini);
  END;

  IF userID = '' THEN BEGIN
    //Generade Random ID and save it immediately
    userID := rand_string;
    self.save;
  END;
END;

FUNCTION TSettings.MovieNameAlwaysConfirm: boolean;
BEGIN
  result := ((_SaveCutMovieMode AND smAlwaysAsk) > 0);
END;

PROCEDURE TSettings.save;
VAR
  ini                              : TCustomIniFile;
  FileName                         : STRING;
  section                          : STRING;
  iCutApplication                  : integer;
  iFilter                          : integer;
BEGIN
  FileName := ChangeFileExt(Application.ExeName, '.ini');
  ini := TIniFile.Create(FileName);
  TRY
    section := 'General';
    ini.WriteString(section, 'Version', Application_version);
    ini.WriteString(section, 'UserName', UserName);
    ini.WriteString(section, 'UserID', UserID);

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
    FOR iFilter := 0 TO self.FilterBlackList.Count - 1 DO BEGIN
      ini.WriteString(section, 'Filter_' + IntToStr(iFilter), GUIDToString(self.FilterBlackList.Item[iFilter]));
    END;

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
    ini.WriteString(section, 'ApplicationHelp', url_help);

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

    section := 'Warnings';
    ini.WriteBool(section, 'WarnOnWrongCutApp', WarnOnWrongCutApp);

    section := 'WindowStates';
    ini.WriteInteger(section, 'Main_WindowState', integer(self.MainFormWindowState));
    iniWriteRect(ini, section, 'Main', self.MainFormBounds);
    IF self.FramesFormWindowState <> wsNormal THEN
      ini.WriteInteger(section, 'Frames_WindowState', integer(self.FramesFormWindowState));
    iniWriteRect(ini, section, 'Frames', self.FramesFormBounds);
    IF self.PreviewFormWindowState <> wsNormal THEN
      ini.WriteInteger(section, 'Preview_WindowState', integer(self.PreviewFormWindowState));
    iniWriteRect(ini, section, 'Preview', self.PreviewFormBounds);
    iniWriteRect(ini, section, 'Logging', self.LoggingFormBounds);
    ini.WriteBool(section, 'LoggingFormVisible', self.LoggingFormVisible);

    FOR iCutApplication := 0 TO CutApplicationList.Count - 1 DO BEGIN
      (CutApplicationList[iCutApplication] AS TCutApplicationBase).SaveSettings(ini);
    END;

  FINALLY
    FreeAndNil(ini);
    self._NewSettingsCreated := NOT FileExists(FileName);
  END;
END;

FUNCTION TSettings.SaveCutlistMode: byte;
BEGIN
  result := self._SaveCutListMode AND $0F;
END;

FUNCTION TSettings.SaveCutMovieMode: byte;
BEGIN
  result := self._SaveCutMovieMode AND $0F;
END;

PROCEDURE TFSettings.FormCreate(Sender: TObject);
VAR
  frame                            : TfrmCutApplicationBase;
  newTabsheet                      : TTabsheet;
  iCutApplication                  : integer;
  CutApplication                   : TCutApplicationBase;
  MinSize                          : TSizeConstraints;
BEGIN
  CBOtherApp.Items.Clear;
  MinSize := tabURLs.Constraints;
  EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters

  FOR iCutApplication := 0 TO Settings.CutApplicationList.Count - 1 DO BEGIN
    CutApplication := (Settings.CutApplicationList[iCutApplication] AS TCutApplicationBase);
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

    CBOtherApp.Items.Add(CutApplication.Name);
  END;

  IF tabUserData.Height < MinSize.MinHeight THEN
    self.Constraints.MinHeight := self.Height - (tabUserData.Height - MinSize.MinHeight);
  IF tabUserData.Width < MinSize.MinWidth THEN
    self.Constraints.MinWidth := self.Width - (tabUserData.Width - MinSize.MinWidth);

  CBWmvApp.Items.Assign(CBOtherApp.Items);
  CBAviApp.Items.Assign(CBOtherApp.Items);
  CBHQAviApp.Items.Assign(CBOtherApp.Items);
  CBMP4App.Items.Assign(CBOtherApp.Items);

  cbxCodecWmv.Items := CodecList;
  cbxCodecAvi.Items := CodecList;
  cbxCodecHQAvi.Items := CodecList;
  cbxCodecMP4.Items := CodecList;
  cbxCodecOther.Items := CodecList;
END;


PROCEDURE TFSettings.FormDestroy(Sender: TObject);
BEGIN
  IF EnumFilters <> NIL THEN
    FreeAndNil(EnumFilters);
END;

PROCEDURE TFSettings.EChceckInfoIntervalKeyPress(Sender: TObject;
  VAR Key: Char);
BEGIN
  IF NOT (key IN [#0..#31, '0'..'9']) THEN key := chr(0);
END;

PROCEDURE TFSettings.EFrameWidthExit(Sender: TObject);
VAR
  val                              : integer;
  Edit                             : TEdit;
BEGIN
  Edit := Sender AS TEdit;
  IF Edit = NIL THEN exit;
  val := StrToIntDef(Edit.Text, -1);
  IF val < 1 THEN BEGIN
    ActiveControl := Edit;
    RAISE EConvertError.Create('Invalid value: ' + Edit.Text);
  END
END;

PROCEDURE TFSettings.lbchkBlackListClickCheck(Sender: TObject);
VAR
  FilterGuid                       : TGUID;
  idx                              : integer;
BEGIN
  IF NOT assigned(EnumFilters) THEN exit;

  idx := lbchkBlackList.ItemIndex;
  IF idx = -1 THEN
    exit;
  IF idx < EnumFilters.CountFilters THEN
    FilterGuid := StringToFilterGUID(lbchkBlackList.Items[idx])
  ELSE
    FilterGuid := EnumFilters.Filters[idx].CLSID;
  IF lbchkBlackList.Checked[idx] THEN BEGIN
    Settings.FilterBlackList.Add(FilterGuid);
  END
  ELSE BEGIN
    Settings.FilterBlackList.Delete(FilterGuid);
  END;
END;

PROCEDURE TFSettings.FillBlackList;
VAR
  i, filterCount                   : Integer;
  filterInfo                       : TFilCatNode;
  blackList                        : TGUIDList;
BEGIN
  blackList := TGUIDList.Create;
  FOR I := 0 TO Settings.FilterBlackList.Count - 1 DO
    blackList.Add(Settings.FilterBlackList.Item[i]);
  TRY
    lbchkBlackList.Clear;
    IF EnumFilters <> NIL THEN
      FreeAndNil(EnumFilters);
    EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
    IF NOT assigned(EnumFilters) THEN exit;

    filterCount := EnumFilters.CountFilters;
    FOR i := 0 TO filterCount - 1 DO BEGIN
      filterInfo := EnumFilters.Filters[i];
      IF blackList.IsInList(filterInfo.CLSID) THEN
        blackList.Delete(filterInfo.CLSID);
      lbchkBlackList.AddItem(FilterInfoToString(filterInfo), NIL);
      lbchkBlackList.Checked[lbchkBlackList.Count - 1] := Settings.FilterIsInBlackList(filterInfo.CLSID);
      lbchkBlackList.ItemEnabled[lbchkBlackList.Count - 1] := NOT IsEqualGUID(GUID_NULL, filterInfo.CLSID);
    END;
    filterInfo.FriendlyName := '???';
    FOR I := 0 TO blackList.Count - 1 DO BEGIN
      filterInfo.CLSID := blackList.Item[i];
      lbchkBlackList.AddItem(FilterInfoToString(filterInfo), NIL);
      lbchkBlackList.Checked[lbchkBlackList.Count - 1] := true;
      lbchkBlackList.ItemEnabled[lbchkBlackList.Count - 1] := NOT IsEqualGUID(GUID_NULL, filterInfo.CLSID);
    END;
  FINALLY
    FreeAndNil(blackList);
  END;
END;

PROCEDURE TFSettings.tsSourceFilterShow(Sender: TObject);
VAR
  i                                : Integer;
  filterInfo                       : TFilCatNode;
BEGIN
  IF lbchkBlackList.Count = 0 THEN BEGIN
    FillBlackList;
  END;
  IF Settings.SourceFilterList.count = 0 THEN BEGIN
    cbxSourceFilterListWMV.Enabled := false;
    cbxSourceFilterListAVI.Enabled := false;
    cbxSourceFilterListHQAVI.Enabled := false;
    cbxSourceFilterListMP4.Enabled := false;
    cbxSourceFilterListOther.Enabled := false;

    cbxSourceFilterListWMV.Items.Clear;
    cbxSourceFilterListWMV.ItemIndex := -1;
    cbxSourceFilterListAVI.Items.Clear;
    cbxSourceFilterListAVI.ItemIndex := -1;
    cbxSourceFilterListHQAVI.Items.Clear;
    cbxSourceFilterListHQAVI.ItemIndex := -1;
    cbxSourceFilterListMP4.Items.Clear;
    cbxSourceFilterListMP4.ItemIndex := -1;
    cbxSourceFilterListOther.Items.Clear;
    cbxSourceFilterListOther.ItemIndex := -1;
  END ELSE IF self.cbxSourceFilterListOther.Items.Count = 0 THEN BEGIN
    // lazy initialize
    FOR i := 0 TO Settings.SourceFilterList.count - 1 DO BEGIN
      filterInfo := Settings.SourceFilterList.GetFilterInfo[i];
      self.cbxSourceFilterListOther.AddItem(FilterInfoToString(filterInfo), NIL);
    END;
    cbxSourceFilterListWMV.Items.Assign(cbxSourceFilterListOther.Items);
    cbxSourceFilterListAVI.Items.Assign(cbxSourceFilterListOther.Items);
    cbxSourceFilterListHQAVI.Items.Assign(cbxSourceFilterListOther.Items);
    cbxSourceFilterListMP4.Items.Assign(cbxSourceFilterListOther.Items);

    cbxSourceFilterListWMV.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsWmv.PreferredSourceFilter);
    cbxSourceFilterListChange(cbxSourceFilterListWMV);
    cbxSourceFilterListAVI.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsAvi.PreferredSourceFilter);
    cbxSourceFilterListChange(cbxSourceFilterListAVI);
    cbxSourceFilterListHQAVI.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsHQAvi.PreferredSourceFilter);
    cbxSourceFilterListChange(cbxSourceFilterListHQAVI);
    cbxSourceFilterListMP4.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsMP4.PreferredSourceFilter);
    cbxSourceFilterListChange(cbxSourceFilterListMP4);
    cbxSourceFilterListOther.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.CutAppSettingsOther.PreferredSourceFilter);
    cbxSourceFilterListChange(cbxSourceFilterListOther);

    cbxSourceFilterListWMV.Enabled := true;
    cbxSourceFilterListAVI.Enabled := true;
    cbxSourceFilterListHQAVI.Enabled := true;
    cbxSourceFilterListMP4.Enabled := true;
    cbxSourceFilterListOther.Enabled := true;
  END;
END;

PROCEDURE TFSettings.btnRefreshFilterListClick(Sender: TObject);
VAR
  cur                              : TCursor;
BEGIN
  cur := self.Cursor;
  TRY
    screen.cursor := crHourglass;
    self.pnlPleaseWait.Visible := true;
    application.ProcessMessages;

    cbxSourceFilterListWMV.Clear;
    cbxSourceFilterListAVI.Clear;
    cbxSourceFilterListHQAVI.Clear;
    cbxSourceFilterListMP4.Clear;
    cbxSourceFilterListOther.Clear;

    FillBlackList;
    Settings.SourceFilterList.Fill(pnlPleaseWait, Settings.FilterBlackList);

    tsSourceFilterShow(sender);
  FINALLY
    screen.cursor := cur;
    self.pnlPleaseWait.Visible := false;
  END;
END;

FUNCTION TFSettings.GetMovieTypeFromControl(CONST Sender: TObject; VAR MovieType: TMovieType): boolean;
BEGIN
  IF (Sender = cbxSourceFilterListWMV) OR (Sender = CBWmvApp) OR (Sender = cbxCodecWmv) OR (Sender = btnCodecConfigWmv) OR (Sender = btnCodecAboutWmv) THEN BEGIN
    MovieType := mtWMV;
    Result := true;
  END
  ELSE IF (Sender = cbxSourceFilterListAVI) OR (Sender = CBAviApp) OR (Sender = cbxCodecAvi) OR (Sender = btnCodecConfigAvi) OR (Sender = btnCodecAboutAvi) THEN BEGIN
    MovieType := mtAVI;
    Result := true;
  END
  ELSE IF (Sender = cbxSourceFilterListHQAVI) OR (Sender = CBHQAviApp) OR (Sender = cbxCodecHQAvi) OR (Sender = btnCodecConfigHQAvi) OR (Sender = btnCodecAboutHQAvi) THEN BEGIN
    MovieType := mtHQAvi;
    Result := true;
  END
  ELSE IF (Sender = cbxSourceFilterListMP4) OR (Sender = CBMP4App) OR (Sender = cbxCodecMP4) OR (Sender = btnCodecConfigMP4) OR (Sender = btnCodecAboutMP4) THEN BEGIN
    MovieType := mtMP4;
    Result := true;
  END
  ELSE IF (Sender = cbxSourceFilterListOther) OR (Sender = CBOtherApp) OR (Sender = cbxCodecOther) OR (Sender = btnCodecConfigOther) OR (Sender = btnCodecAboutOther) THEN BEGIN
    MovieType := mtUnknown;
    Result := true;
  END
  ELSE BEGIN
    Result := false;
  END;
END;

FUNCTION TFSettings.GetCodecSettingsControls(CONST Sender: TObject;
  VAR cbx: TComboBox; VAR btnConfig, btnAbout: TButton): boolean;
VAR
  MovieType                        : TMovieType;
BEGIN
  Result := GetMovieTypeFromControl(Sender, MovieType);
  IF Result THEN
    Result := GetCodecSettingsControls(MovieType, cbx, btnConfig, btnAbout);
END;

FUNCTION TFSettings.GetCodecSettingsControls(CONST MovieType: TMovieType;
  VAR cbx: TComboBox; VAR btnConfig, btnAbout: TButton): boolean;
BEGIN
  CASE MovieType OF
    mtWMV: BEGIN
        cbx := cbxCodecWmv;
        btnConfig := btnCodecConfigWmv;
        btnAbout := btnCodecAboutWmv;
        Result := true;
      END;
    mtAVI: BEGIN
        cbx := cbxCodecAvi;
        btnConfig := btnCodecConfigAvi;
        btnAbout := btnCodecAboutAvi;
        Result := true;
      END;
    mtHQAVI: BEGIN
        cbx := cbxCodecHQAvi;
        btnConfig := btnCodecConfigHQAvi;
        btnAbout := btnCodecAboutHQAvi;
        Result := true;
      END;
    mtMP4: BEGIN
        cbx := cbxCodecMP4;
        btnConfig := btnCodecConfigMP4;
        btnAbout := btnCodecAboutMP4;
        Result := true;
      END;
    mtUnknown: BEGIN
        cbx := cbxCodecOther;
        btnConfig := btnCodecConfigOther;
        btnAbout := btnCodecAboutOther;
        Result := true;
      END;
  ELSE
    Result := false;
  END;
END;


PROCEDURE TFSettings.Init;
BEGIN
  CBWmvApp.ItemIndex := CBWmvApp.Items.IndexOf(WmvAppSettings.CutAppName);
  CBAviApp.ItemIndex := CBAviApp.Items.IndexOf(AviAppSettings.CutAppName);
  CBHQAviApp.ItemIndex := CBHQAviApp.Items.IndexOf(HQAviAppSettings.CutAppName);
  CBMP4App.ItemIndex := CBMP4App.Items.IndexOf(MP4AppSettings.CutAppName);
  CBOtherApp.ItemIndex := CBOtherApp.Items.IndexOf(OtherAppSettings.CutAppName);

  cbxCodecWmv.ItemIndex := CodecList.IndexOfCodec(WmvAppSettings.CodecFourCC);
  cbxCodecAvi.ItemIndex := CodecList.IndexOfCodec(AviAppSettings.CodecFourCC);
  cbxCodecHQAvi.ItemIndex := CodecList.IndexOfCodec(HQAviAppSettings.CodecFourCC);
  cbxCodecMP4.ItemIndex := CodecList.IndexOfCodec(MP4AppSettings.CodecFourCC);
  cbxCodecOther.ItemIndex := CodecList.IndexOfCodec(OtherAppSettings.CodecFourCC);

  cbCutAppChange(CBWmvApp);
  cbCutAppChange(CBAviApp);
  cbCutAppChange(CBHQAviApp);
  cbCutAppChange(CBMP4App);
  cbCutAppChange(CBOtherApp);

  cbxCodecChange(CBWmvApp);
  cbxCodecChange(CBAviApp);
  cbxCodecChange(CBHQAviApp);
  cbxCodecChange(CBMP4App);
  cbxCodecChange(CBOtherApp);
END;

PROCEDURE TFSettings.SetCutAppSettings(CONST MovieType: TMovieType; VAR ASettings: RCutAppSettings);
BEGIN
  CASE MovieType OF
    mtWMV: WmvAppSettings := ASettings;
    mtAVI: AviAppSettings := ASettings;
    mtHQAVI: HQAviAppSettings := ASettings;
    mtMP4: MP4AppSettings := ASettings;
    mtUnknown: OtherAppSettings := ASettings;
  END;
END;

PROCEDURE TFSettings.GetCutAppSettings(CONST MovieType: TMovieType; VAR ASettings: RCutAppSettings);
BEGIN
  CASE MovieType OF
    mtWMV: BEGIN
        WmvAppSettings.CutAppName := CBWmvApp.Text;
        ASettings := WmvAppSettings;
      END;
    mtAVI: BEGIN
        AviAppSettings.CutAppName := CBAviApp.Text;
        ASettings := AviAppSettings;
      END;
    mtHQAvi: BEGIN
        HQAviAppSettings.CutAppName := CBHQAviApp.Text;
        ASettings := HQAviAppSettings;
      END;
    mtMP4: BEGIN
        MP4AppSettings.CutAppName := CBMP4App.Text;
        ASettings := MP4AppSettings;
      END;
    mtUnknown: BEGIN
        OtherAppSettings.CutAppName := CBOtherApp.Text;
        ASettings := OtherAppSettings;
      END;
  END;
END;

PROCEDURE TFSettings.cbxCodecChange(Sender: TObject);
VAR
  Codec                            : TICInfoObject;
  cbxCodec                         : TComboBox;
  btnConfig, btnAbout              : TButton;
  MovieType                        : TMovieType;
  CutAppSettings                   : RCutAppSettings;
BEGIN
  IF NOT GetMovieTypeFromControl(Sender, MovieType) THEN
    Exit;
  IF NOT GetCodecSettingsControls(MovieType, cbxCodec, btnConfig, btnAbout) THEN
    Exit;

  GetCutAppSettings(MovieType, CutAppSettings);

  CutAppSettings.CodecName := cbxCodec.Text;
  // Reset codec settings ...
  CutAppSettings.CodecSettingsSize := 0;
  CutAppSettings.CodecSettings := '';

  Codec := NIL;
  IF cbxCodec.ItemIndex >= 0 THEN BEGIN
    Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] AS TICInfoObject);
  END;
  IF Assigned(Codec) THEN BEGIN
    CutAppSettings.CodecFourCC := Codec.ICInfo.fccHandler;
    CutAppSettings.CodecVersion := Codec.ICInfo.dwVersion;
    btnConfig.Enabled := cbxCodec.Enabled AND Codec.HasConfigureBox;
    btnAbout.Enabled := cbxCodec.Enabled AND Codec.HasAboutBox;
  END ELSE BEGIN
    CutAppSettings.CodecFourCC := 0;
    CutAppSettings.CodecVersion := 0;
    btnConfig.Enabled := false;
    btnAbout.Enabled := false;
  END;
  // only set settings, if sender is codec combo (else called from init)
  IF Sender = cbxCodec THEN
    SetCutAppSettings(MovieType, CutAppSettings);
END;

PROCEDURE TFSettings.btnCodecConfigClick(Sender: TObject);
VAR
  Codec                            : TICInfoObject;
  cbxCodec                         : TComboBox;
  btnConfig, btnAbout              : TButton;
  MovieType                        : TMovieType;
  CutAppSettings                   : RCutAppSettings;
BEGIN
  IF NOT GetMovieTypeFromControl(Sender, MovieType) THEN
    Exit;
  IF NOT GetCodecSettingsControls(MovieType, cbxCodec, btnConfig, btnAbout) THEN
    Exit;
  Codec := NIL;
  IF cbxCodec.ItemIndex >= 0 THEN
    Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] AS TICInfoObject);
  IF Assigned(Codec) THEN BEGIN
    GetCutAppSettings(MovieType, CutAppSettings);
    Assert(CutAppSettings.CodecFourCC = Codec.ICInfo.fccHandler);
    IF (CutAppSettings.CodecVersion <> Codec.ICInfo.dwVersion) THEN BEGIN
      // Reset settings, if codec version changes ...
      // TODO: Log message or ask user.
      CutAppSettings.CodecVersion := Codec.ICInfo.dwVersion;
      CutAppSettings.CodecSettings := '';
      CutAppSettings.CodecSettingsSize := 0;
    END;
    IF Codec.Config(self.Handle, CutAppSettings.CodecSettings, CutAppSettings.CodecSettingsSize) THEN BEGIN
      SetCutAppSettings(MovieType, CutAppSettings);
    END;
  END;
END;

PROCEDURE TFSettings.btnCodecAboutClick(Sender: TObject);
VAR
  Codec                            : TICInfoObject;
  cbxCodec                         : TComboBox;
  btnConfig, btnAbout              : TButton;
BEGIN
  IF NOT GetCodecSettingsControls(Sender, cbxCodec, btnConfig, btnAbout) THEN
    Exit;
  Codec := NIL;
  IF cbxCodec.ItemIndex >= 0 THEN
    Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] AS TICInfoObject);
  IF Assigned(Codec) THEN BEGIN
    IF Codec.HasAboutBox THEN
      Codec.About(self.Handle);
  END;
END;

PROCEDURE TFSettings.cbCutAppChange(Sender: TObject);
VAR
  cbx, cbxCodec                    : TComboBox;
  btnConfig, btnAbout              : TButton;
  CutApp                           : TCutApplicationBase;
BEGIN
  cbx := Sender AS TComboBox;
  IF NOT Assigned(cbx) THEN exit;
  IF NOT GetCodecSettingsControls(Sender, cbxCodec, btnConfig, btnAbout) THEN
    Exit;

  CutApp := Settings.GetCutApplicationByName(cbx.Text);
  cbxCodec.Enabled := Assigned(CutApp) AND CutApp.HasSmartRendering;
  // enable / disable controls
  cbxCodecChange(Sender);
END;

PROCEDURE TFSettings.cbxSourceFilterListChange(Sender: TObject);
VAR
  idx                              : integer;
  cbx                              : TComboBox;
  MovieType                        : TMovieType;
  CutAppSettings                   : RCutAppSettings;
BEGIN
  cbx := Sender AS TComboBox;
  IF NOT Assigned(cbx) THEN exit;
  IF NOT GetMovieTypeFromControl(Sender, MovieType) THEN
    Exit;
  GetCutAppSettings(MovieType, CutAppSettings);
  idx := cbx.ItemIndex;
  IF idx >= 0 THEN
    CutAppSettings.PreferredSourceFilter := Settings.GetFilterInfo[idx].CLSID
  ELSE
    CutAppSettings.PreferredSourceFilter := GUID_NULL;
  SetCutAppSettings(MovieType, CutAppSettings);
END;

INITIALIZATION
  BEGIN
    EmptyRect := Rect(-1, -1, -1, -1);
  END;

END.
