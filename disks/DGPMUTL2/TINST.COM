andom(4)+2; En:=1000; Bn:=2000; Fundo:='|';
  FOR X:=2 TO 5 DO BEGIN GotoXY(C[X],L[X]); Write('O'); END
END;

BEGIN
  Inicio;
  REPEAT
    REPEAT
      GotoXY(C[1],L[1]); Write('*'); Delay(20);
      FOR X:=2 TO 5 DO IF (C[1]=C[X]) AND (L[1]=L[X]) THEN Fim:=TRUE;
      IF Fim THEN Perda;
      IF Lab [C[1]-11,L[1]-3]=Fundo THEN
        BEGIN Pt:=Pt+1; En:=En+1; Lab [C[1]-11,L[1]-3]:=#32 END
      ELSE
        En:=En-1;
      IF Bn>0 THEN Bn:=Bn-1;
      IF KeyPressed THEN
        BEGIN
   
    IF LAB [X,Y]=#128 THEN LAB [X,Y]:=#46;
END;

BEGIN
  Vidas:=5; Fase:=1; Pt:=0; {MudaLabCP500;}
  GotoXY(1,1); FOR Y:=1 TO 23 DO Write(LAB [Y]);
  REPEAT
    Inicio;
    Game;
    IF (Pt=Fase*1176) AND (Vidas>0) THEN
      BEGIN
        Fase:=Fase+1; Vidas:=Vidas+1;
        FOR X:=1 TO 23 DO
          FOR Y:=4 TO 77 DO
            IF LAB [X,Y]=#128 THEN LAB [X,Y]:=#46;
        GotoXY(1,1); FOR X:=1 TO 23 DO Write(LAB [X])
      END
    ELSE
     IF Vidas>0 THEN
       BEGIN GotoXY(1,13]:=65; L[3]:=9;
  C[4]:=15; L[4]:=17; C[5]:=65; L[5]:=17;
  FOR X:=2 TO 5 DO BEGIN GotoXY(C[X],L[X]); Write('O') END
END;

PROCEDURE Perda;
BEGIN
  GotoXY(10,23);
  Write('Voce foi apanhado. Perda de 200 unidades de energia.');
  En:=En-200; Fim:=En<=0; Delay(1000); GotoXY(10,23); Write(#27#126#75);
  Inicializa
END;

PROCEDURE Inicio;
BEGIN
  Write(SOME);
  ClrScr;
  FOR X:=11 TO 70 DO
    BEGIN
      GotoXY(X,03); Write('#');
      GotoXY(X,22); Write('#')
    END;
  FOR Y:=4 TO 21 ååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOåååååååPROLOGICA-85ååååFORMATADOååååå); FOR Y:=1 TO 23 DO Write(LAB [Y]) END
  UNTIL (Vidas=0) OR (Key=#13);
  IF Key<>#13 THEN Score
END. TO 23 DO Write(LAB [Y]);
  REPEAT
    Inicio;
    Game;
    IF (Pt=Fase*1176) AND (Vidas>0) THEN
      BEGIN
        Fase:=Fase+1; Vidas:=Vidas+1;
        FOR X:=1 TO 23 DO
          FOR Y:=4 TO 77 DO
            IF LAB [X,Y]=#128 THEN LAB [X,Y]:=#46;
        GotoXY(1,1); FOR X:=1 TO 23 DO Write(LAB [X])
      END
    ELSE
     IF Vidas>0 THEN
       BEGIN GotoXY(1,1DO
    BEGIN
      GotoXY(11,Y); Write('#');
      GotoXY(70,Y); Write('#')
    END;
  Fases:='|.:+'; Fase:=1;
  FillChar(Lab,SizeOf(Lab),124);
  FOR X:=12 TO 69 DO
    FOR Y:=4 TO 21 DO
      BEGIN GotoXY(X,Y); Write(Lab [X-11,Y-3]) END;
  GotoXY(12,24); Write('Pontos:');
  GotoXY(33,24); Write('Energia:');
  GotoXY(49,24); Write('Bonus:');
  C[1]:=41; L[1]:=12; Key:=#0; Fim:=False;
  C[2]:=15; L[2]:=9; C[3]:=65; L[3]:=9;
  C[4]:=15; L[4]:=17; C[5]:=65; L[5]:=17;
  Ic:=0; Il:=0; Pt:=0; Y:=R END;
    Say(Ac,Al,LAB [Al,Ac])
  UNTIL (Key=#13) OR (Fim) OR (Pt=Fase*1176);
  IF Key=#13 THEN Vidas:=0 ELSE
    IF Fim THEN Vidas:=Vidas-1
END;

PROCEDURE MudaLabCP500;
BEGIN
  FOR Y:=1 TO 12 DO FOR X:=1 TO 80 DO
    IF LAB [Y,X] = '|' THEN LAB [Y,X]:=#143 ELSE
      IF LAB [Y,X] IN ['-','+'] THEN LAB [Y,X]:=#140;
  FOR Y:=13 TO 23 DO FOR X:=1 TO 80 DO
    IF LAB [Y,X] IN ['|','+'] THEN LAB [Y,X]:=#143 ELSE
      IF LAB [Y,X]='-' THEN LAB [Y,X]:=#140;
  FOR X:=1 TO 23 DO FOR Y:=4 TO 77 DO1                  TURBO Pascal installation menu.
2           Choose installation item from the following:

3 [S]creen installation   |   [C]ommand installation   |   e[X]it

4                        Enter S, C, or X: 
10 Duplicate definition. Error occurred between question
11 Commands starting with the same letter must have the same length.
   Error occurred between question
12 The total maximum length of commands are execeeded
13  -> 

14 CURSOR MOVEMENTS:

20  Character left  
21    Alt Delete terminal? (Enter no. or ^Q to exit):
 Do you want to modify this definition before installation? 
 Terminal type:
 Send an initialization string to the terminal?
 Initializaion defined as a command string? (No = a file)
 Send a reset string to the terminal
 Reset defined as a command? (No = a file)
 CURSOR LEAD-IN command: 
 CURSOR POSITIONING COMMAND to send between line and column:   
 CURSOR POSITIONING COMMAND to send after both line and column:
 Column first
 OFFSET to add to LINE:  replace          
56  Repeat last find        
57  Control character prefix
101 Nothing
 Enter ^X: Exit program, ^R: last page, ^C: next page, ^M: Select Terminal>
 Wait Sorting Definitions
 Change to:
 (Y/N)? 
 y
 n
 Text file name:
 Command:
 Numeric entry expected
 Legal range is 
 , please re-enter: 
 Choose one of the following terminals:
 None of the above   ( Max. 20 Characters )
 Delete a definition ( Max. 20 Characters )
 Which terminal? (Enter no. or ^X to exit): 
 Delete termin             
49  Mark block end               
50  Mark single word             
51  Hide/display block           
52  Copy block                   
53  Move block                   
54  Delete block                 
55  Read block from disk         
56  Write block to disk          


17 MISC. EDITING COMMANDS:  

57  End edit                     
58  Tab                          
59  Auto tab on/off              
60  Restore line                 
61  Find                         
62  Fiernative   
22  Character right 
23  Word left       
24  Word right      
25  Line up         
26  Line down       
27  Page up         
28  Page down       
29  To top of file  
30  To end of file  
31  To left on line 
32  To right on line
33  To last position

15 INSERT & DELETE:

34  Insert mode on/off           
35  Insert line                  
36  Delete line                  
37  Delete to end of line        
38  Delete right word            
39  Delete character under cursor

 OFFSET to add to COLUMN:
 Binary address
 Number of ASCII digits (2 or 3): 
 CLEAR SCREEN command: 
 Does CLEAR SCREEN also HOME cursor
 HOME command: 
 DELETE LINE command: 
 INSERT LINE command: 
 ERASE TO END OF LINE command:
 START HIGHLIGHTING command:  
 END HIGHLIGHTING command:    
 Number of rows (lines) on your screen: 
 Number of columns on your screen:      
 Delay after CURSOR ADDRESS (0-255 ms):                     
 Delay after CLEAR, DELETE and INSERT (0-255 ms):           
 Delay after ERASE TO END OF LINE and HIGHLIGHT (0-255 ms): 
 Is this definition correct?
                     Hardware dependent information
 Operating frequency of your microprocessor in MHz (for delays):
TING command:  
 END HIGHLIGHTING command:    
 Number of rows (lines) on your screen: 
 Number of columns on your screen:      
 Delay after CURSOR ADDRESS (0-255 ms):                     
 Delay after CLEAR, DELETE and INSERT (0-255 ms):           nd & replace               
63  Repeat last find             
64  Control character prefix     

101 Nothing
 ^Q: Quit, ^R: Last page, ^C: Next page, <RETURN>: Select terminal:
 Wait Sorting Definitions
 Change to:
 (Y/N)? 
 y
 n
 Text file name:
 Command:
 Numeric entry expected
 Legal range is 
 , please re-enter: 
 Choose one of the following terminals:
 None of the above   ( Max. 20 Characters )
 Delete a definition ( Max. 20 Characters )
 Which terminal? (Enter no. or ^Q to exit): 
40  Delete left character        
41    Alternative                

16 BLOCK COMMANDS:               

42  Begin block         
43  End block           
44  Mark single word    
45  Copy block          
46  Move block          
47  Delete block        
48  Read block from file
49  Write block to file 

17 MISC. EDITING COMMANDS:  

50  End edit                
51  Tab                     
52  Auto tab on/off         
53  Restore line            
54  Find                    
55  Find & 