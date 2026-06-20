Say(5,3,'Qual o numero do disco a ser recuperado ?    ');
      GotoXY(47,3);
      BufLen:=3;
      Read(Numero)
    UNTIL (Numero>0) AND (Numero<=ContReg) AND (IOResult=0);
    Say(5,3,Seq(44,32));
    {$I+}
    Ponteiro:=Numero-1;
    Mostra;
    IF RegArq1.Numero<>-1 THEN
      BEGIN
        Say(11,24,'Este disco nao esta'' apagado. Verifique e tente novamente.');
        Delay(2000);
        Say(8,24,CLRLIN)
      END
    ELSE
      IF RegArq2 [1]='' THEN
        BEGIN
          Say(1DURE Say(Col,Lin :Byte; Msg :Str80);
BEGIN
  GotoXY(Col,Lin);
  Write(Msg)
END; {Say}

PROCEDURE Window (X1,Y1,X2,Y2: Byte);
VAR
  Lin, Tam :Byte;
  Blank :ARRAY [1..78] OF Char;
  Li,Ls :ARRAY [1..80] OF Char;
BEGIN
  Tam:=X2-X1;
  FillChar(Blank,Tam-2,32);
  FillChar(Ls,Tam,140);
  FillChar(Li,Tam,131);
  GotoXY(X1,Y1);
  Write(Copy(Ls,1,Tam));
  FOR Lin:=Y1+1 T