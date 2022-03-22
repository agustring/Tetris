unit UPiezas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UR;

procedure Schritten (Farbe:Tcolor; i,j:integer; var i1:TImage);
procedure MapGespawn(var imagen1:TImage);
function Zuletzt (i:integer; var S:TSpiel):integer;
procedure InsertRandom (var S:TSpiel; R:integer);
procedure Insert1 (var S:TSpiel);
procedure Insert2 (var S:TSpiel);
procedure Insert3 (var S:TSpiel);
procedure Insert4 (var S:TSpiel);
procedure StuckHerunterladen (var S:TSpiel; var r,x,y:integer; var e:boolean);
procedure GeheNachRechts (var S:TSpiel; var r,x,y:integer);
procedure GeheNachLinks (var S:TSpiel; var r,x,y:integer);
procedure StuckDrehen (var S:TSpiel; var r,x,y:integer);
function ZeileLoschen (var S:TSpiel; var pun:integer): boolean;
function RandomFarbe:TColor;

implementation

const Reihe=15;
const Spalte=21;

procedure Schritten (Farbe:Tcolor; i,j:integer; var i1:TImage);
begin
  if odd(j)
  then
    if odd(i)
    then EinsDreieckMachen(Farbe,25*i,43*j,1,i1)
    else EinsUngekehrtDreieckMachen(Farbe,25*i,43*j,1,i1)
  else
    if odd(i)
    then EinsUngekehrtDreieckMachen(Farbe,25*(i),43*j,1,i1)
    else EinsDreieckMachen(Farbe,25*(i),43*j,1,i1);
end;

procedure MapGespawn(var imagen1:TImage);
var i,j:integer;
begin
  for i:=0 to 7 do
  for j:=0 to 11 do
  begin
    EinsDreieckMachen(clWhite,50*i,43*2*j,1,imagen1);
    EinsUngekehrtDreieckMachen(clWhite,50*i+25,43*2*j,1,imagen1);
    EinsDreieckMachen(clWhite,50*i+25,43*(2*j-1),1,imagen1);
    EinsUngekehrtDreieckMachen(clWhite,50*i,43*(2*j-1),1,imagen1);
  end;
end;

function Zuletzt (i:integer; var S:TSpiel):integer;
var
  j:integer;
begin
  if S[i,21]=false then Zuletzt:=21
  else
  begin
  j:=22;
  repeat
    j:=j-1
  until (S[i,j-1]=false) or (j=0);
  Zuletzt:=j;
  end;
end;

{Insert piece}

procedure InsertRandom (var S:TSpiel; R:integer);
var a:integer;
begin
   a:=R;
   case a of
   1: Insert1(S);
   2: Insert2(S);
   3: Insert3(S);
   0: Insert4(S);
   end;
end;

procedure Insert1 (var S:TSpiel);
begin
     S[5,0]:=true;
     S[6,0]:=true;
     S[4,1]:=true;
     S[5,1]:=true;
end;

procedure Insert2 (var S:TSpiel);
begin
     S[5,0]:=true;
     S[5,3]:=true;
     S[5,2]:=true;
     S[5,1]:=true;
     S[5,4]:=true;
end;

procedure Insert3 (var S:TSpiel);
begin
     S[5,0]:=true;
     S[5,3]:=true;
     S[5,2]:=true;
     S[5,1]:=true;
     S[6,0]:=true;
end;

procedure Insert4 (var S:TSpiel);
begin
     S[5,0]:=true;
     S[6,0]:=true;
     S[6,1]:=true;
     S[5,1]:=true;
end;

procedure StuckHerunterladen (var S:TSpiel; var r,x,y:integer; var e:boolean);
begin
       case r of
       0:     begin
              if (S[x,y+2]=false) and (S[x+1,y+2]=false) and (y+2<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y+2]:=true;
              S[x+1,y+2]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

       1:     begin
              if (S[x,y+2]=false) and (S[x+1,y+1]=false) and (S[x-1,y+2]=false) and (y+2<Spalte+1) then
              begin
              S[x-1,y+1]:=false;
              S[x,y+1]:=false;
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x-1,y+2]:=true;
              S[x,y+2]:=true;
              S[x,y+1]:=true;
              S[x+1,y+1]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

        2:    begin
              if (S[x,y+5]=false) and (y+5<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x,y+3]:=true;
              S[x,y+4]:=true;
              S[x,y+5]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

        3:    begin
              if (S[x,y+4]=false) and (S[x+1,y+1]=false) and (y+4<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x,y+3]:=true;
              S[x,y+4]:=true;
              S[x+1,y+1]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

         11:  begin
              if (S[x,y+2]=false) and (S[x+1,y+3]=false) and (y+2 <Spalte+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+1,y+2]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x+1,y+2]:=true;
              S[x+1,y+3]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

         12:  begin
              if (S[x,y+1]=false) and (S[x+1,y+1]=false) and (S[x+2,y+1]=false) and (S[x+3,y+1]=false) and (S[x+4,y+1]=false) and (S[x+5,y+1]=false) and (y+1<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x+2,y]:=false;
              S[x+3,y]:=false;
              S[x+4,y]:=false;
              S[x,y+1]:=true;
              S[x+1,y+1]:=true;
              S[x+2,y+1]:=true;
              S[x+3,y+1]:=true;
              S[x+4,y+1]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

         13:  begin
              if (S[x,y+1]=false) and (S[x+1,y+1]=false) and (S[x+2,y+1]=false) and (S[x+3,y+2]=false) and (y+2<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x+2,y]:=false;
              S[x+3,y]:=false;
              S[x,y+1]:=true;
              S[x+1,y+1]:=true;
              S[x+2,y+1]:=true;
              S[x+3,y+2]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

         23:  begin
              if (S[x,y+4]=false) and (S[x-1,y+4]=false) and (y+4<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x-1,y+3]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x,y+3]:=true;
              S[x,y+4]:=true;
              S[x-1,y+4]:=true;
              y:=y+1;
              end
              else e:=true;
              end;

         33:  begin
              if (S[x,y+2]=false) and (S[x+1,y+2]=false) and (S[x+2,y+2]=false) and (S[x+3,y+2]=false) and (y+2<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+2,y+1]:=false;
              S[x+3,y+1]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x+1,y+2]:=true;
              S[x+2,y+2]:=true;
              S[x+3,y+2]:=true;
              y:=y+1;
              end
              else e:=true;
              end;
        end;
end;

procedure GeheNachRechts (var S:TSpiel; var r,x,y:integer);
begin
     case r of
     0:       begin
              if (S[x+2,y]=false) and (S[x+2,y+1]=false) and (x+2<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+2,y]:=true;
              S[x+2,y+1]:=true;
              x:=x+1;
              end
              end;

     1:       begin
              if (S[x+2,y]=false) and (S[x+1,y+1]=false) and (x+2<Reihe+1) then
              begin
              S[x-1,y+1]:=false;
              S[x,y+1]:=false;
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x+2,y]:=true;
              S[x+1,y+1]:=true;
              S[x,y+1]:=true;
              S[x+1,y]:=true;
              x:=x+1;
              end
              end;

     2:       begin
              if (S[x+1,y]=false) and (S[x+1,y+1]=false) and (S[x+1,y+2]=false) and (S[x+1,y+3]=false) and (S[x+1,y+4]=false) and (x+1<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x,y+4]:=false;
              S[x+1,y]:=true;
              S[x+1,y+1]:=true;
              S[x+1,y+2]:=true;
              S[x+1,y+3]:=true;
              S[x+1,y+4]:=true;
              x:=x+1;
              end;
              end;

     3:       begin
              if (S[x+2,y]=false) and (S[x+1,y+1]=false) and (S[x+1,y+2]=false) and (S[x+1,y+3]=false) and (x+2<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x+1,y+1]:=true;
              S[x+1,y+2]:=true;
              S[x+1,y+3]:=true;
              S[x+1,y]:=true;
              S[x+2,y]:=true;
              x:=x+1;
              end
              end;

     11:      begin
              if (S[x+2,y+2]=false) and (S[x+2,y+1]=false) and (S[x+1,y]=false) and (x+2<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+1,y+2]:=false;
              S[x+1,y]:=true;
              S[x+1,y+1]:=true;
              S[x+2,y+1]:=true;
              S[x+2,y+2]:=true;
              x:=x+1;
              end
              end;

     12:      begin
              if (S[x+6,y]=false) and (x+1<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x+6,y]:=true;
              x:=x+1;
              end
              end;
     13:      begin
              if (S[x+4,y+1]=false) and (S[x+4,y]=false) and (x+4<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x+3,y+1]:=false;
              S[x+4,y+1]:=true;
              S[x+4,y]:=true;
              x:=x+1;
              end
              end;

     23:      begin
              if (S[x+1,y]=false) and (S[x+1,y+1]=false) and (S[x+1,y+2]=false) and (S[x+1,y+3]=false) and (x+1<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x-1,y+3]:=false;
              S[x+1,y]:=true;
              S[x+1,y+2]:=true;
              S[x+1,y+3]:=true;
              x:=x+1;
              end
              end;

         33:  begin
              if (S[x+1,y]=false) and (S[x+4,y+1]=false) and (x+1<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+2,y+1]:=false;
              S[x+3,y+1]:=false;
              S[x+1,y]:=true;
              S[x+1,y+1]:=true;
              S[x+2,y+1]:=true;
              S[x+3,y+1]:=true;
              S[x+4,y+1]:=true;
              x:=x+1;
              end
              end;
     end;
end;

procedure GeheNachLinks (var S:TSpiel; var r,x,y:integer);
begin
     case r of
     0:       begin
              if (S[x-1,y]=false) and (S[x-1,y+1]=false) and (x-1>-1) then
              begin
              S[x+1,y]:=false;
              S[x+1,y+1]:=false;
              S[x-1,y]:=true;
              S[x-1,y+1]:=true;
              x:=x-1;
              end
              end;

     1:       begin
              if (S[x-2,y+1]=false) and (S[x-1,y]=false) and (x-2>-1) then
              begin
              S[x-1,y+1]:=false;
              S[x,y+1]:=false;
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y]:=true;
              S[x-1,y]:=true;
              S[x-2,y+1]:=true;
              S[x-1,y]:=true;
              x:=x-1;
              end
              end;

     2:       begin
              if (S[x-1,y]=false) and (S[x-1,y+1]=false) and (S[x-1,y+2]=false) and (S[x-1,y+3]=false) and (S[x-1,y+4]=false) and (x-1>-1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x,y+4]:=false;
              S[x-1,y]:=true;
              S[x-1,y+1]:=true;
              S[x-1,y+2]:=true;
              S[x-1,y+3]:=true;
              S[x-1,y+4]:=true;
              x:=x-1;
              end;
              end;

     3:       begin
              if (S[x-1,y]=false) and (S[x-1,y+1]=false) and (S[x-1,y+2]=false) and (S[x-1,y+3]=false) and (x-1>-1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x-1,y+1]:=true;
              S[x-1,y+2]:=true;
              S[x-1,y+3]:=true;
              S[x-1,y]:=true;
              S[x,y]:=true;
              x:=x-1;
              end
              end;

     11:      begin
              if (S[x,y+2]=false) and (S[x-1,y+1]=false) and (S[x-1,y]=false) and (x-1>-1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+1,y+2]:=false;
              S[x-1,y]:=true;
              S[x-1,y+1]:=true;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              x:=x-1;
              end
              end;

     12:      begin
              if (S[x-1,y]=false) and (x-1>-1) then
              begin
              S[x+5,y]:=false;
              S[x-1,y]:=true;
              x:=x-1;
              end
              end;

     13:      begin
              if (S[x+2,y+1]=false) and (S[x-1,y]=false) and (x-1>-1) then
              begin
              S[x+3,y]:=false;
              S[x+3,y+1]:=false;
              S[x+2,y+1]:=true;
              S[x-1,y]:=true;
              x:=x-1;
              end
              end;

     23:      begin
              if (S[x+1,y]=false) and (S[x+1,y+1]=false) and (S[x+1,y+2]=false) and (S[x+1,y+3]=false) and (x-1>-1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x-1,y]:=true;
              S[x-1,y+1]:=true;
              S[x-1,y+2]:=true;
              S[x-2,y+3]:=true;
              x:=x-1;
              end
              end;

     33:      begin
              if (S[x-1,y]=false) and (S[x-1,y+1]=false) and (x-1>-1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+2,y+1]:=false;
              S[x+3,y+1]:=false;
              S[x-1,y]:=true;
              S[x-1,y+1]:=true;
              S[x,y+1]:=true;
              S[x+1,y+1]:=true;
              S[x+2,y+1]:=true;
              x:=x-1;
              end
              end;
     end;
end;

procedure StuckDrehen (var S:TSpiel; var r,x,y:integer);
begin
case r of
       0:     {Do nothing};

       1:     begin
              if (S[x,y+2]=false) and (S[x+1,y+1]=false) and (S[x-1,y+2]=false) and (y+2<Spalte+1) and (x+1<Reihe+1) then
              begin
              S[x-1,y+1]:=false;
              S[x,y+1]:=false;
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y]:=true;
              S[x,y+1]:=true;
              S[x+1,y+1]:=true;
              S[x+1,y+2]:=true;
              r:=r+10;
              end
              end;

        2:    begin
              if (S[x+5,y]=false) and (S[x+4,y]=false) and (S[x+3,y]=false) and (S[x+1,y]=false) and (S[x+2,y]=false) and (x+5<Reihe+1) then
              begin
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x,y+4]:=false;
              S[x,y]:=false;
              S[x,y]:=true;
              S[x+1,y]:=true;
              S[x+2,y]:=true;
              S[x+3,y]:=true;
              S[x+4,y]:=true;
              r:=r+10;
              end;
              end;

        3:    begin
              if (S[x+2,y]=false) and (S[x+3,y]=false) and (S[x+3,y+1]=false) and (x+3<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x,y]:=true;
              S[x+1,y]:=true;
              S[x+2,y]:=true;
              S[x+3,y]:=true;
              S[x+3,y+1]:=true;
              r:=r+10;
              end
              end;

         11:  begin
              if (S[x+1,y]=false) and (S[x-1,y+1]=false) and (y+2<Spalte+1) and (x+1<Reihe+1) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+1,y+2]:=false;
              S[x-1,y+1]:=true;
              S[x,y+1]:=true;
              S[x,y]:=true;
              S[x+1,y]:=true;
              r:=r-10;
              end
              end;

         12:  begin
              if (S[x,y+1]=false) and (S[x,y+2]=false) and (S[x,y+3]=false) and (S[x,y+4]=false) and (S[x,y+5]=false) and (y+5<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x+2,y]:=false;
              S[x+3,y]:=false;
              S[x+4,y]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x,y+3]:=true;
              S[x,y+4]:=true;
              S[x,y]:=true;
              r:=r-10;
              end;
              end;

         13:  begin
              if (S[x,y+1]=false) and (S[x+1,y+1]=false) and (S[x+2,y+1]=false) and (S[x+3,y+2]=false) and (y+2<Spalte+1) then
              begin
              S[x,y]:=false;
              S[x+1,y]:=false;
              S[x+2,y]:=false;
              S[x+3,y]:=false;
              S[x+3,y+1]:=false;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x,y+3]:=true;
              S[x,y]:=true;
              S[x-1,y+3]:=true;
              r:=r+10
              end
              end;

         23:  begin
              if (S[x+1,y]=false) and (y+3<Spalte+1) and (x+1<11) then
              begin
              S[x,y+1]:=false;
              S[x,y+2]:=false;
              S[x,y+3]:=false;
              S[x,y]:=false;
              S[x-1,y+3]:=false;
              S[x,y]:=true;
              S[x,y+1]:=true;
              S[x+1,y+1]:=true;
              S[x+2,y+1]:=true;
              S[x+3,y+1]:=true;
              r:=r+10;
              end
              end;

         33:  begin
              if (S[x+1,y]=false) and (y+3<Spalte+1) and (x+1<11) then
              begin
              S[x,y]:=false;
              S[x,y+1]:=false;
              S[x+1,y+1]:=false;
              S[x+2,y+1]:=false;
              S[x+3,y+1]:=false;
              S[x,y]:=true;
              S[x+1,y]:=true;
              S[x,y+1]:=true;
              S[x,y+2]:=true;
              S[x,y+3]:=true;
              r:=r-30;
              end
              end;
        end;
end;

function ZeileLoschen (var S:TSpiel; var pun:integer): boolean;
var i,j,k:integer;
begin
     for k:=0 to 21 do
     begin
     if (S[0,k]) and
     (S[1,k]) and
     (S[2,k]) and
     (S[3,k]) and
     (S[4,k]) and
     (S[5,k]) and
     (S[6,k]) and
     (S[7,k]) and
     (S[8,k]) and
     (S[9,k]) and
     (S[10,k]) and
     (S[11,k]) and
     (S[12,k]) and
     (S[13,k]) and
     (S[14,k]) and
     (S[15,k]) then
     begin
     for i:=0 to 15 do S[i,k]:=false;
     for j:=0 to k-1 do
     for i:=0 to 15 do
     begin
     S[i,k-j]:=S[i,k-j-1];
     S[i,k-j-1]:=false;
     end;
     ZeileLoschen:=true;
     pun:=pun+1000;
     end
     else ZeileLoschen:=false;
     end;
end;

function RandomFarbe:TColor;
var c:integer;
begin
c:=random(13);
case c of
0: RandomFarbe:=clRed;
1: RandomFarbe:=clBlue;
2: RandomFarbe:=clGreen;
3: RandomFarbe:=clYellow;
5: RandomFarbe:=clBlack;
6: RandomFarbe:=clAqua;
9: RandomFarbe:=clFuchsia;
11: RandomFarbe:=clLime;
12: RandomFarbe:=clMaroon;
4: RandomFarbe:=clMoneyGreen;
7: RandomFarbe:=clNavy;
8: RandomFarbe:=clPurple;
10: RandomFarbe:=clSkyBlue;

end;
end;

end.
