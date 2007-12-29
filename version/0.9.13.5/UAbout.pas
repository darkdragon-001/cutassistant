unit UAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, JvGIF, JvPoweredBy, JvExControls, JvLinkLabel;

type
  TAboutBox = class(TForm)
    pnlAbout: TPanel;
    iProgram_nl: TImage;
    lblProductName_nl: TLabel;
    lblVersion_nl: TLabel;
    lblAuthors: TLabel;
    cmdOk: TButton;
    JvPoweredByJCL_nl: TJvPoweredByJCL;
    JvPoweredByJVCL_nl: TJvPoweredByJVCL;
    iIndy_nl: TImage;
    lblDSPack_nl: TLabel;
    lblCopyright_nl: TLabel;
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
  lblVersion_nl.Caption := 'Version ' + Get_File_Version(Application.ExeName);
end;

end.
 
