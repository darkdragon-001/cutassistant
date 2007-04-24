unit Settings_dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, COntnrs,
  Dialogs, FileCtrl, StdCtrls, ComCtrls, ExtCtrls, IniFiles, Utils, CodecSettings, MMSystem,
  Movie, UCutApplicationBase,

  DirectShow9, DSPack, DSUtil, CheckLst;

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
    procedure BCutMovieSaveDirClick(Sender: TObject);
    procedure BCutlistSaveDirClick(Sender: TObject);
    procedure EProxyPortKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

    procedure EChceckInfoIntervalKeyPress(Sender: TObject; var Key: Char);
    procedure CBInfoCheckEnabledClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tsSourceFilterShow(Sender: TObject);
    procedure btnRefreshFilterListClick(Sender: TObject);
    procedure lbchkBlackListClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EFrameWidthExit(Sender: TObject);
  private
    { Private declarations }
    CodecState: String;
    CodecStateSize: Integer;
    EnumFilters: TSysDevEnum;
    procedure FillBlackList;
  public
    { Public declarations }
  end;

  //deprecated:
  TCutApp = (caAsfBin = 0, caVirtualDub = 1,  caAviDemux = 2);

  TSourceFilterList = class
  private
    FFilters: TList;
    procedure ClearFilterList;
    function Add: PFilCatNode;
    function GetFilter(Index: Integer): TFilCatNode;
    function CheckFilter(EnumFilters: TSysDevEnum; index: integer): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Fill(progressLabel: TPanel): Integer;
    function count: Integer;
    property GetFilterInfo[Index: Integer]: TFilCatNode read GetFilter;
    function GetFilterIndexByCLSID(CLSID: TGUID): Integer;
  end;

  TSettings = class (TObject)
  private
     SourceFilterList: TSourceFilterList;
    _SaveCutListMode, _SaveCutMovieMode: byte;

  public
    //CutApplications
    CutApplicationList: TObjectList;

    //User
    UserName, UserID: string;

    // Preview frame window
    FramesWidth, FramesHeight, FramesCount: integer;

    //General
    CutlistSaveDir, CutMovieSaveDir, CutMovieExtension, CurrentMovieDir: string;
    UseMovieNameSuggestion: boolean;

    //Warnings
    WarnOnWrongCutApp: boolean;

    //Mplayer
    MPlayerPath: String;

    //CutApps
    CutAppNameAvi, CutAppNameWmv, CutAppNameMP4, CutAppNameOther: string;

    //SourceFilter
    SourceFilterWMV, SourceFilterAVI, SourceFilterMP4, SourceFilterOther: TGUID;

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

    function GetCutAppName(MovieType: TMovieType): String;
    function GetCutAppNameByCutAppType(CAType: TCutApp): String; //deprecated
    function GetCutApplicationByName(CAName: string): TCutApplicationBase;
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
  end;

var
  FSettings: TFSettings;

implementation

uses
  Math,
  main, UCutApplicationAsfbin, UCutApplicationVirtualDub, UCutApplicationAviDemux, UCutApplicationMP4Box;


{$R *.dfm}

function FilterInfoToString(const filterInfo: TFilCatNode): string;
begin
  Result := filterInfo.FriendlyName + '  (' + GUIDToString(filterInfo.CLSID) + ')';
end;

function StringToFilterGUID(const s: string): TGUID;
var
  idx, len: integer;
begin
  idx := LastDelimiter('(', s);
  len := LastDelimiter(')', s);
  if idx < 0 then Result := GUID_NULL
  else
  begin
    if len <= idx then len := MaxInt;
    Result := StringToGUID(Copy(s, idx, len - idx))
  end;
end;

procedure TFSettings.BCutMovieSaveDirClick(Sender: TObject);
var
  newDir: String;
begin
  newDir := self.CutMovieSaveDir.Text;
  if selectdirectory('Destination directory for cut movies:', '', newDir) then
    self.CutMovieSaveDir.Text := newDir;
end;

procedure TFSettings.BCUtlistSaveDirClick(Sender: TObject);
var
  newDir: String;
begin
  newDir := self.CutlistSaveDir.Text;
  if selectdirectory('Destination directory for cutlists:', '', newDir) then
    self.CutlistSaveDir.Text := newDir;
end;
                          
procedure TFSettings.EProxyPortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#0 .. #31, '0'..'9']) then key := chr(0);
end;

{ TSettings }

function TSettings.CheckInfos: boolean;
begin
  result := (self.InfoCheckInterval >= 0);
end;

constructor TSettings.create;
begin
  inherited;
  CutApplicationList := TObjectList.Create;
  CutApplicationList.Add(TCutApplicationAsfbin.Create);
  CutApplicationList.Add(TCutApplicationVirtualDub.Create);
  CutApplicationList.Add(TCutApplicationAviDemux.Create);
  CutApplicationList.Add(TCutApplicationMP4Box.Create);

  SourceFilterList:= TSourceFilterList.create;
  FilterBlackList := TGUIDList.Create;

  SourceFilterWMV := GUID_NULL;
  SourceFilterAVI := GUID_NULL;
  SourceFilterMP4 := GUID_NULL;
  SourceFilterOther := GUID_NULL;
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
  FilterBlackList.Free;
  SourceFilterList.Free;
  CutApplicationList.Free;
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

  FSettings.CBWmvApp.ItemIndex      := FSettings.CBWmvApp.Items.IndexOf(self.CutAppNameWmv);
  FSettings.CBAviApp.ItemIndex      := FSettings.CBAviApp.Items.IndexOf(self.CutAppNameAvi);
  FSettings.CBMP4App.ItemIndex      := FSettings.CBMP4App.Items.IndexOf(self.CutAppNameMP4);
  FSettings.CBOtherApp.ItemIndex    := FSettings.CBOtherApp.Items.IndexOf(self.CutAppNameOther);

  FSettings.SaveCutMovieMode.ItemIndex             := SaveCutMovieMode;
  FSettings.CutMovieSaveDir.Text                   := CutMovieSaveDir;
  FSettings.CutMovieExtension.Text                 := CutMovieExtension;
  FSettings.CBUseMovieNameSuggestion.Checked       := UseMovieNameSuggestion;
  FSettings.MovieNameAlwaysConfirm.Checked         := MovieNameAlwaysConfirm;
  FSettings.SaveCutlistMode.ItemIndex              := SaveCutlistMode;
  FSettings.CutlistSaveDir.Text                    := CutlistSaveDir;
  FSettings.CutlistNameAlwaysConfirm.Checked       := CutlistNameAlwaysConfirm;
  Fsettings.CutlistAutoSaveBeforeCutting.Checked   := CutlistAutoSaveBeforeCutting;

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

  Data_Valid := false;
  while not Data_Valid do begin
    if FSettings.ShowModal <> mrOK then break;     //User Cancelled
    Data_Valid := true;
    if (Fsettings.SaveCutMovieMode.ItemIndex = 1) and (not DirectoryExists(FSettings.CutMovieSaveDir.Text)) then begin
      message_string := 'Directory does not exist:' + #13#10 + #13#10 + FSettings.CutMovieSaveDir.Text + #13#10 +  #13#10 + 'Create?' ;
      if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
        Data_Valid := forceDirectories(FSettings.CutMovieSaveDir.Text);
      end else begin
        Data_Valid := false;
        FSettings.pgSettings.ActivePage := Fsettings.TabSaveMovie;
        FSettings.ActiveControl := FSettings.CutMovieSaveDir;
      end;
    end;
    if Data_Valid AND (Fsettings.SaveCutlistMode.ItemIndex = 1) and (not DirectoryExists(FSettings.CutlistSaveDir.Text)) then begin
      message_string := 'Directory does not exist:' + #13#10 + #13#10 + FSettings.CutlistSaveDir.Text + #13#10 +  #13#10 + 'Create?' ;
      if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
        Data_Valid := forceDirectories(FSettings.CutlistSaveDir.Text);
      end else begin
        Data_Valid := false;
        FSettings.pgSettings.ActivePage := Fsettings.TabSaveCutlist;
        FSettings.ActiveControl := FSettings.CutlistSaveDir;
      end;
    end;
    if Data_Valid then begin  //Apply new settings and save them

      self.CutAppNameWmv := FSettings.CBWmvApp.Text;
      self.CutAppNameAvi := FSettings.CBAviApp.Text;
      self.CutAppNameMP4 := FSettings.CBMP4App.Text;
      self.CutAppNameOther := FSettings.CBOtherApp.Text;

      if FSettings.cbxSourceFilterListWMV.ItemIndex >= 0 then
        self.SourceFilterWMV := self.SourceFilterList.GetFilterInfo[FSettings.cbxSourceFilterListWMV.ItemIndex].CLSID;
      if FSettings.cbxSourceFilterListAVI.ItemIndex >= 0 then
        self.SourceFilterAVI := self.SourceFilterList.GetFilterInfo[FSettings.cbxSourceFilterListAVI.ItemIndex].CLSID;
      if FSettings.cbxSourceFilterListMP4.ItemIndex >= 0 then
        self.SourceFilterMP4 := self.SourceFilterList.GetFilterInfo[FSettings.cbxSourceFilterListMP4.ItemIndex].CLSID;
      if FSettings.cbxSourceFilterListOther.ItemIndex >= 0 then
        self.SourceFilterOther := self.SourceFilterList.GetFilterInfo[FSettings.cbxSourceFilterListOther.ItemIndex].CLSID;

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

function TSettings.GetCutAppName(MovieType: TMovieType): String;
begin
  Case MovieType of
    mtWMV: result := self.CutAppNameWmv;
    mtAVI: result := self.CutAppNameAvi;
    mtMP4: result := self.CutAppNameMP4;
    else result := self.CutAppNameOther;
  end;
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

function TSettings.GetPreferredSourceFilterByMovieType(
  MovieType: TMovieType): TGUID;
begin
  case MovieType of
    mtWMV: result := self.SourceFilterWMV;
    mtAVI: result := self.SourceFilterAVI;
    mtMP4: result := self.SourceFilterMP4;
    else result := self.SourceFilterOther;
  end;
end;

procedure TSettings.load;
var
  ini: TIniFile;
  FileName: String;
  section, StrValue: string;
  //fccHandler: FOURCC;
  //CodecVersion: DWORD;
  //CodecSettingsBuffer: PChar;
  //CodecSettings: String;
  //CodecSettingsSize, CodecSettingsSizeRead, BufferSize: Integer;
  iFilter, iCutApplication: integer;
  //CutAppAsfbin: TCutApplicationAsfbin;
  //CutAppAviDemux : TCutApplicationAviDemux;
begin
  FileName := ChangeFileExt( Application.ExeName, '.ini' );
  ini := TIniFile.Create(FileName);
  try
    section := 'General';
    UserName :=  ini.ReadString(section, 'UserName', '');
    UserID :=  ini.ReadString(section, 'UserID', '');

    section := 'FrameWindow';
    FramesWidth := ini.ReadInteger(section, 'Width', 280);
    FramesHeight := ini.ReadInteger(section, 'Height', 210);
    FramesCount := ini.ReadInteger(section, 'Count', 12);

    section := 'External Cut Application';
    //old ini Files (for Compatibility with versions below 0.9.9):
    if self.CutAppNameWmv   = '' then
      self.CutAppNameWmv   := GetCutAppNameByCutAppType(TCutApp(ini.ReadInteger(section, 'CutAppWmv', integer(caAsfBin))));
    if self.CutAppNameAvi   = '' then
      self.CutAppNameAvi   := GetCutAppNameByCutAppType(TCutApp(ini.ReadInteger(section, 'CutAppAvi', integer(caVirtualDub))));
    if self.CutAppNameOther = '' then
      self.CutAppNameOther := GetCutAppNameByCutAppType(TCutApp(ini.ReadInteger(section, 'CutAppOther', integer(caVirtualDub))));
    //defaults
    if self.CutAppNameWmv   = '' then self.CutAppNameWmv   := 'Asfbin';
    if self.CutAppNameAvi   = '' then self.CutAppNameAvi   := 'VirtualDub';
    if self.CutAppNameMP4   = '' then self.CutAppNameMP4   := 'MP4Box';
    if self.CutAppNameOther = '' then self.CutAppNameOther := 'VirtualDub';

    self.CutAppNameWmv := ini.ReadString(section, 'CutAppNameWmv', CutAppNameWmv);
    self.CutAppNameAvi := ini.ReadString(section, 'CutAppNameAvi', CutAppNameAvi);
    self.CutAppNameMP4 := ini.ReadString(section, 'CutAppNameMP4', CutAppNameMP4);
    self.CutAppNameOther := ini.ReadString(section, 'CutAppNameOther', CutAppNameOther);

    section := 'WMV Files';
    StrValue := ini.ReadString(section, 'PreferredSourceFilter', GUIDToString(GUID_NULL));
    SourceFilterWMV := StringToGUID(StrValue);
    section := 'AVI Files';
    StrValue := ini.ReadString(section, 'PreferredSourceFilter', GUIDToString(GUID_NULL));
    SourceFilterAVI := StringToGUID(StrValue);
    section := 'MP4 Files';
    StrValue := ini.ReadString(section, 'PreferredSourceFilter', GUIDToString(GUID_NULL));
    SourceFilterMP4 := StringToGUID(StrValue);
    section := 'OtherMediaFiles';
    StrValue := ini.ReadString(section, 'PreferredSourceFilter', GUIDToString(GUID_NULL));
    SourceFilterOther := StringToGUID(StrValue);

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

    section := 'Warnings';
    self.WarnOnWrongCutApp := ini.ReadBool(section, 'WarnOnWrongCutApp', true);

    for iCutApplication := 0 to CutApplicationList.Count - 1 do begin
      (CutApplicationList[iCutApplication] as TCutApplicationBase).LoadSettings(ini);
    end;

  finally
    ini.Free;
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
  ini: TIniFile;
  section: String;
  iCutApplication: integer;
  iFilter: integer;
begin
  ini := TIniFile.Create(ChangeFileExt( Application.ExeName, '.ini' ));
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

    {ini.WriteString(section, 'VirtualDubPath', VDub_path);
    ini.WriteBool(section, 'VirtualDubNotClose', self.VDNotClose);
    ini.WriteBool(section, 'VirtualDubUseSmartRendering', self.FVDUseSmartRendering);
    ini.WriteString(section, 'VirtualDubScriptsPath', self.VDScriptSaveDir);
    //ini.WriteBool(section, 'VirtualDubScriptsDelete', self.VDScriptDelete);  }

    ini.WriteString(section, 'CutAppNameWmv', self.CutAppNameWmv);
    ini.WriteString(section, 'CutAppNameAvi', self.CutAppNameAvi);
    ini.WriteString(section, 'CutAppNameMP4', self.CutAppNameMP4);
    ini.WriteString(section, 'CutAppNameOther', self.CutAppNameOther);

    section := 'WMV Files';
    ini.WriteString(section, 'PreferredSourceFilter', GUIDToString(self.SourceFilterWMV));
    section := 'AVI Files';
    ini.WriteString(section, 'PreferredSourceFilter', GUIDToString(self.SourceFilterAVI));
    section := 'MP4 Files';
    ini.WriteString(section, 'PreferredSourceFilter', GUIDToString(self.SourceFilterMP4));
    section := 'OtherMediaFiles';
    ini.WriteString(section, 'PreferredSourceFilter', GUIDToString(self.SourceFilterOther));

   { section := 'VirtualDub';
    ini.WriteString(section, 'CodecFourCC', '0x' + IntToHex(self.VDUseCodec, 8));
    ini.WriteString(section, 'CodecVersion', '0x' + IntToHex(self.VDCodecVersion, 8));
    ini.WriteString(section, 'CodecSettings', VDCodecSettings);
    ini.WriteInteger(section, 'CodecSettingsSize', self.VDCodecSettingsSize); }

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

    section := 'Settings';
    ini.WriteInteger(section, 'OffsetSecondsCutChecking', OffsetSecondsCutChecking);
    ini.WriteString(section, 'CurrentMovieDir', self.CurrentMovieDir);
    ini.WriteInteger(section, 'InfoCheckIntervalDays', self.InfoCheckInterval);
    ini.WriteDate(section, 'InfoLastChecked', self.InfoLastChecked);
    ini.WriteBool(section, 'InfoShowMessages', self.InfoShowMessages);
    ini.WriteBool(section, 'InfoShowBeta', self.InfoShowBeta);
    ini.WriteBool(section, 'InfoShowStable', self.InfoShowStable);

    section := 'Warnings';
    ini.WriteBool(section, 'WarnOnWrongCutApp', WarnOnWrongCutApp);

    for iCutApplication := 0 to CutApplicationList.Count - 1 do begin
      (CutApplicationList[iCutApplication] as TCutApplicationBase).SaveSettings(ini);
    end;

  finally
    ini.Free;
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
  CBMP4App.Items.Assign(CBOtherApp.Items);
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
    raise EConvertError.Create('Invalid value: ' + Edit.Text);
  end
end;

procedure TFSettings.CBInfoCheckEnabledClick(Sender: TObject);
begin
  self.GBInfoCheck.Visible := self.CBInfoCheckEnabled.Checked;
end;

procedure TFSettings.FormShow(Sender: TObject);
begin
  CBInfoCheckEnabledClick(sender);
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

{ TSourceFilterList }

procedure TSourceFilterList.ClearFilterList;
var
  i: Integer;
begin
  for i := 0 to (FFilters.Count - 1) do
    if assigned(FFilters.Items[i]) then Dispose(FFilters.Items[i]);
  FFilters.Clear;
end;

function TSourceFilterList.GetFilter(Index: Integer): TFilCatNode;
var
  FilterInfo: PFilCatNode;
begin
  FilterINfo := FFilters.Items[Index];
  result := FilterInfo^;
end;

function TSourceFilterList.Add: PFilCatNode;
var
  newFilterINfo: PFilCatNode;
begin
  new(newFilterINfo);
  self.FFilters.Add(newFilterINfo);
  result := newFilterInfo;
end;

function TSourceFilterList.GetFilterIndexByCLSID(CLSID: TGUID): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to self.count -1 do begin
    if isEqualGUID(CLSID, self.GetFilterInfo[i].CLSID) then begin
      result := i;
      break;
    end;
  end;
end;

{ TSourceFilterList }

procedure UpdateControlCaption(cntrl: TControl; s: string);
begin
  if cntrl = nil then exit;

  if cntrl is TPanel then
  begin
    with cntrl as TPanel do
    begin
      Caption := s;
      Refresh;
    end;
  end
  else if cntrl is TLabel then
  begin
    with cntrl as TLabel do
    begin
      Caption := s;
      Refresh;
    end;
  end
end;

function TSourceFilterList.count: Integer;
begin
  result := FFilters.Count;
end;

constructor TSourceFilterList.create;
begin
  FFilters := TList.Create;
end;

destructor TSourceFilterList.destroy;
begin
  ClearFilterList;
  FreeAndNil(FFilters);
  inherited;
end;

function TSourceFilterList.CheckFilter(EnumFilters: TSysDevEnum; index: integer): Boolean;
const
  CLS_ID_WMT_LOG_FILTER: TGUID = '{92883667-E95C-443D-AC96-4CACA27BEB6E}';
var
  Filter: IBaseFilter;
  newFilterInfo: PFilCatNode;
  filterInfo: TFilCatNode;
begin
  Result := false;
  filterInfo := EnumFilters.Filters[index];
  //Skip Wmt Log Filter -> causing strange exception
  if not (IsEqualGUID(filterInfo.CLSID, CLS_ID_WMT_LOG_FILTER)
    or Settings.FilterIsInBlackList(filterInfo.CLSID))  then
  begin
    Filter := EnumFilters.GetBaseFilter(index);
    if supports(Filter, IFileSourceFilter) then
    begin
      newFilterInfo := self.Add;
      newFilterINfo^  := filterInfo;
      Result := true;
    end;
    Filter:=nil;
  end;
end;

function TSourceFilterList.Fill(progressLabel: TPanel): Integer;
var
  EnumFilters: TSysDevEnum;
  i, filterCount: Integer;
  newFilterInfo: PFilCatNode;
  ParentForm: TWinControl;
begin
  self.ClearFilterList;
  newFilterInfo := self.Add;
  newFilterINfo^.FriendlyName := '(none)';
  newFilterInfo^.CLSID := GUID_NULL;
  result := 1;

  EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
  if not assigned(EnumFilters) then exit;

  ParentForm := progressLabel;
  while (ParentForm <> nil) and not (ParentForm is TCustomForm) do
    ParentForm := ParentForm.Parent;

  UpdateControlCaption(progressLabel, 'Checking Filters. Please wait ...');
  filterCount := EnumFilters.CountFilters;
  try
    For i := 0 to filterCount - 1 do
    begin
      try
        UpdateControlCaption(progressLabel, SysUtils.Format('Checking Filter (%3d/%3d)', [i+1, filterCount]));
        CheckFilter(EnumFilters, i);
      except
      on E: exception do
        begin
        showmessage('Error while checking Filter '+EnumFilters.Filters[i].FriendlyName +#13#10
                   +'ClassID: ' + GUIDTOString(EnumFilters.Filters[i].CLSID)+#13#10
                   +'Error: ' + E.Message);
        if ParentForm <> nil then ParentForm.Refresh;
        //raise;
        end;
      end;
    end;
  finally
    UpdateControlCaption(progressLabel, 'Checking Filters. Done.');
    EnumFilters.free;
    result := self.FFilters.Count;
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
    cbxSourceFilterListMP4.Enabled := false;
    cbxSourceFilterListOther.Enabled := false;

    cbxSourceFilterListWMV.ItemIndex := -1;
    cbxSourceFilterListAVI.ItemIndex := -1;
    cbxSourceFilterListMP4.ItemIndex := -1;
    cbxSourceFilterListOther.ItemIndex := -1;
  end else begin
    for i := 0 to Settings.SourceFilterList.count-1 do begin
      filterInfo := Settings.SourceFilterList.GetFilterInfo[i];
      self.cbxSourceFilterListOther.AddItem(FilterInfoToString(filterInfo), nil);
    end;
    cbxSourceFilterListWMV.Items.Assign(cbxSourceFilterListOther.Items);
    cbxSourceFilterListAVI.Items.Assign(cbxSourceFilterListOther.Items);
    cbxSourceFilterListMP4.Items.Assign(cbxSourceFilterListOther.Items);

    cbxSourceFilterListWMV.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.SourceFilterWMV);
    cbxSourceFilterListAVI.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.SourceFilterAVI);
    cbxSourceFilterListMP4.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.SourceFilterMP4);
    cbxSourceFilterListOther.ItemIndex := Settings.SourceFilterList.GetFilterIndexByCLSID(Settings.SourceFilterOther);

    cbxSourceFilterListWMV.Enabled := true;
    cbxSourceFilterListAVI.Enabled := true;
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
    cbxSourceFilterListMP4.Clear;
    cbxSourceFilterListOther.Clear;

    FillBlackList;
    Settings.SourceFilterList.Fill(pnlPleaseWait);

    tsSourceFilterShow(sender);
  finally
    screen.cursor := cur;
    self.pnlPleaseWait.Visible := false;
  end;
end;

end.


