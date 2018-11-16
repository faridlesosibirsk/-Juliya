unit UDBConnection;

interface

function GetDBConnect:String;

implementation

{ TDBconnection }

uses USettings;

function GetDBConnect: String;
begin
  result:='Provider=SQLOLEDB;Password='+password+';Persist Security Info=True;User ID='+NameUser+
      ';Initial Catalog='+'model'+';Data Source='+NameServer;
  //';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;'+
  //'Workstation ID='+ReadComputerName;//+
  //';Use Encryption for Data=False;Tag with column collation when possible=False';
end;

end.
