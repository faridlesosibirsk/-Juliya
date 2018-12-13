unit UObjectsCreate;

interface

uses
  stdCtrls,comctrls,Forms;

type
  TObjectsCreate = class
  private
  public
    procedure LabelCreate(AOwner:TForm; Left, Top:integer;
      Caption:String; var Label_:TLabel);
    procedure ButtonCreate(AOwner: TForm; Left,Top,Height,Width: integer;
      Caption: String; var Button_: TButton);
    procedure ComboBoxCreate(AOwner: TForm; Left,Top,Width: integer;
      var ComboBox_: TComboBox);
    procedure DateTimePickerCreate(AOwner: TForm; Left,Top,Width: integer;
      Kind:TDateTimeKind; var DateTimePicker_: TDateTimePicker);
    procedure EditCreate(AOwner: TForm; Left, Top, Width: integer;
      var Edit_: TEdit);
  end;

implementation

{ TObjectsCreate }

procedure TObjectsCreate.LabelCreate(AOwner: TForm;
  Left,Top: integer; Caption: String; var Label_: TLabel);
begin
  Label_:=TLabel.create(AOwner);
  Label_.Left:=Left;
  Label_.Top:=Top;
  Label_.Parent:= AOwner;
  Label_.Font.Name:='Times New Roman';
  Label_.Font.Size:=11;
  Label_.Caption:=Caption;
end;

procedure TObjectsCreate.ButtonCreate(AOwner: TForm; Left,Top,Height,Width: integer;
  Caption: String; var Button_: TButton);
begin
  Button_:=TButton.create(AOwner);
  Button_.Left:=Left;
  Button_.Top:=Top;
  Button_.Height:=Height;
  Button_.Width:=Width;
  Button_.Parent:= AOwner;
  Button_.Font.Name:='Times New Roman';
  Button_.Font.Size:=11;
  Button_.Caption:=Caption;
end;

procedure TObjectsCreate.ComboBoxCreate(AOwner: TForm; Left, Top,
  Width: integer; var ComboBox_: TComboBox);
begin
  ComboBox_:=TComboBox.create(AOwner);
  ComboBox_.Left:=Left;
  ComboBox_.Top:=Top;
  ComboBox_.Width:=Width;
  ComboBox_.Parent:= AOwner;
  ComboBox_.Style:=csDropDownList;
  ComboBox_.Font.Name:='Times New Roman';
  ComboBox_.Font.Size:=11;
end;

procedure TObjectsCreate.DateTimePickerCreate(AOwner: TForm; Left, Top,
  Width: integer; Kind:TDateTimeKind; var DateTimePicker_: TDateTimePicker);
begin
  DateTimePicker_:=TDateTimePicker.create(AOwner);
  DateTimePicker_.Left:=160;
  DateTimePicker_.Top:=8;
  DateTimePicker_.Width:=110;
  DateTimePicker_.Parent:= AOwner;
  DateTimePicker_.Kind:=Kind;
  DateTimePicker_.Font.Name:='Times New Roman';
  DateTimePicker_.Font.Size:=11;
end;

procedure TObjectsCreate.EditCreate(AOwner: TForm; Left, Top, Width: integer;
   var Edit_: TEdit);
begin
  Edit_:=TEdit.create(AOwner);
  Edit_.Left:=Left;
  Edit_.Top:=Top;    //72
  Edit_.Width:=Width;
  Edit_.Parent:= AOwner;
  Edit_.Text:='';
  Edit_.Font.Name:='Times New Roman';
  Edit_.Font.Size:=11;
end;

end.
