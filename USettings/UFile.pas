unit UFile;

interface

uses StdCtrls,SysUtils,Classes,UVarServer,FileCtrl,DBGrids,ADODB;

type
  TFile = class
  private
  public
    function GetFileDate(FileName:String):String;
    function TextSize(FileName:string):integer;
    procedure NumberFile(NameServer:TNameServer;var FileListBox_:TFileListBox;
      DBGrid_:TDBGrid; adoQuery_:TADOQuery);
    procedure SortFileListBox(FileListBox_:TFileListBox);
  end;

implementation

uses UMain;

{ TFile }

function TFile.GetFileDate(FileName: String): String;
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

function TFile.TextSize(FileName:string): integer;
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

procedure TFile.NumberFile(NameServer:TNameServer;var FileListBox_:TFileListBox; DBGrid_:TDBGrid; adoQuery_:TADOQuery);
begin
  with adoQuery_ do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM ['+NameServer.GetDataBase+'].[dbo].[AddFiles]');
    SQL.Add('WHERE FileName='+''''+FileListBox_.Items[FileListBox_.ItemIndex]+'''');
    Active:=True;
  end;
  DBGrid_.Columns[0].Title.Caption:='№';
  DBGrid_.Columns[1].Title.Caption:='Имя файла';
  DBGrid_.Columns[2].Title.Caption:='Дата изменения';
  DBGrid_.Columns[3].Title.Caption:='Количество строк';
end;

procedure TFile.SortFileListBox(FileListBox_:TFileListBox);
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

end.
