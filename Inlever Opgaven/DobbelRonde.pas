1 program DobbelRonde;
 2   { Etienne van Delden, 0618959, 19-09-2006  }
 3   { Dit programma hoort bij de opgave 'Dobbel Ronde' en bepaalt van de invoer
 4     of er een unieke hoogste worp is. Hard-coded is het limiet van
 5     invoeren/spelers op 5 gezet. }
 6 
 7 const
 8   AantalSpelers = 5;                    // Het aantal spelers
 9 
10 var
11   worp: Integer;                       // het gegooide getal
12   max: Integer;                        // het tot nu toe behaalde maximum
13   winnaar: 0 .. AantalSpelers;         // de winnaar
14   i: Integer;                           // teller variabele
15 
16 begin
17   max := 0;                             // er is nog geen maximum
18   winnaar := 0;                         // speler 0 is standaard winnaar
19   i := 0;                               // teller initialisatie
20 
21   while i <> AantalSpelers do
22     begin
23       read( worp );
24       i := i + 1;                       // teller ophogen, zodat hij nu de
25                                         // juiste speler aanwijst
26 
27       if max < worp then                // er is een nieuw maximum gegooid
28         begin
29           max := worp;
30           winnaar := i
31         end
32 
33       else if max =  worp then          // het maximum is niet meer uniek
34                                         // speler 0 word nu winnaar
35         begin
36           winnaar := 0
37         end;
38     end;
39 
40   writeln( max, ' ', winnaar )
41 end.