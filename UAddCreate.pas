unit UAddCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, Data.DB, Data.Win.ADODB, Contnrs,
  Generics.Collections, UInterface,FileCtrl;

type

  TAddCreate = class(TInterfacedObject, TInterfaceMenuCreate)
  private
    Label1,Label2,Label3:TLabel;
    Label4,Label5,Label6:TLabel;
    Button1:TButton;
  public
    constructor create(AOwner: TForm);
    procedure destroy;
    procedure make;
  end;

implementation

{ TAddCreate }

uses UMain;

constructor TAddCreate.create(AOwner: TForm);
begin
  FMain.Caption:='Добавление';
  FMain.Height:=290;
  FMain.Width:=470;
  FMain.FileListBox1.Visible:=True;

  FMain.DBGrid1.Align:=alNone;
  FMain.DBGrid1.Left:=8;
  FMain.DBGrid1.Top:=143;
  FMain.DBGrid1.Height:=65;
  FMain.DBGrid1.Width:=438;

  Label1:=TLabel.create(AOwner);
  Label1.Left:=227;
  Label1.Top:=8;
  Label1.Parent:= AOwner;
  Label1.Font.Name:='Times New Roman';
  Label1.Font.Size:=11;
  Label1.Caption:='Номер выбранного файла:';

  Label2:=TLabel.create(AOwner);
  Label2.Left:=227;
  Label2.Top:=31;
  Label2.Parent:= AOwner;
  Label2.Font.Name:='Times New Roman';
  Label2.Font.Size:=11;
  Label2.Caption:='Количество строк в файле:';

  Label3:=TLabel.create(AOwner);
  Label3.Left:=227;
  Label3.Top:=54;
  Label3.Parent:= AOwner;
  Label3.Font.Name:='Times New Roman';
  Label3.Font.Size:=11;
  Label3.Caption:='Дата изменения:';

  Label4:=TLabel.create(AOwner);
  Label4.Left:=398;
  Label4.Top:=8;
  Label4.Parent:= AOwner;
  Label4.Font.Name:='Times New Roman';
  Label4.Font.Size:=11;
  Label4.Caption:='_-_-_';

  Label5:=TLabel.create(AOwner);
  Label5.Left:=398;
  Label5.Top:=31;
  Label5.Parent:= AOwner;
  Label5.Caption:='_-_-_';
  Label5.Font.Name:='Times New Roman';
  Label5.Font.Size:=11;

  Label6:=TLabel.create(AOwner);
  Label6.Left:=335;
  Label6.Top:=54;
  Label6.Parent:= AOwner;
  Label6.Font.Name:='Times New Roman';
  Label6.Font.Size:=11;
  Label6.Caption:='_-_-_-_-_-_-_-_-';//Label6.Caption:='05.11.2018 16:34';
  

  Button1:=TButton.create(AOwner);
  Button1.Left:=235;
  Button1.Top:=91;
  Button1.Height:=25;
  Button1.Width:=200;
  Button1.Parent:= AOwner;
  Button1.Font.Name:='Times New Roman';
  Button1.Font.Size:=11;
  Button1.Caption:='Добавить';

  //Button1.OnClick:=Button1Click;
  //AOwner.DBGrid1.TabOrder:=2;
  //все объекты первой формы/юнита(добавление)
end;

procedure TAddCreate.destroy;
begin
  Label1.Free;
  Label2.Free;
  Label3.Free;
  Label4.Free;
  Label5.Free;
  Label6.Free;
  Button1.Free;
  FMain.FileListBox1.Visible:=False;
end;

procedure TAddCreate.make;
begin

end;

end.
