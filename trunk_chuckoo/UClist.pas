UNIT UClist;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, UCutlist, JvGIF, Buttons;

TYPE
  TfrmClist = CLASS(TForm)
    Lcutlist: TListView;
    PAuthor: TPanel;
    LAuthor: TLabel;
    Panel4: TPanel;
    LResultingDuration: TLabel;
    LTotalCutoff: TLabel;
    lblCutApplication: TLabel;
    lblMovieType: TLabel;
    lblMovieFPS: TLabel;
    BReplaceCut: TButton;
    BEditCut: TButton;
    BDeleteCut: TButton;
    BClearCutlist: TButton;
    BConvert: TButton;
    ICutlistWarning: TImage;
    BCutlistInfo: TBitBtn;
    RCutMode: TRadioGroup;
    PROCEDURE BReplaceCutClick(Sender: TObject);
    PROCEDURE BEditCutClick(Sender: TObject);
    PROCEDURE BDeleteCutClick(Sender: TObject);
    PROCEDURE BClearCutlistClick(Sender: TObject);
    PROCEDURE BConvertClick(Sender: TObject);
    PROCEDURE BCutlistInfoClick(Sender: TObject);
    PROCEDURE RCutModeClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
    PROCEDURE enable_del_buttons(value: boolean);
  END;

VAR
  frmClist                         : TfrmClist;

IMPLEMENTATION

USES Main;

{$R *.dfm}

PROCEDURE TfrmClist.BReplaceCutClick(Sender: TObject);
VAR
  dcut                             : integer;
BEGIN
  IF frmClist.Lcutlist.SelCount = 0 THEN BEGIN
    //    self.enable_del_buttons(false);
    exit;
  END;
  dcut := strtoint(frmClist.Lcutlist.Selected.caption);
  cutlist.ReplaceCut(pos_from, pos_to, dCut);
END;

PROCEDURE TfrmClist.BEditCutClick(Sender: TObject);
VAR
  dcut                             : integer;
BEGIN
  IF frmClist.Lcutlist.SelCount = 0 THEN BEGIN
    //   self.enable_del_buttons(false);
    exit;
  END;
  dcut := strtoint(frmClist.Lcutlist.Selected.caption);
  pos_from := cutlist[dcut].pos_from;
  pos_to := cutlist[dcut].pos_to;
  Fmain.refresh_times;
END;

PROCEDURE TfrmClist.BDeleteCutClick(Sender: TObject);
BEGIN
  IF frmClist.Lcutlist.SelCount = 0 THEN BEGIN
    //   self.enable_del_buttons(false);
    exit;
  END;
  cutlist.DeleteCut(strtoint(frmClist.Lcutlist.Selected.caption));
END;

PROCEDURE TfrmClist.BClearCutlistClick(Sender: TObject);

BEGIN
  frmClist.Lcutlist.Clear;
  cutlist.init;


END;

PROCEDURE TfrmClist.enable_del_buttons(value: boolean);
BEGIN
  self.bDeleteCut.enabled := value;
  self.bEditCut.Enabled := value;
  self.bReplaceCut.Enabled := value;
  self.BClearCutlist.Enabled := value;


END;



PROCEDURE TfrmClist.BConvertClick(Sender: TObject);
VAR
  newCutlist                       : TCutlist;
BEGIN
  IF cutlist.Count = 0 THEN exit;
  newCutlist := cutlist.convert;
  newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
  FreeAndNIL(cutlist);
  cutlist := newCutlist;
  cutlist.RefreshGUI;
END;

PROCEDURE TfrmClist.BCutlistInfoClick(Sender: TObject);
BEGIN
  cutlist.EditInfo;
END;

PROCEDURE TfrmClist.RCutModeClick(Sender: TObject);
BEGIN


  Fmain.setCutlistMode(self.RCutMode.ItemIndex);
  //case self.RCutMode.ItemIndex of

   /// 0: Fmain.cutlist.Mode := clmCutOut;
   // 1: Fmain.cutlist.Mode := clmCrop;
//  end;
END;
END.
