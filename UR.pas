unit UR;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
type
    TSpiel=array[0..15,0..21] of boolean;
    
  procedure EinsDreieckMachen (DieFarbe:Tcolor; i,j:integer; f:real; var i1:TImage);
  procedure EinsUngekehrtDreieckMachen (DieFarbe:Tcolor; i,j:integer; f:real; var i1:TImage);

implementation

procedure EinsDreieckMachen (DieFarbe:Tcolor; i,j:integer; f:real; var i1:TImage);
var
  Puntos: array of TPoint;
begin
  with i1.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Brush.Color :=DieFarbe ;
    SetLength( Puntos, 3 );
    Puntos[0].y := round(43*f)+j;
    Puntos[0].x := round(0*f)+i;
    Puntos[1].y := round(0*f)+j;
    Puntos[1].x := round(25*f)+i;
    Puntos[2].y := round(43*f)+j;
    Puntos[2].x := round(50*f)+i;
    Polygon( Puntos );
  end;
end;

procedure EinsUngekehrtDreieckMachen (DieFarbe:Tcolor; i,j:integer; f:real; var i1:TImage);
var
  Puntos: array of TPoint;
begin
  with i1.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Brush.Color :=DieFarbe ;
    SetLength( Puntos, 3 );
    Puntos[0].y := round(0*f)+j;
    Puntos[0].x := round(0*f)+i;
    Puntos[1].y := round(43*f)+j;
    Puntos[1].x := round(25*f)+i;
    Puntos[2].y := round(0*f)+j;
    Puntos[2].x := round(50*f)+i;
    Polygon( Puntos );
  end;
end;

end.
