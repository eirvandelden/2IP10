1 program Mediaan;
   2   { Etienne van Delden, 0618959, 10-09-2006 }
   3   { Dit programma bepaalt van 3 ingevoerde getallen de middelste in grote.
   4     Als de invoer 2 gelijke getallen heeft, dan schrijft hij een lege
   5     regel. Ik maak gebruik van methode 1, de controle op de conditie per
   6     var in een if-constructie.}
   7 
   8 var
   9   A, B, C: Integer;                     // Input var voor de 3 getallen
  10 
  11 begin
  12   readln( A, B, C );                    // Lees input
  13 
  14                                         // Eerst de controle op gelijke
  15   if A = B then                         //  getallen
  16     writeln( '' )
  17   else if A = C then
  18     writeln( '' )
  19   else if B = C then
  20     writeln( '' )
  21                                         // Mediaan bepalen
  22   else if A > B then                    // A is groter dan B
  23     begin
  24       if A > C then                       // A is groter dan C
  25                                           // B of C is mediaan
  26         begin
  27           if B > C then                    // B is mediaan
  28             writeln( B )                   // Output B
  29           else                             // C is mediaan
  30             writeln( C )                  // Output C
  31         end
  32       else                                // A is kleiner dan C
  33                                           // A is mediaan
  34         writeln( A )                      // Output A
  35     end
  36 
  37   else                                  // A is kleiner dan B
  38     begin
  39       if a > c then                       // A is Mediaan
  40        writeln( a )                       // Ouput A
  41       else                                // A is kleinder dan C
  42                                           // B of C is mediaan
  43         begin
  44           if b > c then                    // C is mediaan
  45             writeln( c )                   // Ouput C
  46           else                             // B is mediaan
  47            writeln( b )                    // Ouput B
  48         end;
  49       end;
  50   writeln ( 'Tik <return> om programma te verlaten: ' );
  51   readln
  52 end.