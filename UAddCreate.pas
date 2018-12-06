unit UAddCreate;

interface

uses
  SysUtils, Variants, Controls, Forms, StdCtrls, Buttons,
  UInterface, UFile, UUpdateBase, UVarServer,IniFiles;

type
  TAddCreate = class(TInterfacedObject, TInterfaceMenuCreate)
  private
    Label1,Label2,Label3:TLabel;
    Label4,Label5,Label6:TLabel;
    Button1:TButton;
  public
    constructor create(AOwner: TForm);
    procedure destroy;
    procedure Button1Click(Sender:TObject);
  end;

implementation

{ TAddCreate }

uses UMain;

constructor TAddCreate.create(AOwner: TForm);
//var Ini:TIniFile;
begin
  {Ini:=TIniFile.Create(CHangeFileExt(Application.ExeName,'.INI'));
  try
    FMain.Caption:=Ini.ReadString('TAddCreate','Caption','FMain');
  finally
    Ini.Free;
  end; }

  FMain.Caption:='Добавление';
  FMain.Height:=290;
  FMain.Width:=470;
  FMain.FileListBox1.Visible:=True;

  FMain.DBGrid1.Align:=alNone;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=143;
  FMain.DBGrid1.Height:=65;
  FMain.DBGrid1.Width:=438;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=227;
  Label1.Top:=8;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='Номер выбранного файла:';

  Label2:=TLabel.create(AOwner);
  Label2.Left:=227;
  Label2.Top:=31;
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='Количество строк в файле:';

  Label3:=TLabel.create(AOwner);
  Label3.Left:=227;
  Label3.Top:=54;
  Label3.Parent:= AOwner;
  Label3.Font.Name:='Times New Roman';
  Label3.Font.Size:=11;
  Label3.Caption:='Дата изменения:';

  Label4:=TLabel.create(AOwner);
  Label4.Left:=398;
  Label4.Top:=8;
  Label4.Parent:= AOwner;
  Label4.Font.Name:='Times New Roman';
  Label4.Font.Size:=11;
  Label4.Caption:='_-_-_';

  Label5:=TLabel.create(AOwner);
  Label5.Left:=398;
  Label5.Top:=31;
  Label5.Parent:= AOwner;
  Label5.Caption:='_-_-_';
  Label5.Font.Name:='Times New Roman';
  Label5.Font.Size:=11;

  Label6:=TLabel.create(AOwner);
  Label6.Left:=335;
  Label6.Top:=54;
  Label6.Parent:= AOwner;
  Label6.Font.Name:='Times New Roman';
  Label6.Font.Size:=11;
  Label6.Caption:='_-_-_-_-_-_-_-_-';

  Button1:=TButton.create(AOwner);
  Button1.Left:=235;
  Button1.Top:=91;
  Button1.Height:=25;
  Button1.Width:=200;
  Button1.Parent:= AOwner;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Caption:='Добавить';

  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  Button1.OnClick:=Button1Click;
end;

procedure TAddCreate.destroy;
begin
  Label1.Free;
  Label2.Free;
  Label3.Free;
  Label4.Free;
  Label5.Free;
  Label6.Free;
  Button1.Free;
  FMain.FileListBox1.Visible:=False;
end;

procedure TAddCreate.Button1Click(Sender: TObject);
var i:integer;FileName:string;
begin
  if FMain.FileListBox1.Count<>0 then
  with FMain.adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    FileName:=FMain.FileListBox1.Items[FMain.FileListBox1.ItemIndex];
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
      Application.MessageBox('Новые записи внесены в базу данных','Информация')
    end;
  end
  else Application.MessageBox('В выбранной папке отсутствуют файлы .trc','Предупреждение')
end;

end.
