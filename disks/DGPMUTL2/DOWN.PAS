9) THEN
        FOR X:=1 TO 12 DO Say(MC[X],ML[X],Copy(AUTOR,X,1))
      ELSE
        IF M=1 THEN
          FOR X:=1 TO 12 DO Say(MC[X],ML[X],Copy(AUTOR,X,1));
      IF KeyPressed THEN Read(Kbd,Key);
      Uc:=C[1]; Ul:=L[1];
      IF (Ic[1]<>0) AND (Cv(1)) THEN
        IF (Caminho(1,0,Ic[1])) THEN Tsva(1) ELSE Tsv(1)
      ELSE
        IF (Il[1]<>0) AND (Ch(1)) THEN
   