1 program LettersTurven;
  2   { (c) 1981, Tom Verhoeff, TUE.  Version 1.0 }
  3   { 2006, Etienne van Delden, 0618959, 22 september 2006, Version 2.0}
  4 
  5   { De nieuwe versie van 'LettersTurven':
  6     Lees een regel met karakters (eindigend met een . )
  7       Bepaal het aantal voorkomens van de kleine letters.
  8       Schrijf een tabel met de per kleine letter een regel,
  9       waarop de letter, het aantal voorkomens en het percentage.}
 10 
 11 const
 12   MinLetter = 'a';                      // eerste te tellen kleine letter
 13   MaxLetter = 'z';                      // laatste te tellen kleine letter
 14 
 15 type
 16   Letter = MinLetter .. MaxLetter;      // te tellen letters
 17 
 18 var
 19   a: Char;                              // om de te tellen letters te doorlopen
 20   freq: array [ Letter ] of Cardinal;   // frequentietelling van letters
 21   i: Integer;                           // teller die alle letter bijhoud
 22   percent: array [ Letter ] of Real;    // var voor percentages
 23 
 24 begin
 25 ////////// 1. Initialiseer de tellingen op nul //////////
 26 
 27   for a := MaxLetter downto MinLetter do begin
 28     freq [ a ] := 0
 29   end;
 30 
 31   i := 0;                               // er zijn 0 kleine letters
 32 
 33 ////////// 2. Lees de letters en tel hun voorkomens //////////
 34 
 35   while a <> '.' do begin               // Lees alle letters tot het einde
 36     read ( a );
 37     if (a <= MaxLetter) and (a >= MinLetter) then begin
 38                                         // a legaal karakter
 39       freq [ a ] := freq [ a ] + 1;   // dit karakter komt 1 keer meer voor
 40       i := i + 1                      // totale karakters met 1 meer
 41     end;
 42   end;
 43 
 44   readln;
 45 
 46 ////////// 3. Schrijf de tabel //////////
 47   writeln ( 'Ltr    #       %' );
 48   writeln ( '---  ---  ------' );
 49 
 50   for a := MaxLetter downto MinLetter do begin
 51                                         // print van z tot a
 52     if freq[ a ] <> 0 then begin        // als het letter voor is gekomen
 53       percent[ a ] := ( freq[ a ] / i) * 100;
 54       writeln ( ' ', a, ' ', '    ', freq [ a ],  percent[ a ]: 8: 2)
 55     end;
 56 
 57   end
 58 end.