unit UVarServer;

interface

uses SysUtils;

type
  TNameServer = class
  public
    function GetName:string;
    function GetNameUser:string;
    function GetDataBase:string;
    function Getpassword:string;
    function GetNameServer:string;
    function Getpath:string;
    function SetPath(PT:string):string;
    procedure ReadConfig;
    procedure SaveConfig(NS,NU,PW,DB,PT:String);
  end;

implementation

uses UMain;      //&&&

var path, NameServer, NameUser, DataBase, password:string;

{ TNameServer }

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

function TNameServer.Getpath: string;
begin
  result:=path;
end;

function TNameServer.SetPath(PT: string): string;
begin
  path:=PT;
end;

procedure TNameServer.ReadConfig;
var
  myFile:TextFile;
  k:integer;
  text:string;
begin
  AssignFile(myFile,GetCurrentDir()+'\config.ini');
  Reset(myFile);
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    if pos('[Путь к папке Trace]',text)<>0 then
    begin
      readln(myFile,text);
      path:=text;               //Edit1.text:=text;
    end;
    if pos('[Данные о сервере]',text)<>0 then
    begin
      readln(myFile,text);
      k:=pos(' ',text);
      NameServer:=copy(text,k+1,length(text)-k); //Edit2.text:=NameServer;//DataSource
      readln(myFile,text);
      k:=pos(' ',text);
      NameUser:=copy(text,k+1,length(text)-k);    //Edit3.text:=NameUser;//UserID
      readln(myFile,text);
      k:=pos(' ',text);
      DataBase:=copy(text,k+1,length(text)-k);    //Edit5.text:=DataBase;
    end;
  end;
  closefile(myFile);
end;

procedure TNameServer.SaveConfig(NS, NU, PW, DB,PT: String);
var
  myFile:TextFile;
  k:integer;
  text:string;
begin
  FMain.Memo1.Clear;
  AssignFile(myFile,GetCurrentDir()+'\config.ini');
  Reset(myFile);
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    FMain.Memo1.Lines.Add(text);
    if pos('[Путь к папке Trace]',text)<>0 then
    begin
      readln(myFile,text);
      if length(PT)<>0 then if path[length(PT)]<>'\' then PT:=PT+'\';
      FMain.Memo1.Lines.Add(PT);
      path:=PT;
    end;
    if pos('[Данные о сервере]',text)<>0 then
    begin
      readln(myFile,text);
      k:=pos(' ',text);
      delete(text,k+1,(length(text)-k));
      insert(NS,text,k+1);FMain.Memo1.Lines.Add(text);
      NameServer:=NS;
      readln(myFile,text);
      k:=pos(' ',text);
      delete(text,k+1,(length(text)-k));
      insert(NU,text,k+1);FMain.Memo1.Lines.Add(text);
      NameUser:=NU;
      password:=PW;
      readln(myFile,text);
      k:=pos(' ',text);
      delete(text,k+1,(length(text)-k));
      insert(DB,text,k+1);FMain.Memo1.Lines.Add(text);
      DataBase:=DB;
    end;
  end;
  closefile(myFile);
  FMain.Memo1.Lines.SaveToFile(GetCurrentDir()+'\config.ini');
end;



end.
