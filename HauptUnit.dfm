object Form1: TForm1
  Left = 956
  Top = 9
  Width = 765
  Height = 1020
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = a
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 32
    Top = 16
    Width = 441
    Height = 947
  end
  object Button1: TButton
    Left = 496
    Top = 88
    Width = 89
    Height = 25
    Caption = 'Magic Succeds'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MediaPlayer1: TMediaPlayer
    Left = 480
    Top = 904
    Width = 253
    Height = 30
    FileName = 'C:\Users\Agustin\Desktop\Proyecto 2.0\Perdiste.wav'
    Visible = False
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 488
    Top = 128
    Width = 249
    Height = 97
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'Viner Hand ITC'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object MediaPlayer2: TMediaPlayer
    Left = 480
    Top = 936
    Width = 57
    Height = 30
    VisibleButtons = [btPlay, btPause]
    FileName = 
      'C:\Users\Agustin\Desktop\Proyecto 2.0\8 Bit Relax instrumental.w' +
      'av'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 488
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Betr'#252'gen'
    TabOrder = 4
    Visible = False
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 568
    Top = 240
    Width = 41
    Height = 21
    TabOrder = 5
    Visible = False
  end
  object Edit2: TEdit
    Left = 544
    Top = 944
    Width = 185
    Height = 16
    Font.Charset = OEM_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Terminal'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'Game devs'
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = Timer1Timer
    Left = 504
    Top = 32
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer2Timer
    Left = 536
    Top = 32
  end
  object Timer3: TTimer
    OnTimer = Timer3Timer
    Left = 568
    Top = 32
  end
end
