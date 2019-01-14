unit UMain;

interface

uses
  Vcl.Controls, Vcl.Grids, System.Classes, Forms, Menus,
  StdCtrls, DBGrids, Data.DB, Data.Win.ADODB,  ExtCtrls,
  UInterface, UAddCreate, UConstructor, UHelp, USettings,
  URequestAllRecords, URequestDate, URequestStatusCall, URequestTypeCall,
  URequestNumber, sSkinManager;

type
  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    MAddFile, MRequest, MRequestDate,
    ConstructorRequests, MSettings,
    MHelp, MAllRecords, MStatusCall,
    MTypeCall, MNumber: TMenuItem;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Memo1: TMemo;
    procedure MAddFileClick(Sender: TObject);
    procedure MSettingsClick(Sender: TObject);
    procedure MHelpClick(Sender: TObject);
    procedure MRequestDateClick(Sender: TObject);
    procedure ConstructorRequestsClick(Sender: TObject);
    procedure MAllRecordsClick(Sender: TObject);
    procedure MStatusCallClick(Sender: TObject);
    procedure MTypeCallClick(Sender: TObject);
    procedure MNumberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetTitleDBGrid;
  private
    /// <link>aggregation</link>
    fFileCreate: TInterfaceMenuCreate;
  end;

var
  FMain: TFMain;
  SelectMenu:integer;

implementation

{$R *.dfm}

{ TFMain }

procedure TFMain.FormCreate(Sender: TObject);
begin
  fFileCreate:=TAddCreate.create(FMain);
  SelectMenu:=1;
  MSettings.Enabled:=True;
end;

procedure TFMain.MAddFileClick(Sender: TObject);
begin
  if SelectMenu<>1 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TAddCreate.create(self);
    Caption:=MAddFile.Caption;
    SelectMenu:=1;
    MSettings.Enabled:=True;
  end;
end;

procedure TFMain.MAllRecordsClick(Sender: TObject);
begin
  if SelectMenu<>2 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestAllRecords.create(self);
    SelectMenu:=2;
    MSettings.Enabled:=False;
  end;
end;

procedure TFMain.MRequestDateClick(Sender: TObject);
begin
  if SelectMenu<>3 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestDate.create(self);
    SelectMenu:=3;
    MSettings.Enabled:=False;
  end;
end;

procedure TFMain.MStatusCallClick(Sender: TObject);
begin
  if SelectMenu<>4 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestStatusCall.create(self);
    SelectMenu:=4;
    MSettings.Enabled:=False;
  end;
end;

procedure TFMain.MTypeCallClick(Sender: TObject);
begin
  if SelectMenu<>5 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestTypeCall.create(self);
    SelectMenu:=5;
    MSettings.Enabled:=False;
  end;
end;

procedure TFMain.SetTitleDBGrid;
begin
  DBGrid1.Columns[0].Title.Caption:='№';
  DBGrid1.Columns[1].Title.Caption:='Дата';
  DBGrid1.Columns[2].Title.Caption:='Время';
  DBGrid1.Columns[3].Title.Caption:='Длительность';
  DBGrid1.Columns[4].Title.Caption:='Статус звонка';
  DBGrid1.Columns[5].Title.Caption:='Тип звонка';
  DBGrid1.Columns[6].Title.Caption:='Код';
  DBGrid1.Columns[7].Title.Caption:='Городской номер';
  DBGrid1.Columns[8].Title.Caption:='Внутренний номер';
end;

procedure TFMain.MNumberClick(Sender: TObject);
begin
  if SelectMenu<>6 then
  begin
    fFileCreate.destroy;
    fFileCreate:=TRequestNumber.create(self);
    SelectMenu:=6;
    MSettings.Enabled:=False;
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
  FHelp.ShowModal;
end;

end.
