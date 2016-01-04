program EnergiePillen;
  { Etienne van Delden, 0618959, 07-11-2006  }
  { De berekent van een energie waarden tabel, het pad wat je moet doorlopen
    om zoveel mogelijk energie uit die tabel te halen. Dit word naar een apart
    bestand geschreven waarin ook het te doorlopen pad word weergegeven. }

uses 
  procs;

//** GLOBAL CONSTANT DEFINITION **********

const
    InputFilename = 'energiepillen.in'; // naam van het input bestand
    OutputFilename = 'energiepillen.out'; /// naam van het output bestand

//** GLOBAL VARIABLE DEFINITION **********
  var
    inFile: Text;                 // var voor input bestand (lezen)
    outFile: Text;                // var voor output bestand  (schrijven)
    map: Kaart;                   // de kaart waar het omgaat
    antwoord: TAntwoord;          // var om het antwoord door te voeren

  begin
    

    AssignFile( inFile, InputFilename ); // open het te lezen bestand
    Reset( inFile );              // zet de leeskop vooraan
    ReadMap (inFile, map );       // Lees alle gevens
    Close (inFile);               // sluit het te lezen bestand

    ComputeAnswer( map, antwoord );// bereken het antwoord
    
    AssignFile( outFile, OutputFilename ); // open het te schrijven bestand

    ReWrite( outFile );           // zet de schrijfkop vooraan

    WriteAnswer( outFile, map, antwoord );  // schrijf het antwoord weg

    close( outFile );               // sluit het te schrijven bestand


  end.

	
  