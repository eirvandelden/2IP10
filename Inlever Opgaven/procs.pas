unit procs;
  { Etienne van Delden, 0618959, 07-11-2006  }

interface

//**CONSTANT DEFINITION **********

const
{ Maxima }
MaxnRijen = 25;                   // Het maximale aantal rijen in een matrix
MaxnKolommen = 20;                // Het maximale aantal Kolommen in een matrix
MaxWaarde = 99;                   // De maximale waarde die een vak kan hebben
MaxSomPad = (MaxnRijen + MaxnKolommen) * MaxWaarde;
                                  // De allergrootste sompad is het maximale
                                  //  aantal rijen en het maximale aantal
                                  //  kolommen waar de maximale waarde instaat

CellWidth = 3;                    // De breedte van een schrijf veld in de output
                                  // (evt. * niet meegerekend)
  
//** TYPE DEFINITION *************  
  
type 
    
  TVeldWaarde = 0 .. MaxWaarde;   // De velwaardes lopen van 0 tot het maximum
  TRijIndex = 1 .. MaxnRijen;     // Het aantal rijen loopt van 1 tot het maximum
  TKolIndex = 1 .. MaxnKolommen;  // Het aantal kolommen loopt vna 1 tot het max
  TSomPad = 0 .. MaxSomPad;       // En het sompad loopt van 0 tot het max
                                  //  (1 vak met waarde 0 is het minimum)
                                  
  Kaart = record                  // De kaart ..
    nRijen: 1 .. MaxnRijen;       // .. bevat een aantal rijen
    nKolommen: 1 .. MaxnKolommen; // .. bevat een aantal kolommen
    energie: array [TRijIndex, TKolIndex] of TVeldWaarde; // .. bevat op ieder
                                  //  veld een bepaalde energiewaardee
  end;                            // end record: Kaart
  
  TAntwoord = record              // Het antwoord..
    map: Kaart;                   // .. bevat een kaart
    max: TSomPad;                 //  .. bevat een maximale energiewaarde voor
                                  //  de mogelijke paden
    pad: array [TRijIndex, TKolIndex] of Boolean; // hetzelfde kaartje, maar nu
                                  //  met vakjes of er op het vakje gelopen word
  end;                            // end recond: TAntwoord

//** INTERFACE: PROCEDURES ***************

procedure ReadMap (var input: Text; var map: Kaart);
  // Lees de kaart uit een input
  { pre: input is geopend voor lezen en de leeskop staat voor de kaart gegevens
    post: map bevat de data uit input, de leeskop staat achteraan }

procedure ComputeAnswer (const map: Kaart; var antwoord: TAntwoord);
    // Bereken mbv de gegevens in map wat het pad is waarvan je het meeste 
    //  energie krijgt
    { pre: de hele kaart is ingelezen
      post: het pad waarvan je de meeste energie krijgt is berekend }

    procedure WriteAnswer (var output: Text; const map: Kaart; const antwoord: TAntwoord);
  { pre: output is geopend om te schrijven, het maximale pad is berekend
    post: de gegevens in antwoord zijn weggeschreven naar output }

implementation

//** FUNCTIONS ****************
function  maximum( k,l: Integer ): Integer;
  { pre: 2 integers
    ret: de grootste van de 2   }

  begin
    
    if k < l then                 // als de een groter is dan de andere
    begin
      Result := l                 //  word hij het resulataat
    end
    else if k > l then            // dit was niet het geval
    begin
      Result := k                 // dus wordt de andere het resultaat
    end
    else if k = l then            // 2 gelijke getallen
    begin
      Result := k                 // 1 van de 2 word het resultaat
    end;

  end;                            // end maximum

//**PROCEDURES*****************

procedure ReadMap (var input: Text; var map: Kaart);
    { zie interface }


var
  leesRij: TRijIndex;             // teller var voor huidige rij
  leesKolom: TKolIndex;           // teller var voor huidige  kolom

begin
  // Lees het aantal rijen en het aantal kolommen
  read( input, map.nRijen, map.nKolommen );

  // Lees alle veldwaarden }
  for leesRij := 1 to map.nRijen do
  begin
    
    for leesKolom := 1 to map.nKolommen do
    begin
      read( input, map.energie[ leesRij, leesKolom ] ); // veldwaarden
    end;                          // end for kolommen
    
  end;                            // end for rijen
  
end; //procedure ReadMap
 

procedure ComputeAnswer (const map: Kaart; var antwoord: TAntwoord);
    { zie interface }

  var
    maxMap: array[ TRijIndex, TKolIndex ] of TSomPad; // alle opgetelde waardes
    huidigRij: TRijIndex;         // hulp var voor de huidige rij
    huidigKolom: TKolIndex;       // hulp var voor de huidige kolom
    somRechts: TSomPad;           // bepaal de groote van het vakje rechts van ons
    somOnder: TSomPad;            // bepaal de groote van het vakje onder ons
    grensRechts: Boolean;          // om te kijken of iets op de rechtergrens ligt
    grensOnder: Boolean;           // om te kijken of iets op de ondergrens ligt

  begin
    // Genereer de maximale padsom vanuit rechtsonder voor iedere positie

    somOnder := 0;
    
    for huidigRij := map.nRijen downto 1 do // doorloop voor alle rijen
    begin
      somRechts := 0;                       // de som vanaf rechts is 0
    
      for huidigKolom := map.nKolommen downto 1 do //voor alle kolommen
      begin
    
          if huidigRij < map.nRijen then  // als we niet bij de laatste rij zijn 
          begin
            somOnder := maxMap[ huidigRij + 1, huidigKolom ]; 
                   // pak dan de waarde van het vakje onder ons, in dezelfde kolom
          end;
          
          if huidigKolom < map.nKolommen then  // als we neit bij de laatste kolom zijn
          begin
            somRechts := maxMap[ huidigRij, huidigKolom + 1 ];
            // pak dan de waarde van het vakje orechts, in dezelfde rij                
          end;
          
          maxMap[ huidigRij, huidigKolom ] :=
            map.energie[ huidigRij, huidigKolom ] + maximum( somRechts, somOnder );
          // de maximale waarde op het huidge vakje, word zijn energie waarde, 
          //  plus de grootste onder of rechts van ons
      end;                      // end for 
      
    end;


    antwoord.map := map;        // Geef de huidige map door aan het antwoord
    antwoord.max := maxMap[ 1, 1 ]; // De grootste hoeveelheid energie

    { Genereer het pad }
    with antwoord, map do
    begin
      
    // Reset en/of Initialisatie van variabelen  
      huidigRij := 1;             // terug naar rij 1
      huidigKolom := 1;           // terug naar kolom 1
      somOnder := 0;              // reset van var
      somRechts := 0;             // reset van var
      grensRechts := False;       // we gaan ervan uit dat we niet bij de grens zijn
      grensOnder := False;        // we gaan ervan uit dat we niet bij de grens zijn
      pad [1, 1] := True;         // linksboven is het eerste vak waar we lopen
      
      // we gaan nu kijken waar we lopen
      while (huidigRij < nRijen) or (huidigKolom < nKolommen) do
      begin
      
        if huidigRij < nRijen then  // als we niet bij de laatste rij zijn
        begin
          somOnder := maxMap [huidigRij + 1, huidigKolom];
        end
        else
        begin
          grensOnder := True;       // we zitten aan de grens
        end;
        
        if huidigKolom < nKolommen then begin // als we neit bij de laatste kolom zijn
          somRechts := maxMap [huidigRij, huidigKolom + 1];
        end
        else
        begin
          grensRechts := True;      // we zitten aan de grens
        end;
        
        // als we naar onderen kunnen gaan
        if grensRechts or ((not grensOnder) and (somOnder > somRechts)) then
        begin
          huidigRij := huidigRij + 1; // naar de volgende rij
        end
        else
        begin
          huidigKolom := huidigKolom + 1; // naar de volgende kolom
        end;
        
        pad [huidigRij, huidigKolom] := True; // we hebben op dit pad gelopen
      end;
    end;


  end; //procedure ComputeAnswer
  
    procedure WriteAnswer (var output: Text; const map: Kaart; const antwoord: TAntwoord);
    { zie interface }

    var
      schrijfRij: TRijIndex; // iterator voor de huidige rij
      schrijfKolom: TKolIndex; // iterator voor de huidige kolom

    begin
      writeln( output, antwoord.max);
      writeln( output );

      with antwoord, map do
      begin
      
        for schrijfRij := 1 to nRijen do // voor iedere rij
        begin
        
          for schrijfKolom := 1 to nKolommen do // en voor iedere kolom
          begin
            write( output, energie[ schrijfRij, schrijfKolom ]: CellWidth );

            if pad[ schrijfRij, schrijfKolom] then 
            begin                 // zitten we op het pad?
              write( output, '*' ); // dan een extra sterretje scchrijven
            end
            else if schrijfKolom < nKolommen then
            begin                 // als we niet op laatste kolom zitten
              write( output, ' ' ); //  maak een scheidings-spatie
            end;                  // end if path
              
          end;                    //en for huidigKolom
            
          writeln( output );
          
        end;                      // end for huidigRij
      end;                        // end with: answer, map

    end;                          // endprocedure Writeantwoord


end.                              // end procs.pas