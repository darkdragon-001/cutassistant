unit CutlistInfo_dialog;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes,  Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,

  UCutlist, Utils;

const
  movie_file_extensions: array [0..7] of string
    = ('.avi', '.mpg', '.mpeg', '.wmv', '.asf', '.mp2', '.mp4', '.mg4');

type
  TFCutlistInfo = class(TForm)
    Label1: TLabel;
    RGRatingByAuthor: TRadioGroup;
    GroupBox1: TGroupBox;
    CBEPGError: TCheckBox;
    CBMissingBeginning: TCheckBox;
    CBMissingEnding: TCheckBox;
    CBMissingVideo: TCheckBox;
    CBMissingAudio: TCheckBox;
    CBOtherError: TCheckBox;
    EOtherErrorDescription: TEdit;
    EActualContent: TEdit;
    Button1: TButton;
    Button2: TButton;
    EUserComment: TEdit;
    Label2: TLabel;
    LAuthor: TLabel;
    Panel1: TPanel;
    CBFramesPresent: TCheckBox;
    Label3: TLabel;
    EMovieName: TEdit;
    BMovieNameCopy: TButton;
    procedure FormShow(Sender: TObject);
    procedure CBEPGErrorClick(Sender: TObject);
    procedure CBOtherErrorClick(Sender: TObject);
    procedure EnableOK(Sender: TObject);
    procedure BMovieNameCopyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    original_movie_filename: string;
  end;


var
  FCutlistInfo: TFCutlistInfo;

implementation



{$R *.dfm}

procedure TFCutlistInfo.FormShow(Sender: TObject);
begin
  CBEPGErrorClick(sender);
  CBOtherErrorClick(sender);
  self.Button2.Enabled := false;
end;

procedure TFCutlistInfo.CBEPGErrorClick(Sender: TObject);
begin
  self.EActualContent.Enabled := self.CBEPGError.Checked;
  self.EnableOK(sender);
end;

procedure TFCutlistInfo.CBOtherErrorClick(Sender: TObject);
begin
  self.EOtherErrorDescription.Enabled := self.CBOtherError.Checked;
  self.EnableOK(sender);
end;   

procedure TFCutlistInfo.EnableOK(Sender: TObject);
begin
  if self.RGRatingByAuthor.ItemIndex < 0 then exit;
  self.Button2.Enabled := true;
end;

procedure TFCutlistInfo.BMovieNameCopyClick(Sender: TObject);
var
  s, e: string;
begin
  s := extractfilename(original_movie_filename);
  e := extractFileExt(s);
  while AnsiMatchText(e, movie_file_extensions) do begin
    s := changefileExt(s, '');
    e := extractFileExt(s);
  end;
  s := AnsiReplaceText(s, '_', ' ');
  self.EMovieName.Text := s;
end;

end.
