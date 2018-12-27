unit UUpdateBase;

interface

uses SysUtils, UVarServer;

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
  procedure UpDateBase(NameServer:TNameServer;FileName:string;start:integer);

var
   p:array of Filestr;         //������������ ������ �������
   n:integer;                  //���������� ������� � ������������ �������

implementation

uses UMain;

{ TUpdateDB }

procedure UpDateBase(NameServer:TNameServer;FileName:string;start: integer);
var
  i,j,n:integer;                    //���������� �����
  text,s:string;                    //�������� ������
//********************************************************************//
procedure Select9801;
begin
  with FMain.adoQuery1 do
  case length(p[i].citynumber) of  //������� ����������� 8
    1:SQL.Add(s+''''+'��������'+''', ');
    2:if p[i].citynumber='89' then SQL.Add(s+''''+'��������'+''', ')
      else SQL.Add(s+''''+'���������'+''', ');
    4:SQL.Add(s+''''+'������'+''', ');
    5:SQL.Add(s+''''+'���������'+''', ');
    6:SQL.Add(s+''''+'���������'+''', ');
    7:SQL.Add(s+''''+'���������'+''', ');
    8:SQL.Add(s+''''+'���������'+''', ');
    10:SQL.Add(s+''''+'��������'+''', ');
    9,11,12,14:SQL.Add(s+''''+'��������'+''', ');
    else SQL.Add(s+''''+'�������'+''', ');
  end;
end;
//-------------------------------------------------------------------//
procedure AdaptationRequest(i:integer);
begin
  with FMain.adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('Insert Into ['+NameServer.GetDataBase+'].[dbo].[Call_records] (date, time, duration, statuscall, typecall, code, citynumber, insidenumber, id, trunkid1, trunkid2, trunkid3)');
    SQL.Add('VALUES ('''+'20'+copy(p[i].date,5,2)+'-'+copy(p[i].date,3,2)+'-'+copy(p[i].date,1,2)+''''+', ');  //1
    SQL.Add(''''+copy(p[i].time,1,2)+':'+copy(p[i].time,3,2)+''''+', ');                                       //2
    SQL.Add(''''+p[i].duration+''''+', ');                                                                     //3
    case p[i].statuscall[1] of                                                                                 //4,5
      '0':SQL.Add(''''+'������'+''''+', '+''''+'������ 0'+''''+', ');
      '7':begin
            s:=''''+'���������'+''', ';
            case p[i].code of
              801:SQL.Add(s+''''+'���������'+''', ');
              802:if length(p[i].citynumber)=4 then SQL.Add(s+''''+'������'+''', ')
                  else if (length(p[i].citynumber)=7)or(length(p[i].citynumber)=8) then SQL.Add(s+''''+'���������'+''', ')
                    else SQL.Add(s+''''+'�������'+''', ');
              9801: Select9801;
              else SQL.Add(s+''''+'�������'+''', ');
            end;
      end;
      '9':SQL.Add(''''+'��������'+''', '+''''+'��������'+''', ');
      'A':SQL.Add(''''+'������ A'+''', '+''''+'������ ��'+''', ');
      'C':SQL.Add(''''+'������ C'+''', '+''''+'������ ��'+''', ');
      '4':begin
            SQL.Add(''''+'������ 4'+''', ');
            if p[i].insidenumber='               ' then SQL.Add(''''+'������ ��'+''', ')
            else if p[i].code=9801 then SQL.Add(''''+'������ ��'+''', ')
              else SQL.Add(''''+'������ 4'+''', ');
      end;
      else SQL.Add(''''+'��'+''', '+''''+'�������'+''', ');
    end;
    if p[i].code=0 then SQL.Add('NULL, ')  else SQL.Add(IntToStr(p[i].code)+', ');                            //6
    SQL.Add(''''+p[i].citynumber+''''+', ');                                                                  //7
    if p[i].insidenumber='               ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].insidenumber+''''+', '); //8
    if p[i].id='                     ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].id+''''+', ');       //9
    if p[i].trunkid1='  ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].trunkid1+''''+', ');              //10
    if p[i].trunkid2='    ' then SQL.Add('NULL'+', ')  else SQL.Add(''''+p[i].trunkid2+''''+', ');            //11
    if p[i].trunkid3='  ' then SQL.Add('NULL'+')')  else SQL.Add(''''+p[i].trunkid3+''''+')');                //12
    ExecSQL;
  end;//AdaptationRequest(i:integer) end
end;
//********************************************************************//
begin
  //�������� ���� �� ������, � ���������� �������
  FMain.Memo1.Clear;
  FMain.Memo1.Lines.LoadFromFile(FileName);
  //��������� ���� ��� ������
  j:=start-1;n:=start-1;
  setLength(p,n);                   //���������� ������� �� ���������
  while j<=(FMain.Memo1.Lines.count-1) do //���� �� ����� �����
  begin
    text:='';
    text:=FMain.Memo1.Lines[j];
    j:=j+1;
    if (copy(text,1,5)<>'#COM2')and(copy(text,1,5)<>'00:00')and(length(text)=94)then
    begin
      n:=n+1;setLength(p,n);        //���������� ���������� �������
      with p[i] do                  //������ ������
      begin
        date:=copy(text,1,6);
        time:=copy(text,8,4);
        duration:=copy(text,13,4);
        statuscall:=copy(text,18,1);
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
        Adaptationrequest(i);
        i:=i+1;
      end;
    end;
  end;
  FMain.Memo1.Clear;
end;

end.
