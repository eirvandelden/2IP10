  1 unit Lists;
  2   { Oktober 2003; Tom Verhoeff; versie 1.0 }
  3   { unit om lijsten te manipuleren }
  4   { Oefenversie zonder implementatie van Find }
  5 
  6 interface
  7 
  8 const
  9   MaxListLen = 24; { maximum lengte van een lijst, 1 <= MaxListLen }
 10   MinEntry = 0; { kleinste waarde in een lijst }
 11   MaxEntry = 99; { grootste waarde in een lijst, MinEntry <= MaxEntry }
 12 
 13 type
 14   Index = 0 .. MaxListLen - 1; { index in een lijst }
 15   Entry = MinEntry .. MaxEntry; { waarde in een lijst }
 16   List = record
 17            len: 0 .. MaxListLen; { actuele lengte van de lijst }
 18            val: array [ Index ] of Entry; { de rij van waarden in de lijst }
 19              { de lijst bestaat uit de waarden val[0] t/m val[len-1] }
 20          end;
 21   { Voor s: List, is vereist dat s.val[i] gedefinieerd is voor 0 <= i < s.len }
 22 
 23 procedure Find ( const s: List; const x: Entry;
 24                  var found: Boolean; var pos: Index );
 25   { zoek x in lijst s }
 26   { pre:  s is oplopend gesorteerd (duplicaten toegestaan)
 27     post: found = `er bestaat een i met 0<=i<s.len en s.val[i]=x', en
 28           found impliceert  0<=pos<s.len  en  s.val[pos] = x }
 29 
 30 procedure WriteList ( var f: Text; const ident: String; const s: List );
 31   { schrijf lijst s naar f }
 32   { pre:  f is geopend om te schrijven
 33     post: lijst s is geschreven naar f, volgens het formaat
 34           ident.len: ...
 35           ident.val: ... }
 36 
 37 procedure GenerateList ( var s: List; const n, m, d, c: Integer );
 38   { genereer lijst s met lengte n volgens patroon m, d, c:
 39     blokken van lengte d met gelijke waarden c, c+m, c+2m, ... }
 40   { pre:  0 <= n <= MaxListLen,  d > 0,
 41           MinEntry <= m * (i div d) + c <= MaxEntry  voor 0 <= i < n
 42     post: s.len = n  en  s.val[i] = m * (i div d) + c  voor 0 <= i < n }
 43 
 44 implementation
 45 
 46 //** PROCEDURE FIND ************************
 47 
 48 
 49 procedure Find ( const s: List; const x: Entry;
 50                  var found: Boolean; var pos: Index );
 51   { zie interface }
 52 
 53   var
 54     h: Integer;                   // var voor het bepalen van het midden
 55     i: Integer;                   // de lower limit
 56     j: Integer;                   // de upper limit
 57 
 58   begin
 59 
 60   // ** INITIALISATION ***
 61     i := -1;                      // vaststellen lower limit
 62     j := s.len;                   // vaststellen upper limit
 63     found := false;               // we gaan ervanuit dat het getal we we zoeken
 64                                   //  niet word gevonden
 65     pos := 0;                     // we gaan ervanuit dat het getal we we zoeken
 66                                   //  niet word gevonden
 67 
 68 
 69   // de zoekende while lus. Zolang i + 1 < j moet er gezocht worden.
 70     while ( ( i + 1 ) < j ) do
 71     begin
 72 
 73       h := ( i + j ) div 2;       // bepaal het midden
 74 
 75       if s.val[h] <= x then       // als de waarde van het midden kleiner of
 76       begin                       //  gelijk is aan x, dan stellen we de lower
 77         i := h                    //  limit bij
 78       end                         // end if
 79       else if s.val[h] > x then   // als de waarde van het midden groter is dan
 80       begin                       //  x, dan stellen we de upper limit bij
 81         j := h
 82       end                         // end if
 83 
 84     end;                          // end while
 85 
 86     if ( i >= 0 ) then            // we controleren nu of het gevonden getal in
 87     begin                         //  de lijst staat.
 88       if s.val[i] = x then        // is de waarde van getal i gelijk aan x?
 89       begin
 90         found := True;            // we hebben ons geta; gevonden
 91         pos := i;                 // en de positie van x
 92       end;
 93     end;
 94 
 95 
 96 
 97   end;                            // end Procedure Find
 98 
 99 procedure WriteList ( var f: Text; const ident: String; const s: List );
100   { zie interface }
101   var
102     i: Integer; { om waarden van s te doorlopen }
103      { i: Index, but then for-loop fails with Range Check error when s.len=0 }
104   begin
105     with s do begin
106       writeln ( f, ident, '.len: ', len )
107     ; write ( f, ident, '.val:' )
108 
109     ; for i := 0 to len - 1 do begin
110         write ( f, ' ', val [ i ] )
111       end { for i }
112 
113     ; writeln ( f )
114     end { with s }
115   end; { WriteList }
116 
117 procedure GenerateList ( var s: List; const n, m, d, c: Integer );
118   { zie interface }
119   begin
120     with s do begin
121       len := 0
122 
123       { invariant: val[i] ingevuld voor alle i met 0 <= i < len <= n }
124     ; while len <> n do begin
125         val[len] := m * ( len div d ) + c
126       ; len := len + 1
127       end { for len }
128 
129     end { with s }
130   end; { GenerateList }
131 
132 end.