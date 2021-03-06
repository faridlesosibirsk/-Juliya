object FMain: TFMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'FMain'
  ClientHeight = 231
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object Memo1: TMemo
    Left = 8
    Top = 155
    Width = 438
    Height = 33
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 143
    Width = 548
    Height = 65
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = RUSSIAN_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Times New Roman'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 214
    Width = 564
    Height = 17
    Align = alBottom
    BevelOuter = bvSpace
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 376
    Top = 160
    object MSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = MSettingsClick
    end
    object MAddFile: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
      OnClick = MAddFileClick
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
    Parameters = <>
    Left = 32
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 88
    Top = 160
  end
end
