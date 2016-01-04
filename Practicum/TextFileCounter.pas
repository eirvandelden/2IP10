1 program TextFileCounter;
  2  { Etienne van Delden, 0618959, <date>  }
  3   { Dit programma telt het aantal woorden, getallen, regels en tekens van de
  4   input file die men ingeeft.}
  5 
  6 
  7 
  8 const
  9   letter = ['a' .. 'z', 'A' .. 'Z'];    // type letter
 10   cijfer = ['0' .. '9'];                // type cijfer
 11   underscore = ['_'];                   // type underscore
 12   FileNotFoundError = 2;                // Run-Time Error Code
 13 
 14 procedure CountText ( var f: Text; var i_regels, i_woord, i_getal, i_teken: Integer );
 15   { pre:  f is geopend om te lezen, leeskop staat vooraan
 16     post: r = aantal regels in f
 17           t = aantal tekens in f
 18           f is geopend om te lezen, leeskop staat achteraan }
 19   var
 20     teken: Char;                        // om teken in te lezen
 21     Toestand: ( Elders, InWoord, InGetal ); // waar is de leeskop
 22 
 23     temp: String;
 24 
 25 
 26   begin
 27     i_regels := 0;                      // init var aantal regels gelezen uit f
 28     i_teken := 0;                       // init var aantal tekens gelezen uit f
 29     i_getal := 0;                       // init var aantal getallen gelezen uitf
 30     i_woord := 0;                       // init var aantal woorden gelezen uit f
 31     Toestand := Elders;                 // init var, toestand begint in Elders
 32 
 33     while not Eof( f ) do begin { verwerk eerstvolgende regel }
 34 
 35       while not Eoln( f ) do begin { verwerk eerstvolgende teken }
 36         read( f, teken );
 37 
 38                                         // We gaan nu kijken wat de toestand is
 39                                         // van het vorige karakter en
 40                                         // vergelijken dat met het type van het
 41                                         // huidige karakter, om te bepalen of
 42                                         // de toestand moet worden aangepast
 43         case Toestand of
 44           Elders: begin                 // Als het vorige teken in Elders zit...
 45                                         // ... en het huidige teken een
 46             if (teken in letter) then   // letter is, tel 1 woord meer
 47             begin
 48               i_woord := i_woord + 1;
 49               Toestand := InWoord;
 50               temp := 'InWoord'
 51             end                         // end controle 1
 52                                         // ... en het huidige teken een
 53                                         // underscore is, tel 1 woor meer
 54             else if ( teken in underscore ) then
 55             begin
 56               i_woord := i_woord + 1;
 57               Toestand := InWoord;
 58               temp := 'InWoord'
 59             end                         // end controle 2
 60                                         // ... en het huidige teken een
 61             else if (teken in cijfer)  then // cijfer is, tel 1 cijfer meer
 62             begin
 63               i_getal := i_getal + 1;
 64               Toestand := InGetal;
 65               temp := 'InGetal'
 66             end                         // end controle 3
 67                                         // ... en het huidige teken geen letter,
 68                                         // cijfer of underscore is
 69             else if not (( teken in letter) or (teken in cijfer) or
 70              (teken in underscore)) then
 71             begin
 72               Toestand := Elders;
 73               temp := 'Elders'
 74             end;                         // end controle 4
 75           end;                          // end Elders
 76 
 77                                         // Als het vorige teken in InGetal
 78                                         // zit...
 79           InGetal: begin
 80                                           // .. en het huidige teken is een
 81             if (teken in underscore ) then // underscore
 82             begin
 83               i_woord := i_woord + 1;
 84               Toestand := InWoord;
 85               temp := 'InGetal'
 86             end                         // end controle 1
 87                                         // ... en het huidige teken geen letter,
 88                                         // cijfer of underscore is
 89             else if not (( teken in letter) or (teken in cijfer) or
 90              (teken in underscore)) then
 91             begin
 92               Toestand := Elders;
 93               temp := 'Elders'
 94             end;                         // end controle 2
 95         end;  // end Ingetal
 96 
 97                                         // Als het vorige teken in InWoord
 98           InWoord: begin                  // zit...
 99                                         // .. en het huidige teken geen letter,
100                                         // cijfer of underscore is
101             if not (( teken in letter) or (teken in cijfer) or
102             (teken in underscore)) then
103             begin
104               Toestand := Elders;
105               temp := 'Elders'
106             end;                         // end controle 1
107           end;
108         end;                            // end case
109 
110         writeln( temp );
111         i_teken := i_teken + 1;
112         writeln( i_teken );
113 
114       end;                              // end while Eoln
115       Toestand := Elders;
116       readln( f );
117       i_regels := i_regels + 1
118     end                                 // end while Eof
119 
120   end;                                  // end procedure CountText
121 
122 var
123   inFile      : Text;                   // file om te tellen
124   outFile     : Text;                   // voor output file
125   aantalRegels: Integer;                // aantal regels in inFile
126   aantalTekens: Integer;                // aantal tekens in inFile
127   aantalWoorden: Integer;               // aantal woorden in inFile
128   aantalGetal: Integer;                 // aantal getallen in inFile
129 
130 begin
131                                         // initialisatie file toekennen
132   AssignFile( inFile, 'woorden.in' );
133   AssignFile( outFile, 'woorden.out' );
134   Rewrite ( outFile );
135   Reset( inFile);
136                                         // Voor de procedure uit
137   CountText( inFile, aantalRegels, aantalWoorden, aantalGetal, aantalTekens );
138                                         // schrijf de output naar het bestand
139   writeln( outfile, aantalRegels, ' regel(s)' );
140   writeln( outfile, aantalWoorden, ' woord(en)' );
141   writeln( outfile, aantalGetal, ' getal(len)');
142   writeln( outfile, aantalTekens, ' teken(s)' );
143                                         // sluit het bestand
144   CloseFile ( inFile );
145   CloseFile ( outFile );
146 end.