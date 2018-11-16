unit USpravka;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFSpravka = class(TForm)
    Label2: TLabel;
    Button1: TButton;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSpravka: TFSpravka;

implementation

{$R *.dfm}

end.
