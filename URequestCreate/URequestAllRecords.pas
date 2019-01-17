unit URequestAllRecords;

interface

uses StdCtrls, SysUtils, Forms, UVarServer, UInterface, UConstants, Generics.Collections;

type
  TRequestAllRecords = class(TInterfaceMenuCreate)
  public
    constructor create(AOwner: TForm);
    procedure destroy;override;
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Request;
  end;

implementation

uses UMain;

{ TRequestAllRecords }

constructor TRequestAllRecords.create(AOwner: TForm);
begin
  NameServer:=TNameServer.GetInstance;
  fFileCreate.OptionsFMain(FMain, RAllIni,'FMain_');
  fFileCreate.OptionsDBGrid(FMain.DBGrid1, RAllIni,'DBGrid_');
  FMain.ADOQuery1.Close;
  FMain.GetPanel1;

  ListLabels:=TList<TLabel>.create;
  fFileCreate.OptionsLabels(AOwner,RAllIni,'Label_',0);

  ListButtons:=TList<TButton>.create;
  fFileCreate.OptionsButtons(AOwner,RAllIni,'Button_',1);
  ListButtons.Items[0].OnClick:=Button1Click;
  ListButtons.Items[1].OnClick:=Button2Click;

  ListComboBoxs:=TList<TComboBox>.create;
  fFileCreate.OptionsComboBoxs(AOwner,RAllIni,'ComboBox_',0);
end;

procedure TRequestAllRecords.destroy;
var i:integer;
begin
  for i := 0 to ListLabels.Count-1 do
    ListLabels.Items[i].Free;
  for i := 0 to ListButtons.Count-1 do
    ListButtons.Items[i].Free;
  for i := 0 to ListComboBoxs.Count-1 do
    ListComboBoxs.Items[i].Free;
end;

procedure TRequestAllRecords.Request;
begin
  with FMain.AdoQuery1 do
  begin
    case ListComboBoxs.Items[0].ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
  end;
end;

procedure TRequestAllRecords.Button1Click(Sender: TObject);
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
  FMain.GetPanel2;
end;

procedure TRequestAllRecords.Button2Click(Sender: TObject);
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
