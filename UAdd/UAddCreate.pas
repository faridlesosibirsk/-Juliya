unit UAddCreate;

interface

uses
  SysUtils, Variants, Controls, Forms, StdCtrls, FileCtrl, Classes, Winapi.Windows,
  UInterface, UFile, UVarServer,  UUpdateBase, UConstants, Generics.Collections;

type
  TAddCreate = class(TInterfaceMenuCreate)
  private
    /// <link>aggregation</link>
    File_: TFile;
  public
    procedure SetFileListBox(mask: string);
    function GetFileListBox:TFileListBox;
    constructor create(AOwner: TForm);
    procedure destroy;override;
    procedure Button1Click(Sender:TObject);
    procedure FileListBox1KeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FileListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure SortFileListBox(FileListBox_:TFileListBox);
  end;
  procedure ClickKeyOrMouse;

var File1: TFile;

implementation

{ TAddCreate }

uses UMain;

constructor TAddCreate.create(AOwner: TForm);
begin
  NameServer:=TNameServer.GetInstance;
  fFileCreate.OptionsFMain(FMain, AddIni,'FMain_');
  FMain.DBGrid1.Align:=alNone;
  fFileCreate.OptionsDBGrid(FMain.DBGrid1, AddIni,'DBGrid_');
  FMain.ADOQuery1.Close;
  FMain.GetPanel1;

  ListLabels:=TList<TLabel>.create;
  fFileCreate.OptionsLabels(AOwner,AddIni,'Label_',5);

  ListButtons:=TList<TButton>.create;
  fFileCreate.OptionsButtons(AOwner,AddIni,'Button_',0);
  ListButtons.Items[0].OnClick:=Button1Click;

  ListFileListBoxs:=TList<TFileListBox>.create;
  fFileCreate.OptionsFileListBox(AOwner,AddIni,'FileListBox_',0);

  ListFileListBoxs.Items[0].Mask:=NameServer.Getpath+'*.trc';
  ListFileListBoxs.Items[0].OnKeyDown:=FileListBox1KeyUp;
  ListFileListBoxs.Items[0].OnKeyUp:=FileListBox1KeyUp;
  ListFileListBoxs.Items[0].OnMouseDown:=FileListBox1MouseDown;
  ListFileListBoxs.Items[0].OnMouseUp:=FileListBox1MouseDown;
end;

procedure TAddCreate.destroy;
var i:integer;
begin
  ListFileListBoxs.Items[0].mask:='.';
  ListButtons.Items[0].SetFocus;
  ListFileListBoxs.Items[0].Destroy;
  for i := 0 to ListLabels.Count-1 do
    ListLabels.Items[i].Free;
  for i := 0 to ListButtons.Count-1 do
    ListButtons.Items[i].Free;
end;

procedure TAddCreate.Button1Click(Sender: TObject);
var i:integer;FileName:string;
begin
  if (ListFileListBoxs.Items[0].Count<>0)and(ListFileListBoxs.Items[0].ItemIndex>=0) then
  with FMain.adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    FileName:=ListFileListBoxs.Items[0].Items[ListFileListBoxs.Items[0].ItemIndex];
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
      UpDateBase(NameServer,NameServer.Getpath+FileName,i);
      Application.MessageBox('Файл добавлен в базу данных','Информация')
    end
    else if Fields[3].value<File1.TextSize(NameServer.Getpath+FileName) then
    begin
      i:=Fields[3].value+1;
      UpDateBase(NameServer,NameServer.Getpath+FileName,i);
      active:=false;
      SQL.Clear;
      SQL.Add('UPDATE ['+NameServer.GetDataBase+'].[dbo].[AddFiles]');
      SQL.Add('SET [Lines] ='+''''+IntToStr(File1.TextSize(NameServer.Getpath+FileName))+'''');
      SQL.Add('WHERE [FileName]='+''''+FileName+'''');
      ExecSQL;
      Application.MessageBox('Новые записи внесены в базу данных','Информация');
    end;
  end
  else if (ListFileListBoxs.Items[0].Count<>0)and(ListFileListBoxs.Items[0].ItemIndex<0)
    then Application.MessageBox('Выберите файл из списка','Предупреждение')
    else Application.MessageBox('В выбранной папке отсутствуют файлы .trc','Предупреждение');
end;

procedure TAddCreate.FileListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ListFileListBoxs.Items[0].Count<>0 then
    if (key=VK_LEFT)or(key=VK_RIGHT)or(key=VK_UP)or(key=VK_DOWN)
    then ClickKeyOrMouse;
end;

procedure TAddCreate.FileListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ListFileListBoxs.Items[0].Count<>0
  then ClickKeyOrMouse;
end;

function TAddCreate.GetFileListBox: TFileListBox;
begin
  result:=ListFileListBoxs.Items[0];
end;

procedure TAddCreate.SetFileListBox(mask: string);
begin
  ListFileListBoxs.Items[0].Mask:=mask;
end;

procedure TAddCreate.SortFileListBox(FileListBox_:TFileListBox);
var
  i,j,N:integer;
  c:string;
  flag:boolean;
function GetText(text:string):string;
begin
  result:=copy(text,12,4)+copy(text,9,2)+copy(text,6,2);
end;
begin
  N:=FileListBox_.Items.Count-1;
  i:=0;
  repeat
    i:=i+1;
    flag:=false;
    for j := n-1 downto 0 do
    if GetText(FileListBox_.Items.Strings[j])>GetText(FileListBox_.Items.Strings[j+1]) then
    begin
      c:=FileListBox_.Items.Strings[j];
      FileListBox_.Items.Strings[j]:=FileListBox_.Items.Strings[j+1];
      FileListBox_.Items.Strings[j+1]:=c;
      flag:=true;
    end;
  until not flag;
end;

procedure ClickKeyOrMouse;
begin
  File1.NumberFile(NameServer,ListFileListBoxs.Items[0],FMain.DBGrid1,FMain.ADOQuery1);
  ListLabels.Items[3].Caption:=IntToStr(ListFileListBoxs.Items[0].ItemIndex+1);
  ListLabels.Items[4].Caption:=IntToStr(File1.TextSize(NameServer.Getpath+ListFileListBoxs.Items[0].Items[ListFileListBoxs.Items[0].ItemIndex]));
  ListLabels.Items[5].Caption:=File1.GetFileDate(NameServer.Getpath+ListFileListBoxs.Items[0].Items[ListFileListBoxs.Items[0].ItemIndex]);
end;

end.
