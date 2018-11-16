object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'FMain'
  ClientHeight = 232
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 17
  object DBGrid1: TDBGrid
    Left = 8
    Top = 139
    Width = 438
    Height = 75
    TabOrder = 0
    TitleFont.Charset = RUSSIAN_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Times New Roman'
    TitleFont.Style = []
  end
  object FileListBox1: TFileListBox
    Left = 8
    Top = 8
    Width = 215
    Height = 125
    ItemHeight = 17
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 215
    Width = 454
    Height = 17
    Align = alBottom
    BevelOuter = bvSpace
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 376
    Top = 160
    object MSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = MSettingsClick
    end
    object AddFile: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
      OnClick = AddFileClick
    end
    object MRequest: TMenuItem
      Caption = #1047#1072#1087#1088#1086#1089#1099
      object MAllRecords: TMenuItem
        Caption = #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
        OnClick = MAllRecordsClick
      end
      object MRequestDate: TMenuItem
        Caption = #1055#1086' '#1076#1072#1090#1077' '#1080' '#1074#1088#1077#1084#1077#1085#1080
        OnClick = MRequestDateClick
      end
      object MStatusCall: TMenuItem
        Caption = #1057#1090#1072#1090#1091#1089' '#1079#1074#1086#1085#1082#1072
        OnClick = MStatusCallClick
      end
      object MTypeCall: TMenuItem
        Caption = #1058#1080#1087' '#1079#1074#1086#1085#1082#1072
        OnClick = MTypeCallClick
      end
      object MNumber: TMenuItem
        Caption = #1053#1086#1084#1077#1088
        OnClick = MNumberClick
      end
      object ConstructorRequests: TMenuItem
        Caption = #1050#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088
        OnClick = ConstructorRequestsClick
      end
    end
    object MHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      OnClick = MHelpClick
    end
  end
  object ADOQuery1: TADOQuery
    Connection = FSettings.ADOConnection1
    Parameters = <>
    Left = 32
    Top = 160
  end
  object DataSource1: TDataSource
    Left = 88
    Top = 160
  end
end
