unit UDBConnection;

interface

function GetDBConnect:String;

implementation

{ TDBconnection }

uses UVarServer,UMain;

function GetDBConnect: String;
begin
  result:='Provider=SQLOLEDB;Password='+NameServer.GetPassword+';Persist Security Info=True;User ID='
      +NameServer.GetNameUser+';Initial Catalog='+'model'+';Data Source='+NameServer.GetNameServer;
  //';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;'+
  //'Workstation ID='+ReadComputerName;//+
  //';Use Encryption for Data=False;Tag with column collation when possible=False';
end;

end.
