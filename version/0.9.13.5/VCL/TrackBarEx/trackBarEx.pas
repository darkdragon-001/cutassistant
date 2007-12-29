unit trackBarEx;

interface

uses
  SysUtils, Classes, Controls, ComCtrls;

type
  TtrackBarEx = class(TTrackBar)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property OnMOuseUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Win32', [TtrackBarEx]);
end;

end.
