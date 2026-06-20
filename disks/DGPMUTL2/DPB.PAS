LAB [L[1],C[1]]:=#128; GotoXY(22,23); Write(Pt)
        END;
      C[1]:=C[1]+Ic[1]; L[1]:=L[1]+Il[1];
      IF (Mc[1]<25) OR (Mc[1]>56) OR (Ml[1]<4) OR (Ml[1]>19) THEN
        Say(Mc[1],Ml[1],#128)
      ELSE
        IF M=1 THEN Say(Mc[1],Ml[1],TOPTEN [Ml[1]-3,Mc[1]-24]);
      Move(Mc[2],Mc[1],11);
      Move(Ml[2],Ml[1],11);
      Mc[12]:=Uc; Ml[12]:=Ul
    UNTIL (Key=#13) OR (Pt=1214*Fase);
    IF (Key<>#13) THEN
      BEGIN
        Fase:=Fase+1; Vidas:=Vidas+1;
        FOR X:=1 TO 23 DO F)=1 THEN Tsh(G)
END;

PROCEDURE Tsva(H : Byte);
BEGIN
  IF Random(2)=1 THEN Tsv(H)
END;

PROCEDURE Inicio;
BEGIN
  C[1]:=41; L[1]:=11;
  Ic[1]:=0; Il[1]:=0;
  GotoXY(1,1); FOR X:=1 TO 23 DO Write(LAB [X]);
  GotoXY(22,23); Write(Pt);
  GotoXY(45,23); Write(Vidas);
  GotoXY(66,23); Write(Fase)
END;

BEGIN
  FOR Y:=1 TO 12 DO FOR X:=1 TO 80 DO
    IF LAB [Y,X] = '|' THEN LAB [Y,X]:=#143 ELSE
      IF LAB [Y,X] IN ['-','+'] THEN LAB [Y,X]:=#140;
  FOR Y:=13 TO 23 DO FOR X:=1 TO 80 DO
    IF LAB [Y,X] IN ['|','+'] THEN LAB [Y,X]:=#143 ELSE
      IF LAB [Y,X]='-' THEN LAB [Y,X]:=#140;
  FOR X:=1 TO 23 DO FOR Y:=4 TO 77 DO
    IF LAB [X,Y]=#128 THEN LAB [X,Y]:=#46;
  Vidas:=5; Fase:=1; Pt:=0;
  REPEAT
    Inicio; READ; Tsv(1); Tsh(1); M:=Random(2);
    FOR X:=1 TO 12 DO BEGIN Mc[X]:=C[1]; Ml[X]:=L[1] END;
    FOR X:=1 TO 16 DO Say(25,X+3,TOPTEN [X]);
    Say