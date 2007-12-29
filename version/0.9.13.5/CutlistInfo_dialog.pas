unit CutlistInfo_dialog;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes,  Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,

  UCutlist, Utils, JvExStdCtrls, JvCheckBox;

const
  movie_file_extensions: array [0..7] of string
    = ('.avi', '.mpg', '.mpeg', '.wmv', '.asf', '.mp2', '.mp4', '.mg4');

type
  TFCutlistInfo = class(TForm)
    lblInfoCaption: TLabel;
    rgRatingByAuthor: TRadioGroup;
    grpDetails: TGroupBox;
    edtOtherErrorDescription: TEdit;
    edtActualContent: TEdit;
    cmdCancel: TButton;
    cmdOk: TButton;
    edtUserComment: TEdit;
    lblComment: TLabel;
    lblAuthor: TLabel;
    pnlAuthor: TPanel;
    lblSuggestedFilename: TLabel;
    edtMovieName: TEdit;
    cmdMovieNameCopy: TButton;
    lblFrameRate: TLabel;
    cbEPGError: TJvCheckBox;
    cbMissingBeginning: TJvCheckBox;
    cbMissingEnding: TJvCheckBox;
    cbMissingVideo: TJvCheckBox;
    cbMissingAudio: TJvCheckBox;
    cbOtherError: TJvCheckBox;
    cbFramesPresent: TJvCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cbEPGErrorClick(Sender: TObject);
    procedure cbOtherErrorClick(Sender: TObject);
    procedure EnableOK(Sender: TObject);
    procedure cmdMovieNameCopyClick(Sender: TObject);
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
  cbFramesPresent.Left := rgRatingByAuthor.BoundsRect.Right - cbFramesPresent.Width;
  CBEPGErrorClick(sender);
  CBOtherErrorClick(sender);
  self.cmdOk.Enabled := false;
end;

procedure TFCutlistInfo.cbEPGErrorClick(Sender: TObject);
begin
  self.edtActualContent.Enabled := self.CBEPGError.Checked;
  self.EnableOK(sender);
end;

procedure TFCutlistInfo.cbOtherErrorClick(Sender: TObject);
begin
  self.edtOtherErrorDescription.Enabled := self.CBOtherError.Checked;
  self.EnableOK(sender);
end;   

procedure TFCutlistInfo.EnableOK(Sender: TObject);
begin
  if self.RGRatingByAuthor.ItemIndex < 0 then exit;
  self.cmdOk.Enabled := true;
end;

procedure TFCutlistInfo.cmdMovieNameCopyClick(Sender: TObject);
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
  self.edtMovieName.Text := s;
end;

end.
