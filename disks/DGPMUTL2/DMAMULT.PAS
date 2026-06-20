   Erro(3);
              Close(Fonte);
              Close(Destino)
            END
          ELSE
            BEGIN
              ReWrite(Destino);
              WriteLn('Tamanho do arquivo fonte...: ',FileSize(Fonte));
              WriteLn('Arquivo fonte..............: ',Naf);
              WriteLn('Arquio destino.............: ',Nad);
              WriteLn('Registros copiados.........: ');
              REPEAT
                BlockRead(Fonte,Buffer,FileSize(Fonte));
                GotoXY(                       **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  WriteLn(Lst,'**                                    **');
  2,24,'Este disco nao foi apagado. Verifique e tente novamente.');
          Delay(2000);
          Say(8,24,CLRLIN)
        END
      ELSE
        BEGIN
          RegArq1.Numero:=Numero;
          Seek(Arquivo1,Numero-1);
          Write(Arquivo1,RegArq1);
          Say(29,24,'Recuperacao executada.');
          Close(Arquivo1);
          Inicializa
        END;
    Say(20,24,'Deseja recuperar mais diretorios ? [S/N]:');
    REPEAT
      Read(Kbd,Tecla);
      Tecla:=UpCase(Tecla)
    UNTILy(Li,1,Tam))
END; {Window}

PROCEDURE MostraDir;
VAR Ln, Cl, C :Integer;
BEGIN
  Cl:=8;
  Ln:=5;
  FOR C:=1 TO Cp DO
    BEGIN
      GotoXY(Cl,Ln);
      Write(Copy(RegArq2[C],1,8),'.',Copy(RegArq2[C],9,3));
      Cl:=Cl+18;
      IF Cl=80 THEN
        BEGIN
          Ln:=Ln+1;
          Cl:=8
        END
    END
END; {MostaDir}

PROCEDURE Mostra;
BEGIN {Mostra}
  Seek(Arquivo1,Ponteiro);
  Seek(Arquivo2,Ponteiro);
  Read(Arquivo1,RegArq1);
  Read(Arquivo2,RegArq2);
  Say(5,3,'Nom
31Simple
32
33
34
35
36Type
37Untyped
40 label
41Unknown syntax error
42 in preceding defini