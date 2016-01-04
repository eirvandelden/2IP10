1 program Snoep;
  2   { Etienne van Delden, 0618959, 10-09-2006 }
  3   { Dit programma kijkt C snoepjes eerlijk verdeeld kan worden over
  4     K Kinderen. Zo ja, dan word er uitgerekent hoeveel snoepjes
  5     ieder kind krijgt}
  6 
  7 var
  8   K, C: Integer;                  // De kinderen en de snoepjes (invoer)
  9   Q   : Integer;                  // var voor het aantal snoepjes per kind
 10 
 11 begin
 12   readln ( K, C ) ;               // invoer
 13 
 14   if K = 0 then                   // Controle op fake input
 15     writeln( 'No' )
 16   else if C = 0 then
 17     writeln( 'No' )
 18 
 19   else                            // Input is goed, nu de verdeling
 20     begin
 21     if C mod K > 0 then           // Kan C eerlijk verdeeld worden over K?
 22         writeln( 'No' )           // Ouput, het kan niet
 23     else
 24       begin                       // Het kan wel, hoeveel snoepjes krijgt
 25                                   //  ieder kind?
 26       Q := C div K;
 27       writeln( 'Yes' );           // Ouput: Het kan wel
 28                   writeln( Q );               // Output: De snoepjes per kind
 29       end;
 30     end;
 31   writeln ( 'Tik <return> om programma te verlaten: ' );
 32   readln
 33 end.