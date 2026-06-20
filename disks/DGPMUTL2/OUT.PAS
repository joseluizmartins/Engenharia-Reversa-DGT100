;
  FOR Lin:=Y1+1 TO Y2-1 DO
    BEGIN
      GotoXY(X1,Lin);
      Write(#42,Copy(Blank,1,Tam-2),#42)
    END;
  GotoXY(X1,Y2);
  Write(Copy(Li,1,Tam))
END;

PROCEDURE Box(X1,Y1,X2,Y2,Ce: Byte);
VAR
  Lin,V,Tam :Byte;
  Blank :ARRAY [1..78] OF Char;
  Li,Ls :ARRAY [1..80] OF Char;
BEGIN
  Tam:=X2-X1+1;
  FillChar(Blank,Tam-2,32);
  FOR V:=X1 TO X2 DO
    BEGIN
      Tela [V,Y1]:=Chr(Ce);
      Tela [V,Y2]:=Chr(Ce)
    END;
  FillChar(Ls,Tam,Ce);
  FillChar(Li,Tam,Ce);
  GotoXY(X1,Y1ееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееее