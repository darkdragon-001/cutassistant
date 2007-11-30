unit UClist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, UCutlist, JvGIF, Buttons;

type
  TfrmClist = class(TForm)
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
    procedure BReplaceCutClick(Sender: TObject);
    procedure BEditCutClick(Sender: TObject);
    procedure BDeleteCutClick(Sender: TObject);
    procedure BClearCutlistClick(Sender: TObject);
    procedure BConvertClick(Sender: TObject);
    procedure BCutlistInfoClick(Sender: TObject);
    procedure RCutModeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure enable_del_buttons(value: boolean);
  end;

var
  frmClist: TfrmClist;

implementation

uses Main;

{$R *.dfm}

procedure TfrmClist.BReplaceCutClick(Sender: TObject);
var
  dcut: integer;
begin
  if frmClist.Lcutlist.SelCount = 0 then begin
//    self.enable_del_buttons(false);
    exit;
  end;
  dcut := strtoint(frmClist.Lcutlist.Selected.caption);
  cutlist.ReplaceCut(pos_from, pos_to, dCut);
end;

procedure TfrmClist.BEditCutClick(Sender: TObject);
var
  dcut: integer;
begin
  if frmClist.Lcutlist.SelCount = 0 then begin
 //   self.enable_del_buttons(false);
    exit;
  end;
  dcut := strtoint(frmClist.Lcutlist.Selected.caption);
  pos_from := cutlist[dcut].pos_from;
  pos_to := cutlist[dcut].pos_to;
  Fmain.refresh_times;
end;
procedure TfrmClist.BDeleteCutClick(Sender: TObject);
begin
  if frmClist.Lcutlist.SelCount = 0 then begin
 //   self.enable_del_buttons(false);
    exit;
  end;
  cutlist.DeleteCut(strtoint(frmClist.Lcutlist.Selected.caption));
end;

procedure TfrmClist.BClearCutlistClick(Sender: TObject);
begin
 frmClist.Lcutlist.Clear;



end;

procedure TfrmClist.enable_del_buttons(value: boolean);
begin
  self.bDeleteCut.enabled := value;
  self.bEditCut.Enabled := value;
  self.bReplaceCut.Enabled := value;
  self.BClearCutlist.Enabled := value;


end;



procedure TfrmClist.BConvertClick(Sender: TObject);
var
  newCutlist: TCutlist;
begin
  if cutlist.Count = 0 then exit;
  newCutlist := cutlist.convert;
  newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
  FreeAndNIL(cutlist);
  cutlist := newCutlist;
  cutlist.RefreshGUI;
end;
procedure TfrmClist.BCutlistInfoClick(Sender: TObject);
begin
  cutlist.EditInfo;
end;
procedure TfrmClist.RCutModeClick(Sender: TObject);
begin


   Fmain.setCutlistMode( self.RCutMode.ItemIndex );
  //case self.RCutMode.ItemIndex of

   /// 0: Fmain.cutlist.Mode := clmCutOut;
   // 1: Fmain.cutlist.Mode := clmCrop;
//  end;
end;
end.

