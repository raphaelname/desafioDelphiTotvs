object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta CEP'
  ClientHeight = 258
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Position = poScreenCenter
  TextHeight = 15
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 624
    Height = 258
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'CEP'
      object gbxPesquisa: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 610
        Height = 45
        Align = alTop
        TabOrder = 0
        object medtCEP: TMaskEdit
          Left = 10
          Top = 10
          Width = 116
          Height = 23
          EditMask = '!99999-999;0; '
          MaxLength = 9
          TabOrder = 0
          Text = ''
        end
        object Button1: TButton
          Left = 132
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 1
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 51
        Width = 616
        Height = 177
        Align = alClient
        Caption = 'Resultado '
        TabOrder = 1
        object ledtLogradouro: TLabeledEdit
          Left = 13
          Top = 42
          Width = 287
          Height = 23
          EditLabel.Width = 62
          EditLabel.Height = 15
          EditLabel.Caption = 'Logradouro'
          TabOrder = 0
          Text = ''
        end
        object ledtBairro: TLabeledEdit
          Left = 315
          Top = 42
          Width = 287
          Height = 23
          EditLabel.Width = 31
          EditLabel.Height = 15
          EditLabel.Caption = 'Bairro'
          TabOrder = 1
          Text = ''
        end
        object ledtCidade: TLabeledEdit
          Left = 13
          Top = 88
          Width = 215
          Height = 23
          EditLabel.Width = 37
          EditLabel.Height = 15
          EditLabel.Caption = 'Cidade'
          TabOrder = 2
          Text = ''
        end
        object ledtUF: TLabeledEdit
          Left = 250
          Top = 88
          Width = 100
          Height = 23
          EditLabel.Width = 14
          EditLabel.Height = 15
          EditLabel.Caption = 'UF'
          TabOrder = 3
          Text = ''
        end
        object ledtIBGE: TLabeledEdit
          Left = 379
          Top = 88
          Width = 100
          Height = 23
          EditLabel.Width = 24
          EditLabel.Height = 15
          EditLabel.Caption = 'IBGE'
          TabOrder = 4
          Text = ''
        end
        object ledtDDD: TLabeledEdit
          Left = 502
          Top = 88
          Width = 100
          Height = 23
          EditLabel.Width = 24
          EditLabel.Height = 15
          EditLabel.Caption = 'DDD'
          TabOrder = 5
          Text = ''
        end
        object ledtOrigem: TLabeledEdit
          Left = 13
          Top = 136
          Width = 222
          Height = 23
          EditLabel.Width = 40
          EditLabel.Height = 15
          EditLabel.Caption = 'Origem'
          TabOrder = 6
          Text = ''
        end
        object ledtURL: TLabeledEdit
          Left = 250
          Top = 136
          Width = 352
          Height = 23
          EditLabel.Width = 21
          EditLabel.Height = 15
          EditLabel.Caption = 'URL'
          TabOrder = 7
          Text = ''
        end
      end
    end
  end
end
