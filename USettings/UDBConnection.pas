unit UDBConnection;

interface

uses Data.Win.ADODB, UVarServer;

type
  TDBConnection = class
  private
    ADOConnection:TADOConnection;
    /// <link>aggregation</link>
  public
    function GetDBConnect(NameServer:TNameServer):String;
    function GetADOConnection: TADOConnection;
    constructor create(NameServer:TNameServer);
  end;

implementation

{ TDBconnection }

uses UMain;

constructor TDBConnection.create(NameServer:TNameServer);
begin
  if not Assigned(ADOConnection) then
    ADOConnection := TADOConnection.create(nil);
  ADOConnection.ConnectionString :=GetDBConnect(NameServer);
  ADOConnection.LoginPrompt := false;
  ADOConnection.Connected := true;
end;

function TDBConnection.GetADOConnection: TADOConnection;
begin
  result := ADOConnection;
end;

function TDBConnection.GetDBConnect(NameServer:TNameServer): String;
begin
  result:='Provider=SQLOLEDB;Password='+NameServer.GetPassword+
  ';Persist Security Info=True;User ID='+NameServer.GetNameUser+
  ';Initial Catalog='+'model'+';Data Source='+NameServer.GetNameServer;
end;

end.
