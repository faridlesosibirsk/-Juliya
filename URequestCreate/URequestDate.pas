unit URequestDate;

interface

uses StdCtrls, SysUtils, Forms, ComCtrls, URequestCreate;

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
    procedure Request;
  end;

implementation

uses UMain;

{ TRequewtDate }

constructor TRequestDate.create(AOwner: TForm);
begin
  FMain.Caption:='Запрос: по дате и времени';
  FMain.Height:=700;
  FMain.Width:=1000;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=100;
  FMain.DBGrid1.Height:=520;
  FMain.DBGrid1.Width:=969;
  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  ObjectsCreate.LabelCreate(AOwner,30,12,'Выберите период с:                               по:',Label1);
  ObjectsCreate.LabelCreate(AOwner,30,44,'Время с:                                                по:',Label2);
  ObjectsCreate.LabelCreate(AOwner,30,76,'Сортировка по:',Label3);
  DateTimePicker1:=TDateTimePicker.create(AOwner);
  DateTimePicker1.Left:=160;
  DateTimePicker1.Top:=8;
  DateTimePicker1.Width:=110;
  DateTimePicker1.Parent:= AOwner;
  DateTimePicker1.Kind:=dtkDate;
  DateTimePicker1.Font.Name:='Times New Roman';
  DateTimePicker1.Font.Size:=11;
  DateTimePicker2:=TDateTimePicker.Create(AOwner);
  DateTimePicker2.Left:=300;
  DateTimePicker2.Top:=8;
  DateTimePicker2.Width:=110;
  DateTimePicker2.Parent:= AOwner;
  DateTimePicker2.Kind:=dtkDate;
  DateTimePicker2.Font.Name:='Times New Roman';
  DateTimePicker2.Font.Size:=11;
  DateTimePicker3:=TDateTimePicker.create(AOwner);
  DateTimePicker3.Left:=160;
  DateTimePicker3.Top:=40;
  DateTimePicker3.Width:=110;
  DateTimePicker3.Parent:= AOwner;
  DateTimePicker3.Kind:=dtkTime;
  DateTimePicker3.Font.Name:='Times New Roman';
  DateTimePicker3.Font.Size:=11;
  DateTimePicker4:=TDateTimePicker.Create(AOwner);
  DateTimePicker4.Left:=300;
  DateTimePicker4.Top:=40;
  DateTimePicker4.Width:=110;
  DateTimePicker4.Parent:= AOwner;
  DateTimePicker4.Kind:=dtkTime;
  DateTimePicker4.Font.Name:='Times New Roman';
  DateTimePicker4.Font.Size:=11;
  ObjectsCreate.ButtonCreate(AOwner,300,72,25,130,'Выполнить запрос',Button1);
  Button1.OnClick:=Button1Click;
  ObjectsCreate.ButtonCreate(AOwner,450,72,25,130,'Сохранить в файл',Button2);
  Button2.OnClick:=Button2Click;
  ObjectsCreate.ComboBoxCreate(AOwner,160,72,110,ComboBox1);
  ComboBox1.Items.Add('возрастанию');
  ComboBox1.Items.Add('убыванию');
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

procedure TRequestDate.Request;
begin
  with FMain.AdoQuery1 do
  begin
    SQL.Add('WHERE (date>='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+''''+')');
    SQL.Add(' AND (date<='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date)+''''+')');
    SQL.Add(' AND (time>='+''''+FormatDateTime('hh:mm:ss',DateTimePicker3.Time)+''''+')');
    SQL.Add(' AND (time<'+''''+FormatDateTime('hh:mm:ss',DateTimePicker4.Time)+''''+')');
    case ComboBox1.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
  end;
end;

procedure TRequestDate.Button1Click(Sender: TObject);
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    Request;
    Active:=True;
  end;
  FMain.SetTitleDBGrid;
  FMain.Panel1.Caption:=NameServer.GetName+'  Записей: '
    +IntToStr(FMain.DBGrid1.DataSource.DataSet.RecordCount)+'  ';
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
    SQL.Add('CREATE TABLE [dbo].[Temp] ([№] [int] IDENTITY(1,1) NOT NULL,[date] [date] NOT NULL,'+
      '[time] [time](0) NOT NULL,[duration] [int] NOT NULL,[statuscall] [char](9) NOT NULL,'+
      '[typecall] [char](9) NULL,[code] [int] NULL,[citynumber] [varchar](17) NOT NULL,'+
	    '[insidenumber] [bigint] NULL,	[id] [int] NULL,[trunkid1] [int] NULL,'+
      '[trunkid2] [int] NULL,[trunkid3] [int] NULL) ON [PRIMARY]');
    SQL.Add('SET ANSI_PADDING OFF');
    SQL.Add('INSERT INTO ['+NameServer.GetDataBase+'].[dbo].[Temp] ([date],[time],[duration],[statuscall],[typecall],'+
      '[code],[citynumber],[insidenumber],[id],[trunkid1],[trunkid2],[trunkid3])');
    SQL.Add('SELECT [date],[time],[duration],[statuscall],[typecall],[code],[citynumber],'+
      '[insidenumber],[id],[trunkid1],[trunkid2],[trunkid3]');
    ///// Request /////
    SQL.Add('FROM ['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    Request;
    {SQL.Add('EXEC sp_configure '+''''+'show advanced options'+''''+',1');
    SQL.Add('RECONFIGURE');
    SQL.Add('EXEC sp_configure '+''''+'xp_cmdshell'+''''+', 1');
    SQL.Add('RECONFIGURE');}
    ExFileName:=getcurrentdir()+'\Отчеты\'+
      FormatDateTime('yyyy-mm-dd',date())+'_'+FormatDateTime('hh-mm-ss',time())+'.csv';
    ExFileFields:=getcurrentdir()+'\Name.csv';
    ExFileTemp:=getcurrentdir()+'\Temp.csv';
    SQL.Add('EXEC master..xp_cmdshell');
    SQL.Add(''''+'bcp "SELECT * FROM ['+NameServer.GetDataBase+'].[dbo].[Temp]" queryout '+
      '"'+ExFileTemp+'"'+' -T -w -x -t"	"'+'''');
    SQL.Add('EXEC master..xp_cmdshell');
    SQL.Add(''''+'copy '+'"'+ExFileFields+'"'+' + '+'"'+ExFileTemp+'"'+' '+'"'+ExFileName+'"'+'''');
    SQL.Add('Drop Table ['+NameServer.GetDataBase+'].[dbo].[Temp]');
    Active:=True;
  end;
end;

end.
