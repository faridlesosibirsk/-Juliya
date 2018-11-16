unit URequestCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Data.DB, Data.Win.ADODB, Contnrs,ComCtrls,
  Generics.Collections, UInterface,USettings;

type
  TRequestCreate = class(TInterfacedObject, TInterfaceMenuCreate)
  public
    constructor create(AOwner: TForm);virtual;abstract;
    procedure destroy;virtual;abstract;
    procedure make;virtual;abstract;
  end;

  TRequestAllRecords = class(TRequestCreate)
  private
    Label1:TLabel;
    Combobox1:TCombobox;
    Button1:TButton;
    Button2:TButton;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure make;override;
  end;

  TRequestDate = class(TRequestCreate)
  private
    Label1,Label2,Label3:TLabel;
    Combobox1:TCombobox;
    Button1:TButton;
    Button2:TButton;
    DateTimePicker1,DateTimePicker2,
    DateTimePicker3,DateTimePicker4:TDateTimePicker;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure make;override;
  end;

  TRequestStatusCall = class(TRequestCreate)
  private
    Label1,Label2:TLabel;
    Combobox1,ComboBox2:TCombobox;
    Button1:TButton;
    Button2:TButton;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure make;override;
  end;

  TRequestTypeCall = class(TRequestCreate)
  private
    Label1,Label2:TLabel;
    Combobox1,ComboBox2:TCombobox;
    Button1:TButton;
    Button2:TButton;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure make;override;
  end;

  TRequestNumber = class(TRequestCreate)
  private
    Label1,Label2,Label3:TLabel;
    Combobox1,ComboBox2:TCombobox;
    Edit1:TEdit;
    Button1:TButton;
    Button2:TButton;
  public
    constructor create(AOwner: TForm);override;
    procedure destroy;override;
    procedure make;override;
  end;

var
  i:integer;  //���������� ��� �����

implementation

uses UMain;

{ TRequestAllRecords }

constructor TRequestAllRecords.create(AOwner: TForm);
begin
  FMain.Caption:='������: ��� ������';
  FMain.Height:=500;
  FMain.Width:=700;
  FMain.FileListBox1.Visible:=True;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=36;
  FMain.DBGrid1.Height:=469;
  FMain.DBGrid1.Width:=669;
  FMain.FileListBox1.Visible:=false;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=30;
  Label1.Top:=12;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='���������� ��:';

  ComboBox1:=TComboBox.create(AOwner);
  ComboBox1.Left:=150;
  ComboBox1.Top:=8;
  ComboBox1.Width:=140;
  ComboBox1.Parent:= AOwner;
  ComboBox1.Style:=csDropDownList;
  ComboBox1.Font.Name:='Times New Roman';
  ComboBox1.Font.Size:=11;
  ComboBox1.Items.Add('�����������');
  ComboBox1.Items.Add('��������');
  ComboBox1.ItemIndex:=0;

  Button1:=TButton.create(AOwner);
  Button1.Left:=310;
  Button1.Top:=7;
  Button1.Width:=130;
  Button1.Parent:= AOwner;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Caption:='��������� ������';

  Button2:=TButton.create(AOwner);
  Button2.Left:=460;
  Button2.Top:=7;
  Button2.Width:=130;
  Button2.Parent:= AOwner;
  Button2.Font.Name:='Times New Roman';
  Button2.Font.Size:=11;
  Button2.Caption:='��������� � ����';
end;

procedure TRequestAllRecords.destroy;
begin
  Label1.Free;
  ComboBox1.Free;
  Button1.Free;
  Button2.Free;
end;

procedure TRequestAllRecords.make;
begin
  //Label1.Caption:='1';
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+DataBase+'].[dbo].[Call_records]');
    case ComboBox1.ItemIndex of
      0:SQL.Add('ORDER BY [date] asc,[time] asc');
      1:SQL.Add('ORDER BY [date] desc,[time] desc');
    end;
    Active:=True;  //ExecSQL;
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
  //FMain.Label10.Caption:='�������: '+IntToStr(Form1.DBGrid1.DataSource.DataSet.RecordCount)+'     ';
end;

{ TRequewtDate }

constructor TRequestDate.create(AOwner: TForm);
begin
  FMain.Caption:='������: �� ���� � �������';
  FMain.Height:=500;
  FMain.Width:=700;//FMain.Height:=290;  //FMain.Width:=470;
  FMain.FileListBox1.Visible:=True;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=100;
  FMain.DBGrid1.Height:=469;
  FMain.DBGrid1.Width:=669;
  FMain.FileListBox1.Visible:=false;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=30;
  Label1.Top:=12;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='�������� ������ �:                               ��:';

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

  Label2:=TLabel.create(AOwner);
  Label2.Left:=30;
  Label2.Top:=44;
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='����� �:                                                ��:';

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

  Label3:=TLabel.create(AOwner);
  Label3.Left:=30;
  Label3.Top:=76;
  Label3.Parent:= AOwner;
  Label3.Font.Name:='Times New Roman';
  Label3.Font.Size:=11;
  Label3.Caption:='���������� ��:';

  ComboBox1:=TComboBox.create(AOwner);
  ComboBox1.Left:=160;
  ComboBox1.Top:=72;
  ComboBox1.Width:=110;
  ComboBox1.Parent:= AOwner;
  ComboBox1.Style:=csDropDownList;
  ComboBox1.Font.Name:='Times New Roman';
  ComboBox1.Font.Size:=11;
  ComboBox1.Items.Add('�����������');
  ComboBox1.Items.Add('��������');
  ComboBox1.ItemIndex:=0;

  Button1:=TButton.create(AOwner);
  Button1.Left:=300;
  Button1.Top:=72;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Width:=130;
  Button1.Parent:= AOwner;
  Button1.Caption:='��������� ������';

  Button2:=TButton.create(AOwner);
  Button2.Left:=450;
  Button2.Top:=72;
  Button2.Width:=130;
  Button2.Parent:= AOwner;
  Button2.Font.Name:='Times New Roman';
  Button2.Font.Size:=11;
  Button2.Caption:='��������� � ����';
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

procedure TRequestDate.make;
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+DataBase+'].[dbo].[Call_records]');
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
  //Form1.Label10.Caption:='�������: '+IntToStr(Form1.DBGrid1.DataSource.DataSet.RecordCount)+'     ';
end;

{ TRequestStatusCall }

constructor TRequestStatusCall.create(AOwner: TForm);
begin
  FMain.Caption:='������: ������ ������';
  FMain.Height:=500;
  FMain.Width:=700;//FMain.Height:=290;  //FMain.Width:=470;
  FMain.FileListBox1.Visible:=True;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=70;
  FMain.DBGrid1.Height:=469;
  FMain.DBGrid1.Width:=669;
  FMain.FileListBox1.Visible:=false;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=30;
  Label1.Top:=12;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='�������� ������ ������:';

  ComboBox1:=TComboBox.create(AOwner);
  ComboBox1.Left:=200;
  ComboBox1.Top:=8;
  ComboBox1.Width:=140;
  ComboBox1.Parent:= AOwner;
  ComboBox1.Style:=csDropDownList;
  ComboBox1.Font.Name:='Times New Roman';
  ComboBox1.Font.Size:=11;
  ComboBox1.Items.Add('��������');
  ComboBox1.Items.Add('���������');
  ComboBox1.Items.Add('������');
  ComboBox1.Items.Add('������ A');
  ComboBox1.Items.Add('������ C');
  ComboBox1.Items.Add('������ 4');
  ComboBox1.Items.Add('��');
  ComboBox1.ItemIndex:=0;

  Label2:=TLabel.create(AOwner);
  Label2.Left:=30;
  Label2.Top:=44;
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='���������� ��:';

  ComboBox2:=TComboBox.create(AOwner);
  ComboBox2.Left:=200;
  ComboBox2.Top:=40;
  ComboBox2.Width:=140;
  ComboBox2.Parent:= AOwner;
  ComboBox2.Style:=csDropDownList;
  ComboBox2.Font.Name:='Times New Roman';
  ComboBox2.Font.Size:=11;
  ComboBox2.Items.Add('�����������');
  ComboBox2.Items.Add('��������');
  ComboBox2.ItemIndex:=0;

  Button1:=TButton.create(AOwner);
  Button1.Left:=360;
  Button1.Top:=40;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Width:=130;
  Button1.Parent:= AOwner;
  Button1.Caption:='��������� ������';

  Button2:=TButton.create(AOwner);
  Button2.Left:=510;
  Button2.Top:=40;
  Button2.Width:=130;
  Button2.Parent:= AOwner;
  Button2.Font.Name:='Times New Roman';
  Button2.Font.Size:=11;
  Button2.Caption:='��������� � ����';
end;

procedure TRequestStatusCall.destroy;
begin
  Label1.Free;
  Label2.Free;
  ComboBox1.Free;
  ComboBox2.Free;
  Button1.Free;
  Button2.Free;
end;

procedure TRequestStatusCall.make;
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+DataBase+'].[dbo].[Call_records]');
    case ComboBox1.ItemIndex of
      0:SQL.Add('WHERE statuscall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
      1:SQL.Add('WHERE statuscall='+''''+ComboBox1.Items[ComboBox1.ItemIndex]+'''');
    end;
    case ComboBox2.ItemIndex of
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
  //Form1.Label10.Caption:='�������: '+IntToStr(Form1.DBGrid1.DataSource.DataSet.RecordCount)+'     ';
end;

{ TRequestTypeCall }

constructor TRequestTypeCall.create(AOwner: TForm);
begin
  FMain.Caption:='������: ��� ������';
  FMain.Height:=500;
  FMain.Width:=700;//FMain.Height:=290;  //FMain.Width:=470;
  FMain.FileListBox1.Visible:=True;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=70;
  FMain.DBGrid1.Height:=469;
  FMain.DBGrid1.Width:=669;
  FMain.FileListBox1.Visible:=false;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=30;
  Label1.Top:=12;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='�������� ��� ������:';

  ComboBox1:=TComboBox.create(AOwner);
  ComboBox1.Left:=200;
  ComboBox1.Top:=8;
  ComboBox1.Width:=140;
  ComboBox1.Parent:= AOwner;
  ComboBox1.Style:=csDropDownList;
  ComboBox1.Font.Name:='Times New Roman';
  ComboBox1.Font.Size:=11;
  ComboBox1.Items.Add('��������');
  ComboBox1.Items.Add('���������');
  ComboBox1.Items.Add('��������');
  ComboBox1.Items.Add('���������');
  ComboBox1.Items.Add('���������');
  ComboBox1.Items.Add('������');
  ComboBox1.Items.Add('������ 0');
  ComboBox1.Items.Add('������ ��');
  ComboBox1.Items.Add('������ ��');
  ComboBox1.Items.Add('������ 4');
  ComboBox1.Items.Add('�������');
  ComboBox1.ItemIndex:=0;

  Label2:=TLabel.create(AOwner);
  Label2.Left:=30;
  Label2.Top:=44;
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='���������� ��:';

  ComboBox2:=TComboBox.create(AOwner);
  ComboBox2.Left:=200;
  ComboBox2.Top:=40;
  ComboBox2.Width:=140;
  ComboBox2.Parent:= AOwner;
  ComboBox2.Style:=csDropDownList;
  ComboBox2.Font.Name:='Times New Roman';
  ComboBox2.Font.Size:=11;
  ComboBox2.Items.Add('�����������');
  ComboBox2.Items.Add('��������');
  ComboBox2.ItemIndex:=0;

  Button1:=TButton.create(AOwner);
  Button1.Left:=360;
  Button1.Top:=40;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Width:=130;
  Button1.Parent:= AOwner;
  Button1.Caption:='��������� ������';

  Button2:=TButton.create(AOwner);
  Button2.Left:=510;
  Button2.Top:=40;
  Button2.Width:=130;
  Button2.Parent:= AOwner;
  Button2.Font.Name:='Times New Roman';
  Button2.Font.Size:=11;
  Button2.Caption:='��������� � ����';
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

procedure TRequestTypeCall.make;
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+DataBase+'].[dbo].[Call_records]');
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
  FMain.DBGrid1.Columns[0].Title.Caption:='�';
  FMain.DBGrid1.Columns[1].Title.Caption:='����';
  FMain.DBGrid1.Columns[2].Title.Caption:='�����';
  FMain.DBGrid1.Columns[3].Title.Caption:='������������';
  FMain.DBGrid1.Columns[4].Title.Caption:='������ ������';
  FMain.DBGrid1.Columns[5].Title.Caption:='��� ������';
  FMain.DBGrid1.Columns[6].Title.Caption:='���';
  FMain.DBGrid1.Columns[7].Title.Caption:='��������� �����';
  FMain.DBGrid1.Columns[8].Title.Caption:='���������� �����';
  //Form1.Label10.Caption:='�������: '+IntToStr(Form1.DBGrid1.DataSource.DataSet.RecordCount)+'     ';
end;

{ TRequestNumber }

constructor TRequestNumber.create(AOwner: TForm);
begin
  FMain.Caption:='������: �� ������ ��������';
  FMain.Height:=500;
  FMain.Width:=700;//FMain.Height:=290;  //FMain.Width:=470;
  FMain.FileListBox1.Visible:=True;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=100;
  FMain.DBGrid1.Height:=469;
  FMain.DBGrid1.Width:=669;
  FMain.FileListBox1.Visible:=false;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=30;
  Label1.Top:=12;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='�������� ��� ������:';

  ComboBox1:=TComboBox.create(AOwner);
  ComboBox1.Left:=200;
  ComboBox1.Top:=8;
  ComboBox1.Width:=140;
  ComboBox1.Parent:= AOwner;
  ComboBox1.Style:=csDropDownList;
  ComboBox1.Font.Name:='Times New Roman';
  ComboBox1.Font.Size:=11;
  ComboBox1.Items.Add('���������/����������');
  ComboBox1.Items.Add('���������� ����� ���');
  ComboBox1.ItemIndex:=0;

  Label2:=TLabel.create(AOwner);
  Label2.Left:=30;
  Label2.Top:=44;    //76
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='������� ����� ��������:';

  Edit1:=TEdit.create(AOwner);
  Edit1.Left:=200;
  Edit1.Top:=40;    //72
  Edit1.Width:=140;
  Edit1.Parent:= AOwner;
  Edit1.Text:='';
  Edit1.Font.Name:='Times New Roman';
  Edit1.Font.Size:=11;
  Edit1.MaxLength:=8;

  Label3:=TLabel.create(AOwner);
  Label3.Left:=30;
  Label3.Top:=76;     //44
  Label3.Parent:= AOwner;
  Label3.Font.Name:='Times New Roman';
  Label3.Font.Size:=11;
  Label3.Caption:='���������� ��:';

  ComboBox2:=TComboBox.create(AOwner);
  ComboBox2.Left:=200;
  ComboBox2.Top:=72; //40
  ComboBox2.Width:=140;
  ComboBox2.Parent:= AOwner;
  ComboBox2.Style:=csDropDownList;
  ComboBox2.Font.Name:='Times New Roman';
  ComboBox2.Font.Size:=11;
  ComboBox2.Items.Add('�����������');
  ComboBox2.Items.Add('��������');
  ComboBox2.ItemIndex:=0;

  Button1:=TButton.create(AOwner);
  Button1.Left:=360;
  Button1.Top:=72;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Width:=130;
  Button1.Parent:= AOwner;
  Button1.Caption:='��������� ������';

  Button2:=TButton.create(AOwner);
  Button2.Left:=510;
  Button2.Top:=72;
  Button2.Width:=130;
  Button2.Parent:= AOwner;
  Button2.Font.Name:='Times New Roman';
  Button2.Font.Size:=11;
  Button2.Caption:='��������� � ����';
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

procedure TRequestNumber.make;
begin
  with FMain.AdoQuery1 do
  begin
    active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM	['+DataBase+'].[dbo].[Call_records]');
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
    Active:=True;  //ExecSQL;
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
  //Form1.Label10.Caption:='�������: '+IntToStr(Form1.DBGrid1.DataSource.DataSet.RecordCount)+'     ';
end;

end.
