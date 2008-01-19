UNIT CutlistRate_dialog;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

TYPE
  TFCutlistRate = CLASS(TForm)
    Label1: TLabel;
    RGRatingByAuthor: TRadioGroup;
    btnCancel: TButton;
    ButtonOK: TButton;
    PROCEDURE RGRatingByAuthorClick(Sender: TObject);
    PROCEDURE FormCloseQuery(Sender: TObject; VAR CanClose: Boolean);
  PRIVATE
    { Private declarations }
    FRatingSelectedByUser: boolean;
    FUNCTION GetSelectedRating: integer;
    PROCEDURE SetSelectedRating(rating: integer);
    FUNCTION GetSelectedRatingText: STRING;
  PUBLIC
    { Public declarations }
    PROPERTY SelectedRating: integer READ GetSelectedRating WRITE SetSelectedRating;
    PROPERTY SelectedRatingText: STRING READ GetSelectedRatingText;
  END;

VAR
  FCutlistRate                     : TFCutlistRate;

IMPLEMENTATION

{$R *.dfm}

PROCEDURE TFCutlistRate.RGRatingByAuthorClick(Sender: TObject);
BEGIN
  IF self.RGRatingByAuthor.ItemIndex >= 0 THEN BEGIN
    self.ButtonOK.Enabled := true;
    FRatingSelectedByUser := (Sender = RGRatingByAuthor);
  END;
END;

FUNCTION TFCutlistRate.GetSelectedRatingText: STRING;
BEGIN
  IF SelectedRating < 0 THEN
    Result := ''
  ELSE
    Result := RGRatingByAuthor.Items.Strings[SelectedRating];
END;

FUNCTION TFCutlistRate.GetSelectedRating: integer;
BEGIN
  Result := RGRatingByAuthor.ItemIndex;
END;

PROCEDURE TFCutlistRate.SetSelectedRating(rating: integer);
BEGIN
  IF rating >= RGRatingByAuthor.Items.Count THEN
    rating := -1;
  RGRatingByAuthor.ItemIndex := rating;
  FRatingSelectedByUser := false;
END;

PROCEDURE TFCutlistRate.FormCloseQuery(Sender: TObject;
  VAR CanClose: Boolean);
VAR
  title, msg                       : STRING;
BEGIN
  IF ModalResult <> mrOk THEN
    Exit;
  IF SelectedRating < 0 THEN CanClose := false
  ELSE IF NOT FRatingSelectedByUser THEN BEGIN
    title := 'Please confirm preselected rating ...';
    msg := 'Do you want to use the proposed rating for the cutlist?'#13#10#13#10'  '
      + SelectedRatingText;
    FRatingSelectedByUser := IDOK = Application.MessageBox(PChar(msg), PChar(title), MB_ICONQUESTION OR MB_OKCANCEL OR MB_DEFBUTTON2);
    CanClose := FRatingSelectedByUser;
  END;
  IF NOT CanClose THEN
    RGRatingByAuthor.SetFocus;
END;

END.
