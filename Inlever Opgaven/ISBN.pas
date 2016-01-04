1 program ISBN;
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
 52 procedure alleenISBNcijfers ( var regel: String );
 53   // pre: Zij regel = R en 1 <= Length( R ) <= 40
 54   // post: regel = rijtje van alle ISBN-cijfers uit R
 55 
 56   var
 57     i: Integer;                         // teller variabele
 58 
 59   begin
 60     i := 1;                             // init i
 61 
 62     while i <= Length( regel ) do
 63     begin                               // verwijder char i als char i geen
 64                                         //  geldig cijfer of X is
 65       if not ((regel[ i ] >= '0') and (regel[ i ] <= '9' )
 66       or (regel[i]='X')) then
 67       begin
 68         Delete( regel, i, 1 );
 69       end
 70       else
 71       begin
 72         i := i + 1
 73       end;                              // end if
 74 
 75     end;                                // end while
 76 
 77   end;                                  // end procedure alleenISBNCijfers
 78 
 79 function okX ( const code: String): Boolean;
 80   // pre: code bestaat uit precies 10 ISBN-cijfers
 81   // ret: of er geen 'x' in code voorkomt op positie 1 t/m 9
 82 
 83   var
 84     i: Integer;                         // teller variabele
 85 
 86   begin
 87     Result := True;                     // we gaan uit vna juiste code
 88 
 89     for i := 1 to Length( code ) - 1 do
 90     begin
 91 
 92       if code[ i ] = 'X' then
 93       begin
 94         Result := False                 // X staat op de verkeerde plaats
 95       end;                              // end if
 96 
 97     end;                                // end for
 98 
 99   end;                                  // end function okX
100 
101 procedure verwerkRegel ( regel: String );
102   // pre: regel bevat een code wat een ISBN zou kunnen zijn
103   // post: regel is geschreven,
104   //   met erachter de tekst ' is een geldig ISBN' of ' is niet een geldig ISBN'
105   //    al naar gelang regel een geldig ISBN bevat of niet
106 
107   begin
108     alleenISBNcijfers( regel );          // input omzetten naar cijfers+X
109     write( regel );
110 
111     if Length( regel ) < 10 then         // controle: is regel te kort?
112     begin
113       write(' is te kort');
114     end
115     else if Length( regel ) > 10 then    // controle: is regel te lang?
116     begin
117       write(' is te lang');
118    end
119    else if okX( regel ) = False then     // controle: staat x juist geplaatst?
120    begin
121      write( ' bevat X op verkeerde plaats' );
122    end
123    else if isGeldigISBN (regel) = false then begin
124      write( ' is niet geldig' );       // controle: is code geldig?
125    end
126    else begin
127      write( ' is geldig' );
128    end;                        // end if
129 
130     writeln
131   end;                                  // end verwerkRegel
132 
133 
134 
135 begin                                   // het uiteindelijke programma
136   readln ( input );
137 
138   while input <> '.' do begin            // zolang het einde niet is bereikt
139     verwerkRegel( input );
140     readln ( input )
141   end;                                  // end while
142 
143 end.