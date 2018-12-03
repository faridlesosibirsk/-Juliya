unit UFile;

interface

uses StdCtrls,SysUtils,Classes,UVarServer;

{type
  TFile = class
  private
  public}
    function GetFileDate(FileName:String):String;
    function TextSize(FileName:string):integer;
    procedure NumberFile(FileName:string;var a,b,c:string);
    procedure SortFileListBox;
  //end;

implementation

uses UMain;

{ TFile }

function GetFileDate(FileName: String): String;
var
  FHandle:Integer;
begin
  FHandle:=FileOpen(FileName,0);
  try
    Result:=DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
  finally
    FileClose(FHandle);
  end;
end;

function TextSize(FileName:string): integer;
var
  tmp:TStringList;
begin
  if FileExists(FileName) then
  begin
    tmp:=TStringList.Create;
    tmp.LoadFromFile(FileName);
    result:=tmp.Count;
    tmp.Free;
  end;
end;

procedure NumberFile(FileName:string;var a,b,c:string);    //
var NameServer:TNameServer;
begin
  a:=IntToStr(FMain.FileListBox1.ItemIndex+1);                  //Label4.Caption
  b:=IntToStr(TextSize(FileName));    //Label5.Caption
  c:=GetFileDate(FileName); //Label6.Caption
  with FMain.adoQuery1 do   //FileName=path+FMain.FileListBox1.Items[FMain.FileListBox1.ItemIndex]
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM ['+NameServer.GetDataBase+'].[dbo].[AddFiles]');
    SQL.Add('WHERE FileName='+''''+FMain.FileListBox1.Items[FMain.FileListBox1.ItemIndex]+'''');
    Active:=True;
  end;
  FMain.DBGrid1.Columns[0].Title.Caption:='№';
  FMain.DBGrid1.Columns[1].Title.Caption:='Имя файла';
  FMain.DBGrid1.Columns[2].Title.Caption:='Дата изменения';
  FMain.DBGrid1.Columns[3].Title.Caption:='Количество строк';
end;

procedure SortFileListBox;
var
  i,j,N:integer;
  c:string;
  flag:boolean;
function GetText(text:string):string;
begin
  result:=copy(text,12,4)+copy(text,9,2)+copy(text,6,2);
end;
begin
  N:=FMain.FileListBox1.Items.Count-1;
  i:=0;
  repeat
    i:=i+1;
    flag:=false;
    for j := n-1 downto 0 do
    if GetText(FMain.FileListBox1.Items.Strings[j])>GetText(FMain.FileListBox1.Items.Strings[j+1]) then
    begin
      c:=FMain.FileListBox1.Items.Strings[j];
      FMain.FileListBox1.Items.Strings[j]:=FMain.FileListBox1.Items.Strings[j+1];
      FMain.FileListBox1.Items.Strings[j+1]:=c;
      flag:=true;
    end;
  until not flag;

end;



end.
