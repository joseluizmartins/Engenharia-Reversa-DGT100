Ln(Linha:5,' :',Buffer);
        Linha:=Linha+1;
        IF Linha Div Pagina = 21 THEN
          BEGIN
            Pagina:=Pagina+1;
            Write('Pressione [ENTER]');
            BufLen:=0;
            Read;
            ClrScr;
            GotoXY(10,1);
            Write('Listando: ',Nome);
            GotoXY(40,1);
            WriteLn('Pagina: ',Pagina);
            WriteLn;
          END
      UNTIL Eof(Arq);
      Close(Arq)
    END
  ELSE
    WriteLn('Arquivo nao encontrado.')
ееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееее