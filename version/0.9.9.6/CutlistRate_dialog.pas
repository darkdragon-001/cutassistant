unit CutlistRate_dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFCutlistRate = class(TForm)
    Label1: TLabel;
    RGRatingByAuthor: TRadioGroup;
    Button1: TButton;
    ButtonOK: TButton;
    procedure RGRatingByAuthorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCutlistRate: TFCutlistRate;

implementation

{$R *.dfm}



procedure TFCutlistRate.RGRatingByAuthorClick(Sender: TObject);
begin
  if self.RGRatingByAuthor.ItemIndex >= 0 then self.ButtonOK.Enabled := true;
end;

end.
