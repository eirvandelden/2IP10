1 program KeizerKiezer;
 2   { (c) 2002, Tom Verhoeff, versie 2 }
 3   { Kies keizer uit opgegeven aantal kandidaten, genummerd vanaf 0.
 4     Iedere 3e kandidaat valt af volgens aftelversje 'Geen kei-zer'. }
 5 
 6   { 22 September 2006, Etiene van Delden, versie 2.5 }
 7 
 8 const
 9   MaxNKandidaten = 10000;               // maximale aantal kandidaten, >= 1
10   MaxNCijfers    =     0;               // maximale aantal cijfers
11                                         //  in kandidaatnummer
12   NLettergrepen  =     3;               // aantal lettergrepen, >=1
13 
14 type
15   Kandidaat = 0 .. MaxNKandidaten - 1;  // de kandidaten, eigenlijk
16                                         //  0 .. NKandidaten - 1
17 
18 var
19   NKandidaten: 1 .. MaxNKandidaten;     // aantal kandidaten (invoer)
20   rest: 1 .. MaxNKandidaten;            // aantal overgebleven kandidaten
21   aangewezen: Kandidaat;                // doorloopt kring
22   g: 1 .. NLettergrepen;                // doorloopt lettergrepen
23                                         //  lettergreep g valt op
24                                         //  aangewezen kandidaat
25   keizer: Kandidaat;                    // wie keizer wordt (uitvoer)
26   opvolger: array [ Kandidaat ] of Integer;
27                                         // opvolger aanwijzen
28   i: Kandidaat;                         // hulpvar voor opvolger init.
29   vorige: Kandidaat;                    // de vorige persoon, voor de aangewezen
30 
31 begin
32 ////////// 1. Lees aantal kandidaten //////////
33   write( 'Aantal kandidaten? ' );
34   readln( NKandidaten );
35   writeln( NKandidaten, ' kandidaten' );
36 
37 ////////// 2. Initialiseer volle kring. Wijs eerste kandidaat aan //////////
38 
39   for i := 0 to NKandidaten - 1 do begin
40     opvolger[ i ] := (i + 1) mod Nkandidaten;
41   end;                                  // alle opvolgers
42 
43   rest := NKandidaten;                  // alle kandidaten doen (nog) mee
44   aangewezen := 0;                      // kandidaat 0 als eerste aangewezen
45   g := 1;                               // lettergreep g valt op
46                                         //  aangewezen kandidaat
47 
48 ////////// 3. Dun kring uit tot een enkele kandidaat resteert, die keizer wordt
49 
50 
51   while rest <> 1 do begin
52 
53       ///// 3.1. Wijs kandidaat bij laatste lettergreep aan /////
54     while g <> NLettergrepen do begin
55 
56       vorige := aangewezen;
57       aangewezen := opvolger[ aangewezen ];
58                                         // volgende kandidaat
59       g := g + 1  ;
60     end;
61       ///// 3.2 Pas de opvolger aan /////
62                                         // laatste lettergreep is
63                                         // gevallen op de aangewezen kandidaat
64     opvolger[ vorige ] := opvolger[ aangewezen ];
65                                         // andere opvolger word toegekend
66 
67     aangewezen := opvolger[ aangewezen ];
68                                         // de aangewezen persoon schuift door
69     g := 1;                            // lettergreep reset
70     rest :=  rest-1;                    // er is 1 iemand minder
71   end;
72 
73   keizer := aangewezen;
74 
75 ////////// 4. Schrijf keizer //////////
76  writeln ( 'Kandidaat ', keizer : MaxNCijfers, ' wordt keizer' );
77 end.