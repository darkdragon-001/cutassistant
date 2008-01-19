UNIT CutlistInfo_dialog;

INTERFACE

USES
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,

  UCutlist, Utils;

CONST
  movie_file_extensions            : ARRAY[0..7] OF STRING
                                   = ('.avi', '.mpg', '.mpeg', '.wmv', '.asf', '.mp2', '.mp4', '.mg4');

TYPE
  TFCutlistInfo = CLASS(TForm)
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
    lblFrameRate: TLabel;
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE CBEPGErrorClick(Sender: TObject);
    PROCEDURE CBOtherErrorClick(Sender: TObject);
    PROCEDURE EnableOK(Sender: TObject);
    PROCEDURE BMovieNameCopyClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
    original_movie_filename: STRING;
  END;


VAR
  FCutlistInfo                     : TFCutlistInfo;

IMPLEMENTATION



{$R *.dfm}

PROCEDURE TFCutlistInfo.FormShow(Sender: TObject);
BEGIN
  CBEPGErrorClick(sender);
  CBOtherErrorClick(sender);
  self.Button2.Enabled := false;
END;

PROCEDURE TFCutlistInfo.CBEPGErrorClick(Sender: TObject);
BEGIN
  self.EActualContent.Enabled := self.CBEPGError.Checked;
  self.EnableOK(sender);
END;

PROCEDURE TFCutlistInfo.CBOtherErrorClick(Sender: TObject);
BEGIN
  self.EOtherErrorDescription.Enabled := self.CBOtherError.Checked;
  self.EnableOK(sender);
END;

PROCEDURE TFCutlistInfo.EnableOK(Sender: TObject);
BEGIN
  IF self.RGRatingByAuthor.ItemIndex < 0 THEN exit;
  self.Button2.Enabled := true;
END;

PROCEDURE TFCutlistInfo.BMovieNameCopyClick(Sender: TObject);
VAR
  s, e                             : STRING;
BEGIN
  s := extractfilename(original_movie_filename);
  e := extractFileExt(s);
  WHILE AnsiMatchText(e, movie_file_extensions) DO BEGIN
    s := changefileExt(s, '');
    e := extractFileExt(s);
  END;
  s := AnsiReplaceText(s, '_', ' ');
  self.EMovieName.Text := s;
END;

END.
