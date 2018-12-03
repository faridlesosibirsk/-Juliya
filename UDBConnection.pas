unit UDBConnection;

interface

uses Data.DB, Data.Win.ADODB;

type
  TDBConnection = class
  private
    ADOConnection:TADOConnection;
  public
    function GetDBConnect:String;
    function GetADOConnection: TADOConnection;
    constructor create;
  end;

implementation

{ TDBconnection }

uses UVarServer,UMain;

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
  {'Provider=MSDASQL.1;Password=2307;
  Persist Security Info=True;
  User ID=root;
  Extended Properties="DRIVER={MySQL ODBC 5.3 Unicode Driver}{;
  UID=root;PWD=2307;
  SERVER=localhost;
  DATABASE=store;
  PORT=3306;
  COLUMN_SIZE_S32=1;";
  Initial Catalog=store'}
  result:='Provider=SQLOLEDB;Password='+NameServer.GetPassword+
  ';Persist Security Info=True;User ID='+NameServer.GetNameUser+
  ';Initial Catalog='+'model'+';Data Source='+NameServer.GetNameServer;
end;

end.
