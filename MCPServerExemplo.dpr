program MCPServerExemplo;

uses
  Vcl.Forms,
  ServerMain in 'ServerMain.pas' {FormServer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormServer, FormServer);
  Application.Run;
end.
