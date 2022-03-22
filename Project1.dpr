program Project1;

uses
  Forms,
  HauptUnit in 'HauptUnit.pas' {Form1},
  UPiezas in 'UPiezas.pas',
  UR in 'UR.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
