UNIT CutlistSearchResults;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

TYPE
  TFCutlistSearchResults = CLASS(TForm)
    Panel1: TPanel;
    LLinklist: TListView;
    BCancel: TButton;
    PROCEDURE LLinklistClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
    LinkList: ARRAY OF ARRAY[0..1] OF STRING;
    PROCEDURE GenerateLinks;
  END;

VAR
  FCutlistSearchResults            : TFCutlistSearchResults;

IMPLEMENTATION

{$R *.dfm}

{ TFCutlistSearchResults }

PROCEDURE TFCutlistSearchResults.GenerateLinks;
VAR
  iLink                            : Integer;
  ALink                            : TListItem;
BEGIN
  self.LLinklist.Clear;
  FOR iLInk := 0 TO length(self.LinkList) - 1 DO BEGIN
    ALink := self.LLinklist.Items.Add;
    ALink.Caption := inttostr(iLink);
    ALink.SubItems.Add(self.LinkLIst[iLInk, 0]);
  END;
END;


PROCEDURE TFCutlistSearchResults.LLinklistClick(Sender: TObject);
BEGIN
  IF self.LLinklist.ItemIndex < 0 THEN exit;
  self.ModalResult := mrOK;
END;

END.
