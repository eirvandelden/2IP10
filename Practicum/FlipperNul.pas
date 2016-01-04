1 program FlipperNul;
 2   // (c) 2002, Tom Verhoeff, TUE //
 3   // (c) 2006, E.I.R. van Delden, 0618959, TUE //
 4   // Een beter flipperend programma, sinds 0 altijd de kleinste is, hoeft er
 5   // alleen van achter naar voren te worden geflipt. 0 wordt dan, ongeacht
 6   // waar hij staat, naar voren toe verplaatst.
 7 
 8 
 9 uses
10   FlipperkastNul;
11 
12 const
13   MijnNummer = 0618959;                 // mijn studentnummer
14 
15 var
16   nBallen: Integer;                     // het aantal ballen
17   i: Integer;                           // hulp var
18 
19 begin
20   Start ( MijnNummer, nBallen );
21 
22   for i := nballen - 1 downto 1 do      // de lus om 0 naar voren te brengen
23     begin
24       flip ( i - 1, i )
25     end;
26 
27   Stop ( 0 )                            // het gat met bal 0 is het eerste gat
28 end.