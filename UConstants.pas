unit UConstants;

interface

type
  TConstants = class
    public
      function GetDirectory():string;
  end;

var
  Constant:Tconstants;

const
  AddIni = '\IniFiles\Add.ini';
  RAllIni = '\IniFiles\RequestAll.ini';
  RDateIni = '\IniFiles\RequestDate.ini';
  RNumberIni = '\IniFiles\RequestNumber.ini';
  RStatusIni = '\IniFiles\RequestStatus.ini';
  RTypeIni = '\IniFiles\RequestType.ini';
  FontName='Times New Roman';
  FontSize=11;

implementation

{ TConstants }

function TConstants.GetDirectory: string;
var sPath:string;
begin
  GetDir(0,sPath);
  result:=sPath;
end;

end.
