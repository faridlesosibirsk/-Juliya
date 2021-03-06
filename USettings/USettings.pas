unit USettings;

interface

uses
  System.Classes, SysUtils, Controls, Forms, Dialogs, StdCtrls, Buttons, FileCtrl,
  UDBConnection, UVarServer, UScript, UConstructor, UAddCreate, UFile;

type
  TFSettings = class(TForm)
    Edit1, Edit2, Edit3,
    Edit4, Edit5: TEdit;
    Label1, Label2, Label3,
    Label4, Label5, Label6: TLabel;
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
    /// <link>aggregation</link>
    NameServer: TNameServer;
    /// <link>aggregation</link>
    Script: TScript;
    /// <link>aggregation</link>
    AddCreate: TAddCreate;
    /// <link>aggregation</link>
    Connection: TDBConnection;
    { Private declarations }
  public
    { Public declarations }
  end;

var FSettings:TFSettings;

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
  NameServer:=TNameServer.GetInstance;
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
  if length(edit1.Text)=0 then Application.MessageBox('������� ���� � ����� Trace.','������ ����')
  else if edit2.Text='' then Application.MessageBox('������� ��� �������.','������ ����')
  else if edit3.Text='' then Application.MessageBox('������� ��� ������������.','������ ����')
  else if edit5.Text='' then Application.MessageBox('������� ��� ���� ������.','������ ����');
  if (edit1.Text<>'')and(edit2.Text<>'')and(edit3.Text<>'')and(edit5.Text<>'') then
  begin
    NameServer.SaveConfig(edit2.Text,edit3.Text,edit4.Text,edit5.Text,edit1.text);
    AddCreate.SetFileListBox(NameServer.Getpath+'*.trc');
    if SelectMenu=1 then AddCreate.SortFileListBox(AddCreate.GetFileListBox);
    Script.ScriptCreateDB(NameServer);
    Script.ScriptCreateTb(NameServer);
    flag:=true;
    ///// connecting to DataBase
    try
      Connection:= TDBConnection.create(NameServer);
      FMain.ADOQuery1.Connection:= Connection.GetADOConnection;
      FConstructor.ADOQuery1.Connection:= Connection.GetADOConnection;
      ///search all names DataBases
      FMain.adoQuery1.active:=false;
      FMain.adoQuery1.SQL.Clear;
      FMain.adoQuery1.SQL.Add('SELECT name FROM [master].[dbo].[sysdatabases]');
      FMain.adoQuery1.ExecSQL;
    except
      on e:exception do
      if pos('[DBNETLIB][ConnectionOpen (Connect()).]SQL Server �� ����������',e.message)<>0
      then begin
        flag:=false;
        Application.MessageBox('SQL Server �� ����������, ��� ������ ��������.','������');
      end
      else if pos('������ ����� ������������',e.message)<>0 then begin
        flag:=false;
        Application.MessageBox('��� ������������ ��� ������ ������� �������.','������ ����� ������������');
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
      ButtonSelected1:=MessageDlg('���� ������ � ������ '+NameServer.GetDataBase+
      ' ��� ����������. ���������� � ��� ������?',mtCustom,[mbYes,mbNo],0);
      if ButtonSelected1=mrYes then close;
    end
    else
      ButtonSelected2:=MessageDlg('������� ���� ������ '+NameServer.GetDataBase+
      ' � ������� AddFiles, Call_records?',mtCustom,[mbYes,mbNo],0);
    if ButtonSelected2=mrYes then
    begin
      Script.RequestCreate;
      Application.MessageBox('���� ������ �������.','����������');
      close;
    end;
  end;
end;

end.
