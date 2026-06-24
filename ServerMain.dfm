object FormServer: TFormServer
  Left = 0
  Top = 0
  Caption = 'Exemplo de Servidor MCP'
  ClientHeight = 441
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    760
    441)
  TextHeight = 15
  object lblEndpoint: TLabel
    Left = 16
    Top = 19
    Width = 48
    Height = 15
    Caption = 'Endpoint'
  end
  object edtHost: TEdit
    Left = 80
    Top = 16
    Width = 121
    Height = 23
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object edtPort: TEdit
    Left = 208
    Top = 16
    Width = 57
    Height = 23
    TabOrder = 1
    Text = '8765'
  end
  object btnStart: TButton
    Left = 280
    Top = 15
    Width = 82
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 2
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 368
    Top = 15
    Width = 82
    Height = 25
    Caption = 'Parar'
    TabOrder = 3
    OnClick = btnStopClick
  end
  object memLog: TMemo
    Left = 16
    Top = 56
    Width = 728
    Height = 369
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object sdmMCPServer1: TsdmMCPServer
    Request = ' '
    Response = ' '
    ServerSettingsAllowedAuthMethods = 'Anonymous,Basic,Digest,NTLM,Negotiate'
    SSLCertStore = 'MY'
    OnLog = sdmMCPServer1Log
    OnToolRequest = sdmMCPServer1ToolRequest
    Left = 48
    Top = 112
  end
end
