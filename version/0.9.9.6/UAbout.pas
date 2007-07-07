unit UAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, JvGIF, JvPoweredBy, JvExControls, JvLinkLabel;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    JvPoweredByJCL1: TJvPoweredByJCL;
    JvPoweredByJVCL1: TJvPoweredByJVCL;
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  AboutBox: TAboutBox;

implementation

uses Utils;

{$R *.dfm}

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  Version.Caption := 'Version ' + Get_File_Version(Application.ExeName);
end;

end.
 
