unit HauptUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UPiezas, UR, MPlayer;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    Button1: TButton;
    MediaPlayer1: TMediaPlayer;
    Memo1: TMemo;
    Timer3: TTimer;
    MediaPlayer2: TMediaPlayer;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure a(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer3Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const Reihe=15;
const Spalte=21;

var
    Spiel:TSpiel;
    ErsteMove:boolean;
    PieceKind,x,y,Ergebnis:integer;
    MeisterFarbe:TColor;

procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;
begin
{Initialize graphic interface}
  MapGespawn(Image1);
{Initialize tetris matrix}
  for i:=0 to Reihe do
  for j:=0 to Spalte do
  Spiel[i,j]:=false;
{Start timer}
  Timer2.Enabled:=true;
{First move piece is place by this function}
  ErsteMove:=true;
  Ergebnis:=0;
  if edit2.Text='On' then
  begin
  Button2.Visible:=True;
  edit1.Visible:=true;
  end;
  Button1.Destroy;
  MediaPlayer2.open;
  MediaPlayer2.play;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i,j:integer;
begin
     for i:=0 to Reihe do
     for j:=0 to Spalte do
  begin
  if Spiel[i,j]=true
  then Schritten(MeisterFarbe,i,j,Image1);
  if Spiel[i,j]=false
  then Schritten(clWhite,i,j,Image1);
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
  var a:integer;
      punkt:boolean;
begin
  if not ErsteMove then

  StuckHerunterladen(Spiel,PieceKind,x,y,ErsteMove)

  else
      begin

      punkt := ZeileLoschen(Spiel,Ergebnis);
      if punkt then
      begin
      {Do nothing}
      end;

      for a:=0 to Reihe do
       if Spiel[a,0]=true then
       begin
       MediaPlayer2.Stop;
       MediaPlayer1.open;
       MediaPlayer1.Wait:=true;
       MediaPlayer1.play;
       MediaPlayer1.close;
       timer2.Enabled:=false;
       if Ergebnis<1001 then
       ShowMessage('Stop playing, uninstall, and go away cuz u r so bad'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<2001 then
       ShowMessage('I bet this is ur fst time with computers'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<3001 then
       ShowMessage('Three lines? I didnt thought u could get this far *laughing emoji*'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<4001 then
       ShowMessage('Not bad...'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<5001 then
       ShowMessage('How could u? R u cheating?'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<6001 then
       ShowMessage('This game was supposed to be hardcore, how did u do that?'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<7001 then
       ShowMessage('*Applauses*'+char(13)+'Your score: '+inttostr(Ergebnis))
       else if Ergebnis<8001 then
       ShowMessage('R u god?'+char(13)+'Your score: '+inttostr(Ergebnis))
       else
       ShowMessage('If u would have made just one more line I would have call u to play big leagues'+char(13)+'Your score: '+inttostr(Ergebnis))
       end;

      memo1.clear;
      memo1.Lines.add('Score: '+inttostr(Ergebnis));
      randomize;
      PieceKind:=random(4);
      x:=5;
      y:=0;
      InsertRandom(Spiel,PieceKind);
      ErsteMove:=false;
      end;
end;


procedure TForm1.a(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
    VK_Left : GeheNachLinks(Spiel,PieceKind,x,y);
    VK_Right : GeheNachRechts(Spiel,PieceKind,x,y);
    VK_Up : StuckDrehen(Spiel,PieceKind,x,y);
    VK_Down : StuckHerunterladen(Spiel,PieceKind,x,y,ErsteMove);
  end;
Key := 0;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
MeisterFarbe:=RandomFarbe;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,a:integer;
begin
a:=strtoint(edit1.Text);
for i:=0 to 15 do
Spiel[i,a]:=true;
end;

end.
