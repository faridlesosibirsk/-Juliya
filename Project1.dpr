program Project1;

uses
  Vcl.Forms,
  USpravka in 'USpravka.pas' {FSpravka},
  USettings in 'USettings.pas' {FSettings},
  UMain in 'UMain.pas' {FMain},
  UDBConnection in 'UDBConnection.pas',
  UInterface in 'UInterface.pas',
  UAddCreate in 'UAddCreate.pas' {,
  UConstructor in 'UConstructor.'},
  UConstructor in 'UConstructor.pas' {FConstructor},
  URequestCreate in 'URequestCreate\URequestCreate.pas',
  URequestAllRecords in 'URequestCreate\URequestAllRecords.pas',
  URequestDate in 'URequestCreate\URequestDate.pas',
  URequestNumber in 'URequestCreate\URequestNumber.pas',
  URequestStatusCall in 'URequestCreate\URequestStatusCall.pas',
  URequestTypeCall in 'URequestCreate\URequestTypeCall.pas',
  UVarServer in 'UVarServer.pas',
  UFile in 'UFile.pas',
  UUpdateBase in 'UUpdateBase.pas',
  UScript in 'UScript.pas';

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
