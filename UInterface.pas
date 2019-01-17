unit UInterface;

interface

uses
  StdCtrls, Forms, DBGrids, UVarServer,IniFiles, UConstants,
  Generics.Collections, SysUtils, FileCtrl, ComCtrls;

type
  TInterfaceMenuCreate = class
  private
    /// <link>aggregation</link>
    NameServer_: TNameServer;
    /// <link>aggregation</link>
    fFileCreate_: TInterfaceMenuCreate;
  public
    procedure destroy;virtual;abstract;
    procedure OptionsFMain(FMain_:TForm; IniName, Name:string);
    procedure OptionsDBGrid(DBGrid_:TDBGrid; IniName, Name:string);
    procedure OptionsFileListBox(AOwner: TForm; IniName, Name: string; count: integer);
    procedure OptionsLabels(AOwner:TForm; IniName, Name:string; count:integer);
    procedure OptionsButtons(AOwner:TForm; IniName, Name:string; count:integer);
    procedure OptionsEdits(AOwner: TForm; IniName, Name:string; count:integer);
    procedure OptionsComboBoxs(AOwner: TForm; IniName, Name:string; count:integer);
    procedure OptionsDateTimePickers(AOwner: TForm; IniName, Name:string; count:integer);
  end;

var fFileCreate: TInterfaceMenuCreate;
    NameServer: TNameServer;
    Ini:TIniFile;
    ListLabels:TList<TLabel>;
    ListButtons:TList<TButton>;
    ListComboBoxs:TList<TComboBox>;
    ListFileListBoxs:TList<TFileListBox>;
    ListEdits:TList<TEdit>;
    ListDateTimePickers:TList<TDateTimePicker>;

implementation

{ TInterfaceMenuCreate }

procedure TInterfaceMenuCreate.OptionsFMain(FMain_:TForm; IniName, Name:string);
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    FMain_.Caption:=Ini.ReadString(Name,'Caption','0');
    FMain_.Height:=Ini.ReadInteger(Name,'Height',0);
    FMain_.Width:=Ini.ReadInteger(Name,'Width',0);
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsDBGrid(DBGrid_:TDBGrid; IniName, Name:string);
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    DBGrid_.Left:=Ini.ReadInteger(Name,'Left',0);
    DBGrid_.Top:=Ini.ReadInteger(Name,'Top',0);
    DBGrid_.Height:=Ini.ReadInteger(Name,'Height',0);
    DBGrid_.Width:=Ini.ReadInteger(Name,'Width',0);
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsFileListBox(AOwner: TForm; IniName, Name: string; count: integer);
var i:integer;
    FileListBox_:TFileListBox;
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    for i := 0 to count do
    begin
      FileListBox_:=TFileListBox.Create(AOwner);
      FileListBox_.Left:=Ini.ReadInteger(Name+IntToStr(i+1),'Left',0);
      FileListBox_.Top:=Ini.ReadInteger(Name+IntToStr(i+1),'Top',0);
      FileListBox_.Height:=Ini.ReadInteger(Name+IntToStr(i+1),'Height',0);
      FileListBox_.ItemHeight:=Ini.ReadInteger(Name+IntToStr(i+1),'ItemHeight',0);
      FileListBox_.Width:=Ini.ReadInteger(Name+IntToStr(i+1),'Width',0);
      FileListBox_.Parent:=Aowner;
      FileListBox_.Font.Name:=FontName;
      FileListBox_.Font.Size:=FontSize;
      ListFileListBoxs.Add(FileListBox_);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsLabels(AOwner:TForm; IniName, Name: string; count: integer);
var i:integer;
    Label_:TLabel;
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    for i := 0 to count do
    begin
      Label_:=TLabel.create(AOwner);
      Label_.Left:=Ini.ReadInteger(Name+IntToStr(i+1),'Left',0);
      Label_.Top:=Ini.ReadInteger(Name+IntToStr(i+1),'Top',0);
      Label_.Caption:=Ini.ReadString(Name+IntToStr(i+1),'Caption','0');
      Label_.Parent:= AOwner;
      Label_.Font.Name:=FontName;
      Label_.Font.Size:=FontSize;
      ListLabels.Add(Label_);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsButtons(AOwner: TForm; IniName,
  Name: string; count: integer);
var i:integer;
    Button_:TButton;
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    for i := 0 to count do
    begin
      Button_:=TButton.create(AOwner);
      Button_.Left:=Ini.ReadInteger(Name+IntToStr(i+1),'Left',0);
      Button_.Top:=Ini.ReadInteger(Name+IntToStr(i+1),'Top',0);
      Button_.Caption:=Ini.ReadString(Name+IntToStr(i+1),'Caption','0');
      Button_.Height:=Ini.ReadInteger(Name+IntToStr(i+1),'Height',0);
      Button_.Width:=Ini.ReadInteger(Name+IntToStr(i+1),'Width',0);
      Button_.Parent:= AOwner;
      Button_.Font.Name:=FontName;
      Button_.Font.Size:=FontSize;
      ListButtons.Add(Button_);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsEdits(AOwner: TForm; IniName,
  Name: string; count: integer);
var i:integer;
    Edit_:TEdit;
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    for i := 0 to count do
    begin
      Edit_:=TEdit.create(AOwner);
      Edit_.Left:=Ini.ReadInteger(Name+IntToStr(i+1),'Left',0);
      Edit_.Top:=Ini.ReadInteger(Name+IntToStr(i+1),'Top',0);
      Edit_.Width:=Ini.ReadInteger(Name+IntToStr(i+1),'Width',0);
      Edit_.Parent:= AOwner;
      Edit_.Font.Name:=FontName;
      Edit_.Font.Size:=FontSize;
      ListEdits.Add(Edit_);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsComboBoxs(AOwner: TForm; IniName,
  Name: string; count: integer);
var i,j,CountItems:integer;
    ComboBox_:TComboBox;
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    for i := 0 to count do
    begin
      ComboBox_:=TComboBox.create(AOwner);
      ComboBox_.Left:=Ini.ReadInteger(Name+IntToStr(i+1),'Left',0);
      ComboBox_.Top:=Ini.ReadInteger(Name+IntToStr(i+1),'Top',0);
      ComboBox_.Width:=Ini.ReadInteger(Name+IntToStr(i+1),'Width',0);
      ComboBox_.Parent:= AOwner;
      ComboBox_.Style:=csDropDownList;
      ComboBox_.Font.Name:=FontName;
      ComboBox_.Font.Size:=FontSize;
      CountItems:=Ini.ReadInteger(Name+IntToStr(i+1),'CountItems',0);
      for j := 0 to CountItems-1 do
        ComboBox_.Items.Add(Ini.ReadString(Name+IntToStr(i+1),'Items'+IntToStr(j+1),'0'));
      ComboBox_.ItemIndex:=0;
      ListComboBoxs.Add(ComboBox_);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TInterfaceMenuCreate.OptionsDateTimePickers(AOwner: TForm; IniName,
  Name: string; count: integer);
var i:integer;
    DateTimePicker_:TDateTimePicker;
begin
  try
    Ini:=TIniFile.Create(Constant.GetDirectory+IniName);
    for i := 0 to count do
    begin
      DateTimePicker_:=TDateTimePicker.create(AOwner);
      DateTimePicker_.Left:=Ini.ReadInteger(Name+IntToStr(i+1),'Left',0);
      DateTimePicker_.Top:=Ini.ReadInteger(Name+IntToStr(i+1),'Top',0);
      DateTimePicker_.Width:=Ini.ReadInteger(Name+IntToStr(i+1),'Width',0);
      //DateTimePicker_.Kind:=(Ini.ReadString(Name+IntToStr(i+1),'Kind','0'));
      DateTimePicker_.Parent:= AOwner;
      DateTimePicker_.Font.Name:=FontName;
      DateTimePicker_.Font.Size:=FontSize;
      ListDateTimePickers.Add(DateTimePicker_);
    end;
  finally
    Ini.Free;
  end;
end;

end.
