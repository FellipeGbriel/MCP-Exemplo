unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  sdmcore, sdmtypes, sdmmcpclient;

type
  TForm1 = class(TForm)
    sdmMCPClient1: TsdmMCPClient;
    lblUrl: TLabel;
    edtUrl: TEdit;
    btnConnect: TButton;
    btnListTools: TButton;
    btnEcho: TButton;
    btnAdd: TButton;
    btnDisconnect: TButton;
    memLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnListToolsClick(Sender: TObject);
    procedure btnEchoClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure sdmMCPClient1Connected(Sender: TObject; StatusCode: Integer;
      const Description: string);
  private
    procedure ConfigureClient;
    procedure Log(const AMessage: string);
    procedure LogTools;
    procedure LogToolMessages;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  edtUrl.Text := 'http://127.0.0.1:8765';
  Log('Execute o projeto MCPServerExample e clique em Conectar.');
end;

// Configura o cliente, coloca a conexão como HTTP e usa a URL do Edit

procedure TForm1.ConfigureClient;
begin
  sdmMCPClient1.Transport := TsdmTTransports.ttHttp;
  sdmMCPClient1.URL := edtUrl.Text;
  sdmMCPClient1.Timeout := 30;
end;

// Função para logs com hora

procedure TForm1.Log(const AMessage: string);
begin
  memLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + '  ' + AMessage);
end;

//Pega as ferramentas do servidor com ToolCount

procedure TForm1.LogTools;
var
  I: Integer;
begin

  ShowMessage('ToolCount: ' + IntToStr(sdmMCPClient1.ToolCount));
  if sdmMCPClient1.ToolCount = 0 then
  begin
    Log('Nenhuma ferramenta retornada pelo servidor.');
    Exit;
  end;

  Log('Ferramentas disponiveis:');
  for I := 0 to sdmMCPClient1.ToolCount - 1 do
    Log(Format('  %s - %s', [sdmMCPClient1.ToolName[I], sdmMCPClient1.ToolDescription[I]]));
end;

// Pega o retorno das ferramentas

procedure TForm1.LogToolMessages;
var
  I: Integer;
begin
  if sdmMCPClient1.ToolMessageCount = 0 then
  begin
    Log('A ferramenta nao retornou mensagens.');
    Exit;
  end;

  for I := 0 to sdmMCPClient1.ToolMessageCount - 1 do
    Log('Ferramenta: ' + sdmMCPClient1.ToolMessageValue[I]);
end;

// Conexão

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  try
    ConfigureClient;
    sdmMCPClient1.Connect;
    Log('Conectado em ' + edtUrl.Text);
  except
    on E: Exception do
      Log('Erro ao conectar: ' + E.Message);
  end;
end;

procedure TForm1.btnListToolsClick(Sender: TObject);
begin
  try
    sdmMCPClient1.ListTools;
    LogTools;
  except
    on E: Exception do
      Log('Erro ao listar ferramentas: ' + E.Message);
  end;
end;

// teste das duas ferramentas (Eco e Soma), adiciona os parâmetros e chama a ferramenta

procedure TForm1.btnEchoClick(Sender: TObject);
begin
  try
    sdmMCPClient1.AddToolParam('text', 'Mensagem enviada pelo cliente Delphi');
    sdmMCPClient1.InvokeTool('echo');
    LogToolMessages;
  except
    on E: Exception do
      Log('Erro ao chamar eco: ' + E.Message);
  end;
end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  try
    sdmMCPClient1.AddToolParam('a', '21');
    sdmMCPClient1.AddToolParam('b', '21');
    sdmMCPClient1.InvokeTool('add_numbers');
    LogToolMessages;
  except
    on E: Exception do
      Log('Erro ao chamar soma: ' + E.Message);
  end;
end;

procedure TForm1.btnDisconnectClick(Sender: TObject);
begin
  try
    sdmMCPClient1.Disconnect;
    Log('Desconectado.');
  except
    on E: Exception do
      Log('Erro ao desconectar: ' + E.Message);
  end;
end;

procedure TForm1.sdmMCPClient1Connected(Sender: TObject; StatusCode: Integer;
  const Description: string);
begin
  Log(Format('Evento AoConectar: %d %s', [StatusCode, Description]));
end;

end.
