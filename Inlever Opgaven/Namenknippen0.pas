1 program NamenKnippen0;
   2   { (c) 2002, Tom Verhoeff, TUE }
   3   { Lees een lijst namen tussen aanhalingstekens (een per regel).
   4     De lijst is afgesloten met een losse '.'.
   5     Schrijf de namen zonder aanhalingstekens. }
   6 
   7 
   8 var
   9   regel: String;                        // om regel te lezen
  10   achternaam: String;                   // var voor achternaam
  11   i: Integer;                           // hulp var
  12 
  13 begin
  14   readln ( regel );
  15 
  16   while regel <> '.' do begin           // zolang einde niet is bereikt
  17     Delete( regel, 1, 1 );              // linkse " verwijderd
  18     Delete( regel, Length ( regel ), 1 );  // rechtse " verwijderd
  19 
  20     if Pos( ' ', regel ) <> 0 then      // als er een spatie is
  21       begin
  22         i := Pos ( ' ', regel );         // Positie van de meest links spatie
  23         achternaam := Copy( regel, 1, i -  1); //kopieer de achternaam
  24         Delete( regel, 1 , i);          // Verwijder de achternaam
  25 
  26         while Pos( ' ', regel ) = 1 do // Verwijder de resterende spaties
  27           begin
  28             Delete( regel, 1, 1)
  29           end;
  30 
  31         writeln ( '"', regel, ' ', achternaam, '"' );
  32       end                               // end if conditie
  33     else                                // Als er geen spatie is: geef de input
  34       begin
  35         writeln( '"', regel, '"')
  36       end;
  37 
  38     readln ( regel );                   // lees de volgende regel
  39   end                                   // end while
  40 
  41 end.