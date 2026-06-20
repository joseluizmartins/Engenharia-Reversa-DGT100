
      Bdos($0E,DriveCorr);
      REPEAT
        Trocou:=FALSE;
        FOR C:=1 TO Cp-1 DO
          IF RegArq2[C]>RegArq2[C+1] THEN
            BEGIN
              Auxi:=RegArq2[C];
              RegArq2[C]:=RegArq2[C+1];
              RegArq2[C+1]:=Auxi;
              Trocou:=TRUE
            END
      UNTIL NOT Trocou;
      MostraDir;
      {$I-}
      REPEAT
        Say(5,3,'Nome: ');
        BufLen:=20;
        ReadLn(Nome)
      UNTIL Nome<>'';
      Say(33,3,'Data de hoje:   /  D; {Window}

PROCEDURE MostraDir;
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

PROCEDURE Chame(NomeArq :Str80);
VAR ArqChn :FILE;
BEGIN
  Assign(ArqChn,NomeArq);
  Chain(ArqChn)
END; {Chame}

BEGIN {Cadastra_Disco}
  DriveCorr:=Bdos($19);
  Inicializa;
  Say(37,21,Seq(10,32));
  REPEAT
    FOR En:=0 TO 13 DO
      Mem[$F500+En]:=ROTINA[EN];
    Bdos($1A,$F600);
    REPEAT
      FOR C:=1 TO 64 DO
        RegArq2[C]:='';
      Window(3,2,79,22);
      REPEAT
        Say(26,3,' ');
        Say(5,3,'Qual o drive ? [A/B] ');
        BufLen:=1;
        ReadLn(Drive)
      UNTIL Upcase(Drive) IN ['A','B'];
      Say(5,3,Seq(22,32));
      Bdos($0E,(Ord(UpCase(Drive))-65));
      InLine($CD/$00/$F5);
      Grupo:=0;
      Cp:=0;
      REPEAT
        FOR Seto    ReWrite(Arquivo1);
  ReSet(Arquivo2);
  IF IOresult<>0 THEN
    ReWrite(Arquivo2);
  {$I+}
END;

FUNCTION Seq(Len, Car :Byte) :Str80;
VAR Buffer :ARRAY [1..255] OF Char;
BEGIN
  FillChar(Buffer,Len,Car);
  Seq:=Copy(Buffer,1,Len)
END;

PROCEDURE Escolha;
BEGIN
  GotoXY(14,24);
  Write('[ENTER] Confirma  -  [ESC] Cancela  -  [BREAK] Reentra');
  REPEAT
    Read(Kbd,Tecla)
  UNTIL Ord(Tecla) IN [13,27,126];
  GotoXY(14,24);
  Write(Seq(54,32))
END; {Escolha}

PROCEDURE Say(Col,Lin/');
      REPEAT
        Say(47,3,'  ');
        GotoXY(47,3);
        BufLen:=2;
        Read(Dia)
      UNTIL (Dia>'00') AND (Dia<'32') AND (Pos('.',Dia)=0);
      REPEAT
        Say(50,3,'  ');
        GotoXY(50,3);
        BufLen:=2;
        Read(Mes)
      UNTIL (Mes>'00') AND (Mes<'13') AND (Pos('.',Mes)=0);
      REPEAT
        Say(53,3,'  ');
        GotoXY(53,3);
        BufLen:=2;
        Read(Ano)
      UNTIL (Ano>'00') AND (Ano<='99') AND (Pos('.',Ano)=0);
      Data:=Dia+'/'{$C-}
PROGRAM Cadastra_Disco;
{MODULO-3.PAS = MODULO-3.CHN}

CONST
  ROTINA :Array [0..13] OF Byte=($0E,$02,$CD,$1E,$DE,$0E,$00,
                                 $CD,$21,$DE,$CD,$27,$DE,$C9);
TYPE
  Cabecalho = RECORD
                Nome   :STRING [20];
                Data   :STRING [08];
                Numero :Integer;
                Np     :Byte
              END;

  Diretorio = ARRAY [1..64] OF STRING [11];
  Str80 = STRING [80];

VAR
  RegArq1 :Cabecalho;
  Arquivo1 :FILE OF Cabe Str1;
  Op       : Str2;
  So,De,Dr,
  Tecla,Axl: Char;
  Dado     : Str255;
  Ok       : Boolean;istros do arquivo aberto }
  Nreg,    { Numero do registro corrente do arquivo atual }
  ANreg,   { Auxiliar para Nreg }
  A,C,Err,
  Tr,Se,Cod,
  Tf,Td,Sd,
  Sf,Ns,Cs : Integer;
  Key      : Boolean;
  Kb,E,R,
  Ase,Atr, { Contadores auxiliares de Setor e Trilha }
  Co,Dc,Cp,
  Nb,      { Numero do buffer do arquivo em uso }
  Lin,Col,
  Tl       : Byte;
  St       :r Rodrigo Luiz Ferreira Raposo                     *)
(*                                                                           *)
(*                 Turbo-Pascal 3.0 & CP/M Vs. 2.2 - 08/07/89                *)
(*                                                                           *)
(*****************************************************************************)

{$C-,R+,V+}

CONST
  SETTRK : ARRAY [1..6] OF Byte = ($0E,$00,$CD,$1E,$DE,$C9);
  SETSEC : ARRAY [1..6] OF Byte = ($0E,$00,$CD,ееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееее               Move(Dma,Buffer [0,1,1],128);
                  Nreg:=Nreg+1;
                  Igual:=Buffer [0,0,1]=Buffer [0,1,1]
                UNTIL (NOT Igual) OR (Nreg=Treg);
                IF NOT Igual THEN
                  Write(Pv(12,18),'Arquivos nao sao iguais.')
                ELSE
                  Write(Pv(12,18),'Nao ha diferenca.');
                Enter(12,19)
              END
        END
    END;}
  Close_Window(1,10,14,70,20)
END;ееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееее$21,$DE,$C9);

TYPE
  Str1     = STRING [1];
  Str2     = STRING [2];
  Str4     = STRING [4];
  Str11    = STRING [11];
  Str12    = STRING [12];
  Str80    = STRING [80];
  Str255   = STRING [255];
  Line     = ARRAY [1..80] OF Char;
  Screen   = ARRAY [1..24] OF Line;

VAR
  Dma,Buf  : ARRAY [1..128] OF Byte;
  Ar       : STRING [128];
  Opcoes   : STRING [133];
  Buffer   : ARRAY [0..1,0..39,1..128] OF Byte;
  Linha    : Line;
  Video    : ARRAY [1..3] OF Screen;
  Dir      : ARRAY [1..64] OF STRING [12];
  Fcb      : ARRAY [1..2,0..35] OF Byte;
  Arq      : ARRAY [1..3] OF Str11;
  Treg,    { Total de registros do arquivo aberto }
  Nreg,    { Numero do registro corrente do arquivo atual }
  ANreg,   { Auxiliar para Nreg }
  A,C,Err,
  Tr,Se,Cod,
  Tf,Td,Sd,
  Sf,Ns,Cs : Integer;
  Key      : Boolean;
  Kb,E,R,
  Ase,Atr, { Contadores auxiliares de Setor e Trilha }
  Co,Dc,Cp,
  Nb,      { Numero do buffer do arquivo em uso }
  Lin,Col,
  Tl       : Byte;
  St       :(*****************************************************************************)
(*                              ==============                               *)
(*                              <<< Zapper >>>                               *)
(*                              ==============                               *)
(*           Editor de Diskettes - Breakpoint Programas & Sistemas           *)
(*                                                                           *)
(*                      PoееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееееееPROLOGICA-85ееееFORMATADOеееее(20,32))
                END
          UNTIL (Arq [3]='') OR (Existe(Arq [3],3));
          IF Arq [3] <> '' THEN
            IF Existe(Arq[3],3) THEN
              BEGIN
                IF FileSize(3)<Treg THEN
                  Treg:=FileSize(3);
                Write(Pv(12,17),'Comparando...');
                Nreg:=0;
                Igual:=TRUE;
                REPEAT
                  ReadRnd(Nreg,2);
                  Move(Dma,Buffer [0,0,1],128);
                  ReadRnd(Nreg,3);
   