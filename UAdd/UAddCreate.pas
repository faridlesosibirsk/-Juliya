unit UAddCreate;

interface

uses
  SysUtils, Variants, Controls, Forms, StdCtrls, FileCtrl, Classes, Winapi.Windows,
  UInterface, UFile, UVarServer,IniFiles, UUpdateBase;

type
  TAddCreate = class(TInterfacedObject, TInterfaceMenuCreate)
  private
    Label1,Label2,Label3:TLabel;
    Label4,Label5,Label6:TLabel;
    Button1:TButton;
  public
    procedure SetFileListBox(mask: string);
    function GetFileListBox:TFileListBox;
    constructor create(AOwner: TForm);
    procedure destroy;
    procedure Button1Click(Sender:TObject);
    procedure FileListBox1KeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FileListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  end;

implementation

{ TAddCreate }

uses UMain;

var FileListBox1:TFileListBox;

constructor TAddCreate.create(AOwner: TForm);
begin
  FMain.Caption:='Добавление';
  FMain.Height:=280;
  FMain.Width:=570;
  FMain.DBGrid1.Align:=alNone;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=143;
  FMain.DBGrid1.Height:=65;
  FMain.DBGrid1.Width:=548;
  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  ObjectsCreate.LabelCreate(AOwner,257,8,'Номер выбранного файла:',Label1);
  ObjectsCreate.LabelCreate(AOwner,257,31,'Количество строк в файле:',Label2);
  ObjectsCreate.LabelCreate(AOwner,257,54,'Дата изменения:',Label3);
  ObjectsCreate.LabelCreate(AOwner,428,8,'_-_-_',Label4);
  ObjectsCreate.LabelCreate(AOwner,428,31,'_-_-_',Label5);
  ObjectsCreate.LabelCreate(AOwner,365,54,'_-_-_-_-_-_-_-_-',Label6);
  ObjectsCreate.ButtonCreate(AOwner,265,91,25,200,'Добавить',Button1);
  Button1.OnClick:=Button1Click;
  FileListBox1:=TFileListBox.Create(AOwner);
  FileListBox1.Height:=125;
  FileListBox1.ItemHeight:=17;
  FileListBox1.Parent:=Aowner;
  FileListBox1.Left:=8;
  FileListBox1.Mask:=NameServer.Getpath+'*.trc';
  FileListBox1.Top:=8;
  FileListBox1.Width:=220;
  FileListBox1.OnKeyDown:=FileListBox1KeyUp;
  FileListBox1.OnKeyUp:=FileListBox1KeyUp;
  FileListBox1.OnMouseDown:=FileListBox1MouseDown;
  FileListBox1.OnMouseUp:=FileListBox1MouseDown;
  File1.SortFileListBox(AddCreate.GetFileListBox);
end;

procedure TAddCreate.destroy;
begin
  FileListBox1.mask:='.';
  Button1.SetFocus;
  FileListBox1.Destroy;
  Label1.Free;
  Label2.Free;
  Label3.Free;
  Label4.Free;
  Label5.Free;
  Label6.Free;
  Button1.Free;
end;

procedure TAddCreate.Button1Click(Sender: TObject);
var i:integer;FileName:string;
begin
  if (FileListBox1.Count<>0)and(FileListBox1.ItemIndex>=0) then
  with FMain.adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    FileName:=FileListBox1.Items[FileListBox1.ItemIndex];
    SQL.Add('SELECT * FROM ['+NameServer.GetDataBase+'].[dbo].[AddFiles]');
    SQL.Add('WHERE FileName='+''''+FileName+'''');
    Active:=True;
    if FMain.DBGrid1.Fields[0].Value=null then
    begin
      active:=false;
      SQL.Clear;
      SQL.Add('Insert Into ['+NameServer.GetDataBase+'].[dbo].[AddFiles] (FileName, DateChange, Lines)');
      SQL.Add('VALUES ('+''''+FileName+''''+', '+''''+
        File1.GetFileDate(NameServer.Getpath+FileName)+''''+
        ', '+''''+IntToStr(File1.TextSize(NameServer.Getpath+FileName))+''''+')');
      ExecSQL;
      i:=1;
      UpDateBase(NameServer.Getpath+FileName,i);
      Application.MessageBox('Файл добавлен в базу данных','Информация')
    end
    else if Fields[3].value<File1.TextSize(NameServer.Getpath+FileName) then
    begin
      i:=Fields[3].value+1;
      UpDateBase(NameServer.Getpath+FileName,i);
      active:=false;
      SQL.Clear;
      SQL.Add('UPDATE ['+NameServer.GetDataBase+'].[dbo].[AddFiles]');
      SQL.Add('SET [Lines] ='+''''+IntToStr(File1.TextSize(NameServer.Getpath+FileName))+'''');
      SQL.Add('WHERE [FileName]='+''''+FileName+'''');
      ExecSQL;
      Application.MessageBox('Новые записи внесены в базу данных','Информация');
    end;
  end
  else if (FileListBox1.Count<>0)and(FileListBox1.ItemIndex<0)
    then Application.MessageBox('Выберите файл из списка','Предупреждение')
    else Application.MessageBox('В выбранной папке отсутствуют файлы .trc','Предупреждение');
end;

procedure TAddCreate.FileListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FileListBox1.Count<>0 then
    if (key=VK_LEFT)or(key=VK_RIGHT)or(key=VK_UP)or(key=VK_DOWN)
    then
    begin
      File1.NumberFile(NameServer.Getpath+FileListBox1.Items[FileListBox1.ItemIndex],FileListBox1,FMain.DBGrid1,FMain.ADOQuery1);
      Label4.Caption:=IntToStr(FileListBox1.ItemIndex+1);
      Label5.Caption:=IntToStr(File1.TextSize(NameServer.Getpath+FileListBox1.Items[FileListBox1.ItemIndex]));
      Label6.Caption:=File1.GetFileDate(NameServer.Getpath+FileListBox1.Items[FileListBox1.ItemIndex]);
    end;
end;

procedure TAddCreate.FileListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if FileListBox1.Count<>0
  then begin
    File1.NumberFile(NameServer.Getpath+FileListBox1.Items[FileListBox1.ItemIndex],
      FileListBox1,FMain.DBGrid1,FMain.ADOQuery1);
    Label4.Caption:=IntToStr(FileListBox1.ItemIndex+1);
    Label5.Caption:=IntToStr(File1.TextSize(NameServer.Getpath+FileListBox1.Items[FileListBox1.ItemIndex]));
    Label6.Caption:=File1.GetFileDate(NameServer.Getpath+FileListBox1.Items[FileListBox1.ItemIndex]);
  end;
end;

function TAddCreate.GetFileListBox: TFileListBox;
begin
  result:=FileListBox1;
end;

procedure TAddCreate.SetFileListBox(mask: string);
begin
  FileListBox1.Mask:=mask;
end;

end.
