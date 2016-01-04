1 program GelijkeBuren;
  2   { Etienne van Delden, 0618959, 15-09-2006 }
  3   { Dit programma bepaalt van een gegeven invoer (die eindigt bij -1)
  4     hoeveel gelijkwaardige buren hierin zitten.  }
  5 
  6 
  7 var
  8   input1:      Integer;                 // var input
  9   input0:      Integer;                 // var vorige input
 10   gb    :      Integer;                 // var hoeveel gelijke buren
 11 
 12 begin
 13                                         // initialiseren variabelen
 14   input1 := -2;
 15   input0 := -3;
 16   gb := 0;
 17 
 18   while input1 <> -1 do                 // is het einde behaald?
 19     begin
 20       read( input1 );                   // lees nieuw getal
 21 
 22       if input1 = input0 then           // is de waarde gelijk aan het vorige?
 23         gb := gb + 1;                    // gelijke waarde gevonden
 24 
 25       input0 := input1;                 // doorgeven van de waarde
 26 
 27     end;
 28 
 29   writeln( gb )                         // output
 30 end.