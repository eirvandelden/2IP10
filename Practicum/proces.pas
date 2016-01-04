1 unit procs;
   2   { Etienne van Delden, 0618959, 03-11-2006  }
   3 
   4 interface
   5 
   6 //**CONSTANT DEFINITION **********
   7 
   8 const
   9   MaxSa = 1000;                   // maximale sprongafstand
  10   MaxSk = 1000;                   // maximale sprongkosten
  11   MaxLen = 10000;                 // maximale lengte
  12 
  13 //** TYPE DEFINITION *************
  14 
  15 type
  16 
  17      Run = record
  18        sa: 1 .. MaxSa;            // sprongafstand
  19        sk: 1 .. MaxSk;            // sprongkosten
  20        len: 1 .. MaxLen;          // lengte
  21        k: array [ 1 .. MaxLen ] of Integer;
  22      end;                         // end type: Run
  23 
  24      Antwoord = record
  25        m: Integer;                // minimale kosten voor route naar vakje len
  26      end;                         // end type: Antwoord
  27 
  28 //** INTERFACE: PROCEDURES ***************
  29 
  30 procedure ReadRun ( var f: Text; var r: Run );
  31   { pre: f is geopend voor lezen, leeskop staat vooraan. f is een geldig
  32       input bestand.
  33     post: leeskop staat achteraan, sa, sk, len en de array k zijn ingevuld }
  34 
  35 procedure ComputeAnswer ( const r: Run; var a: Antwoord );
  36   { pre: de run informatie is ingelzen.
  37     post: het antwoord, behorend bij de gegevens van r, is ingevuld. }
  38 
  39 procedure WriteAnswer ( var f: Text; const a: Antwoord );
  40   { pre: het antwoord is uitegerekent, de output file is geopend om te schrijven.
  41     post: een bestand is geschreven met alle antwoorden a erin op een aparte regel.}
  42 
  43 implementation
  44 
  45 //** FUNCTIONS ****************
  46 function  minimum ( k,l: Integer ): Integer;
  47   { pre: 2 integers
  48     ret: de kleinset van de 2   }
  49 
  50   begin
  51 
  52     if k < l then         // als de een groter is dan de andere
  53     begin
  54       Result := k         //  word hij het resulataat
  55     end
  56     else if k > l then    // dit was niet het geval
  57     begin
  58       Result := l         // dus wordt de andere het resuktaat
  59     end
  60     else if k = l then    // 2 gelijke getallen
  61     begin
  62       Result := k         // 1 van de 2 word het resultaat
  63     end;
  64 
  65   end;                            // end minimum
  66 
  67 //**PROCEDURES*****************
  68 
  69 procedure ReadRun ( var f: Text; var r: Run );
  70   { zie interface }
  71 
  72   var
  73     j: Integer;                   // hulp var
  74 
  75   begin
  76 
  77     read( f, r.sa );              // lees sprong afstand
  78     read( f, r.sk );              // lees sprongkosten
  79     read( f, r.len);              // lees weglengte
  80 
  81     for j := 1 to r.len do        // voor ieder vakje, lees de kosten om naar
  82     begin                         //  vakje te lopen
  83       read( f, r.k[ j ] );
  84     end;
  85   end;                            // end procedure ReadRun
  86 
  87 procedure ComputeAnswer ( const r: Run; var a: Antwoord );
  88   { zie interface }
  89 
  90   var
  91     i: Integer;                   // hulp var
  92     k: Integer;                   // hulp var
  93     l: Integer;                   // hulp var
  94     g: array [ 0 .. MaxLen ] of Integer;  // de goedkoopste waardes
  95 
  96   begin
  97 
  98     a.m := 0;                     // we gaan uit van geen antwoord
  99 
 100     for i := 0 to r.len do        // init goedkoopste oplossing: overal 0
 101     begin
 102       g[ i ] := 0
 103     end;
 104 
 105     i := 0;                       // reset teller var voor hergebruik
 106 
 107     while ( i <> r.len ) do       // zolang we niet het einde hebben behaald
 108     begin
 109 
 110       i := i + 1;                 // we zijn 1 vakje verder
 111 
 112       if ( 0 < i ) and ( i < r.sa ) then  //als het vakje waar ze zijn onder de
 113       begin                               //  sprong afstand zit
 114         g[ i ] := r.k[ i ] + g[ i - 1 ];  // dan is de goedkoopste oplossing lopen
 115       end
 116       else if ( r.sa <= i ) and ( i <= r.len ) then
 117       begin                       // als we bij een vakje zijn, groter dan de
 118                                   //  kleinste sprong en niet voorbij het einde
 119 
 120         k := g[ i - 1 ];          // init hulp var
 121         l :=  g[ i - r.sa ] + r.sk; // init hulp var
 122         g[ i ] := r.k[ i ] + minimum( k, l ); //bepaal de goedkoopste oplossing
 123       end;                        // end else if
 124 
 125     end;                          // end while
 126 
 127     a.m := g[ r.len ];            // schrijf het antwoord
 128 
 129   end;
 130 
 131 
 132 procedure WriteAnswer ( var f: Text; const a: Antwoord );
 133   { zien interface }
 134   begin
 135     writeln( f, a.m );            // schrijf het antwoord naar output file
 136   end;
 137 
 138 end.                              // end pros.pas