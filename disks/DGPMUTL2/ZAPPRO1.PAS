aDir;
BEGIN
  Cl:=8;
  Ln:=5;
  FOR C:=1 TO Cp DO
    BEGIN
      GotoXY(Cl,Ln);
      Write(Copy(RegArq2[C],1,8),'.',Cop