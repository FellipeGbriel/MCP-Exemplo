# Exemplo MCP em Delphi

Projeto de exemplo para demonstrar o uso de MCP (Model Context Protocol) com Delphi/RAD Studio, contendo um cliente e um servidor no mesmo grupo de projetos.

## Estrutura

- `ExemploMCP.groupproj`: grupo com os dois projetos do exemplo.
- `MCPServerExemplo.dproj`: servidor MCP VCL.
- `MCPClient.dproj`: cliente MCP VCL.
- `ServerMain.pas` / `ServerMain.dfm`: formulario principal do servidor.
- `Unit1.pas` / `Unit1.dfm`: formulario principal do cliente.

## O que o exemplo faz

O servidor MCP escuta via HTTP em `127.0.0.1:8765` e registra ferramentas simples:

- `echo`: retorna ao cliente o texto recebido.
- `add_numbers`: soma dois valores numericos.
- `server_time`: retorna a data e hora atuais do servidor.

O cliente MCP conecta no endpoint do servidor, lista as ferramentas disponiveis e chama as ferramentas de exemplo.

## Requisitos

- RAD Studio/Delphi com suporte a VCL.
- SDK/componentes MCP usados pelo projeto, incluindo as units:
  - `sdmcore`
  - `sdmtypes`
  - `sdmmcpclient`
  - `sdmmcpserver`

## Como executar

1. Abra `ExemploMCP.groupproj` no RAD Studio.
2. Compile os projetos `MCPServerExemplo` e `MCPClient`.
3. Execute primeiro o `MCPServerExemplo`.
4. No servidor, confirme o host `127.0.0.1` e a porta `8765`, depois clique em iniciar.
5. Execute o `MCPClient`.
6. No cliente, use a URL `http://127.0.0.1:8765` e clique em conectar.
7. Use os botoes do cliente para listar ferramentas e testar `echo` e `add_numbers`.

## Observacoes

- O exemplo usa transporte HTTP sem SSL.
- Os arquivos de build e arquivos locais do RAD Studio nao devem ser versionados.
- Se a porta `8765` estiver em uso, altere a porta no servidor e atualize a URL no cliente.
