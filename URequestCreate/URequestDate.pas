unit URequestDate;

interface

uses StdCtrls, SysUtils, Forms, ComCtrls, UVarServer, UInterface, UConstants, Generics.Collections;

type
  TRequestDate = class(TInterfaceMenuCreate)
  public
    constructor create(AOwner: TForm);
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
  NameServer:=TNameServer.GetInstance;
  fFileCreate.OptionsFMain(FMain, RDateIni,'FMain_');
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=100;
  FMain.DBGrid1.Height:=520;
  FMain.DBGrid1.Width:=969;
  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;

  ListLabels:=TList<TLabel>.create;
  fFileCreate.OptionsLabels(AOwner,RDateIni,'Label_',2);

  ListButtons:=TList<TButton>.create;
  fFileCreate.OptionsButtons(AOwner,RDateIni,'Button_',1);
  ListButtons.Items[0].OnClick:=Button1Click;
  ListButtons.Items[1].OnClick:=Button2Click;

  ListDateTimePickers:=TList<TDateTimePicker>.create;
  fFileCreate.OptionsDateTimePickers(AOwner,RDateIni,'DateTimePicker_',3);
  ListDateTimePickers.Items[0].Kind:=dtkDate;
  ListDateTimePickers.Items[1].Kind:=dtkDate;
  ListDateTimePickers.Items[2].Kind:=dtkTime;
  ListDateTimePickers.Items[3].Kind:=dtkTime;

  ListComboBoxs:=TList<TComboBox>.create;
  fFileCreate.OptionsComboBoxs(AOwner,RDateIni,'ComboBox_',0);
end;

procedure TRequestDate.destroy;
var i:integer;
begin
  for i := 0 to ListLabels.Count-1 do
    ListLabels.Items[i].Free;
  for i := 0 to ListButtons.Count-1 do
    ListButtons.Items[i].Free;
  for i := 0 to ListComboBoxs.Count-1 do
    ListComboBoxs.Items[i].Free;
  for i := 0 to ListDateTimePickers.Count-1 do
    ListDateTimePickers.Items[i].Free;
end;

procedure TRequestDate.Request;
begin
  with FMain.AdoQuery1 do
  begin
    SQL.Add('WHERE (date>='+''''+FormatDateTime('yyyy-mm-dd',ListDateTimePickers.Items[0].Date)+''''+')');
    SQL.Add(' AND (date<='+''''+FormatDateTime('yyyy-mm-dd',ListDateTimePickers.Items[1].Date)+''''+')');
    SQL.Add(' AND (time>='+''''+FormatDateTime('hh:mm:ss',ListDateTimePickers.Items[2].Time)+''''+')');
    SQL.Add(' AND (time<'+''''+FormatDateTime('hh:mm:ss',ListDateTimePickers.Items[3].Time)+''''+')');
    case ListComboBoxs.Items[0].ItemIndex of
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
