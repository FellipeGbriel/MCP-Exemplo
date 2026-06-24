object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de Cliente MCP'
  ClientHeight = 441
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    760
    441)
  TextHeight = 15
  object lblUrl: TLabel
    Left = 16
    Top = 19
    Width = 21
    Height = 15
    Caption = 'URL'
  end
  object edtUrl: TEdit
    Left = 48
    Top = 16
    Width = 313
    Height = 23
    TabOrder = 0
    Text = 'http://127.0.0.1:8765'
  end
  object btnConnect: TButton
    Left = 376
    Top = 15
    Width = 82
    Height = 25
    Caption = 'Conectar'
    TabOrder = 1
    OnClick = btnConnectClick
  end
  object btnListTools: TButton
    Left = 464
    Top = 15
    Width = 82
    Height = 25
    Caption = 'Listar'
    TabOrder = 2
    OnClick = btnListToolsClick
  end
  object btnEcho: TButton
    Left = 552
    Top = 15
    Width = 82
    Height = 25
    Caption = 'Eco'
    TabOrder = 3
    OnClick = btnEchoClick
  end
  object btnAdd: TButton
    Left = 640
    Top = 15
    Width = 50
    Height = 25
    Caption = 'Somar'
    TabOrder = 4
    OnClick = btnAddClick
  end
  object btnDisconnect: TButton
    Left = 696
    Top = 15
    Width = 50
    Height = 25
    Caption = 'Parar'
    TabOrder = 5
    OnClick = btnDisconnectClick
  end
  object memLog: TMemo
    Left = 16
    Top = 56
    Width = 728
    Height = 369
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object sdmMCPClient1: TsdmMCPClient
    SSLAcceptServerCertStore = 'MY'
    SSLCertStore = 'MY'
    OnConnected = sdmMCPClient1Connected
    Left = 48
    Top = 112
  end
end
