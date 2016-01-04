1 program CodeSquasherCounter;
  2  { Etienne van Delden, 0618959, 24-10-2006  }
  3   { Dit programma telt het gemiddelde aantal tekens per regel, het aantal
  4     tekens, het aantal tekens binnen commentaar en het percentage commentaar
  5     van een gegeven pascal file. De output is zowel een tekstfile, waarin alle
  6     tekens vervangen zijn door spaties, behalve bij commentaar, en standaard
  7     output naar het venster. }
  8 
  9   { pre: input is een bestaan, leesbaar pascal bestand, wat geldige pascal
 10     code bevat. Het opgegeven output bestand moet aangemaakt worden, of is
 11     herschrijfbaar.
 12     post: er worden 4 regels statistieken teruggeven in de commmand line. In
 13     het opgegeven output bestand staat de originele code van de input, waarbij
 14     alle tekens, behalve het commentaar, vervangen zijn door spaties }
 15 
 16   //**Top Level Variabele Declaratie ******************************
 17 
 18 var
 19   inFile      : Text;                   // de in te lezen file
 20   outFile     : Text;                   // de output file
 21   aantalRegels: Integer;                // aantal regels in inFile
 22   aantalTekens: Integer;                // aantal tekens in inFile
 23   aantalComments: Integer;              // aantal commentaartekens in inFile
 24   inp  : String;                        // var voor inlezen te lezen bestand
 25   outp : String;                        // var voor naam van output file
 26 
 27     //** Procedure ** Calculate Statistics **********************************
 28 
 29 procedure CalculateStatistics ( var inp,outp: Text; var i_lines, i_characters,
 30   i_comment: Integer );
 31   { pre: inp is geopend voor lezen, leeskop staat vooraan,
 32      inp bevat een syntactsch correct Pascal programma,
 33      outp is geopend voor schrijven, leeskop staat vooraan.
 34     post: leeskop en schrijfkop staan achteraan,
 35      outp bevat het commentaar uit inp,
 36      i_lines = aantal regels in inp
 37      i_characters = aantal non-whitespace tekens in inp
 38      i_comment = aantal non-whitespace commentaar-tekens in inp }
 39 
 40     //** Local Level Variabele Declaratoe ***********************
 41 
 42   var
 43 
 44     c_read: Char;                 // var voor het lezen van een teken
 45     s_code: String;               // string om output weg te schrijven
 46     t_position: ( Elders, InString, InBraces, AfterSlash, AfterSlashes );
 47                                   // de positie van de leeskop, zitten we in een
 48                                   //  string, commentaar of daarbuiten?
 49 const
 50   const_string = [ '''' ];        // const om strings te herkennen
 51   const_whitespace = [ ' ',  chr(9)  ]; // const om whitespaces te herkennen
 52 
 53     // De code van de procedure
 54   begin
 55 
 56     // Initialiseren van (hulp) variabelen
 57     i_lines      := 0;            // er zijn nog 0 regels gelezen
 58     i_comment    := 0;            // er zijn nog 0 commentaar tekens gelezen
 59     i_characters := 0;            // er zijn nog 0 tekens gelezen
 60     t_position   := Elders;       // de leeskop bevindt zich nog buiten
 61                                   //  strings en commentaar
 62 
 63     // Zolang het einde van het bestand nog niet is bereikt, verwerk de
 64     //  eerstvolgende regel
 65     while not Eof( inp ) do begin
 66 
 67     // Zolang het einde van de regel niet is behaald, verwerk het eerstvolgende
 68     //  teken
 69     while not Eoln( inp ) do begin
 70 
 71     //INITIALISATION
 72 
 73       s_code := ' ';              // we gaan ervan uit dat er minimaal 1 teken
 74                                   //  is wat we moeten vervangen
 75       read( inp, c_read );        // lees het eerstvolgende teken
 76 
 77                                   // als c_read geen whitespace is, dan
 78       if not (c_read in const_whitespace) then // verhogen we de tekens teller
 79       begin
 80         i_characters := i_characters + 1;
 81       end;
 82 
 83     // CASE DISTICTION
 84 
 85     // We gaan nu kijken wat de positie moet worden, aan de hand van de vorige
 86     //  positie en het zojuist gelezen teken.
 87     // Indien nodig verhogen we de commentaar teller.
 88 
 89       case t_position of
 90       // POSITION: ELDERS **************************
 91           Elders: begin           // De positie was 'Elders' ..
 92                                   // .. maar er komt een string aan
 93             if (c_read in const_string) then
 94             begin
 95               t_position := InString
 96             end                   // end if string
 97 
 98                                   // ... maar er komt commentaar aan.
 99 
100             else if ( c_read = '{' ) then
101             begin
102               t_position := InBraces;
103 
104               s_code := '{'       // Commentaar teken 'blijft' staan
105             end                   // end if bracket open
106 
107                                   // ... maar er is mogelijk commentaar, wanner
108                                   // als er hierna nog een / komt
109             else if (c_read = '/')  then
110             begin
111               t_position := AfterSlash;
112                                   // het is nog niet duidelijk of dit commentaar
113                                   //  is of niet, hier moeten we zometeen
114               s_code := ''        //  rekening mee houden
115             end                   // end if afterslash
116 
117           end;                    // end case(Elders)
118 
119       // POSITION: INSTRING **************************
120 
121           InString: begin         // De positie was 'Instring' ..
122                                   // .. maar nu eindigy de string
123             if (c_read in const_string ) then
124             begin
125               t_position := Elders
126             end                   // end if string
127 
128           end;
129 
130       // POSITION:INBRACERS **************************
131 
132           InBraces: begin         // De positie was 'InBraces' ..
133 
134             if ( c_read = '}' ) then // .. maar we gaan nu uit het commentaar
135             begin
136               s_code := '}';      // het teken moet wel nog geschren worden
137               t_position := Elders
138             end
139 
140             else                  // De rest van de tekens vallen onder
141             begin                       //  commentaar, wat gekopieerd word.
142               s_code := c_read;    // Als het teken geen spatie is
143                                   //  comment teller ophogen
144               if not ( c_read in const_whitespace ) then
145               begin
146                 i_comment := i_comment + 1
147               end;
148             end;                  // end if bracket close
149 
150           end;                    // end case( InBraces )
151 
152       // POSITION: AFTERSLASH **************************
153 
154           AfterSlash: begin       // De Positie was 'AfterSlash' (we hebben
155                                   //  zonet dus een / gelzen
156 
157             if (c_read = '{' ) then // .. maar we gaan naar commentaar
158             begin
159               s_code := ' {';       // de vorige / moet worden vervangen!
160               t_position := InBraces
161             end                     // end if bracket op
162 
163             else if (c_read = '/' ) then // .. en het wordt wel degelijk
164             begin                       // commentaar
165               s_code := '//';     // de vorige / niet vergeten te schrijve
166               t_position := AfterSlashes
167             end                   // end if //
168 
169             else                  // .. en word alsnog 'Elders'
170             begin
171               t_position := Elders;
172               s_code := '  '      // de vorige / niet vergeten te vervange
173             end
174           end;
175 
176       // POSITION: AFTERSLASHES **************************
177 
178         AfterSlashes: begin       // Alle tekens tot eoln kopieren, het is
179           s_code := c_read;       //  immers commentaar
180                                   // Als het teken geen spatie is
181                                   //  comment teller ophogen
182           if not ( c_read in const_whitespace ) then
183           begin
184             i_comment := i_comment + 1
185           end;
186         end;                      // end case( AfterSlashes)
187 
188       end;                        // end case
189 
190       // AFTER CASE PROCESSING
191                                   // We weten of het zojuist gelezen teken
192                                   //  commentaar is of niet en schrijven
193       write( outp, s_code);       //  het juiste teken
194 
195     end;                          // end while Eoln
196 
197     // We zijn nu aan het einde van de regel, als we achter / of // zaten,
198     //  dan gaan we nu terug naar 'Elders' in all andere gevallen blijft
199     //  de juiste positie
200     if ( t_position = AfterSlash) then
201     begin
202       t_position := Elders;
203     end
204     else if ( t_position = AfterSlashes ) then
205     begin
206       t_position := Elders
207     end;
208 
209     i_lines := i_lines + 1;     // we hebben een regel (uit)gelezen
210     readln( inp );              // de leeskop naar het begin van de volgende
211                                 //  regel
212     writeln( outp  );           // de schrijfkop naar het begin van de
213                                 // volgende regel
214   end                           // end while( Eof)
215 
216 end;                            // end procedure CountStatistics
217 
218     //** Proecdure ** WriteStatistics **********************************
219 
220 
221 procedure WriteStatistics ( const aantalRegels, aantalTekens, aantalComments: Integer );
222 { pre: r > 0 en t > 0
223    post: 4 regels met t/r, t, c, 100*c/t geschreven naar standaard-uitvoer }
224 
225 begin
226 
227   writeln( aantalTekens / aantalRegels : 0: 1  , ' tekens per regel (gemiddeld over ', aantalRegels, ' regels)');   // schrijf gem. tekens per regel
228   writeln( aantalTekens, ' tekens' );   //schrijf aantal tekens
229   writeln( aantalComments, ' commentaar-tekens'); // schrijf aantal commentaar
230   writeln( 100 * ( aantalComments / aantalTekens) : 0 : 1, ' percentage commentaar-tekens');                 // schrijf percentage commentaar
231 
232   // De writeln's zijn niet gewrapped omdat FPC 2.1.1 het niet tolereert dat een
233   //  string word gewrapped.
234 
235 
236 end;
237 
238     //** Het Werkelijke programma **********************************
239 
240 begin
241   readln( inp );                 // lees welk bestand geopend moet worden
242   readln( outp );                // lees de naam van de output
243 
244   // Initialisatie variabelen
245 
246   aantalRegels := 0;
247   aantalTekens := 0;
248   aantalComments := 0;
249 
250   AssignFile( inFile, inp );      // Open het zojuist ingegeven lees bestand
251   AssignFile( outFile, outp );    // Open het zojuist ingegeven schrijf bestand
252   Rewrite ( outFile );            // Schrijffile leeg maken
253   Reset( inFile);
254                                   // Voor de statistiek bereken procedure uit
255   CalculateStatistics( inFile, outFile, aantalRegels, aantalTekens,
256    aantalComments );
257   WriteStatistics( aantalRegels, aantalTekens, aantalComments );
258                                   // schrijf de zojuist geschreven output naar
259                                   //  het opgegeven output bestand
260 
261   CloseFile ( inFile );           // sluit het gelezen bestand
262   CloseFile ( outFile );          // sluit het geschreven bestand
263 end.