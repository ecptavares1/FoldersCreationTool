program FCT;

uses
  Vcl.Forms,
  fct.view.main in '..\FORMS\fct.view.main.pas' {Form1},
  fct.controller.main in '..\FORMS\fct.controller.main.pas',
  fct.controller.interfaces in '..\FORMS\fct.controller.interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
