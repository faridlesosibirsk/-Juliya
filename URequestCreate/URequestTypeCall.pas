unit URequestTypeCall;

interface

uses StdCtrls,SysUtils,Forms,URequestCreate;

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
  end;

implementation

uses UMain;

{ TRequestTypeCall }

constructor TRequestTypeCall.create(AOwner: TForm);
begin
  FMain.Caption:='Запрос: тип звонка';
  FMain.Height:=700;
  FMain.Width:=1000;
  FMain.FileListBox1.Visible:=True;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=70;
  FMain.DBGrid1.Height:=550;
  FMain.DBGrid1.Width:=969;
  FMain.FileListBox1.Visible:=false;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=30;
  Label1.Top:=12;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='Выберите тип звонка:';

  ComboBox1:=TComboBox.create(AOwner);
  ComboBox1.Left:=200;
  ComboBox1.Top:=8;
  ComboBox1.Width:=140;
  ComboBox1.Parent:= AOwner;
  ComboBox1.Style:=csDropDownList;
  ComboBox1.Font.Name:='Times New Roman';
  ComboBox1.Font.Size:=11;
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

  Label2:=TLabel.create(AOwner);
  Label2.Left:=30;
  Label2.Top:=44;
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='Сортировка по:';

  ComboBox2:=TComboBox.create(AOwner);
  ComboBox2.Left:=200;
  ComboBox2.Top:=40;
  ComboBox2.Width:=140;
  ComboBox2.Parent:= AOwner;
  ComboBox2.Style:=csDropDownList;
  ComboBox2.Font.Name:='Times New Roman';
  ComboBox2.Font.Size:=11;
  ComboBox2.Items.Add('возрастанию');
  ComboBox2.Items.Add('убыванию');
  ComboBox2.ItemIndex:=0;

  Button1:=TButton.create(AOwner);
  Button1.Left:=360;
  Button1.Top:=40;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Width:=130;
  Button1.Parent:= AOwner;
  Button1.Caption:='Выполнить запрос';
  Button1.OnClick:=Button1Click;

  Button2:=TButton.create(AOwner);
  Button2.Left:=510;
  Button2.Top:=40;
  Button2.Width:=130;
  Button2.Parent:= AOwner;
  Button2.Font.Name:='Times New Roman';
  Button2.Font.Size:=11;
  Button2.Caption:='Сохранить в файл';
  Button2.OnClick:=Button2Click;

  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  //'  Записей: '+IntToStr(FMain.DBGrid1.DataSource.DataSet.RecordCount)+'  ';
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

procedure TRequestTypeCall.Button1Click(Sender: TObject);
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    case ComboBox1.ItemIndex of
      0:SQL.Add('WHERE typecall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
      1:SQL.Add('WHERE typecall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
    end;
    case ComboBox2.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
    Active:=True;  //ExecSQL;
  end;
  FMain.DBGrid1.Columns[0].Title.Caption:='№';
  FMain.DBGrid1.Columns[1].Title.Caption:='Дата';
  FMain.DBGrid1.Columns[2].Title.Caption:='Время';
  FMain.DBGrid1.Columns[3].Title.Caption:='Длительность';
  FMain.DBGrid1.Columns[4].Title.Caption:='Статус звонка';
  FMain.DBGrid1.Columns[5].Title.Caption:='Тип звонка';
  FMain.DBGrid1.Columns[6].Title.Caption:='Код';
  FMain.DBGrid1.Columns[7].Title.Caption:='Городской номер';
  FMain.DBGrid1.Columns[8].Title.Caption:='Внутренний номер';
  FMain.Panel1.Caption:=NameServer.GetName;
  //'  Записей: '+IntToStr(FMain.DBGrid1.DataSource.DataSet.RecordCount)+'  ';
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
    ///// ЗАПРОС /////
    SQL.Add('FROM ['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    case ComboBox1.ItemIndex of
      0:SQL.Add('WHERE typecall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
      1:SQL.Add('WHERE typecall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
    end;
    case ComboBox2.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
    /////  /////
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
    Active:=True;  //ExecSQL;
  end;
end;

end.
