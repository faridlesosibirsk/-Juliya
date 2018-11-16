program Project1;



uses
  Vcl.Forms,
  USpravka in 'USpravka.pas' {FSpravka},
  USettings in 'USettings.pas' {FSettings},
  UDBConnection in 'UDBConnection.pas',
  UInterface in 'UInterface.pas',
  UAddCreate in 'UAddCreate.pas' {,
  UConstructor in 'UConstructor.'},
  UConstructor in 'UConstructor.pas' {FConstructor},
  UMain in 'UMain.pas' {FMain},
  URequestCreate in 'URequestCreate.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFSpravka, FSpravka);
  Application.CreateForm(TFSettings, FSettings);
  Application.CreateForm(TFConstructor, FConstructor);
  Application.Run;
end.
