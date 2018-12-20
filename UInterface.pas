unit UInterface;

interface

uses
  StdCtrls, Forms;

type
  TInterfaceMenuCreate = class
  public
    procedure destroy;virtual;abstract;
    procedure LabelCreate(AOwner:TForm; Left, Top:integer;
      Caption:String; var Label_:TLabel);
    procedure ButtonCreate(AOwner: TForm; Left,Top,Height,Width: integer;
      Caption: String; var Button_: TButton);
    procedure ComboBoxCreate(AOwner: TForm; Left,Top,Width: integer;
      var ComboBox_: TComboBox);
    procedure EditCreate(AOwner: TForm; Left, Top, Width: integer;
      var Edit_: TEdit);
  private
    fFileCreate: TInterfaceMenuCreate;
  end;

implementation

{ TInterfaceMenuCreate }

procedure TInterfaceMenuCreate.ButtonCreate(AOwner: TForm; Left, Top, Height,
  Width: integer; Caption: String; var Button_: TButton);
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

procedure TInterfaceMenuCreate.ComboBoxCreate(AOwner: TForm; Left, Top,
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

procedure TInterfaceMenuCreate.EditCreate(AOwner: TForm; Left, Top,
  Width: integer; var Edit_: TEdit);
begin
  Edit_:=TEdit.create(AOwner);
  Edit_.Left:=Left;
  Edit_.Top:=Top;
  Edit_.Width:=Width;
  Edit_.Parent:= AOwner;
  Edit_.Text:='';
  Edit_.Font.Name:='Times New Roman';
  Edit_.Font.Size:=11;
end;

procedure TInterfaceMenuCreate.LabelCreate(AOwner: TForm; Left, Top: integer;
  Caption: String; var Label_: TLabel);
begin
  Label_:=TLabel.create(AOwner);
  Label_.Left:=Left;
  Label_.Top:=Top;
  Label_.Parent:= AOwner;
  Label_.Font.Name:='Times New Roman';
  Label_.Font.Size:=11;
  Label_.Caption:=Caption;
end;

end.
