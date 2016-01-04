1 program fierljeppen;
  2   { Etienne van Delden, 0618959, 03-11-2006  }
  3   { Dit programma berekent de minst inspannende weg voor een fierljepper die
  4       over een recht pad loopt. Hij krijgt de mogelijkheid om te springen of te
  5       lopen.}
  6 
  7 uses                              // maak gebruik van procs.pas
  8   procs;
  9 
 10 //**GLOBAL VARIABLES DECLARATION *******
 11 
 12 var
 13   input:  String;                 // var voor naam van het ingaande bestand
 14   output: String;                 // var voor naam van het uitgaande bestand
 15   inFile: Text;                   // var voor aanroepen van input bestand
 16   outFile: Text;                  // var voor aanroepen van output bestand
 17   in_run: Integer;                // var voor bijhouden hoeveel runs erzijn
 18   i: Integer;                     // hulp var
 19   r_run: Run;                     // var voor bepalen hoeveelste run behandeld
 20                                   //  wordt
 21   a_antwoord: Antwoord;           // var voor bewaren v/h antwoord
 22 
 23 //**MAIN PROGRAM **********************
 24 
 25 begin
 26 
 27 // ** INITIALISATION *******************
 28   input := 'fierljeppen.in';      // init input filenaam
 29   output := 'fierljeppen.out';    // init ouput filenaam
 30       // de in- en output voorbereiden
 31   AssignFile( inFile, input );
 32   AssignFile( outFile, output );
 33   Rewrite ( outFile );
 34   Reset( inFile);
 35 
 36 //** READ RUNS **********************
 37 
 38   read( inFile, in_run );         // lees hoeveel runs er in totaal zijn
 39 
 40 //** CALCULATE/WRITE RUNS***********
 41 
 42   for i := 1 to in_run do         // herhaal voor alle runs:
 43   begin
 44     ReadRun( inFile, r_run );     // lees de informatie behorend bij deze run
 45     ComputeAnswer( r_run, a_antwoord ); // bereken de minimale inspanning voor
 46                                         //  deze run
 47     WriteAnswer( outFile, a_antwoord ); // schrijf het antwoord naar de output file
 48   end;                            // end for
 49 
 50   CloseFile ( inFile );           // sluit het gelezen bestand
 51   CloseFile ( outFile );          // sluit het geschreven bestand
 52 
 53 end.