unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids,Data.DB, Data.Win.ADODB, Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.ComCtrls,
  UInterface, UAddCreate,UConstructor,USpravka, USettings,
  URequestAllRecords,URequestDate,URequestStatusCall,URequestTypeCall,
  URequestNumber,UVarServer,UFile;

type
  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    AddFile, MRequest, MRequestDate,
    ConstructorRequests, MSettings,
    MHelp, MAllRecords, MStatusCall,
    MTypeCall, MNumber: TMenuItem;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    FileListBox1: TFileListBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Memo1: TMemo;
    procedure AddFileClick(Sender: TObject);
    procedure MSettingsClick(Sender: TObject);
    procedure MHelpClick(Sender: TObject);
    procedure MRequestDateClick(Sender: TObject);
    procedure ConstructorRequestsClick(Sender: TObject);
    procedure MAllRecordsClick(Sender: TObject);
    procedure MStatusCallClick(Sender: TObject);
    procedure MTypeCallClick(Sender: TObject);
    procedure MNumberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FileListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fFileCreate: TInterfaceMenuCreate;
    SelectMenu:integer;
  end;

var
  FMain: TFMain;
  NameServer:TNameServer;
  File1:TFile;

implementation

{$R *.dfm}

{ TFMain }

procedure TFMain.FileListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var a,b,c:string;
begin
  if FileListBox1.Count<>0 then
    if (key=VK_LEFT)or(key=VK_RIGHT)or(key=VK_UP)or(key=VK_DOWN)
    then File1.NumberFile(NameServer.Getpath+
      FMain.FileListBox1.Items[FMain.FileListBox1.ItemIndex],a,b,c);
end;

procedure TFMain.FileListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a,b,c:string;
  begin
  if FileListBox1.Count<>0
  then File1.NumberFile(NameServer.Getpath+
      FMain.FileListBox1.Items[FMain.FileListBox1.ItemIndex],a,b,c);
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  fFileCreate:=TAddCreate.create(FMain);
end;

procedure TFMain.AddFileClick(Sender: TObject);
begin
  if SelectMenu<>1 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TAddCreate.create(self);
    Caption:=AddFile.Caption;
    SelectMenu:=1;
  end;
end;

procedure TFMain.MAllRecordsClick(Sender: TObject);
begin
  if SelectMenu<>2 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestAllRecords.create(self);
    SelectMenu:=2;
  end;
end;

procedure TFMain.MRequestDateClick(Sender: TObject);
begin
  if SelectMenu<>3 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestDate.create(self);
    SelectMenu:=3;
  end;
end;

procedure TFMain.MStatusCallClick(Sender: TObject);
begin
  if SelectMenu<>4 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestStatusCall.create(self);
    SelectMenu:=4;
  end;
end;

procedure TFMain.MTypeCallClick(Sender: TObject);
begin
  if SelectMenu<>5 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestTypeCall.create(self);
    SelectMenu:=5;
  end;
end;

procedure TFMain.MNumberClick(Sender: TObject);
begin
  if SelectMenu<>6 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestNumber.create(self);
    SelectMenu:=6;
  end;
end;

procedure TFMain.ConstructorRequestsClick(Sender: TObject);
begin
  FConstructor.ShowModal;
end;

procedure TFMain.MSettingsClick(Sender: TObject);
begin
  FSettings.ShowModal;
end;

procedure TFMain.MHelpClick(Sender: TObject);
begin
  FSpravka.ShowModal;
end;

end.
