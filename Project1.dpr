program Project1;

uses
  Vcl.Forms,
  USpravka in 'USpravka.pas' {FSpravka},
  USettings in 'USettings\USettings.pas' {FSettings},
  UMain in 'UMain.pas' {FMain},
  UDBConnection in 'USettings\UDBConnection.pas',
  UInterface in 'UInterface.pas',
  UAddCreate in 'UAdd\UAddCreate.pas' {,
  UConstructor in 'UConstructor.'},
  UConstructor in 'UConstructor.pas' {FConstructor},
  URequestCreate in 'URequestCreate\URequestCreate.pas',
  URequestAllRecords in 'URequestCreate\URequestAllRecords.pas',
  URequestDate in 'URequestCreate\URequestDate.pas',
  URequestNumber in 'URequestCreate\URequestNumber.pas',
  URequestStatusCall in 'URequestCreate\URequestStatusCall.pas',
  URequestTypeCall in 'URequestCreate\URequestTypeCall.pas',
  UVarServer in 'USettings\UVarServer.pas',
  UFile in 'USettings\UFile.pas',
  UUpdateBase in 'UAdd\UUpdateBase.pas',
  UScript in 'USettings\UScript.pas',
  UObjectsCreate in 'UAdd\UObjectsCreate.pas';

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
