unit USettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,UDBConnection,
  Data.Win.ADODB,FileCtrl,UVarServer,UScript,UConstructor;

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
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Test1;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSettings:TFSettings;
  Script:TScript;
  Connection: TDBConnection;

implementation

{$R *.dfm}

uses UMain;

procedure TFSettings.FormActivate(Sender: TObject);
begin
  NameServer.ReadConfig;
  Edit1.Text:=NameServer.Getpath;
  Edit2.Text:=NameServer.GetNameServer;
  Edit3.Text:=NameServer.GetNameUser;
  Edit5.Text:=NameServer.GetDataBase;
end;

procedure TFSettings.FormCreate(Sender: TObject);
begin
  BitBtn1.glyph.LoadFromFile(getcurrentdir()+'\Folder.bmp');
end;

procedure TFSettings.BitBtn1Click(Sender: TObject);
var
  chosenDirectory:string;
begin
  //POSSIBLE ERROR - THIS FOLDER DOES NOT EXIST
  chosenDirectory:='C:\';
  if SelectDirectory('','\',chosenDirectory) then
    if chosenDirectory[length(chosenDirectory)]<>'\'
      then NameServer.SetPath(chosenDirectory+'\')
      else NameServer.SetPath(chosenDirectory);
  Edit1.Text:=NameServer.GetPath;
end;

procedure TFSettings.Button1Click(Sender: TObject);
begin
  FMain.Panel1.Caption:=NameServer.GetName;
  Test1;
end;

procedure TFSettings.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked=True
    then Edit4.PasswordChar:=#0
    else Edit4.PasswordChar:=#42;
end;

procedure TFSettings.Test1;
var
  ButtonSelected1,ButtonSelected2:integer;
  flag,equal:boolean;
  i:integer;
begin
  if length(edit1.Text)=0 then Application.MessageBox('Укажите путь к папке Trace.','Пустое поле')
  else if edit2.Text='' then Application.MessageBox('Укажите имя сервера.','Пустое поле')
  else if edit3.Text='' then Application.MessageBox('Укажите имя пользователя.','Пустое поле')
  else if edit5.Text='' then Application.MessageBox('Укажите имя базы данных.','Пустое поле');
  if (edit1.Text<>'')and(edit2.Text<>'')and(edit3.Text<>'')and(edit5.Text<>'') then
  begin
    NameServer.SaveConfig(edit2.Text,edit3.Text,edit4.Text,edit5.Text,edit1.text);
    FMain.FileListBox1.Mask:=NameServer.Getpath+'*.trc';                                           //Fmain
    Script.ScriptCreateDB;
    Script.ScriptCreateTb;
    ///// connecting to DataBase
    Connection:= TDBConnection.create;
    FMain.ADOQuery1.Connection:= Connection.GetADOConnection;
    FConstructor.ADOQuery1.Connection:= Connection.GetADOConnection;
    ///search all names DataBases
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
    ///// existing database names /////
    Memo1.Clear;
    FMain.DBGrid1.DataSource.DataSet.Open;
    FMain.ADOQuery1.First;
    for i:=0 to FMain.ADOQuery1.RecordCount-1 do
    begin
      Memo1.Lines.Add(FMain.ADOQuery1.Fields[0].Value);
      FMain.ADOQuery1.Next;
    end;
    Memo1.Lines.Add(FMain.ADOQuery1.Fields[0].Value);
    /////searching database in existing databases/////
    equal:=false;
    for i:=0 to FMain.ADOQuery1.RecordCount-1 do
      if Memo1.Lines[i]=NameServer.GetDataBase then equal:=true;
    Memo1.Clear;
    FMain.ADOQuery1.Close;//clear table
    if equal=true then
    begin
      ButtonSelected1:=MessageDlg('База данных с именем '+NameServer.GetDataBase+
      ' уже существует. Продолжить с ней работу?',mtCustom,[mbYes,mbNo],0);
      if ButtonSelected1=mrYes then close;
    end
    else
      ButtonSelected2:=MessageDlg('Создать базу данных '+NameServer.GetDataBase+
      ' и таблицы AddFiles, Call_records?',mtCustom,[mbYes,mbNo],0);
    if ButtonSelected2=mrYes then
    begin
      Script.RequestCreate;
      Application.MessageBox('База данных создана.','Информация');
      close;
    end;
  end;
end;

end.
