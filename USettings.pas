unit USettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,UDBConnection,
  Data.Win.ADODB,FileCtrl;

type
  TFSettings = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    ADOConnection1: TADOConnection;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ReadConfig;
    procedure SaveConfig;
    procedure CreateSqript;
    procedure RequestCreateTables;
    procedure FormCreate(Sender: TObject);
    procedure Test1;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSettings:TFSettings;
  path,NameServer,NameUser,DataBase,password:string;

implementation

{$R *.dfm}

uses UMain;

procedure TFSettings.FormCreate(Sender: TObject);
begin
  ReadConfig;
  BitBtn1.glyph.LoadFromFile(getcurrentdir()+'\Folder.bmp');
end;

procedure TFSettings.BitBtn1Click(Sender: TObject);
var
  chosenDirectory:string;
begin
  //ВОЗМОЖНАЯ ОШИБКА - ЭТОЙ ПАПКИ НЕ СУЩЕСТВУЕТ
  chosenDirectory:='C:\';
  if SelectDirectory('','\',chosenDirectory) then
    if chosenDirectory[length(chosenDirectory)]<>'\'
      then path:=chosenDirectory+'\'
      else path:=chosenDirectory;
  Edit1.Text:=path;
end;

procedure TFSettings.Button1Click(Sender: TObject);
begin
  FMain.Panel1.Caption:=' Используется сервер: '+NameServer+', база данных: '+DataBase;
  Test1;
end;

procedure TFSettings.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked=True
    then Edit4.PasswordChar:=#0
    else Edit4.PasswordChar:=#42;
end;

procedure TFSettings.Edit1Change(Sender: TObject);
begin
  path:=Edit1.Text;
end;

procedure TFSettings.ReadConfig;
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
      Edit1.text:=text;
      path:=text;
    end;
    if pos('[Данные о сервере]',text)<>0 then
    begin
      readln(myFile,text);
      k:=pos(' ',text);
      NameServer:=copy(text,k+1,length(text)-k); //DataSource
      Edit2.text:=NameServer;
      readln(myFile,text);
      k:=pos(' ',text);
      NameUser:=copy(text,k+1,length(text)-k);    //UserID
      Edit3.text:=NameUser;
      readln(myFile,text);
      k:=pos(' ',text);
      DataBase:=copy(text,k+1,length(text)-k);
      Edit5.text:=DataBase;
    end;
  end;
  closefile(myFile);
end;

procedure TFSettings.SaveConfig;
var
  myFile:TextFile;
  k:integer;
  text:string;
begin
  Memo1.Clear;
  AssignFile(myFile,GetCurrentDir()+'\config.ini');
  Reset(myFile);
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    Memo1.Lines.Add(text);
    if pos('[Путь к папке Trace]',text)<>0 then
    begin
      readln(myFile,text);
      Memo1.Lines.Add(path);
    end;
    if pos('[Данные о сервере]',text)<>0 then
    begin
      readln(myFile,text);
      k:=pos(' ',text);
      delete(text,k+1,(length(text)-k));
      insert(edit2.Text,text,k+1);Memo1.Lines.Add(text);
      NameServer:=Edit2.text;
      readln(myFile,text);
      k:=pos(' ',text);
      delete(text,k+1,(length(text)-k));
      insert(edit3.Text,text,k+1);Memo1.Lines.Add(text);
      NameUser:=Edit3.text;
      password:=Edit4.text;
      readln(myFile,text);
      k:=pos(' ',text);
      delete(text,k+1,(length(text)-k));
      insert(edit5.Text,text,k+1);Memo1.Lines.Add(text);
      DataBase:=Edit5.text;
    end;
  end;
  closefile(myFile);
  Memo1.Lines.SaveToFile(GetCurrentDir()+'\config.ini');
end;

procedure TFSettings.CreateSqript;
var
  myFile:TextFile;
  startword,endword,lengthword:integer;
  text:string;
begin
  ///// ОБРАБАТЫВАЕМ СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ /////
  AssignFile(myFile,GetCurrentDir()+'\Calls.sql');
  Reset(myFile);
  Memo1.Clear;
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    if pos('[',text)<>0 then
    begin
      startword:=pos('[',text)+1;
      endword:=pos(']',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(DataBase,text,startword);
    end;
    if pos('.mdf',text)<>0 then
    begin
      startword:=pos('= N',text)+4;
      endword:=pos(', ',text)-1;
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(DataBase,text,startword);
      startword:=pos('MSSQL\DATA\',text)+11;
      endword:=pos('.mdf',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(DataBase,text,startword);
    end;
    if pos('_log.ldf',text)<>0 then
    begin
      startword:=pos('= N',text)+4;
      endword:=pos('_log',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(DataBase,text,startword);
      startword:=pos('MSSQL\DATA\',text)+11;
      endword:=pos('_log.ldf',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(DataBase,text,startword);
    end;
    Memo1.Lines.Add(text);
  end;
  closefile(myFile);
  Memo1.Lines.SaveToFile(GetCurrentDir()+'\Calls.sql');
      ///// ОБРАБАТЫВАЕМ СКРИПТ СОЗДАНИЯ ТАБЛИЦ /////
  AssignFile(myFile,GetCurrentDir()+'\Table.sql');
  Reset(myFile);
  Memo1.Clear;
  while (not Eof(myFile)) do
  begin
    readln(myFile,text);
    if pos('USE',text)<>0 then
    begin
      startword:=pos('[',text)+1;
      endword:=pos(']',text);
      lengthword:=endword-startword;
      delete(text,startword,lengthword);
      insert(DataBase,text,startword);
    end;
    Memo1.Lines.Add(text);
  end;
  closefile(myFile);
  Memo1.Lines.SaveToFile(GetCurrentDir()+'\Table.sql');
  Memo1.Clear;
end;

procedure TFSettings.RequestCreateTables;
var
  myFile:TextFile;
  text:string;
begin
  ///// СОЗДАНИЕ БАЗЫ ДАННЫХ, ТАБЛИЦ В SQL /////
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

procedure TFSettings.Test1;
var
  ButtonSelected1,ButtonSelected2:integer;
  flag,equal:boolean;
  i:integer;
  //Connection: TConnection;
begin
  if length(path)<>0 then if path[length(path)]<>'\' then path:=path+'\';
  if length(path)<>0 then edit1.Text:=path;
  if length(edit1.Text)=0 then Application.MessageBox('Укажите путь к папке Trace.','Пустое поле')
  else if edit2.Text='' then Application.MessageBox('Укажите имя сервера.','Пустое поле')
  else if edit3.Text='' then Application.MessageBox('Укажите имя пользователя.','Пустое поле')
  else if edit5.Text='' then Application.MessageBox('Укажите имя базы данных.','Пустое поле');
  if (edit1.Text<>'')and(edit2.Text<>'')and(edit3.Text<>'')and(edit5.Text<>'') then
  begin
    SaveConfig;
    FMain.FileListBox1.Mask:=path+'*.trc';                                           //Fmain
    CreateSqript;
    ///// ПРОВЕРКА СОЕДИНЕНИЯ С СЕРВЕРОМ /////
    {Connection := TConnection.create;
    ADOConnection1:=Connection.GetADOConnection; }
    try
      ADOConnection1.ConnectionString:=GetDBConnect;
    except
      on e:exception do
      if e.Message='Операция не допускается, если объект открыт' then
      begin
        ADOConnection1.Close;
        ADOConnection1.ConnectionString:=GetDBConnect;
      end;
    end;
    ///поиск названий всех Баз данных
    flag:=true;
    FMain.adoQuery1.active:=false;
    FMain.adoQuery1.SQL.Clear;
    FMain.adoQuery1.SQL.Add('SELECT name FROM [master].[dbo].[sysdatabases]');
    try
      FMain.adoQuery1.ExecSQL;
    except
      on e:exception do
      if e.Message='[DBNETLIB][ConnectionOpen (Connect()).]SQL Server не существует, или доступ запрещен'
      then begin
        flag:=false;
        Application.MessageBox('SQL Server не существует, или доступ запрещен.','Ошибка');
      end
      else if pos('Ошибка входа пользователя',e.message)<>0 then begin
        flag:=false;
        Application.MessageBox('Имя пользователя или пароль введены неверно.','Ошибка входа пользователя');
      end
    end;
  end;
  if flag=true then
  begin
    ///// СУЩЕСТВУЮЩИЕ БАЗЫ ДАННЫХ /////
    Memo1.Clear;
    FMain.DBGrid1.DataSource.DataSet.Open;
    FMain.ADOQuery1.First;
    for i:=0 to FMain.ADOQuery1.RecordCount-1 do
    begin
      Memo1.Lines.Add(FMain.ADOQuery1.Fields[0].Value);
      FMain.ADOQuery1.Next;
    end;
    Memo1.Lines.Add(FMain.ADOQuery1.Fields[0].Value);
    ///// ПОИСК ВВЕДЕННОЙ БАЗЫ ДАННЫХ в списке существующих/////
    equal:=false;
    for i:=0 to FMain.ADOQuery1.RecordCount-1 do
      if Memo1.Lines[i]=DataBase then equal:=true;
    Memo1.Clear;
    FMain.ADOQuery1.Close;//очищаем таблицу от записей
    if equal=true then
    begin
      ButtonSelected1:=MessageDlg('База данных с именем '+DataBase+
      ' уже существует. Продолжить с ней работу?',mtCustom,[mbYes,mbNo],0);
      if ButtonSelected1=mrYes then close;
    end
    else
      ButtonSelected2:=MessageDlg('Создать базу данных '+DataBase+
      ' и таблицы AddFiles, Call_records?',mtCustom,[mbYes,mbNo],0);
    if ButtonSelected2=mrYes then
    begin
      RequestCreateTables;
      Application.MessageBox('База данных создана.','Информация');
      close;
    end;
  end;
end;
end.
