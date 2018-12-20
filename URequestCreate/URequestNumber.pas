unit URequestNumber;

interface

uses StdCtrls, SysUtils, Forms, URequestCreate, UVarServer, UInterface;

type
  TRequestNumber = class(TInterfaceMenuCreate)
  private
    Label1,Label2,Label3:TLabel;
    Combobox1,ComboBox2:TCombobox;
    Edit1:TEdit;
    Button1,Button2:TButton;
    NameServer:TNameServer;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Request;
  end;

implementation

uses UMain;

{ TRequestNumber }

constructor TRequestNumber.create(AOwner: TForm);
begin
  NameServer:=TNameServer.GetInstance;
  FMain.Caption:='������: �� ������ ��������';
  FMain.Height:=700;
  FMain.Width:=1000;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=100;
  FMain.DBGrid1.Height:=520;
  FMain.DBGrid1.Width:=969;
  FMain.ADOQuery1.Close;
  FMain.Panel1.Caption:=NameServer.GetName;
  fFileCreate.LabelCreate(AOwner,30,12,'�������� ��� ������:',Label1);
  fFileCreate.LabelCreate(AOwner,30,44,'������� ����� ��������:',Label2);
  fFileCreate.LabelCreate(AOwner,30,76,'���������� ��:',Label3);
  fFileCreate.ComboBoxCreate(AOwner,200,8,140,ComboBox1);
  ComboBox1.Items.Add('���������/����������');
  ComboBox1.Items.Add('���������� ����� ���');
  ComboBox1.ItemIndex:=0;
  fFileCreate.ComboBoxCreate(AOwner,200,72,140,ComboBox2);
  ComboBox2.Items.Add('�����������');
  ComboBox2.Items.Add('��������');
  ComboBox2.ItemIndex:=0;
  fFileCreate.ButtonCreate(AOwner,360,72,25,130,'��������� ������',Button1);
  Button1.OnClick:=Button1Click;
  fFileCreate.ButtonCreate(AOwner,510,72,25,130,'��������� � ����',Button2);
  Button2.OnClick:=Button2Click;
  fFileCreate.EditCreate(AOwner,200, 40, 140,Edit1);
  Edit1.MaxLength:=8;
end;

procedure TRequestNumber.destroy;
begin
  Label1.Free;
  Label2.Free;
  Label3.Free;
  ComboBox1.Free;
  ComboBox2.Free;
  Edit1.Free;
  Button1.Free;
  Button2.Free;
end;

procedure TRequestNumber.Request;
begin
  with FMain.AdoQuery1 do
  begin
    case ComboBox1.ItemIndex of
      0:begin
        SQL.Add('WHERE ('+'citynumber=');
        if Edit1.Text='' then SQL.Add('NULL'+')')
        else SQL.Add(''''+Edit1.Text+''''+')');
      end;
      1:begin
        SQL.Add('WHERE ('+'insidenumber=');
        if (Edit1.Text='') then SQL.Add('NULL'+')')
        else SQL.Add(''''+Edit1.Text+''''+')');
      end;
    end;
    case ComboBox2.ItemIndex of
      0:SQL.Add(' ORDER BY [date] asc,[time] asc');
      1:SQL.Add(' ORDER BY [date] desc,[time] desc');
    end;
  end;
end;

procedure TRequestNumber.Button1Click(Sender: TObject);
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
  FMain.Panel1.Caption:=NameServer.GetName+'  �������: '
    +IntToStr(FMain.DBGrid1.DataSource.DataSet.RecordCount)+'  ';
end;

procedure TRequestNumber.Button2Click(Sender: TObject);
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
    ///// Request /////
    SQL.Add('FROM ['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    Request;
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
    Active:=True;
  end;
end;

end.
