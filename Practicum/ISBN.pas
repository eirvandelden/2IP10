2   { (c) 2002, Tom Verhoeff, TUE }
  3   { 2006, Etienne van Delden, TUE}
  4   { Programma om te controleren of het ingegeven ISBN een geldig ISBN is. }
  5 
  6 var
  7   input: String;                         // string om ISBN in te lezen
  8 
  9 const
 10   AantalCijfersInISBN = 10;             // aantal ISBN-cijfers in een ISBN
 11 
 12 type
 13   CijferWaarde = 0 .. 10;               // verz. waarden van ISBN-cijfers
 14 
 15 function charToCijferWaarde ( const c: Char ): CijferWaarde;
 16   // converteer karakter dat ISBN-cijfer voorstelt naar zijn waarde
 17   // pre: c in [ '0' .. '9', 'X' ]
 18   //  ret: 0 .. 9, of 10 al naar gelang c = '0' .. '9', of 'X'
 19 
 20   begin
 21     if c in [ '0' .. '9' ] then
 22       Result := ord ( c ) - ord ( '0' )
 23     else { c = 'X' }
 24       Result := 10
 25   end;                                  // end charToCijferWaarde
 26 
 27 function isGeldigISBN ( const code: String ): Boolean;
 28   // controleer of code een geldig ISBN is }
 29   // pre: code bestaat uit precies 10 ISBN-cijfers
 30   //  ret: of code een geldig ISBN is, d.w.z. of
 31   //       (som k: 1 <= k <= 10: (11-k) code_k) een 11-voud is
 32 
 33   var
 34     s: Integer;                         // gewogen cijfer-som
 35     i: Integer;                         // hulp var: teller
 36 
 37   begin
 38     s := 0;                             // int. var s: cijfer som
 39     i := 1;                             // int. hulp var i:teller
 40 
 41     // controleer of het i-de getal een X is en vervang met 10
 42     // vermenigvuldig het i-de getal met i en tel dit op bij de vorige uitkomst
 43 
 44     for i := Length( code ) downto 1 do
 45     begin
 46       s := s + charToCijferWaarde( code[ i ] ) * i
 47     end;
 48 
 49     Result := ( s mod 11 = 0 )
 50   end;                                  // end isGeldigISBN
 51 
 52 procedure verwerkRegel ( const regel: String );
 53   // pre: regel bevat een code met precies 10 ISBN-cijfers
 54   // post: regel is geschreven,
 55   //   met erachter de tekst ' is een geldig ISBN' of ' is niet een geldig ISBN'
 56   //    al naar gelang regel een geldig ISBN bevat of niet
 57 
 58   begin
 59     write ( regel, ' is ' );
 60 
 61     if isGeldigISBN( regel ) <> True then
 62     begin
 63         write( 'niet ' )
 64     end;
 65 
 66     write( 'een geldig ISBN');
 67     writeln
 68   end;                                  // end verwerkRegel
 69 
 70 begin                                   // het uiteindelijke programma
 71   readln ( input );
 72 
 73   while input <> '.' do begin            // zolang het einde niet is bereikt
 74     verwerkRegel ( input );
 75     readln ( input )
 76   end;                                  // end while
 77 
 78 end.