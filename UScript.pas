unit UScript;

interface

uses
  SysUtils, Variants, Controls, Forms, StdCtrls, Buttons, UVarServer;

type
  TScript = class
  private
  public
    procedure ScriptCreateDB;
    procedure ScriptCreateTb;
    procedure RequestCreate;
  end;

implementation

uses UMain;

{ TScript }

procedure TScript.RequestCreate;
var
  myFile:TextFile;
  text:string;
begin
  ///// Create DataBase, Tables in SQL Server/////
  AssignFile(myFile,GetCurrentDir()+'\Calls.sql');
  Reset(myFile);
  try
    FMain.adoQuery1.active:=false;
    FMain.adoQuery1.SQL.Clear;
    while (not Eof(myFile)) do
    begin
      readln(myFile,text);
      FMain.adoQuery1.SQL.Add(text);
    end;
    FMain.adoQuery1.ExecSQL;
  finally
    closefile(myFile);
  end;
  AssignFile(myFile,GetCurrentDir()+'\Table.sql');
  Reset(myFile);
  try
    FMain.adoQuery1.active:=false;
    FMain.adoQuery1.SQL.Clear;
    while (not Eof(myFile)) do
    begin
      readln(myFile,text);
      FMain.adoQuery1.SQL.Add(text);
    end;
    FMain.adoQuery1.ExecSQL;
  finally
    closefile(myFile);
  end;
end;

procedure TScript.ScriptCreateDB;
var
  myFile:TextFile;
  startword,endword,lengthword:integer;
  text:string;
begin
  ///// Update Script create DataBase /////
  AssignFile(myFile,GetCurrentDir()+'\Calls.sql');
  Reset(myFile);
  FMain.Memo1.Clear;
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    if pos('[',text)<>0 then
    begin
      startword:=pos('[',text)+1;
      endword:=pos(']',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(NameServer.GetDataBase,text,startword);
    end;
    if pos('.mdf',text)<>0 then
    begin
      startword:=pos('= N',text)+4;
      endword:=pos(', ',text)-1;
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(NameServer.GetDataBase,text,startword);
      startword:=pos('MSSQL\DATA\',text)+11;
      endword:=pos('.mdf',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(NameServer.GetDataBase,text,startword);
    end;
    if pos('_log.ldf',text)<>0 then
    begin
      startword:=pos('= N',text)+4;
      endword:=pos('_log',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(NameServer.GetDataBase,text,startword);
      startword:=pos('MSSQL\DATA\',text)+11;
      endword:=pos('_log.ldf',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(NameServer.GetDataBase,text,startword);
    end;
    FMain.Memo1.Lines.Add(text);
  end;
  closefile(myFile);
  FMain.Memo1.Lines.SaveToFile(GetCurrentDir()+'\Calls.sql');
end;

procedure TScript.ScriptCreateTb;
var
  myFile:TextFile;
  startword,endword,lengthword:integer;
  text:string;
begin
  ///// Update Script create table /////
  AssignFile(myFile,GetCurrentDir()+'\Table.sql');
  Reset(myFile);
  FMain.Memo1.Clear;
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    if pos('USE',text)<>0 then
    begin
      startword:=pos('[',text)+1;
      endword:=pos(']',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(NameServer.GetDataBase,text,startword);
    end;
    FMain.Memo1.Lines.Add(text);
  end;
  closefile(myFile);
  FMain.Memo1.Lines.SaveToFile(GetCurrentDir()+'\Table.sql');
  FMain.Memo1.Clear;
end;

end.
