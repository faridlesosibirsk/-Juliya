unit UConstructor;

interface

uses
  Vcl.Grids, Vcl.Controls, System.Classes, SysUtils, Forms,
  ComCtrls, StdCtrls, ExtCtrls, DBGrids, Data.DB, Data.Win.ADODB;

type
  TFConstructor = class(TForm)
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    ComboBox9: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure SelectingComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConstructor: TFConstructor;

implementation

{$R *.dfm}

uses UMain,UVarServer;

procedure TFConstructor.FormCreate(Sender: TObject);
begin
  Label10.Visible:=False;
  Label11.Visible:=False;
  Button2.Visible:=False;
  DateTimePicker1.Visible:=False;
  DateTimePicker2.Visible:=False;
  DateTimePicker3.Visible:=False;
  DateTimePicker4.Visible:=False;
  DateTimePicker1.date:=date();
  DateTimePicker2.date:=date();
  DateTimePicker3.date:=date();
  DateTimePicker4.date:=date();
  Edit1.Visible:=False;
  Edit2.Visible:=False;
  Edit3.Visible:=False;
  Edit4.Visible:=False;
end;

procedure TFConstructor.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0:begin
      Label10.Visible:=False;
      DateTimePicker1.Visible:=False;
      DateTimePicker2.Visible:=False;
    end;
  1:begin
      Label10.Visible:=True;
      Label10.Caption:='';
      DateTimePicker1.Visible:=True;
      DateTimePicker2.Visible:=False;
    end;
  2:begin
      Label10.Visible:=True;
      Label10.Caption:='с                                  до';
      DateTimePicker1.Visible:=True;
      DateTimePicker2.Visible:=True;
    end;
  end;
end;

procedure TFConstructor.ComboBox2Change(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
    0:begin
      Label11.Visible:=False;
      DateTimePicker3.Visible:=False;
      DateTimePicker4.Visible:=False;
    end;
    1:begin
      Label11.Visible:=True;
      Label11.Caption:='с                                  до';
      DateTimePicker3.Visible:=True;
      DateTimePicker4.Visible:=True;
    end;
  end;
end;

procedure TFConstructor.ComboBox3Change(Sender: TObject);
begin
  case ComboBox3.ItemIndex of
    0:Edit1.Visible:=False;
    1:Edit1.Visible:=True;
  end;
end;

procedure TFConstructor.ComboBox4Change(Sender: TObject);
begin
  ComboBox5.Items.Clear;
  case ComboBox4.ItemIndex of
    0:begin
        ComboBox5.Items.Add('не важно');
        ComboBox5.Items.Add('входящий');
        ComboBox5.Items.Add('локальный');
        ComboBox5.Items.Add('межгород');
        ComboBox5.Items.Add('спецномер');
        ComboBox5.Items.Add('внутривед');
        ComboBox5.Items.Add('другие');
        ComboBox5.Items.Add('другие 0');
        ComboBox5.Items.Add('другие вх');
        ComboBox5.Items.Add('другие ис');
        ComboBox5.Items.Add('другие 4');
        ComboBox5.Items.Add('необраб');
      end;
    1:  ComboBox5.Items.Add('входящий');
    2:begin
        ComboBox5.Items.Add('не важно');
        ComboBox5.Items.Add('локальный');
        ComboBox5.Items.Add('межгород');
        ComboBox5.Items.Add('спецномер');
        ComboBox5.Items.Add('внутривед');
        ComboBox5.Items.Add('другие');
        ComboBox5.Items.Add('необраб');
      end;
    3:  ComboBox5.Items.Add('другие 0');
    4:  ComboBox5.Items.Add('другие ис');
    5:  ComboBox5.Items.Add('другие вх');
    6:begin
        ComboBox5.Items.Add('не важно');
        ComboBox5.Items.Add('другие ис');
        ComboBox5.Items.Add('другие вх');
        ComboBox5.Items.Add('другие 4');
      end;
    7:  ComboBox5.Items.Add('необраб');
  end;
  ComboBox5.ItemIndex:=0;
end;

procedure TFConstructor.ComboBox6Change(Sender: TObject);
begin
  case ComboBox6.ItemIndex of
    0:Edit2.Visible:=False;
    1:Edit2.Visible:=True;
  end;
end;

procedure TFConstructor.ComboBox7Change(Sender: TObject);
begin
  case ComboBox7.ItemIndex of
    0:Edit3.Visible:=False;
    1:Edit3.Visible:=True;
  end;
end;

procedure TFConstructor.ComboBox8Change(Sender: TObject);
begin
  case ComboBox8.ItemIndex of
    0:Edit4.Visible:=False;
    1:Edit4.Visible:=True;
  end;
end;

procedure TFConstructor.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then key:=#0;
end;

procedure TFConstructor.SelectingComboBox;
var
  a,b,c,d,e,f,g,h:string;
  i,k:integer;
  id:string[8];
begin
  with adoQuery1 do
  begin
    a:='';b:='';c:='';d:='';e:='';f:='';g:='';h:='';k:=0;
    case ComboBox1.ItemIndex of
      1:a:='('+'date='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+''''+')';
      2:a:='('+'date>='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+''''+')'
        +' and ('+'date<='+''''+FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date)+''''+')';
    end;
    case ComboBox2.ItemIndex of
      1:b:='('+'time>='+''''+FormatDateTime('hh:mm:ss',DateTimePicker3.Time)+''''+')'
        +'and ('+'time<='+''''+FormatDateTime('hh:mm:ss',DateTimePicker4.Time)+''''+')';
    end;
    case ComboBox3.ItemIndex of
      1:c:='('+'duration='+''''+Edit1.Text+''''+')';
    end;
    case ComboBox4.ItemIndex of
      1..7:d:='('+'statuscall='+''''+ComboBox4.Items[ComboBox4.ItemIndex]+''''+')';
    end;
    case ComboBox5.ItemIndex of
      1..11:e:='('+'typecall='+''''+ComboBox5.Items[ComboBox5.ItemIndex]+''''+')';
    end;
    case ComboBox6.ItemIndex of
      1:f:='('+'code='+''''+Edit2.Text+''''+')';
    end;
    case ComboBox7.ItemIndex of
      1:g:='('+'citynumber='+''''+Edit3.Text+''''+')';
    end;
    case ComboBox8.ItemIndex of
      1:h:='('+'insidenumber='+''''+Edit4.Text+''''+')';
    end;
    if a='' then id[1]:='0' else id[1]:='1';
    if b='' then id[2]:='0' else id[2]:='1';
    if c='' then id[3]:='0' else id[3]:='1';
    if d='' then id[4]:='0' else id[4]:='1';
    if e='' then id[5]:='0' else id[5]:='1';
    if f='' then id[6]:='0' else id[6]:='1';
    if g='' then id[7]:='0' else id[7]:='1';
    if h='' then id[8]:='0' else id[8]:='1';
    k:=0;
    for i := 1 to 8 do
      if (id[i]='1')and(k=0) then
      begin
        SQL.Add('WHERE ');
        case i of
          1:SQL.Add(a);2:SQL.Add(b);
          3:SQL.Add(c);4:SQL.Add(d);
          5:SQL.Add(e);6:SQL.Add(f);
          7:SQL.Add(g);8:SQL.Add(h);
        end;
        k:=k+1;
      end
      else if (id[i]='1')and(k>0) then
      begin
        case i of
          1:SQL.Add(' and '+a);2:SQL.Add(' and '+b);
          3:SQL.Add(' and '+c);4:SQL.Add(' and '+d);
          5:SQL.Add(' and '+e);6:SQL.Add(' and '+f);
          7:SQL.Add(' and '+g);8:SQL.Add(' and '+h);
        end;
        k:=k+1;
      end;
    case ComboBox9.ItemIndex of
      0:SQL.Add(' ORDER BY [date] asc,[time] asc');
      1:SQL.Add(' ORDER BY [date] desc,[time] desc');
    end;
  end;
end;

procedure TFConstructor.Button1Click(Sender: TObject);
begin
  with adoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    SelectingComboBox;             ///// Request /////
    Active:=true;
  end;
  Button2.Visible:=true;
  FConstructor.DBGrid1.Columns[0].Title.Caption:='№';
  FConstructor.DBGrid1.Columns[1].Title.Caption:='Дата';
  FConstructor.DBGrid1.Columns[2].Title.Caption:='Время';
  FConstructor.DBGrid1.Columns[3].Title.Caption:='Длительность';
  FConstructor.DBGrid1.Columns[4].Title.Caption:='Статус звонка';
  FConstructor.DBGrid1.Columns[5].Title.Caption:='Тип звонка';
  FConstructor.DBGrid1.Columns[6].Title.Caption:='Код';
  FConstructor.DBGrid1.Columns[7].Title.Caption:='Городской номер';
  FConstructor.DBGrid1.Columns[8].Title.Caption:='Внутренний номер';
  FConstructor.Label12.Caption:='Записей: '+IntToStr(FConstructor.DBGrid1.DataSource.DataSet.RecordCount)+'     ';
end;

procedure TFConstructor.Button2Click(Sender: TObject);
var
  ExFile1,ExFile2,ExFileName:string;
begin
  with adoQuery1 do
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
    SQL.Add('SELECT [date],[time],[duration],[statuscall],[typecall],'+
      '[code],[citynumber],[insidenumber],[id],[trunkid1],[trunkid2],[trunkid3]');
    SQL.Add('FROM	['+NameServer.GetDataBase+'].[dbo].[Call_records]');
    SelectingComboBox;             ///// Request /////
    {SQL.Add('EXEC sp_configure '+''''+'show advanced options'+''''+',1');
    SQL.Add('RECONFIGURE');
    SQL.Add('EXEC sp_configure '+''''+'xp_cmdshell'+''''+', 1');
    SQL.Add('RECONFIGURE');}
    ExFileName:=getcurrentdir()+'\Отчеты\'+
      FormatDateTime('yyyy-mm-dd',date())+'_'+FormatDateTime('hh-mm-ss',time());
    ExFile1:=getcurrentdir()+'\Name.csv';
    ExFile2:=getcurrentdir()+'\Temp.csv';
    SQL.Add('EXEC master..xp_cmdshell');
    SQL.Add(''''+'bcp "SELECT * FROM ['+NameServer.GetDataBase+'].[dbo].[Temp]" queryout '+
      ExFile2+' -T -w -x -t"	"'+'''');
    SQL.Add('EXEC master..xp_cmdshell');
    SQL.Add(''''+'copy '+'"'+ExFile1+'"'+' + '+'"'+ExFile2+'"'+' '+'"'+ExFileName+'.csv'+'"'+'''');
    SQL.Add('Drop Table ['+NameServer.GetDataBase+'].[dbo].[Temp]');
    Active:=true;
  end;
end;

end.
