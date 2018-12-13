unit URequestDate;

interface

uses StdCtrls,SysUtils,Forms,ComCtrls,URequestCreate;

type
  TRequestDate = class(TRequestCreate)
  private
    Label1,Label2,Label3:TLabel;
    Combobox1:TCombobox;
    Button1,Button2:TButton;
    DateTimePicker1,DateTimePicker2,
    DateTimePicker3,DateTimePicker4:TDateTimePicker;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
  end;

implementation

uses UMain;

{ TRequewtDate }

constructor TRequestDate.create(AOwner: TForm);
begin
  FMain.Caption:='������: �� ���� � �������';
  FMain.Height:=700;
  FMain.Width:=1000;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=100;
  FMain.DBGrid1.Height:=520;
  FMain.DBGrid1.Width:=969;
  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  ObjectsCreate.LabelCreate(AOwner,30,12,'�������� ������ �:                               ��:',Label1);
  ObjectsCreate.LabelCreate(AOwner,30,44,'����� �:                                                ��:',Label2);
  ObjectsCreate.LabelCreate(AOwner,30,76,'���������� ��:',Label3);
  ObjectsCreate.DateTimePickerCreate(AOwner,160,8,110,dtkDate,DateTimePicker1);
  ObjectsCreate.DateTimePickerCreate(AOwner,300,8,110,dtkDate,DateTimePicker2);
  ObjectsCreate.DateTimePickerCreate(AOwner,160,40,110,dtkTime,DateTimePicker3);
  ObjectsCreate.DateTimePickerCreate(AOwner,300,40,110,dtkTime,DateTimePicker4);
  ObjectsCreate.ButtonCreate(AOwner,300,72,25,130,'��������� ������',Button1);
  Button1.OnClick:=Button1Click;
  ObjectsCreate.ButtonCreate(AOwner,450,72,25,130,'��������� � ����',Button2);
  Button2.OnClick:=Button2Click;
  ObjectsCreate.ComboBoxCreate(AOwner,160,72,110,ComboBox1);
  ComboBox1.Items.Add('�����������');
  ComboBox1.Items.Add('��������');
  ComboBox1.ItemIndex:=0;
end;

procedure TRequestDate.destroy;
begin
  Label1.Free;
  Label2.Free;
  Label3.Free;
  DateTimePicker1.Free;
  DateTimePicker2.Free;
  DateTimePicker3.Free;
  DateTimePicker4.Free;
  ComboBox1.Free;
  Button1.Free;
  Button2.Free;
end;

procedure TRequestDate.Button1Click(Sender: TObject);
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    SQL.Add('WHERE (date>='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+''''+')');
    SQL.Add(' AND (date<='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date)+''''+')');
    SQL.Add(' AND (time>='+''''+FormatDateTime('hh:mm:ss',DateTimePicker3.Time)+''''+')');
    SQL.Add(' AND (time<'+''''+FormatDateTime('hh:mm:ss',DateTimePicker4.Time)+''''+')');
    case ComboBox1.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
    Active:=True;
  end;
  FMain.DBGrid1.Columns[0].Title.Caption:='�';
  FMain.DBGrid1.Columns[1].Title.Caption:='����';
  FMain.DBGrid1.Columns[2].Title.Caption:='�����';
  FMain.DBGrid1.Columns[3].Title.Caption:='������������';
  FMain.DBGrid1.Columns[4].Title.Caption:='������ ������';
  FMain.DBGrid1.Columns[5].Title.Caption:='��� ������';
  FMain.DBGrid1.Columns[6].Title.Caption:='���';
  FMain.DBGrid1.Columns[7].Title.Caption:='��������� �����';
  FMain.DBGrid1.Columns[8].Title.Caption:='���������� �����';
  FMain.Panel1.Caption:=NameServer.GetName;
  //'  �������: '+IntToStr(FMain.DBGrid1.DataSource.DataSet.RecordCount)+'  ';
end;

procedure TRequestDate.Button2Click(Sender: TObject);
var
  ExFileFields,ExFileTemp,ExFileName:String;
begin
  with FMain.adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('USE ['+NameServer.GetDataBase+']');
    SQL.Add('SET ANSI_PADDING ON');
    SQL.Add('CREATE TABLE [dbo].[Temp] ([�] [int] IDENTITY(1,1) NOT NULL,[date] [date] NOT NULL,'+
      '[time] [time](0) NOT NULL,[duration] [int] NOT NULL,[statuscall] [char](9) NOT NULL,'+
      '[typecall] [char](9) NULL,[code] [int] NULL,[citynumber] [varchar](17) NOT NULL,'+
	    '[insidenumber] [bigint] NULL,	[id] [int] NULL,[trunkid1] [int] NULL,'+
      '[trunkid2] [int] NULL,[trunkid3] [int] NULL) ON [PRIMARY]');
    SQL.Add('SET ANSI_PADDING OFF');
    SQL.Add('INSERT INTO ['+NameServer.GetDataBase+'].[dbo].[Temp] ([date],[time],[duration],[statuscall],[typecall],'+
      '[code],[citynumber],[insidenumber],[id],[trunkid1],[trunkid2],[trunkid3])');
    SQL.Add('SELECT [date],[time],[duration],[statuscall],[typecall],[code],[citynumber],'+
      '[insidenumber],[id],[trunkid1],[trunkid2],[trunkid3]');
    ///// ������ /////
    SQL.Add('FROM ['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    SQL.Add('WHERE (date>='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+''''+')');
    SQL.Add(' AND (date<='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date)+''''+')');
    SQL.Add(' AND (time>='+''''+FormatDateTime('hh:mm:ss',DateTimePicker3.Time)+''''+')');
    SQL.Add(' AND (time<'+''''+FormatDateTime('hh:mm:ss',DateTimePicker4.Time)+''''+')');
    case ComboBox1.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
    /////  /////
    {SQL.Add('EXEC sp_configure '+''''+'show advanced options'+''''+',1');
    SQL.Add('RECONFIGURE');
    SQL.Add('EXEC sp_configure '+''''+'xp_cmdshell'+''''+', 1');
    SQL.Add('RECONFIGURE');}
    ExFileName:=getcurrentdir()+'\������\'+
      FormatDateTime('yyyy-mm-dd',date())+'_'+FormatDateTime('hh-mm-ss',time())+'.csv';
    ExFileFields:=getcurrentdir()+'\Name.csv';
    ExFileTemp:=getcurrentdir()+'\Temp.csv';
    SQL.Add('EXEC master..xp_cmdshell');
    SQL.Add(''''+'bcp "SELECT * FROM ['+NameServer.GetDataBase+'].[dbo].[Temp]" queryout '+
      '"'+ExFileTemp+'"'+' -T -w -x -t"	"'+'''');
    SQL.Add('EXEC master..xp_cmdshell');
    SQL.Add(''''+'copy '+'"'+ExFileFields+'"'+' + '+'"'+ExFileTemp+'"'+' '+'"'+ExFileName+'"'+'''');
    SQL.Add('Drop Table ['+NameServer.GetDataBase+'].[dbo].[Temp]');
    Active:=True;  //ExecSQL;
  end;
end;

end.
