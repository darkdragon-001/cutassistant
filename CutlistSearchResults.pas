unit CutlistSearchResults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TFCutlistSearchResults = class(TForm)
    pnlButtons: TPanel;
    LLinklist: TListView;
    cmdCancel: TButton;
    cmdOk: TButton;
    procedure LLinklistClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LinkList: array of array [0..1] of string;
    procedure GenerateLinks;
  end;

var
  FCutlistSearchResults: TFCutlistSearchResults;

implementation

{$R *.dfm}

{ TFCutlistSearchResults }

procedure TFCutlistSearchResults.GenerateLinks;
var
  iLink: Integer;
  ALink: TListItem;
begin
  self.LLinklist.Clear;
  for iLInk := 0 to length(self.LinkList)-1 do begin
      ALink := self.LLinklist.Items.Add;
      ALink.Caption := inttostr(iLink);
      ALink.SubItems.Add(self.LinkLIst[iLInk, 0]);
  end;
end;


procedure TFCutlistSearchResults.LLinklistClick(Sender: TObject);
begin
  if self.LLinklist.ItemIndex < 0 then exit;
  self.ModalResult := mrOK;
end;

procedure TFCutlistSearchResults.cmdOkClick(Sender: TObject);
begin
  if LLinklist.ItemIndex >= 0 then
    ModalResult := mrOk;
end;

end.
