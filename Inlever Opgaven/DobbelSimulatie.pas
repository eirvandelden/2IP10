1 program DobbelRonde;
 2   { Etienne van Delden, 0618959, 26-09-2006  }
 3   { Dit programma hoort bij de opgave 'Dobbel Simulatie' en bepaalt simuleert
 4     een aantal dobbelrondes. Er word willekeurig gegooid door een vast aantal
 5     spelers, waarvan 1 met een dodecaeder gooit. Deze simulatie gebeurt zo vaak
 6     als word aangegeven in de input. }
 7 
 8 const
 9   AantalSpelers = 5;                    // Het aantal spelers
10 
11 type
12   AlleSpelers =  0 .. AantalSpelers;    // Dit type loopt van 0, geen winnaar
13                                         //  tot de laatste speler
14 
15 var
16   worp: Integer;                        // het gegooide getal
17   max: Integer;                         // het tot nu toe behaalde maximum
18   winnaar: AlleSpelers;                 // de winnaar(s)
19   i: Integer;                           // teller variabele/ hulp variabele
20   AantalRondes: Integer;                // het aantal rondes
21   speler: Integer;                      // de huidige speler is..
22   WinRondes: array [ AlleSpelers ] of Integer;
23                                         // array voor het bijhouden van de score
24                                         //  van iedere speler + geen winnaar
25 
26 begin
27 ///// 1. Inititialisatie /////
28   Randomize;                            // initialisatie random generator
29   max := 0;                             // er is nog geen maximum
30   winnaar := 0;                         // speler 0 is standaard winnaar
31   speler := 1;                          // speler 1 is als eerst aan de buurt
32 
33   for i := 0 to AantalSpelers do begin      // initialisatie win frequentie per
34                 WinRondes[ i ] := 0                                                                 //  speler
35         end;
36 
37   i := 0;                               // teller initialisatie
38 
39 ///// 2. Het programma /////
40 /// 2.1 Lees het aantal Rondes ///
41   readln( AantalRondes );                // Hoeveel rondes worden gespeeld?
42 
43 /// 2.2 Executeer aantal rondes ///
44                                         // Hoofdlus: herhaalt het spelen van
45                                         //  1 ronde tot AantalRondes
46   while i <> AantalRondes do
47     begin
48                                         // Speler 1 tot AantalSpelers gooien
49                                         //  ieder, hierbij word de winnaar van
50                                         //  deze ronde bijgehouden
51       for speler := 1 to AantalSpelers do begin
52 /// 2.2.1 Word de dodecaeder gegooid of 2 dice 6? ///
53         if speler = 1 then
54           begin
55             worp := random( 12 )        // Speler 1 gooit met een dodecaeder
56           end
57         else
58           begin
59             worp := random( 6 ) + random( 6 ) // Alle anderen met 2x dice 6
60           end;
61 
62 /// 2.2.2 Bepaal het maximum van de gegooide worp ///
63         if max < worp then              // er is een nieuw maximum gegooid
64           begin
65             max := worp;
66             winnaar := speler
67           end
68         else if max = worp then         // het maximum is niet meer uniek
69           begin
70             winnaar := 0                // speler 0 word nu winnaar
71           end;
72       end;                              // Alle spelers hebben gegooid
73 
74 /// 2.2.3 Winnaar array aanpassen en resetten waarden ///
75                                         // speler [ winnaar ]  heeft 1 keer
76                                         //  meer gewonnen
77     WinRondes[ winnaar ] := WinRondes[ winnaar ] + 1;
78     max := 0;                           // nieuwe ronde, nieuw maximum
79     worp := 0;                          // nieuwe ronde, nieuwe kansen
80 
81 
82     i := i + 1;                         // teller ophogen, op naar de
83                                         // volgende rond
84     end;
85 /// 2.3 Output wegschrijven ///
86 
87   for i := 1 to AantalSpelers do begin
88     write( WinRondes[ i ], ' ' )        // schrijf hoe vaak speler i won
89   end;
90 
91   write( WinRondes[ 0 ]);               // schrijf hoe vaak er geen winnar was
92 
93 end.