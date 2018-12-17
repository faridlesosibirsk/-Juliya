unit UDBConnection;

interface

uses Data.Win.ADODB, UVarServer;

type
  TDBConnection = class
  private
    ADOConnection:TADOConnection;
    NameServer:TNameServer;
  public
    function GetDBConnect:String;
    function GetADOConnection: TADOConnection;
    constructor create;
  end;

implementation

{ TDBconnection }

uses UMain;

constructor TDBConnection.create;
begin
  if not Assigned(ADOConnection) then
    ADOConnection := TADOConnection.create(nil);
  ADOConnection.ConnectionString :=GetDBConnect;
  ADOConnection.LoginPrompt := false;
  ADOConnection.Connected := true;
end;

function TDBConnection.GetADOConnection: TADOConnection;
begin
  result := ADOConnection;
end;

function TDBConnection.GetDBConnect: String;
begin
  NameServer:=TNameServer.GetInstance;
  result:='Provider=SQLOLEDB;Password='+NameServer.GetPassword+
  ';Persist Security Info=True;User ID='+NameServer.GetNameUser+
  ';Initial Catalog='+'model'+';Data Source='+NameServer.GetNameServer;
end;

end.
