unit ServerMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  sdmcore, sdmtypes, sdmmcpserver;

const
  mtText = 0;

type
  TFormServer = class(TForm)
    sdmMCPServer1: TsdmMCPServer;
    lblEndpoint: TLabel;
    edtHost: TEdit;
    edtPort: TEdit;
    btnStart: TButton;
    btnStop: TButton;
    memLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure sdmMCPServer1Log(Sender: TObject; LogLevel: Integer;
      const Message, LogType: string);
    procedure sdmMCPServer1ToolRequest(Sender: TObject; ConnectionId: Integer;
      const Name, Description: string; var IsError: Boolean);
  private
    procedure Log(const AMessage: string);
    procedure RegisterTools;
    procedure StartServer;
    procedure StopServer;
  public
    { Public declarations }
  end;

var
  FormServer: TFormServer;

implementation

{$R *.dfm}

procedure TFormServer.FormCreate(Sender: TObject);
begin
  edtHost.Text := '127.0.0.1';
  edtPort.Text := '8765';
  RegisterTools;
  btnStop.Enabled := False;
end;

procedure TFormServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopServer;
end;

// Inicia o servidor e começa a escutar

procedure TFormServer.StartServer;
begin
  if sdmMCPServer1.Listening then
    Exit;

  sdmMCPServer1.Config('LogLevel=3');
  sdmMCPServer1.Transport := TsdmTTransports.ttHttp;
  sdmMCPServer1.ServerSettings.LocalHost := edtHost.Text;
  sdmMCPServer1.ServerSettings.LocalPort := StrToIntDef(edtPort.Text, 8765);
  sdmMCPServer1.SSLEnabled := False;
  sdmMCPServer1.StartListening;
  sdmMCPServer1.ProcessRequests;

  btnStart.Enabled := False;
  btnStop.Enabled := True;
  Log(Format('Servidor MCP ouvindo em http://%s:%s', [edtHost.Text, edtPort.Text]));
end;

// Registra as ferramentas do servidor MCP

procedure TFormServer.RegisterTools;
begin

  sdmMCPServer1.RegisterToolParam('text', 'Texto que sera retornado ao cliente.', True);
  sdmMCPServer1.RegisterTool('echo', 'Retorna o parametro de texto recebido do cliente MCP.');


  sdmMCPServer1.RegisterToolParam('a', 'Primeiro valor numerico.', True);
  sdmMCPServer1.RegisterToolParam('b', 'Segundo valor numerico.', True);
  sdmMCPServer1.RegisterTool('add_numbers', 'Soma dois valores numericos e retorna o resultado.');

  sdmMCPServer1.RegisterTool('server_time', 'Retorna a data e a hora atuais do servidor.');

end;

// Função geral para Logs com hora

procedure TFormServer.Log(const AMessage: string);
begin
  memLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + '  ' + AMessage);
end;

// Parar o servidor

procedure TFormServer.StopServer;
begin
  if not sdmMCPServer1.Listening then
    Exit;

  sdmMCPServer1.StopListening;
  btnStart.Enabled := True;
  btnStop.Enabled := False;
  Log('Servidor MCP parado.');
end;

procedure TFormServer.btnStartClick(Sender: TObject);
begin
  try
    StartServer;
  except
    on E: Exception do
      Log('Erro ao iniciar servidor: ' + E.Message);
  end;
end;

procedure TFormServer.btnStopClick(Sender: TObject);
begin
  try
    StopServer;
  except
    on E: Exception do
      Log('Erro ao parar servidor: ' + E.Message);
  end;
end;

procedure TFormServer.sdmMCPServer1Log(Sender: TObject; LogLevel: Integer;
  const Message, LogType: string);
begin
  Log(Format('[%s] %s', [LogType, Message]));
end;

// Tratamento de requisições para as ferramentas

procedure TFormServer.sdmMCPServer1ToolRequest(Sender: TObject;
  ConnectionId: Integer; const Name, Description: string; var IsError: Boolean);
var
  A: Double;
  B: Double;
  Text: string;
begin
  try
    if SameText(Name, 'echo') then
    begin
      Text := sdmMCPServer1.GetToolParamValue('text');
      sdmMCPServer1.AddToolMessage(mtText, 'Eco do servidor Delphi: ' + Text);
    end
    else if SameText(Name, 'add_numbers') then
    begin
      A := StrToFloatDef(sdmMCPServer1.GetToolParamValue('a'), 0);
      B := StrToFloatDef(sdmMCPServer1.GetToolParamValue('b'), 0);
      sdmMCPServer1.AddToolMessage(mtText, Format('%.2f + %.2f = %.2f', [A, B, A + B]));
    end
    else if SameText(Name, 'server_time') then
    begin
      sdmMCPServer1.AddToolMessage(mtText, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now));
    end
    else
    begin
      IsError := True;
      sdmMCPServer1.AddToolMessage(mtText, 'Ferramenta desconhecida: ' + Name);
    end;
  except
    on E: Exception do
    begin
      IsError := True;
      sdmMCPServer1.AddToolMessage(mtText, 'Erro no servidor: ' + E.Message);
    end;
  end;
end;

end.
