/*
 Tento soubor obsahue DDL skript, ktery vytvori strukturu databaze, jez
 slouzi jako zakladni struktura semestralni prace z predmetu 'Databazove
 Systemy II' na Fakulte elektrotechniky a informatiky Univerzity
 Pardubice.

 Autori:
 David Schwam<david.schwam@student.upce.cz>
 Jiri Skoda<jiri.skoda@student.upce.cz>
 Pardubice, 2022
*/

-- Vytvoreni sekvenci, ktere budou slouzit pro generovani primarnich klicu
CREATE SEQUENCE adresy_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE cipove_karty_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE jizdni_rady_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE linky_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE modely_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE obce_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE osoby_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE provozy_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE skutecne_rady_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE smeny_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE typy_vozidel_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE vozidla_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE vyrobci_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE zastavky_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE zamestnanci_seq START WITH 1 NOCACHE ORDER;

-- Tabulka adresy
CREATE TABLE adresy (
    id_adresa       INTEGER DEFAULT adresy_seq.nextval NOT NULL,
    ulice           VARCHAR2(64),
    cislopopisne    INTEGER NOT NULL,
    cisloorientacni INTEGER,
    obec_id_obec    INTEGER NOT NULL
);
ALTER TABLE adresy ADD CONSTRAINT adresa_pk PRIMARY KEY ( id_adresa );

-- Tabulka cipove karty
CREATE TABLE cipove_karty (
    id_cipova_karta      INTEGER DEFAULT cipove_karty_seq.nextval NOT NULL,
    cislokarty           INTEGER NOT NULL,
    datumvydani          DATE NOT NULL,
    datumplatnosti       DATE NOT NULL,
    povolena             NUMBER NOT NULL,
    zamestnanec_id_osoba INTEGER NOT NULL
);
ALTER TABLE cipove_karty ADD CONSTRAINT cipova_karta_pk PRIMARY KEY ( id_cipova_karta );
ALTER TABLE cipove_karty ADD CONSTRAINT cipova_karta_cislokarty_un UNIQUE ( cislokarty );

-- Tabulka jizdni rady
CREATE TABLE jizdni_rady (
    id_jizdni_rad                INTEGER DEFAULT jizdni_rady_seq.nextval NOT NULL,
    casprijezdu                  DATE NOT NULL,
    casodjezdu                   DATE NOT NULL,
    poradovecislo                INTEGER NOT NULL,
    varianta                     VARCHAR2(2) NOT NULL,
    linka_id_linka               INTEGER NOT NULL,
    zastavky_id_zastavka         INTEGER NOT NULL
);
ALTER TABLE jizdni_rady ADD CONSTRAINT jizdni_rad_pk PRIMARY KEY ( id_jizdni_rad );

-- Tabulka linky
CREATE TABLE linky (
    id_linka INTEGER DEFAULT linky_seq.nextval NOT NULL,
    kod      CHAR(3) NOT NULL
);
ALTER TABLE linky ADD CONSTRAINT linka_pk PRIMARY KEY ( id_linka );
ALTER TABLE linky ADD CONSTRAINT linka_kod_un UNIQUE ( kod );

-- Tabulky modely
CREATE TABLE modely (
    id_model           INTEGER DEFAULT modely_seq.nextval NOT NULL,
    nazev              VARCHAR2(64) NOT NULL,
    mistasezeni        INTEGER NOT NULL,
    mistastani         INTEGER NOT NULL,
    klimatizace        NUMBER NOT NULL,
    nizkopodlazni      NUMBER NOT NULL,
    palivo             VARCHAR2(16) NOT NULL,
    vyrobce_id_vyrobce INTEGER NOT NULL
);
ALTER TABLE modely ADD CONSTRAINT model_pk PRIMARY KEY ( id_model );

-- Tabulka obce
CREATE TABLE obce (
    id_obec  INTEGER DEFAULT obce_seq.nextval NOT NULL,
    nazev    VARCHAR2(64) NOT NULL,
    castobce VARCHAR2(64),
    psc      INTEGER NOT NULL,
    stat     VARCHAR2(64) DEFAULT 'CZECH REPUBLIC' NOT NULL
);
ALTER TABLE obce ADD CHECK ( psc BETWEEN 10000 AND 99999 );
ALTER TABLE obce ADD CONSTRAINT obec_pk PRIMARY KEY ( id_obec );

-- Tabulka osoby
CREATE TABLE osoby (
    id_osoba           INTEGER DEFAULT osoby_seq.nextval NOT NULL,
    jmeno              VARCHAR2(64) NOT NULL,
    prijmeni           VARCHAR2(64) NOT NULL,
    e_mail             VARCHAR2(320) NOT NULL,
    telefon            CHAR(14) NOT NULL,
    vyrobce_id_vyrobce INTEGER
);
ALTER TABLE osoby ADD CONSTRAINT osoba_pk PRIMARY KEY ( id_osoba );

-- Tabulka provozy
CREATE TABLE provozy (
    id_provoz            INTEGER DEFAULT provozy_seq.nextval NOT NULL,
    nazev                VARCHAR2(64) NOT NULL,
    servisnistredisko    NUMBER NOT NULL,
    zamestnanec_id_osoba INTEGER NOT NULL,
    adresa_id_adresa     INTEGER NOT NULL
);
ALTER TABLE provozy ADD CONSTRAINT provoz_pk PRIMARY KEY ( id_provoz );

-- Tabulky skutecne rady
CREATE TABLE skutecne_rady (
    id_skutecny_rad           INTEGER DEFAULT skutecne_rady_seq.nextval NOT NULL,
    casprijezdu               DATE,
    casodjezdu                DATE,
    zastavka_id_zastavka      INTEGER NOT NULL,
    smeny_id_smena            INTEGER NOT NULL,
	jizdni_rady_id_jizdni_rad INTEGER NOT NULL
);
ALTER TABLE skutecne_rady ADD CONSTRAINT skutecny_rad_pk PRIMARY KEY ( id_skutecny_rad );

-- Tabulka smeny
CREATE TABLE smeny (
    id_smena             INTEGER DEFAULT smeny_seq.nextval NOT NULL,
    vozidlo_id_vozidlo   INTEGER NOT NULL,
    zamestnanec_id_osoba INTEGER NOT NULL
);
ALTER TABLE smeny ADD CONSTRAINT smena_pk PRIMARY KEY ( id_smena );

-- Tabulka typy vozidel
CREATE TABLE typy_vozidel (
    id_typ_vozidla INTEGER DEFAULT typy_vozidel_seq.nextval NOT NULL,
    nazev          VARCHAR2(16)
);
ALTER TABLE typy_vozidel ADD CONSTRAINT typy_vozidel_pk PRIMARY KEY ( id_typ_vozidla );

-- Tabulka ukoly smen
CREATE TABLE ukoly_smen (
    smena_id_smena           INTEGER NOT NULL,
    jizdni_rad_id_jizdni_rad INTEGER NOT NULL
);
ALTER TABLE ukoly_smen ADD CONSTRAINT ukoly_smen_pk PRIMARY KEY ( smena_id_smena,
                                                                  jizdni_rad_id_jizdni_rad );
-- Tabulka vozidla
CREATE TABLE vozidla (
    id_vozidlo                  INTEGER DEFAULT vozidla_seq.nextval NOT NULL,
    evidencnicislo              INTEGER NOT NULL,
    rokvyroby                   DATE NOT NULL,
    model_id_model              INTEGER NOT NULL,
    provoz_id_provoz            INTEGER NOT NULL,
    pocetvozu                   INTEGER,
    zabezpecovac                CHAR(3),
    pocetclanku                 INTEGER,
    rekuperace                  NUMBER,
    prevodovka                  VARCHAR2(64),
    kloubovy                    NUMBER,
    trakcnibaterie              NUMBER,
    typy_vozidel_id_typ_vozidla INTEGER NOT NULL
);
ALTER TABLE vozidla ADD CHECK ( evidencnicislo BETWEEN 1000 AND 9999 );
ALTER TABLE vozidla ADD CONSTRAINT vozidlo_pk PRIMARY KEY ( id_vozidlo );
ALTER TABLE vozidla ADD CONSTRAINT vozidlo_evidencnicislo_un UNIQUE ( evidencnicislo );

-- Tabulka vyrobci
CREATE TABLE vyrobci (
    id_vyrobce       INTEGER DEFAULT vyrobci_seq.nextval NOT NULL,
    nazev            VARCHAR2(64) NOT NULL,
    adresa_id_adresa INTEGER NOT NULL
);
ALTER TABLE vyrobci ADD CONSTRAINT vyrobce_pk PRIMARY KEY ( id_vyrobce );

-- Tabulka zamestnanci
CREATE TABLE zamestnanci (
    id_osoba         INTEGER DEFAULT zamestnanci_seq.nextval NOT NULL,
    osobnicislo      INTEGER NOT NULL,
    datumnastupu     DATE NOT NULL,
    id_osoba1        INTEGER,
    adresa_id_adresa INTEGER NOT NULL
);
ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanec_pk PRIMARY KEY ( id_osoba );
ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanec_osobnicislo_un UNIQUE ( osobnicislo );

-- Tabulka zastavky
CREATE TABLE zastavky (
    id_zastavka      INTEGER DEFAULT zastavky_seq.nextval NOT NULL,
    nazev            VARCHAR2(32),
    gpssevernisirka  NUMBER NOT NULL,
    gpsvychodnidelka NUMBER NOT NULL,
    kod              VARCHAR2(5) NOT NULL,
    bezbarierova     NUMBER NOT NULL,
    naznameni        NUMBER NOT NULL
);
ALTER TABLE zastavky ADD CONSTRAINT zastavka_pk PRIMARY KEY ( id_zastavka );
ALTER TABLE zastavky ADD CONSTRAINT zastavka_kod_un UNIQUE ( kod );

-- Definice relaci mezi entitami (referencovani cizich klicu)
-- Adresa <> obec
ALTER TABLE adresy
    ADD CONSTRAINT adresa_obec_fk FOREIGN KEY ( obec_id_obec )
        REFERENCES obce ( id_obec );
-- Cipova karta <> zamestnanec		
ALTER TABLE cipove_karty
    ADD CONSTRAINT cipova_karta_zamestnanec_fk FOREIGN KEY ( zamestnanec_id_osoba )
        REFERENCES zamestnanci ( id_osoba );
-- Jizdni rad <> linka		
ALTER TABLE jizdni_rady
    ADD CONSTRAINT jizdni_rad_linka_fk FOREIGN KEY ( linka_id_linka )
        REFERENCES linky ( id_linka );
-- Jizdni rad <> zastavka		
ALTER TABLE jizdni_rady
    ADD CONSTRAINT jizdni_rady_zastavky_fk FOREIGN KEY ( zastavky_id_zastavka )
        REFERENCES zastavky ( id_zastavka );
-- Model <> vyrobce
ALTER TABLE modely
    ADD CONSTRAINT model_vyrobce_fk FOREIGN KEY ( vyrobce_id_vyrobce )
        REFERENCES vyrobci ( id_vyrobce );
-- Osoba <> vyrobce		
ALTER TABLE osoby
    ADD CONSTRAINT osoba_vyrobce_fk FOREIGN KEY ( vyrobce_id_vyrobce )
        REFERENCES vyrobci ( id_vyrobce );
-- Provoz <> adresa
ALTER TABLE provozy
    ADD CONSTRAINT provoz_adresa_fk FOREIGN KEY ( adresa_id_adresa )
        REFERENCES adresy ( id_adresa );
-- Provoz <> zamestnanec
ALTER TABLE provozy
    ADD CONSTRAINT provoz_zamestnanec_fk FOREIGN KEY ( zamestnanec_id_osoba )
        REFERENCES zamestnanci ( id_osoba );
-- Skutecny rad <> zastavka
ALTER TABLE skutecne_rady
    ADD CONSTRAINT skutecny_rad_zastavka_fk FOREIGN KEY ( zastavka_id_zastavka )
        REFERENCES zastavky ( id_zastavka );
-- Skutecny rad <> smena
ALTER TABLE skutecne_rady
    ADD CONSTRAINT skutecne_rady_smeny_fk FOREIGN KEY ( smeny_id_smena )
        REFERENCES smeny ( id_smena );
-- Skutecny rad <> jizdni rad
ALTER TABLE skutecne_rady
    ADD CONSTRAINT skutecne_rady_jizdni_rady_fk FOREIGN KEY ( jizdni_rady_id_jizdni_rad )
        REFERENCES jizdni_rady ( id_jizdni_rad );
-- Smena <> vozidlo
ALTER TABLE smeny
    ADD CONSTRAINT smena_vozidlo_fk FOREIGN KEY ( vozidlo_id_vozidlo )
        REFERENCES vozidla ( id_vozidlo );
-- Smena <> zamestnanec
ALTER TABLE smeny
    ADD CONSTRAINT smena_zamestnanec_fk FOREIGN KEY ( zamestnanec_id_osoba )
        REFERENCES zamestnanci ( id_osoba );
-- Ukol smeny <> jizdni rad
ALTER TABLE ukoly_smen
    ADD CONSTRAINT ukoly_smen_jizdni_rad_fk FOREIGN KEY ( jizdni_rad_id_jizdni_rad )
        REFERENCES jizdni_rady ( id_jizdni_rad );
-- Ukol smeny <> smena
ALTER TABLE ukoly_smen
    ADD CONSTRAINT ukoly_smen_smena_fk FOREIGN KEY ( smena_id_smena )
        REFERENCES smeny ( id_smena );
-- Vozidlo <> typ vozidla
ALTER TABLE vozidla
    ADD CONSTRAINT vozidla_typy_vozidel_fk FOREIGN KEY ( typy_vozidel_id_typ_vozidla )
        REFERENCES typy_vozidel ( id_typ_vozidla );
-- Vozidlo <> model
ALTER TABLE vozidla
    ADD CONSTRAINT vozidlo_model_fk FOREIGN KEY ( model_id_model )
        REFERENCES modely ( id_model );
-- Vozidlo <> provoz
ALTER TABLE vozidla
    ADD CONSTRAINT vozidlo_provoz_fk FOREIGN KEY ( provoz_id_provoz )
        REFERENCES provozy ( id_provoz );
-- Vyrobce <> adresa
ALTER TABLE vyrobci
    ADD CONSTRAINT vyrobce_adresa_fk FOREIGN KEY ( adresa_id_adresa )
        REFERENCES adresy ( id_adresa );
-- Zamestnanec <> adresa
ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanec_adresa_fk FOREIGN KEY ( adresa_id_adresa )
        REFERENCES adresy ( id_adresa );
-- Zamestnanec <> osoba
ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanec_osoba_fk FOREIGN KEY ( id_osoba )
        REFERENCES osoby ( id_osoba );
-- Zamestnanec <> osoba1
ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanec_zamestnanec_fk FOREIGN KEY ( id_osoba1 )
        REFERENCES zamestnanci ( id_osoba );


