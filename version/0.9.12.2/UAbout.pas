UNIT UAbout;

INTERFACE

USES Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, JvGIF, JvPoweredBy, JvExControls, JvLinkLabel;

TYPE
  TAboutBox = CLASS(TForm)
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
    PROCEDURE FormCreate(Sender: TObject);
  PRIVATE
    { Private-Deklarationen }
  PUBLIC
    { Public-Deklarationen }
  END;

VAR
  AboutBox                         : TAboutBox;

IMPLEMENTATION

USES Utils;

{$R *.dfm}

PROCEDURE TAboutBox.FormCreate(Sender: TObject);
BEGIN
  Version.Caption := 'Version ' + Get_File_Version(Application.ExeName);
END;

END.
