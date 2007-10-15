unit CutlistRate_dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFCutlistRate = class(TForm)
    Label1: TLabel;
    RGRatingByAuthor: TRadioGroup;
    btnCancel: TButton;
    ButtonOK: TButton;
    procedure RGRatingByAuthorClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FRatingSelectedByUser: boolean;
    function GetSelectedRating: integer;
    procedure SetSelectedRating(rating: integer);
    function GetSelectedRatingText: string;
  public
    { Public declarations }
    property SelectedRating: integer read GetSelectedRating write SetSelectedRating;
    property SelectedRatingText: string read GetSelectedRatingText;
  end;

var
  FCutlistRate: TFCutlistRate;

implementation

uses CAResources;

{$R *.dfm}

procedure TFCutlistRate.RGRatingByAuthorClick(Sender: TObject);
begin
  if self.RGRatingByAuthor.ItemIndex >= 0 then
  begin
    self.ButtonOK.Enabled := true;
    FRatingSelectedByUser := (Sender = RGRatingByAuthor);
  end;
end;

function TFCutlistRate.GetSelectedRatingText: string;
begin
  if SelectedRating < 0 then
    Result := ''
  else
    Result := RGRatingByAuthor.Items.Strings[SelectedRating];
end;

function TFCutlistRate.GetSelectedRating: integer;
begin
  Result := RGRatingByAuthor.ItemIndex;
end;

procedure TFCutlistRate.SetSelectedRating(rating: integer);
begin
  if rating >= RGRatingByAuthor.Items.Count then
    rating := -1;
  RGRatingByAuthor.ItemIndex := rating;
  FRatingSelectedByUser := false;
end;

procedure TFCutlistRate.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  title, msg: string;
begin
  if ModalResult <> mrOk then
    Exit;
  if SelectedRating < 0 then CanClose := false
  else if not FRatingSelectedByUser then
  begin
    title := CAResources.RsTitleConfirmRating;
    msg := Format(CAResources.RsMsgConfirmRating, [ SelectedRatingText ]);
    FRatingSelectedByUser := IDOK = Application.MessageBox(PChar(msg), PChar(title), MB_ICONQUESTION or MB_OKCANCEL or MB_DEFBUTTON2);
    CanClose := FRatingSelectedByUser;
  end;
  if not CanClose then
    RGRatingByAuthor.SetFocus;
end;

end.
