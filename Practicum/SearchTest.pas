1 program SearchTest;
   2   { Etienne van Delden, 0618959, 27-20-2006  }
   3   { Dit programma test de correctheid van de procedure Find in lists.pas }
   4 
   5 //** USES **********************************
   6 uses
   7   lists;
   8 
   9 //** GLOBAL VARIABLES **********************
  10 
  11 var
  12 
  13   outFile: Text;                  // var voor te schrijven bestand
  14   output: String;                 // naam voor de output file
  15   aanroepTeller: Integer;         // om het aantal aanroepen van Find te tellen
  16   foutenTeller: Integer;          // om het aantal foutieve aanroepen van Find
  17                                   //  te tellen
  18 
  19 //** GLOBAL CONSTANTS **********************
  20 
  21 const
  22   indent = '  ';                  // String waar output moet worden voorafgegaan
  23 
  24 //** PROCEDURE CHECKFIND ******************
  25 
  26 procedure CheckFind ( const s: List; const x: Entry;
  27                       const expectedFound: Boolean );
  28                     { globvar: outFile, aanroepTeller, foutenTeller }
  29   { doe aanroep Find ( s, x, found, pos ) en controleer postconditie:
  30       found = expectedFound, en
  31       als found, dan ook 0 <= pos < s.len  en  s.val[pos] = x }
  32   { pre:  outFile is geopend om te schrijven
  33           aanroepTeller = A, foutenTeller = F
  34           s, x voldoen aan preconditie van Find
  35           expectedFound = `x komt voor in s'
  36     post: aanroepTeller = A + 1,
  37           Find is aangeroepen en resultaat is naar outFile geschreven,
  38           foutenTeller = F + 1 als fout geconstateerd, anders F }
  39   // LOCAL CONSTANTS ****
  40   const
  41     WriteListIndent = indent + 's'; // wat voor .list en .val moet staan in de
  42                                     //  output
  43   // LOCAL VARIABLES ****
  44   var { lokale variabelen }
  45     found: Boolean;               // heeft Find een waarde gevonden?
  46     pos: Index;                   // de positie waar het getal gevonden is
  47 
  48   // BEGIN PROCEDURE ****
  49   begin
  50 
  51     Find( s, x, found, pos );     // Roept find aan en telt de aanroep teller op
  52     aanroepTeller := aanroepTeller + 1;
  53 
  54                                   // Schrijf de uitkomst
  55     writeln( outFile, aanroepTeller, ' Find' );
  56                                   // 1ste regel: volgnummer, aanroepe nroutine
  57     WriteList( outFile, WriteListIndent, s );
  58                                   // 2de regel: 's.len', lengte van lijst s
  59                                   // 3de regel: 's.val'
  60     writeln( outFile, Indent, 'x: ', x );
  61                                   // 4de regel: waarde van x
  62     writeln(outFile, '  found: ', found);
  63                                   // 5de regel: waarde van found
  64     writeln(outFile, '  pos: ', pos);
  65                                   // 6de regel: waarden van pos
  66 
  67                      // bekijk resultaat van find en bepaal de output
  68     if ( expectedFound and found ) then
  69       begin
  70       if s.len <= pos then        // als de lengte kleiner is dan de positie
  71       begin
  72         writeln( outFile, '  FOUT: pos in aanroep ', aanroepTeller );
  73         foutenTeller := foutenTeller + 1
  74       end
  75       else if s.val[ pos ]<> x then // als de positie niet correct is
  76       begin
  77         writeln( outFile, '  FOUT: pos in aanroep ', aanroepTeller );
  78         foutenTeller := foutenTeller + 1
  79       end
  80     end
  81     else if ( expectedFound or found ) then // als 1 van de 2 is waar is
  82     begin
  83       writeln( outFile, '  FOUT: found in aanroep ', aanroepTeller );
  84       foutenTeller := foutenTeller + 1
  85     end;                          // end If
  86 
  87   end;                            // end CheckFind
  88 
  89 
  90 //** PROCEDURE TESTFIND1 ** KAM LIJST ****************
  91 
  92 procedure TestFind1 ( const n: Integer );
  93                     { globvar: outFile, aanroepTeller, foutenTeller }
  94   { pre:  outFile is geopend om te  schrijven
  95           aanroepTeller = A, foutenTeller = F
  96           0 <= n <= MaxListLen
  97     post: Find(...) is getest met alle lijsten s zodanig dat
  98           s.len=n, s.val[i]=2i+1, en alle x=0, ..., 2n
  99           uitvoer is zijn naar outFile geschreven
 100           aanroepTeller = A + 2n + 1
 101           foutenTeller = F + aantal geconstateerde fouten in TestFind1 }
 102   var
 103     s: List;                        // invoer voor CheckFind
 104     expectedFound: Boolean;         // verwachten we dat er de waarde erin zit?
 105     i: Integer;                     // teller var
 106     j: Integer;                     // teller var
 107 
 108   begin
 109     // Als lijst met lengte MaxListLen word gevraagd
 110     if n = MaxListLen then
 111     begin
 112       generateList( s, n, 2, 1, 1 );  // genereer een kamlijst
 113 
 114       for i := 0 to ( 2 * n ) do begin  // loop van 0 tot 2n
 115         expectedFound := ( i mod 2  <> 0 );  // is expected found (on)even?
 116         CheckFind( s, i, expectedFound )  // roep checkFind aan
 117       end                         // end for
 118 
 119     end
 120     else      // als andere lijst lengte
 121     begin
 122 
 123       for i := 0 to n do
 124       begin                       // voor alle lengtes
 125         generateList( s, i, 2, 1, 1 );  // genereer een kamlijst
 126 
 127                                   // loop voor alle mogelijke waardes in delijst
 128         for j := 0 to ( 2 * i ) do begin
 129           expectedFound := ( j mod 2  <> 0) ;  // is expected found (on)even?
 130           CheckFind( s, j, expectedFound )
 131 
 132 
 133         end                       // end for
 134 
 135       end                         // end for
 136 
 137     end                           // end if
 138 
 139 
 140   end;                            // end procedure
 141 
 142 //** PROCEDURE TESTFIND2 ** CONSTANTE LIJST ****************
 143 
 144 procedure TestFind2 ( const n: Integer );
 145                     { globvar: outFile, aanroepTeller, foutenTeller }
 146   { pre:  outFile is geopend om te  schrijven
 147           aanroepTeller = A, foutenTeller = F
 148           0 <= n <= MaxListLen
 149     post: Find(...) is getest met alle lijst s zodanig dat
 150           s.len=n, s.val[i]=MaxEntry, en alle x=MinEntry, ..., MaxEntry
 151           uitvoer is naar outFile geschreven
 152           aanroepTeller = A + MaxEntry - MinEntry + 1
 153           foutenTeller = F + aantal geconstateerde fouten in TestFind2 }
 154 
 155   var
 156     i: Integer;                   // hulp var
 157     s: List;                        // invoer voor CheckFind
 158 
 159   begin
 160   // n hoeveelheid, m is offset, d is deelfactor, c is beginpunt
 161     GenerateList( s, n, 1, n, MaxEntry); // maak een constante lijst
 162 
 163     for i := minEntry to MaxEntry do begin
 164       checkFind( s, i, ( i = MaxEntry ))
 165     end                           // for i
 166 
 167   end;                            // end procedure
 168 
 169 
 170 //** MAIN PRGRAM ******************
 171 begin
 172 
 173   // INITIALIZATION ***
 174   aanroepTeller := 0;             // hoevaak find aangeroepen
 175   foutenTeller := 0;              // hoeveel fouten
 176   output := 'search_test.out';    // naar welk bestand
 177 
 178   // OPEN OUTPUT FILE **
 179   AssignFile( outFile, output );  // Open het zojuist ingegeven schrijf bestand
 180   Rewrite ( outFile );            // Schrijffile leeg maken
 181 
 182   // Test find meerdere keren
 183   testFind1( 5 );                 // Kamlijst test: van 1 tot en met 5
 184   testFind1( MaxListLen );        // Kamlijst test: maximum lijst lengte
 185   testFind2( MaxListLen );        // Constante lijst test: Lengte 10
 186   writeln( outFile, foutenTeller, ' FOUT(EN)' );  // schrijf naar output
 187 
 188   CloseFile ( outFile );          // sluit het geschreven bestand
 189 
 190 end.