unit UAddCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Data.DB, Data.Win.ADODB, Contnrs,
  Generics.Collections, UInterface,FileCtrl,USettings;

type
  Filestr = record
    date:string[6];
    time:string[4];
    duration:string[4];
    statuscall:string[1];
    code:integer;
    citynumber:string[17];
    insidenumber:string[15];
    id:string[21];
    trunkid1:string[2];
    trunkid2:string[4];
    trunkid3:string[2];
  end;
  TAddCreate = class(TInterfacedObject, TInterfaceMenuCreate)
  private
    Label1,Label2,Label3:TLabel;
    Label4,Label5,Label6:TLabel;
    Button1:TButton;
    p:array of Filestr;         //динамический массив записей
    n,                          //количество записей в динамическом массиве
    nf:integer;
  public
    constructor create(AOwner: TForm);
    procedure destroy;
    procedure Button1Click(Sender:TObject);
    function GetFileDate(FileName:String):String;
    function TextSize:integer;
    procedure NumberFile;
    procedure SortFileListBox;
    procedure UpDateBase(var start:integer);
  end;

implementation

{ TAddCreate }

uses UMain;

constructor TAddCreate.create(AOwner: TForm);
begin
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
  Label6.Caption:='_-_-_-_-_-_-_-_-';//Label6.Caption:='05.11.2018 16:34';

  Button1:=TButton.create(AOwner);
  Button1.Left:=235;
  Button1.Top:=91;
  Button1.Height:=25;
  Button1.Width:=200;
  Button1.Parent:= AOwner;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Caption:='Добавить';

  if NameServer='' then FMain.Panel1.Caption:='Необходимо зайти в настройки программы!'
  else  FMain.Panel1.Caption:=' Используется сервер: '+NameServer+', база данных: '+DataBase;
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
var i:integer;
begin
  with FMain.adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM ['+DataBase+'].[dbo].[AddFiles]');
    SQL.Add('WHERE FileName='+''''+FMain.FileListBox1.Items[nf]+'''');
    Active:=True;
    if FMain.DBGrid1.Fields[0].Value=null then
    begin
      active:=false;
      SQL.Clear;
      SQL.Add('Insert Into ['+DataBase+'].[dbo].[AddFiles] (FileName, DateChange, Lines)');
      SQL.Add('VALUES ('+''''+FMain.FileListBox1.Items[nf]+''''+', '+''''+
        GetFileDate(path+FMain.FileListBox1.Items[nf])+''''+
        ', '+''''+IntToStr(TextSize)+''''+')');
      ExecSQL;
      i:=1;
      UpDateBase(i);
      FMain.Memo1.Clear;
      Application.MessageBox('Файл добавлен в базу данных','Информация')
    end
    else if Fields[3].value<TextSize then
    begin
      i:=Fields[3].value+1;
      UpDateBase(i);
      active:=false;
      SQL.Clear;
      SQL.Add('UPDATE ['+DataBase+'].[dbo].[AddFiles]');
      SQL.Add('SET [Lines] ='+''''+IntToStr(TextSize)+'''');
      SQL.Add('WHERE [FileName]='+''''+FMain.FileListBox1.Items[nf]+'''');
      ExecSQL;
      Application.MessageBox('Новые записи внесены в базу данных','Информация')
    end;
  end;
end;

function TAddCreate.GetFileDate(FileName:String):String;
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

procedure TAddCreate.NumberFile;
begin
  Label4.Caption:=IntToStr(FMain.FileListBox1.ItemIndex+1);
  Label5.Caption:=IntToStr(TextSize);
  Label6.Caption:=GetFileDate(path+FMain.FileListBox1.Items[nf]);
  with FMain.adoQuery1 do
    begin
      active:=false;
      SQL.Clear;
      SQL.Add('SELECT * FROM ['+DataBase+'].[dbo].[AddFiles]');
      SQL.Add('WHERE FileName='+''''+FMain.FileListBox1.Items[nf]+'''');
      Active:=True;
    end;
  FMain.DBGrid1.Columns[0].Title.Caption:='№';
  FMain.DBGrid1.Columns[1].Title.Caption:='Имя файла';
  FMain.DBGrid1.Columns[2].Title.Caption:='Дата изменения';
  FMain.DBGrid1.Columns[3].Title.Caption:='Количество строк';
end;

procedure TAddCreate.SortFileListBox;
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

function TAddCreate.TextSize:integer;
var
  tmp:TStringList;
begin
  nf:=FMain.FileListBox1.ItemIndex;
  if FileExists(path+FMain.FileListBox1.Items[nf]) then
  begin
    tmp:=TStringList.Create;
    tmp.LoadFromFile(path+FMain.FileListBox1.Items[nf]);
    result:=tmp.Count;
    tmp.Free;
  end;
end;

procedure TAddCreate.UpDateBase(var start:integer);
var
  i,j:integer;                      //переменная цикла
  text,s:string;                    //исходная строка
begin
  FMain.Memo1.Clear;
  FMain.Memo1.Lines.LoadFromFile(path+FMain.FileListBox1.Items[nf]); //загружаем файл для чтения
  j:=start-1;n:=start-1;            //если файла в базе нет
  setLength(p,n);                   //количество записей по умолчанию
  while j<=(FMain.Memo1.Lines.count-1) do //пока не конец файла
  begin
    text:='';
    text:=FMain.Memo1.Lines[j];
    j:=j+1;
    if (copy(text,1,5)<>'#COM2')and(copy(text,1,5)<>'00:00')and(length(text)=94)then
    begin
      n:=n+1;setLength(p,n);        //увеличение количества записей
      with p[i] do                  //запись данных
      begin
        date:=copy(text,1,6);       //дата
        time:=copy(text,8,4);       //время
        duration:=copy(text,13,4);  //длительность, сек
        statuscall:=copy(text,18,1);//
        s:=copy(text,20,6);
        while pos(' ',s)>0 do delete(s,pos(' ',s),1);
        if length(s)=0 then code:=0 else code:=StrToInt(s);
        citynumber:=copy(text,27,17);
        while pos(' ',citynumber)>0 do delete(citynumber,pos(' ',citynumber),1);
        insidenumber:=copy(text,45,15);
        id:=copy(text,61,21);
        trunkid1:=copy(text,83,2);
        trunkid2:=copy(text,86,4);
        trunkid3:=copy(text,93,2);
        with FMain.adoQuery1 do
        begin
          active:=false;
          SQL.Clear;
          SQL.Add('Insert Into ['+DataBase+'].[dbo].[Call_records] (date, time, duration, statuscall, typecall, code, citynumber, insidenumber, id, trunkid1, trunkid2, trunkid3)');
          SQL.Add('VALUES ('''+'20'+copy(p[i].date,5,2)+'-'+copy(p[i].date,3,2)+'-'+copy(p[i].date,1,2)+''''+', ');  //1
          SQL.Add(''''+copy(p[i].time,1,2)+':'+copy(p[i].time,3,2)+''''+', ');                                       //2
          SQL.Add(''''+p[i].duration+''''+', ');                                                                     //3
          case p[i].statuscall[1] of                                                                                 //4,5
            '0':SQL.Add(''''+'другие'+''''+', '+''''+'другие 0'+''''+', ');
            '7':begin
                s:=''''+'исходящий'+''', ';
                case p[i].code of
                  801:SQL.Add(s+''''+'локальный'+''', ');
                  802:if length(p[i].citynumber)=4 then SQL.Add(s+''''+'другие'+''', ')
                      else if (length(p[i].citynumber)=7)or(length(p[i].citynumber)=8) then SQL.Add(s+''''+'внутривед'+''', ')
                        else SQL.Add(s+''''+'необраб'+''', ');
                  9801:
                      case length(p[i].citynumber) of
                        1:SQL.Add(s+''''+'межгород'+''', ');
                        2:if p[i].citynumber='89' then SQL.Add(s+''''+'межгород'+''', ')
                          else SQL.Add(s+''''+'спецномер'+''', ');
                        4:SQL.Add(s+''''+'другие'+''', ');
                        5:SQL.Add(s+''''+'локальный'+''', ');
                        6:SQL.Add(s+''''+'локальный'+''', ');
                        7:SQL.Add(s+''''+'внутривед'+''', ');
                        8:SQL.Add(s+''''+'внутривед'+''', ');
                        10:SQL.Add(s+''''+'межгород'+''', ');
                        9,11,12,14:SQL.Add(s+''''+'межгород'+''', ');
                        else SQL.Add(s+''''+'необраб'+''', ');
                      end;
                  else SQL.Add(s+''''+'необраб'+''', ');
              end;
            end;
            '9':SQL.Add(''''+'входящий'+''', '+''''+'входящий'+''', ');
            'A':SQL.Add(''''+'другие A'+''', '+''''+'другие ис'+''', ');
            'C':SQL.Add(''''+'другие C'+''', '+''''+'другие вх'+''', ');
            '4':begin
                SQL.Add(''''+'другие 4'+''', ');
                if p[i].insidenumber='               ' then SQL.Add(''''+'другие вх'+''', ')
                else if p[i].code=9801 then SQL.Add(''''+'другие ис'+''', ')
                else SQL.Add(''''+'другие 4'+''', ');
            end;
            else SQL.Add(''''+'нз'+''', '+''''+'необраб'+''', ');
          end;
          if p[i].code=0 then SQL.Add('NULL, ')  else SQL.Add(IntToStr(p[i].code)+', ');                            //6
          SQL.Add(''''+p[i].citynumber+''''+', ');                                                                  //7
          if p[i].insidenumber='               ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].insidenumber+''''+', '); //8
          if p[i].id='                     ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].id+''''+', ');       //9
          if p[i].trunkid1='  ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].trunkid1+''''+', ');              //10
          if p[i].trunkid2='    ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].trunkid2+''''+', ');            //11
          if p[i].trunkid3='  ' then SQL.Add('NULL'+')')  else SQL.Add(''''+p[i].trunkid3+''''+')');                //12
          ExecSQL;
        end;
        i:=i+1;
      end;
    end;
  end;

end;

end.
