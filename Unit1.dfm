object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 423
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 312
    Width = 513
    Height = 89
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 24
    Top = 8
    Width = 641
    Height = 21
    TabOrder = 1
    Text = 
      'https://script.google.com/macros/s/AKfycbxEGXsT0ExFMwkoSZ0bTIn7W' +
      '0JcpY06Cy_xjzv1XGNw2Cfo4Wlv/exec'
  end
  object btnAPI_Get: TButton
    Left = 671
    Top = 8
    Width = 75
    Height = 25
    Caption = 'GET'
    TabOrder = 2
    OnClick = btnAPI_GetClick
  end
  object DBGridEh1: TDBGridEh
    Left = 24
    Top = 73
    Width = 513
    Height = 233
    AllowedOperations = []
    DataSource = DataSource1
    DynProps = <>
    TabOrder = 3
    OnGetCellParams = DBGridEh1GetCellParams
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'LASTNAME'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'TEL'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'PAID'
        Footers = <>
      end
      item
        CellButtons = <>
        Color = 16774094
        DynProps = <>
        EditButtons = <>
        FieldName = 'DBACTION'
        Footers = <>
        ReadOnly = True
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object btnAPI_PostAll: TButton
    Left = 759
    Top = 8
    Width = 114
    Height = 25
    Caption = 'Apply Update All'
    TabOrder = 4
    OnClick = btnAPI_PostAllClick
  end
  object btnDataDelete: TButton
    Left = 186
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = btnDataDeleteClick
  end
  object btnDataNew: TButton
    Left = 24
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Append'
    TabOrder = 6
    OnClick = btnDataNewClick
  end
  object btnDataEdit: TButton
    Left = 105
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 7
    OnClick = btnDataEditClick
  end
  object btnDataPost: TButton
    Left = 462
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 8
    OnClick = btnDataPostClick
  end
  object btnDataCancel: TButton
    Left = 381
    Top = 42
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 9
    OnClick = btnDataCancelClick
  end
  object Button1: TButton
    Left = 879
    Top = 11
    Width = 75
    Height = 25
    Caption = 'Save to file '
    TabOrder = 10
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 759
    Top = 39
    Width = 114
    Height = 25
    Caption = 'Apply Update'
    TabOrder = 11
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 879
    Top = 42
    Width = 75
    Height = 25
    Caption = 'load from file'
    TabOrder = 12
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 543
    Top = 39
    Width = 122
    Height = 25
    Caption = 'POST Json'
    TabOrder = 13
    OnClick = Button4Click
  end
  object PageControl1: TPageControl
    Left = 543
    Top = 73
    Width = 447
    Height = 328
    ActivePage = TabSheet1
    TabOrder = 14
    object TabSheet1: TTabSheet
      Caption = 'HTML'
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 439
        Height = 300
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 447
        ExplicitHeight = 328
        ControlData = {
          4C0000005F2D0000021F00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'JSon'
      ImageIndex = 1
      object mmscript: TMemo
        Left = 0
        Top = 0
        Width = 439
        Height = 300
        Align = alClient
        Lines.Strings = (
          #39'{  '
          
            #9'"responseId": "93992093-69ff-40ac-87d4-cfc59e39f156-7b37ebd7", ' +
            ' '
          #9'"queryResult": {    '
          #9#9#9'"queryText": "'#3618#3639#3609#3618#3633#3609'",    '
          #9#9#9'"action": ".-request_booking-followup.assign_data-'
          'followup.confirmbooking",    '
          #9#9#9'"parameters": {    },    '
          #9#9#9'"allRequiredParamsPresent": true,    '
          
            #9#9#9'"fulfillmentMessages": [{"text": {"text": [""]      }    }], ' +
            ' '
          '  '
          #9#9
          #9#9'    "outputContexts": [{      '
          #9#9#9'"name": "projects/perfectbot-'
          'efrn/agent/sessions/aab6f40a-2ea8-35a1-9f63-'
          '85793ece6f95/contexts/assign_data-followup",      '
          #9#9#9'"parameters": {        '
          #9#9#9#9#9#9'"anyname": "'#3588#3621#3634#3626#3595#3640#3617
          #3610#3657#3634'",        '
          #9#9#9#9'"anyname.original": "'#3588#3621#3634#3626#3595#3640#3617#3610#3657#3634'",        '
          #9#9#9#9#9#9'"bookdate": "2020-09-'
          '17T12:00:00+07:00",        '
          #9#9#9#9'"bookdate.original": "17/9/2020",        '
          #9#9#9#9#9#9'"booktime": "2020-09-'
          '18T17:00:00+07:00",        '
          #9#9#9#9'"booktime.original": "17:00"      }'
          #9#9#9#9'}, '
          #9#9#9#9
          #9#9#9#9'{      '
          #9#9#9#9'"name": "projects/perfectbot-'
          'efrn/agent/sessions/aab6f40a-2ea8-35a1-9f63-'
          '85793ece6f95/contexts/__system_counters__",      '
          #9#9#9#9'"parameters": {        "no-input": 0.0,        '
          '"no-match": 0.0      }    }],    '
          #9#9#9'"intent": {      "name": "projects/perfectbot-'
          'efrn/agent/intents/8df5ad66-3da4-46bc-aca6-a5f41a3f9fa8",      '
          #9#9#9#9'            "displayName": "confirmbooking"    }, '
          '   '
          #9#9#9'"intentDetectionConfidence": 1.0,    '
          #9#9#9'"languageCode": "th"  },  '
          #9#9#9#9
          #9#9#9'"originalDetectIntentRequest": {    '
          #9#9#9#9'"source": "line",    '
          #9#9#9#9'"payload": {      '
          #9#9#9#9'"data": {        '
          #9#9#9#9'"type": "message",        '
          #9#9#9#9'"source": {          '
          #9#9#9#9#9#9#9'"userId": '
          '"Ue93b1115d7c3b3859d50c119c5f619e6",          '
          #9#9#9#9#9#9#9'"type": "user"  '
          '      },        '
          #9#9#9#9#9#9#9'"timestamp": '
          '"1600338950612",        '
          #9#9#9#9#9#9#9'"replyToken": '
          '"d59e87fd139c4f35924238c720ba1472",        '
          #9#9#9#9'"message": {          '
          #9#9#9#9#9#9#9#9#9
          '"id": "12695449045074",          '
          #9#9#9#9#9#9#9#9#9
          '"text": "'#3618#3639#3609#3618#3633#3609'",          '
          #9#9#9#9#9#9#9#9#9
          '"type": "text"        }      }    }  },  '
          #9#9#9#9'"session": "projects/perfectbot-'
          'efrn/agent/sessions/aab6f40a-2ea8-35a1-9f63-85793ece6f95"}'#39)
        TabOrder = 0
      end
    end
  end
  object WrpAPI1: TWrpAPI
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = 'application/json'
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.Host = '127.0.0.1'
    Request.UserAgent = 
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KH' +
      'TML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    API_Host = '127.0.0.1'
    API_UserAgent = 
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KH' +
      'TML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
    OnHostResponse = WrpAPI1HostResponse
    Left = 376
    Top = 96
  end
  object FDMemTable1: TFDMemTable
    BeforePost = FDMemTable1BeforePost
    AfterDelete = FDMemTable1AfterDelete
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 80
    Top = 184
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDMemTable1
    Left = 216
    Top = 248
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 80
    Top = 248
  end
end
