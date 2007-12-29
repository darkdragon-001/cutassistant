unit CutlistSearchResults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TFCutlistSearchResults = class(TForm)
    pnlButtons: TPanel;
    lvLinklist: TListView;
    cmdCancel: TButton;
    cmdOk: TButton;
    procedure lvLinklistClick(Sender: TObject);
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
  self.lvLinklist.Clear;
  for iLInk := 0 to length(self.LinkList)-1 do begin
      ALink := self.lvLinklist.Items.Add;
      ALink.Caption := inttostr(iLink);
      ALink.SubItems.Add(self.LinkList[iLInk, 0]);
  end;
end;


procedure TFCutlistSearchResults.lvLinklistClick(Sender: TObject);
begin
  if self.lvLinklist.ItemIndex < 0 then exit;
  self.ModalResult := mrOK;
end;

procedure TFCutlistSearchResults.cmdOkClick(Sender: TObject);
begin
  if lvLinklist.ItemIndex >= 0 then
    ModalResult := mrOk;
end;

end.
