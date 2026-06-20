ro-1;
          Seek(Arquivo1,Ponteiro);
          Read(Arquivo1,RegArq1);
          IF RegArq1.Numero=-1 THEN
            BEGIN
              Say(28,24,CLRLIN);
              Say(20,24,'Este disco esta'' apagado. Tente a opcao 6');
              Delay(2000);
              Ponteiro:=FilePos(Arquivo2)-1
            END
          ELSE
            BEGIN
              Limpa;
              Mostra
            END
        END;
      IF Tecla=#4 THEN
        BEGIN
          Say(6,24,CLRLIN);
      Mensagem('ULTIMO DISCO DO ARQUIVO ');
                  Ponteiro:=FilePos(Arquivo2)-1;
                  Delay(1000)
                END
              ELSE
                BEGIN
                  Limpa;
                  Mostra
                END
            END
        END;
      IF Tecla='-' THEN
        BEGIN
          IF Ponteiro=0 THEN
            BEGIN
              Say(1,24,CLRLIN);
              Mensagem('PRIMEIRO DISCO DO ARQUIVO ');
              Delay(1000)
            END
   Assign(ArqChn,'SELETOR.CHN');
                  Chain(ArqChn)
                END
              ELSE
                BEGIN
                  Ponteiro:=FilePos(Arquivo1)-1;
                  Limpa;
                  Mostra
                END
            END
        END
    UNTIL Tecla=#27;
    Say(6,24,CLRLIN);
    Say(24,24,'Deseja excluir mais diretorios ? [S/N]: ');
    REPEAT
      Read(Kbd,Sair)
    UNTIL UpCase(Sair) IN ['S','N'];
    Say(24,24,CLRLIN)
  UNTIL UpCase(Sair)='N';
  11,12,'delecao.');
  Say(31,13,'Pressione [ENTER]');
  BufLen:=0;
  Read;
  Window(3,2,79,22);
  REPEAT
    Window(6,4,76,21);
    Seek(Arquivo1,0);
    REPEAT
      Read(Arquivo1,RegArq1)
    UNTIL RegArq1.Numero<>-1;
    Ponteiro:=FilePos(Arqu