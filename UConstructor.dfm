object FConstructor: TFConstructor
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1050#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088' '#1079#1072#1087#1088#1086#1089#1086#1074
  ClientHeight = 520
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 345
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 35
      Height = 19
      Caption = #1044#1072#1090#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 264
      Top = 12
      Width = 50
      Height = 19
      Caption = 'Label10'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 264
      Top = 46
      Width = 50
      Height = 19
      Caption = 'Label10'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 46
      Width = 45
      Height = 19
      Caption = #1042#1088#1077#1084#1103':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 81
      Width = 98
      Height = 19
      Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 116
      Width = 98
      Height = 19
      Caption = #1057#1090#1072#1090#1091#1089' '#1079#1074#1086#1085#1082#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 282
      Top = 116
      Width = 79
      Height = 19
      Caption = #1058#1080#1087' '#1079#1074#1086#1085#1082#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 16
      Top = 154
      Width = 86
      Height = 19
      Caption = #1050#1086#1076' '#1076#1086#1089#1090#1091#1087#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 16
      Top = 197
      Width = 168
      Height = 38
      Caption = #1043#1086#1088#1086#1076#1089#1082#1086#1081' / '#1074#1085#1091#1090#1088#1077#1085#1085#1080#1081' '#1085#1086#1084#1077#1088':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label8: TLabel
      Left = 16
      Top = 245
      Width = 167
      Height = 19
      Caption = #1042#1085#1091#1090#1088#1077#1085#1085#1080#1081' '#1085#1086#1084#1077#1088' '#1040#1058#1057':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label9: TLabel
      Left = 16
      Top = 282
      Width = 105
      Height = 19
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1087#1086':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 8
      Width = 130
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox1Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1086#1076#1080#1085' '#1076#1077#1085#1100
        #1087#1077#1088#1080#1086#1076' '#1089' _ '#1076#1086' _')
    end
    object ComboBox2: TComboBox
      Left = 120
      Top = 43
      Width = 130
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox2Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1087#1077#1088#1080#1086#1076' '#1089' _ '#1076#1086' _')
    end
    object ComboBox3: TComboBox
      Left = 120
      Top = 76
      Width = 130
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox3Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1074#1072#1078#1085#1086)
    end
    object ComboBox4: TComboBox
      Left = 120
      Top = 113
      Width = 130
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 3
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox4Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1074#1093#1086#1076#1103#1097#1080#1081
        #1080#1089#1093#1086#1076#1103#1097#1080#1081
        #1076#1088#1091#1075#1080#1077
        #1076#1088#1091#1075#1080#1077' A'
        #1076#1088#1091#1075#1080#1077' C'
        #1076#1088#1091#1075#1080#1077' 4'
        #1085#1079)
    end
    object ComboBox5: TComboBox
      Left = 426
      Top = 113
      Width = 120
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 4
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1074#1093#1086#1076#1103#1097#1080#1081
        #1083#1086#1082#1072#1083#1100#1085#1099#1081
        #1084#1077#1078#1075#1086#1088#1086#1076
        #1089#1087#1077#1094#1085#1086#1084#1077#1088
        #1074#1085#1091#1090#1088#1080#1074#1077#1076
        #1076#1088#1091#1075#1080#1077
        #1076#1088#1091#1075#1080#1077' 0'
        #1076#1088#1091#1075#1080#1077' '#1074#1093
        #1076#1088#1091#1075#1080#1077' '#1080#1089
        #1076#1088#1091#1075#1080#1077' 4'
        #1085#1077#1086#1073#1088#1072#1073)
    end
    object ComboBox6: TComboBox
      Left = 120
      Top = 151
      Width = 130
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 5
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox6Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1074#1072#1078#1085#1086)
    end
    object ComboBox7: TComboBox
      Left = 223
      Top = 194
      Width = 120
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 6
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox7Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1074#1072#1078#1085#1086)
    end
    object ComboBox8: TComboBox
      Left = 223
      Top = 242
      Width = 120
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 7
      Text = #1085#1077' '#1074#1072#1078#1085#1086
      OnChange = ComboBox8Change
      Items.Strings = (
        #1085#1077' '#1074#1072#1078#1085#1086
        #1074#1072#1078#1085#1086)
    end
    object ComboBox9: TComboBox
      Left = 128
      Top = 279
      Width = 120
      Height = 27
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 8
      Text = #1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
      Items.Strings = (
        #1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
        #1091#1073#1099#1074#1072#1085#1080#1102)
    end
    object DateTimePicker1: TDateTimePicker
      Left = 282
      Top = 8
      Width = 121
      Height = 27
      Date = 43300.534531145840000000
      Time = 43300.534531145840000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object DateTimePicker2: TDateTimePicker
      Left = 425
      Top = 8
      Width = 121
      Height = 27
      Date = 43300.534531145840000000
      Time = 43300.534531145840000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object DateTimePicker3: TDateTimePicker
      Left = 282
      Top = 43
      Width = 121
      Height = 27
      Date = 43300.000000000000000000
      Time = 43300.000000000000000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      TabOrder = 11
    end
    object DateTimePicker4: TDateTimePicker
      Left = 425
      Top = 43
      Width = 121
      Height = 27
      Date = 43300.000000000000000000
      Time = 43300.000000000000000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      TabOrder = 12
    end
    object Edit1: TEdit
      Left = 282
      Top = 78
      Width = 121
      Height = 27
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnKeyPress = Edit1KeyPress
    end
    object Edit2: TEdit
      Left = 282
      Top = 151
      Width = 121
      Height = 27
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnKeyPress = Edit1KeyPress
    end
    object Edit3: TEdit
      Left = 407
      Top = 194
      Width = 121
      Height = 27
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object Edit4: TEdit
      Left = 407
      Top = 242
      Width = 121
      Height = 27
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
    end
    object Panel1: TPanel
      Left = 0
      Top = 312
      Width = 550
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 17
      object Button1: TButton
        Left = 0
        Top = 0
        Width = 264
        Height = 33
        Align = alClient
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 264
        Top = 0
        Width = 286
        Height = 33
        Align = alRight
        Caption = #1042#1099#1074#1086#1076' '#1079#1072#1087#1088#1086#1089#1072' '#1074' '#1092#1072#1081#1083
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 345
    Width = 550
    Height = 157
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 550
      Height = 157
      DataSource = DataSource1
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clDefault
      TitleFont.Height = -16
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = []
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 502
    Width = 550
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Label12: TLabel
      Left = 546
      Top = 0
      Width = 4
      Height = 18
      Align = alRight
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 19
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 546
      Height = 18
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object ADOQuery1: TADOQuery
    Connection = FSettings.ADOConnection1
    Parameters = <>
    Left = 31
    Top = 357
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 87
    Top = 357
  end
end
