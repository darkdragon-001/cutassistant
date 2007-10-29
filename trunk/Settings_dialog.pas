unit Settings_dialog;

interface

{$WARN UNIT_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, COntnrs,
  Dialogs, FileCtrl, StdCtrls, ComCtrls, ExtCtrls, IniFiles, Utils, CodecSettings, MMSystem,
  Movie, UCutApplicationBase,

  DirectShow9, DSPack, DSUtil, CheckLst, Mask, JvExMask, JvSpin;

const
  //Settings Save...Mode
  smWithSource = $00;  //How to Save Cutlists and cut movies
  smGivenDir = $01;
  smAutoSaveBeforeCutting = $40;      //Only Cutlist
  smAlwaysAsk = $80;


type

  TFSettings = class(TForm)
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
    procedure BCutMovieSaveDirClick(Sender: TObject);
    procedure BCutlistSaveDirClick(Sender: TObject);
    procedure EProxyPortKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

    procedure EChceckInfoIntervalKeyPress(Sender: TObject; var Key: Char);
    procedure tsSourceFilterShow(Sender: TObject);
    procedure btnRefreshFilterListClick(Sender: TObject);
    procedure lbchkBlackListClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EFrameWidthExit(Sender: TObject);
    procedure cbxCodecChange(Sender: TObject);
    procedure btnCodecConfigClick(Sender: TObject);
    procedure btnCodecAboutClick(Sender: TObject);
    procedure cbCutAppChange(Sender: TObject);
    procedure cbxSourceFilterListChange(Sender: TObject);
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
  UCutlist, VFW, CAResources;

var
  EmptyRect: TRect;

{$R *.dfm}

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

procedure TFSettings.BCutMovieSaveDirClick(Sender: TObject);
var
  newDir: String;
  currentDir: string;
begin
  newDir := self.CutMovieSaveDir.Text;
  currentDir := self.CutMovieSaveDir.Text;
  if not IsPathRooted(currentDir) then
    currentDir := '';
  if SelectDirectory(CAResources.RSTitleCutMovieDestinationDirectory, currentDir, newDir) then
    self.CutMovieSaveDir.Text := newDir;
end;

procedure TFSettings.BCUtlistSaveDirClick(Sender: TObject);
var
  newDir: String;
  currentDir: string;
begin
  newDir := self.CutlistSaveDir.Text;
  currentDir := self.CutlistSaveDir.Text;
  if not IsPathRooted(currentDir) then
    currentDir := '';
  if SelectDirectory(CAResources.RSTitleCutlistDestinationDirectory, currentDir, newDir) then
    self.CutlistSaveDir.Text := newDir;
end;

procedure TFSettings.EProxyPortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#0 .. #31, '0'..'9']) then
    key := chr(0);
end;

{ TSettings }

function TSettings.CheckInfos: boolean;
begin
  result := (self.InfoCheckInterval >= 0);
end;

constructor TSettings.create;
begin
  inherited;
  FCodecList := TCodecList.Create;
  FCodecList.Fill;
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
  FreeAndNil(FCodecList);
  FreeAndNIL(FilterBlackList);
  FreeAndNIL(SourceFilterList);
  FreeAndNIL(CutApplicationList);
  inherited;
end;

procedure TSettings.edit;
var
  message_string: string;
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

  FSettings.spnWaitTimeout.AsInteger               := CuttingWaitTimeout;
  FSettings.SaveCutMovieMode.ItemIndex             := SaveCutMovieMode;
  FSettings.CutMovieSaveDir.Text                   := CutMovieSaveDir;
  FSettings.CutMovieExtension.Text                 := CutMovieExtension;
  FSettings.CBUseMovieNameSuggestion.Checked       := UseMovieNameSuggestion;
  FSettings.MovieNameAlwaysConfirm.Checked         := MovieNameAlwaysConfirm;
  FSettings.SaveCutlistMode.ItemIndex              := SaveCutlistMode;
  FSettings.CutlistSaveDir.Text                    := CutlistSaveDir;
  FSettings.CutlistNameAlwaysConfirm.Checked       := CutlistNameAlwaysConfirm;
  Fsettings.CutlistAutoSaveBeforeCutting.Checked   := CutlistAutoSaveBeforeCutting;
  Fsettings.RCutMode.ItemIndex                     := DefaultCutMode;
  FSettings.edtSmallSkip.Text                      := IntToStr(SmallSkipTime);
  FSettings.edtLargeSkip.Text                      := IntToStr(LargeSkipTime);
  FSettings.edtNetTimeout.Text                     := IntToStr(NetTimeout);
  FSettings.cbAutoMuteOnSeek.Checked               := AutoMuteOnSeek;

  Fsettings.EURL_Cutlist_Home.Text                 := self.url_cutlists_home;
  Fsettings.EURL_Info_File.Text                    := self.url_info_file;
  Fsettings.EURL_Cutlist_Upload.Text               := self.url_cutlists_upload;
  Fsettings.EURL_Help.Text                         := self.url_help;

  FSettings.EProxyServerName.Text                  := self.proxyServerName;
  FSettings.EProxyPort.Text                        := IntToStr(self.proxyPort);
  FSettings.EProxyUserName.Text                    := self.proxyUserName;
  FSettings.EProxyPassword.Text                    := self.proxyPassword;

  Fsettings.EUserName.Text                         := self.UserName;
  Fsettings.EUserID.Text                           := self.UserID;

  FSettings.EFrameWidth.Text                       := IntToStr(self.FramesWidth);
  FSettings.EFrameHeight.Text                      := IntToStr(self.FramesHeight);
  FSettings.EFrameCount.Text                      := IntToStr(self.FramesCount);

  FSettings.CBInfoCheckMessages.Checked   := self.InfoShowMessages            ;
  FSettings.CBInfoCheckStable.Checked     := self.InfoShowStable              ;
  FSettings.CBInfoCheckBeta.Checked       := self.InfoShowBeta                ;
  if self.CheckInfos then
    FSettings.EChceckInfoInterval.Text      := inttostr(self.InfoCheckInterval)
  else
    FSettings.EChceckInfoInterval.Text      := '0';
  FSettings.CBInfoCheckEnabled.Checked := self.CheckInfos;

  FSettings.Init;

  Data_Valid := false;
  while not Data_Valid do begin
    if FSettings.ShowModal <> mrOK then break;     //User Cancelled
    Data_Valid := true;
    if (Fsettings.SaveCutMovieMode.ItemIndex = 1) then
    begin
      if IsPathRooted(FSettings.CutMovieSaveDir.Text) and (not DirectoryExists(FSettings.CutMovieSaveDir.Text)) then
      begin
        message_string := Format(CAResources.RsCutMovieDirectoryMissing, [ FSettings.CutMovieSaveDir.Text ]);
        if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
          Data_Valid := forceDirectories(FSettings.CutMovieSaveDir.Text);
        end else begin
          Data_Valid := false;
          FSettings.pgSettings.ActivePage := Fsettings.TabSaveMovie;
          FSettings.ActiveControl := FSettings.CutMovieSaveDir;
        end;
      end;
    end;
    if Data_Valid AND (Fsettings.SaveCutlistMode.ItemIndex = 1) then
    begin
      if IsPathRooted(FSettings.CutlistSaveDir.Text) and (not DirectoryExists(FSettings.CutlistSaveDir.Text)) then
      begin
        message_string := Format(CAResources.RsCutlistDirectoryMissing, [ FSettings.CutlistSaveDir.Text ]);
        if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
          Data_Valid := forceDirectories(FSettings.CutlistSaveDir.Text);
        end else begin
          Data_Valid := false;
          FSettings.pgSettings.ActivePage := Fsettings.TabSaveCutlist;
          FSettings.ActiveControl := FSettings.CutlistSaveDir;
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

      case FSettings.SaveCutMovieMode.ItemIndex of
        1: _SaveCutMovieMode := smGivenDir;
        else _SaveCutMovieMode := smWithSource;
      end;
      CutMovieSaveDir                                       := FSettings.CutMovieSaveDir.Text                ;
      CutMovieExtension                                     := FSettings.CutMovieExtension.Text              ;
      if FSettings.MovieNameAlwaysConfirm.Checked then _SaveCutMovieMode := _saveCutMovieMode OR smAlwaysAsk;
      UseMovieNameSuggestion := FSettings.CBUseMovieNameSuggestion.Checked;

      case FSettings.SaveCutlistMode.ItemIndex of
        1: _SaveCutlistMode := smGivenDir;
        else _SaveCutlistMode := smWithSource;
      end;
      CutlistSaveDir                                        := FSettings.CutlistSaveDir.Text                 ;
      if FSettings.CutlistNameAlwaysConfirm.Checked then     _SaveCutlistMode := _SaveCutlistMode OR smAlwaysAsk;
      if Fsettings.CutlistAutoSaveBeforeCutting.Checked then _SaveCutlistMOde := _SaveCutlistMOde OR smAutoSaveBeforeCutting;

      DefaultCutMode := Fsettings.RCutMode.ItemIndex;

      self.url_cutlists_home           := Fsettings.EURL_Cutlist_Home.Text           ;
      self.url_info_file               := Fsettings.EURL_Info_File.Text   ;
      self.url_cutlists_upload         := Fsettings.EURL_Cutlist_Upload.Text         ;
      self.url_help                    := Fsettings.EURL_Help.Text                   ;

      self.proxyServerName             := FSettings.EProxyServerName.Text            ;
      self.proxyPort                   := strToIntDef(FSettings.EProxyPort.Text, self.proxyPort);
      self.proxyUserName               := FSettings.EProxyUserName.Text              ;
      self.proxyPassword               := FSettings.EProxyPassword.Text              ;

      self.UserName                    := Fsettings.EUserName.Text;

      self.FramesWidth                 := StrToInt(FSettings.EFrameWidth.Text);
      self.FramesHeight                := StrToInt(FSettings.EFrameHeight.Text);
      self.FramesCount                 := StrToInt(FSettings.EFrameCount.Text);

      self.SmallSkipTime               := StrToInt(FSettings.edtSmallSkip.Text);
      self.LargeSkipTime               := StrToInt(FSettings.edtLargeSkip.Text);
      self.NetTimeout                  := StrToInt(FSettings.edtNetTimeout.Text);
      self.AutoMuteOnSeek              := FSettings.cbAutoMuteOnSeek.Checked;

      self.InfoShowMessages            :=  FSettings.CBInfoCheckMessages.Checked  ;
      self.InfoShowStable              :=  FSettings.CBInfoCheckStable.Checked    ;
      self.InfoShowBeta                :=  FSettings.CBInfoCheckBeta.Checked      ;
      if FSettings.CBInfoCheckEnabled.Checked then begin
        self.InfoCheckInterval :=  strToIntDef(FSettings.EChceckInfoInterval.Text, 0);
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
  CBOtherApp.Items.Clear;
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

    CBOtherApp.Items.Add(CutApplication.Name);
  end;

  if tabUserData.Height < MinSize.MinHeight then
    self.Constraints.MinHeight := self.Height - ( tabUserData.Height - MinSize.MinHeight);
  if tabUserData.Width < MinSize.MinWidth then
    self.Constraints.MinWidth := self.Width - ( tabUserData.Width - MinSize.MinWidth);

  CBWmvApp.Items.Assign(CBOtherApp.Items);
  CBAviApp.Items.Assign(CBOtherApp.Items);
  CBHQAviApp.Items.Assign(CBOtherApp.Items);
  CBMP4App.Items.Assign(CBOtherApp.Items);

  cbxCodecWmv.Items := CodecList;
  cbxCodecAvi.Items := CodecList;
  cbxCodecHQAvi.Items := CodecList;
  cbxCodecMP4.Items := CodecList;
  cbxCodecOther.Items := CodecList;
end;


procedure TFSettings.FormDestroy(Sender: TObject);
begin
  if EnumFilters <> nil then
    FreeAndNil(EnumFilters);
end;

procedure TFSettings.EChceckInfoIntervalKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in [#0 .. #31, '0'..'9']) then key := chr(0);
end;

procedure TFSettings.EFrameWidthExit(Sender: TObject);
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

procedure TFSettings.lbchkBlackListClickCheck(Sender: TObject);
var
  FilterGuid: TGUID;
  idx: integer;
begin
  if not assigned(EnumFilters) then exit;

  idx := lbchkBlackList.ItemIndex;
  if idx = -1 then
    exit;
  if idx < EnumFilters.CountFilters then
    FilterGuid := StringToFilterGUID(lbchkBlackList.Items[idx])
  else
    FilterGuid := EnumFilters.Filters[idx].CLSID;
  if lbchkBlackList.Checked[idx] then
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
    lbchkBlackList.Clear;
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
      lbchkBlackList.AddItem(FilterInfoToString(filterInfo), nil);
      lbchkBlackList.Checked[lbchkBlackList.Count - 1] := Settings.FilterIsInBlackList(filterInfo.CLSID);
      lbchkBlackList.ItemEnabled[lbchkBlackList.Count - 1] := not IsEqualGUID(GUID_NULL, filterInfo.CLSID);
    end;
    filterInfo.FriendlyName := '???';
    for I := 0 to blackList.Count - 1 do
    begin
      filterInfo.CLSID := blackList.Item[i];
      lbchkBlackList.AddItem(FilterInfoToString(filterInfo), nil);
      lbchkBlackList.Checked[lbchkBlackList.Count - 1] := true;
      lbchkBlackList.ItemEnabled[lbchkBlackList.Count - 1] := not IsEqualGUID(GUID_NULL, filterInfo.CLSID);
    end;
  finally
    FreeAndNil(blackList);
  end;
end;

procedure TFSettings.tsSourceFilterShow(Sender: TObject);
var
  i: Integer;
  filterInfo: TFilCatNode;
begin
  if lbchkBlackList.Count = 0 then
  begin
    FillBlackList;
  end;
  if Settings.SourceFilterList.count = 0 then begin
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
  end else if self.cbxSourceFilterListOther.Items.Count = 0 then
  begin
    // lazy initialize
    for i := 0 to Settings.SourceFilterList.count-1 do begin
      filterInfo := Settings.SourceFilterList.GetFilterInfo[i];
      self.cbxSourceFilterListOther.AddItem(FilterInfoToString(filterInfo), nil);
    end;
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
  end;
end;

procedure TFSettings.btnRefreshFilterListClick(Sender: TObject);
var
  cur: TCursor;
begin
  cur := self.Cursor;
  try
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
  finally
    screen.cursor := cur;
    self.pnlPleaseWait.Visible := false;
  end;
end;

function TFSettings.GetMovieTypeFromControl(const Sender: TObject; var MovieType: TMovieType): boolean;
begin
  if (Sender = cbxSourceFilterListWMV) or (Sender = CBWmvApp) or (Sender = cbxCodecWmv) or (Sender = btnCodecConfigWmv) or (Sender = btnCodecAboutWmv) then
  begin
    MovieType := mtWMV;
    Result := true;
  end
  else if (Sender = cbxSourceFilterListAVI) or (Sender = CBAviApp) or (Sender = cbxCodecAvi) or (Sender = btnCodecConfigAvi) or (Sender = btnCodecAboutAvi) then
  begin
    MovieType := mtAVI;
    Result := true;
  end
  else if (Sender = cbxSourceFilterListHQAVI) or (Sender = CBHQAviApp) or (Sender = cbxCodecHQAvi) or (Sender = btnCodecConfigHQAvi) or (Sender = btnCodecAboutHQAvi) then
  begin
    MovieType := mtHQAvi;
    Result := true;
  end
  else if (Sender = cbxSourceFilterListMP4) or (Sender = CBMP4App) or (Sender = cbxCodecMP4) or (Sender = btnCodecConfigMP4) or (Sender = btnCodecAboutMP4) then
  begin
    MovieType := mtMP4;
    Result := true;
  end
  else if (Sender = cbxSourceFilterListOther) or (Sender = CBOtherApp) or (Sender = cbxCodecOther) or (Sender = btnCodecConfigOther) or (Sender = btnCodecAboutOther) then
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
      cbx := cbxCodecWmv;
      btnConfig := btnCodecConfigWmv;
      btnAbout := btnCodecAboutWmv;
      Result := true;
      end;
    mtAVI: begin
      cbx := cbxCodecAvi;
      btnConfig := btnCodecConfigAvi;
      btnAbout := btnCodecAboutAvi;
      Result := true;
      end;
    mtHQAVI: begin
      cbx := cbxCodecHQAvi;
      btnConfig := btnCodecConfigHQAvi;
      btnAbout := btnCodecAboutHQAvi;
      Result := true;
      end;
    mtMP4: begin
      cbx := cbxCodecMP4;
      btnConfig := btnCodecConfigMP4;
      btnAbout := btnCodecAboutMP4;
      Result := true;
      end;
    mtUnknown: begin
      cbx := cbxCodecOther;
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
  CBWmvApp.ItemIndex      := CBWmvApp.Items.IndexOf(WmvAppSettings.CutAppName);
  CBAviApp.ItemIndex      := CBAviApp.Items.IndexOf(AviAppSettings.CutAppName);
  CBHQAviApp.ItemIndex    := CBHQAviApp.Items.IndexOf(HQAviAppSettings.CutAppName);
  CBMP4App.ItemIndex      := CBMP4App.Items.IndexOf(MP4AppSettings.CutAppName);
  CBOtherApp.ItemIndex    := CBOtherApp.Items.IndexOf(OtherAppSettings.CutAppName);

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
      WmvAppSettings.CutAppName := CBWmvApp.Text;
      ASettings := WmvAppSettings;
    end;
    mtAVI: begin
      AviAppSettings.CutAppName := CBAviApp.Text;
      ASettings := AviAppSettings;
    end;
    mtHQAvi: begin
      HQAviAppSettings.CutAppName := CBHQAviApp.Text;
      ASettings := HQAviAppSettings;
    end;
    mtMP4: begin
      MP4AppSettings.CutAppName := CBMP4App.Text;
      ASettings := MP4AppSettings;
    end;
    mtUnknown: begin
      OtherAppSettings.CutAppName := CBOtherApp.Text;
      ASettings := OtherAppSettings;
    end;
  end;
end;

procedure TFSettings.cbxCodecChange(Sender: TObject);
var
  Codec: TICInfoObject;
  cbxCodec: TComboBox;
  btnConfig, btnAbout: TButton;
  MovieType: TMovieType;
  CutAppSettings: RCutAppSettings;
begin
  if not GetMovieTypeFromControl(Sender, MovieType) then
    Exit;
  if not GetCodecSettingsControls(MovieType, cbxCodec, btnConfig, btnAbout) then
    Exit;

  GetCutAppSettings(MovieType, CutAppSettings);

  CutAppSettings.CodecName := cbxCodec.Text;
  // Reset codec settings ...
  CutAppSettings.CodecSettingsSize := 0;
  CutAppSettings.CodecSettings := '';

  Codec := nil;
  if cbxCodec.ItemIndex >= 0 then
  begin
    Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] as TICInfoObject);
  end;
  if Assigned(Codec) then begin
    CutAppSettings.CodecFourCC := Codec.ICInfo.fccHandler;
    CutAppSettings.CodecVersion := Codec.ICInfo.dwVersion;
    btnConfig.Enabled := cbxCodec.Enabled and Codec.HasConfigureBox;
    btnAbout.Enabled := cbxCodec.Enabled and Codec.HasAboutBox;
  end else begin
    CutAppSettings.CodecFourCC := 0;
    CutAppSettings.CodecVersion := 0;
    btnConfig.Enabled := false;
    btnAbout.Enabled := false;
  end;
  // only set settings, if sender is codec combo (else called from init)
  if Sender = cbxCodec then
    SetCutAppSettings(MovieType, CutAppSettings);
end;

procedure TFSettings.btnCodecConfigClick(Sender: TObject);
var
  Codec: TICInfoObject;
  cbxCodec: TComboBox;
  btnConfig, btnAbout: TButton;
  MovieType: TMovieType;
  CutAppSettings: RCutAppSettings;
begin
  if not GetMovieTypeFromControl(Sender, MovieType) then
    Exit;
  if not GetCodecSettingsControls(MovieType, cbxCodec, btnConfig, btnAbout) then
    Exit;
  Codec := nil;
  if cbxCodec.ItemIndex >= 0 then
    Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] as TICInfoObject);
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
  cbxCodec: TComboBox;
  btnConfig, btnAbout: TButton;
begin
  if not GetCodecSettingsControls(Sender, cbxCodec, btnConfig, btnAbout) then
    Exit;
  Codec := nil;
  if cbxCodec.ItemIndex >= 0 then
    Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] as TICInfoObject);
  if Assigned(Codec) then begin
    if Codec.HasAboutBox then
      Codec.About(self.Handle);
  end;
end;

procedure TFSettings.cbCutAppChange(Sender: TObject);
var
  cbx, cbxCodec: TComboBox;
  btnConfig, btnAbout: TButton;
  CutApp: TCutApplicationBase;
begin
  cbx := Sender as TComboBox;
  if not Assigned(cbx) then exit;
  if not GetCodecSettingsControls(Sender, cbxCodec, btnConfig, btnAbout) then
    Exit;

  CutApp := Settings.GetCutApplicationByName(cbx.Text);
  cbxCodec.Enabled := Assigned(CutApp) and CutApp.HasSmartRendering;
  // enable / disable controls
  cbxCodecChange(Sender);
end;

procedure TFSettings.cbxSourceFilterListChange(Sender: TObject);
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


