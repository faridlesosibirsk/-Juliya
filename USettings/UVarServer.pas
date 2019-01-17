unit UVarServer;

interface

uses SysUtils,IniFiles,Forms;

type
  TNameServer = class
  private
    var path, NameServer, NameUser, DataBase, password:string;
    class var
        /// <link>aggregation</link>
        FInstance: TNameServer;
  public
    class function GetInstance: TNameServer;
    class destructor DestroyClass;
    function GetName:string;
    function GetNameUser:string;
    function GetDataBase:string;
    function Getpassword:string;
    function GetNameServer:string;
    function GetPath:string;
    function SetPath(PT:string):string;
    procedure ReadConfig;
    procedure SaveConfig(NS,NU,PW,DB,PT:String);
    procedure Clear;
  end;

implementation



{ TNameServer }

class function TNameServer.GetInstance: TNameServer;
begin
  if not Assigned(FInstance) then
    FInstance := TNameServer.Create;
  Result := FInstance;
end;



class destructor TNameServer.DestroyClass;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

function TNameServer.GetDataBase: string;
begin
  result:=DataBase;
end;

function TNameServer.GetName:string;
begin
  if NameServer=''
  then result:='Необходимо зайти в настройки программы!'
  else result:=' Используется сервер: '+NameServer+', база данных: '+DataBase;
end;

function TNameServer.GetNameServer: string;
begin
  result:=NameServer;
end;

function TNameServer.GetNameUser: string;
begin
  result:=NameUser;
end;

function TNameServer.Getpassword: string;
begin
  result:=password;
end;

function TNameServer.GetPath: string;
begin
  result:=path;
end;

function TNameServer.SetPath(PT: string): string;
begin
  path:=PT;
end;

procedure TNameServer.ReadConfig;
var
  Ini:TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    path:=Ini.ReadString('Server','Path','C');
    NameServer:=Ini.ReadString('Server','NameServer','');
    NameUser:=Ini.ReadString('Server','NameUser','');
    DataBase:=Ini.ReadString('Server','NameDataBase','');
  finally
    Ini.Free;
  end;
end;

procedure TNameServer.SaveConfig(NS, NU, PW, DB,PT: String);
var Ini:TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  if length(PT)<>0 then if path[length(PT)]<>'\' then PT:=PT+'\';
  path:=PT;
  NameServer:=NS;
  NameUser:=NU;
  password:=PW;
  DataBase:=DB;
  try
    Ini.WriteString('Server','Path',PT);
    Ini.WriteString('Server','NameServer',NS);
    Ini.WriteString('Server','NameUser',NU);
    Ini.WriteString('Server','NameDataBase',DB);
  finally
    Ini.Free;
  end;
end;

procedure TNameServer.Clear;
begin

end;

end.
