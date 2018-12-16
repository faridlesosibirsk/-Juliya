unit URequestTypeCall;

interface

uses StdCtrls, SysUtils, Forms, URequestCreate;

type
  TRequestTypeCall = class(TRequestCreate)
  private
    Label1,Label2:TLabel;
    Combobox1,ComboBox2:TCombobox;
    Button1,Button2:TButton;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Request;
  end;

implementation

uses UMain;

{ TRequestTypeCall }

constructor TRequestTypeCall.create(AOwner: TForm);
begin
  FMain.Caption:='Запрос: тип звонка';
  FMain.Height:=700;
  FMain.Width:=1000;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=70;
  FMain.DBGrid1.Height:=550;
  FMain.DBGrid1.Width:=969;
  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  ObjectsCreate.LabelCreate(AOwner,30,12,'Выберите тип звонка:',Label1);
  ObjectsCreate.LabelCreate(AOwner,30,44,'Сортировка по:',Label2);
  ObjectsCreate.ComboBoxCreate(AOwner,200,8,140,ComboBox1);
  ComboBox1.Items.Add('входящий');
  ComboBox1.Items.Add('локальный');
  ComboBox1.Items.Add('межгород');
  ComboBox1.Items.Add('спецномер');
  ComboBox1.Items.Add('внутривед');
  ComboBox1.Items.Add('другие');
  ComboBox1.Items.Add('другие 0');
  ComboBox1.Items.Add('другие вх');
  ComboBox1.Items.Add('другие ис');
  ComboBox1.Items.Add('другие 4');
  ComboBox1.Items.Add('необраб');
  ComboBox1.ItemIndex:=0;
  ObjectsCreate.ComboBoxCreate(AOwner,200,40,140,ComboBox2);
  ComboBox2.Items.Add('возрастанию');
  ComboBox2.Items.Add('убыванию');
  ComboBox2.ItemIndex:=0;
  ObjectsCreate.ButtonCreate(AOwner,360,40,25,130,'Выполнить запрос',Button1);
  Button1.OnClick:=Button1Click;
  ObjectsCreate.ButtonCreate(AOwner,510,40,25,130,'Сохранить в файл',Button2);
  Button2.OnClick:=Button2Click;
end;

procedure TRequestTypeCall.destroy;
begin
  Label1.Free;
  Label2.Free;
  ComboBox1.Free;
  ComboBox2.Free;
  Button1.Free;
  Button2.Free;
end;

procedure TRequestTypeCall.Request;
begin
  with FMain.AdoQuery1 do
  begin
    SQL.Add('WHERE typecall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
    case ComboBox2.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
  end;
end;

procedure TRequestTypeCall.Button1Click(Sender: TObject);
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

procedure TRequestTypeCall.Button2Click(Sender: TObject);
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
