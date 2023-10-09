/*
 Tento soubor obsahuje skript, ktery vytvori strukturu
 databaze semestralni prace z predmetu 'Databazove Systemy II'.

 Autori:
 David Schwam<david.schwam@student.upce.cz>
 Jiri Skoda<jiri.skoda@student.upce.cz>
 Pardubice, 2023
*/


CREATE SEQUENCE adresy_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE cipove_karty_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE jizdni_rady_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE linky_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE modely_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE obce_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE osoby_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE plany_smen_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE prevodovky_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE provozy_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE role_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE skutecne_rady_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE smeny_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE staty_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE stavy_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE typy_vozidel_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE uzivatele_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE vozidla_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE vyrobci_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE zabezpecovace_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE zastavky_seq START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE zamestnanci_seq START WITH 1 NOCACHE ORDER;

CREATE TABLE adresy (
    id_adresa        INTEGER DEFAULT adresy_seq.nextval NOT NULL,
    ulice            VARCHAR2(64),
    cislo_popisne    INTEGER NOT NULL,
    cislo_orientacni INTEGER,
    obec             INTEGER NOT NULL
);

ALTER TABLE adresy ADD CONSTRAINT adresy_pk PRIMARY KEY ( id_adresa );

CREATE TABLE autobusy (
    id_vozidlo INTEGER NOT NULL,
    kloubovy   NUMBER NOT NULL,
    prevodovka INTEGER NOT NULL
);

ALTER TABLE autobusy ADD CONSTRAINT autobus_pk PRIMARY KEY ( id_vozidlo );

CREATE TABLE cipove_karty (
    id_cipova_karta INTEGER DEFAULT cipove_karty_seq.nextval NOT NULL,
    cislo_karty     INTEGER NOT NULL,
    datum_vydani    DATE NOT NULL,
    datum_platnosti DATE NOT NULL,
    povolena        NUMBER NOT NULL,
    drzitel         INTEGER NOT NULL
);

ALTER TABLE cipove_karty ADD CONSTRAINT cipove_karty_pk PRIMARY KEY ( id_cipova_karta );

ALTER TABLE cipove_karty ADD CONSTRAINT cipove_karty_cislo_karty_un UNIQUE ( cislo_karty );

CREATE TABLE jizdni_rady (
    id_jizdni_rad  INTEGER DEFAULT jizdni_rady_seq.nextval  NOT NULL,
    cas_prijezdu   DATE NOT NULL,
    cas_odjezdu    DATE NOT NULL,
    poradove_cislo INTEGER NOT NULL,
    varianta       INTEGER NOT NULL,
    linka          INTEGER NOT NULL,
    zastavka       INTEGER NOT NULL
);

ALTER TABLE jizdni_rady ADD CONSTRAINT jizdni_rady_pk PRIMARY KEY ( id_jizdni_rad );

CREATE TABLE linky (
    id_linka INTEGER DEFAULT linky_seq.nextval  NOT NULL,
    kod      CHAR(3) NOT NULL
);

ALTER TABLE linky ADD CONSTRAINT linky_pk PRIMARY KEY ( id_linka );

ALTER TABLE linky ADD CONSTRAINT linky_kod_un UNIQUE ( kod );

CREATE TABLE modely (
    id_model      INTEGER DEFAULT modely_seq.nextval  NOT NULL,
    nazev         VARCHAR2(64) NOT NULL,
    mista_sezeni  INTEGER NOT NULL,
    mista_stani   INTEGER NOT NULL,
    klimatizace   NUMBER NOT NULL,
    nizkopodlazni NUMBER NOT NULL,
    palivo        VARCHAR2(16) NOT NULL,
    vyrobce       INTEGER NOT NULL
);

ALTER TABLE modely ADD CONSTRAINT modely_pk PRIMARY KEY ( id_model );

CREATE TABLE obce (
    id_obec   INTEGER DEFAULT obce_seq.nextval  NOT NULL,
    nazev     VARCHAR2(64) NOT NULL,
    cast_obce VARCHAR2(64),
    psc       INTEGER NOT NULL,
    stat      INTEGER NOT NULL
);

ALTER TABLE obce ADD CONSTRAINT obce_pk PRIMARY KEY ( id_obec );

CREATE TABLE osoby (
    id_osoba INTEGER DEFAULT osoby_seq.nextval  NOT NULL,
    jmeno    VARCHAR2(64) NOT NULL,
    prijmeni VARCHAR2(64) NOT NULL,
    e_mail   VARCHAR2(320) NOT NULL,
    telefon  CHAR(14) NOT NULL
);

ALTER TABLE osoby ADD CONSTRAINT osoby_pk PRIMARY KEY ( id_osoba );

CREATE TABLE plany_smen (
    id_plan_smeny INTEGER DEFAULT plany_smen_seq.nextval NOT NULL,
    smena         INTEGER NOT NULL,
    jizdni_rad    INTEGER NOT NULL
);

ALTER TABLE plany_smen ADD CONSTRAINT rel_smena_jizdni_rad_pk PRIMARY KEY ( id_plan_smeny );

CREATE TABLE prevodovky (
    id_prevodovka INTEGER DEFAULT prevodovky_seq.nextval  NOT NULL,
    nazev         VARCHAR2(16) NOT NULL
);

ALTER TABLE prevodovky ADD CONSTRAINT prevodovka_pk PRIMARY KEY ( id_prevodovka );

CREATE TABLE provozy (
    id_provoz          INTEGER DEFAULT provozy_seq.nextval  NOT NULL,
    nazev              VARCHAR2(64) NOT NULL,
    servisni_stredisko NUMBER NOT NULL,
    sidlo              INTEGER NOT NULL,
    vedouci            INTEGER NOT NULL
);

ALTER TABLE provozy ADD CONSTRAINT provoz_pk PRIMARY KEY ( id_provoz );

CREATE TABLE role (
    id_role INTEGER DEFAULT role_seq.nextval  NOT NULL,
    nazev   VARCHAR2(16) NOT NULL
);

ALTER TABLE role ADD CONSTRAINT role_pk PRIMARY KEY ( id_role );

CREATE TABLE skutecne_rady (
    id_skutecny_rad INTEGER DEFAULT skutecne_rady_seq.nextval NOT NULL,
    cas_prijezdu    DATE,
    cas_odjezdu     DATE,
    plan            INTEGER NOT NULL
);

ALTER TABLE skutecne_rady ADD CONSTRAINT skutecny_rad_pk PRIMARY KEY ( id_skutecny_rad );

CREATE TABLE smeny (
    id_smena    INTEGER DEFAULT smeny_seq.nextval  NOT NULL,
    vozidlo     INTEGER NOT NULL,
    zamestnanec INTEGER NOT NULL
);

ALTER TABLE smeny ADD CONSTRAINT smena_pk PRIMARY KEY ( id_smena );

CREATE TABLE soupravy_metra (
    id_vozidlo   INTEGER NOT NULL,
    pocet_vozu   INTEGER NOT NULL,
    zabezpecovac INTEGER NOT NULL
);

ALTER TABLE soupravy_metra ADD CONSTRAINT metro_pk PRIMARY KEY ( id_vozidlo );

CREATE TABLE staty (
    id_stat INTEGER DEFAULT staty_seq.nextval  NOT NULL,
    nazev   VARCHAR2(32) NOT NULL
);

ALTER TABLE staty ADD CONSTRAINT stat_pk PRIMARY KEY ( id_stat );

CREATE TABLE stavy (
    id_stav INTEGER DEFAULT stavy_seq.nextval  NOT NULL,
    nazev   VARCHAR2(16) NOT NULL
);

ALTER TABLE stavy ADD CONSTRAINT stav_pk PRIMARY KEY ( id_stav );

CREATE TABLE tramvaje (
    id_vozidlo   INTEGER NOT NULL,
    pocet_clanku INTEGER NOT NULL,
    rekuperace   NUMBER NOT NULL
);

ALTER TABLE tramvaje ADD CONSTRAINT tramvaj_pk PRIMARY KEY ( id_vozidlo );

CREATE TABLE trolejbusy (
    id_vozidlo      INTEGER NOT NULL,
    trakcni_baterie NUMBER NOT NULL,
    kloubovy        NUMBER NOT NULL
);

ALTER TABLE trolejbusy ADD CONSTRAINT trolejbus_pk PRIMARY KEY ( id_vozidlo );

CREATE TABLE uzivatele (
    id_uzivatel      INTEGER DEFAULT uzivatele_seq.nextval  NOT NULL,
    heslo            VARCHAR2(256) NOT NULL,
    datum_registrace TIMESTAMP NOT NULL,
    role             INTEGER,
    stav             INTEGER,
    zamestnanec      INTEGER NOT NULL
);

ALTER TABLE uzivatele ADD CONSTRAINT uzivatel_pk PRIMARY KEY ( id_uzivatel );

CREATE TABLE vozidla (
    id_vozidlo      INTEGER DEFAULT vozidla_seq.nextval NOT NULL,
    evidencni_cislo INTEGER NOT NULL,
    rok_vyroby      DATE NOT NULL,
    model           INTEGER NOT NULL,
    deponace        INTEGER NOT NULL,
    typ_vozidla     CHAR(3) NOT NULL
);

ALTER TABLE vozidla ADD CHECK ( evidencni_cislo BETWEEN 1000 AND 9999 );

ALTER TABLE vozidla ADD CONSTRAINT vozidlo_pk PRIMARY KEY ( id_vozidlo );

ALTER TABLE vozidla ADD CONSTRAINT vozidlo_evidencni_cislo_un UNIQUE ( evidencni_cislo );

CREATE TABLE vyrobci (
    id_vyrobce INTEGER DEFAULT vyrobci_seq.nextval NOT NULL,
    nazev      VARCHAR2(64) NOT NULL,
    sidlo      INTEGER NOT NULL,
    kontakt    INTEGER
);

ALTER TABLE vyrobci ADD CONSTRAINT vyrobce_pk PRIMARY KEY ( id_vyrobce );

CREATE TABLE zabezpecovace (
    id_zabezpecovac INTEGER DEFAULT zabezpecovace_seq.nextval NOT NULL,
    nazev           VARCHAR2(16) NOT NULL
);

ALTER TABLE zabezpecovace ADD CONSTRAINT zabezpecovac_pk PRIMARY KEY ( id_zabezpecovac );

CREATE TABLE zamestnanci (
    id_zamestnanec   INTEGER DEFAULT zamestnanci_seq.nextval NOT NULL,
    osobni_cislo     INTEGER NOT NULL,
    datum_nastupu    DATE NOT NULL,
    bydliste         INTEGER NOT NULL,
    uzivatelsky_ucet INTEGER NOT NULL,
    osobni_udaje     INTEGER NOT NULL,
    nadrizeny        INTEGER
);

CREATE UNIQUE INDEX zamestnanec__idx ON
    zamestnanci (
        uzivatelsky_ucet
    ASC );

ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanec_pk PRIMARY KEY ( id_zamestnanec );

ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanec_osobni_cislo_un UNIQUE ( osobni_cislo );

ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanec_osoba_un UNIQUE ( osobni_udaje );

ALTER TABLE zamestnanci
    ADD CONSTRAINT osobni_cislo_sestimistne CHECK ( osobni_cislo BETWEEN 100000 AND 999999 );

CREATE TABLE zastavky (
    id_zastavka        INTEGER DEFAULT zastavky_seq.nextval NOT NULL,
    nazev              VARCHAR2(32) NOT NULL,
    gps_severni_sirka  NUMBER NOT NULL,
    gps_vychodni_delka NUMBER NOT NULL,
    kod                VARCHAR2(5) NOT NULL,
    bezbarierova       NUMBER NOT NULL,
    na_znameni         NUMBER NOT NULL
);

ALTER TABLE zastavky ADD CONSTRAINT zastavka_pk PRIMARY KEY ( id_zastavka );

ALTER TABLE zastavky ADD CONSTRAINT zastavka_kod_un UNIQUE ( kod );

ALTER TABLE adresy
    ADD CONSTRAINT adresy_obce_fk FOREIGN KEY ( obec )
        REFERENCES obce ( id_obec );

ALTER TABLE autobusy
    ADD CONSTRAINT autobus_prevodovka_fk FOREIGN KEY ( prevodovka )
        REFERENCES prevodovky ( id_prevodovka );

ALTER TABLE autobusy
    ADD CONSTRAINT autobus_vozidlo_fk FOREIGN KEY ( id_vozidlo )
        REFERENCES vozidla ( id_vozidlo )
            ON DELETE CASCADE;

ALTER TABLE cipove_karty
    ADD CONSTRAINT cipove_karty_zamestnanec_fk FOREIGN KEY ( drzitel )
        REFERENCES zamestnanci ( id_zamestnanec );

ALTER TABLE jizdni_rady
    ADD CONSTRAINT jizdni_rady_linky_fk FOREIGN KEY ( linka )
        REFERENCES linky ( id_linka );

ALTER TABLE jizdni_rady
    ADD CONSTRAINT jizdni_rady_zastavka_fk FOREIGN KEY ( zastavka )
        REFERENCES zastavky ( id_zastavka );

ALTER TABLE soupravy_metra
    ADD CONSTRAINT metro_vozidlo_fk FOREIGN KEY ( id_vozidlo )
        REFERENCES vozidla ( id_vozidlo )
            ON DELETE CASCADE;

ALTER TABLE soupravy_metra
    ADD CONSTRAINT metro_zabezpecovac_fk FOREIGN KEY ( zabezpecovac )
        REFERENCES zabezpecovace ( id_zabezpecovac );

ALTER TABLE modely
    ADD CONSTRAINT modely_vyrobce_fk FOREIGN KEY ( vyrobce )
        REFERENCES vyrobci ( id_vyrobce );

ALTER TABLE obce
    ADD CONSTRAINT obce_stat_fk FOREIGN KEY ( stat )
        REFERENCES staty ( id_stat );

ALTER TABLE provozy
    ADD CONSTRAINT provoz_adresy_fk FOREIGN KEY ( sidlo )
        REFERENCES adresy ( id_adresa );

ALTER TABLE provozy
    ADD CONSTRAINT provozy_zamestnanec_fk FOREIGN KEY ( vedouci )
        REFERENCES zamestnanci ( id_zamestnanec );

ALTER TABLE plany_smen
    ADD CONSTRAINT rel_smena_jizdni_rad_jizdni_rad_fk FOREIGN KEY ( jizdni_rad )
        REFERENCES jizdni_rady ( id_jizdni_rad );

ALTER TABLE plany_smen
    ADD CONSTRAINT rel_smena_jizdni_rad_smena_fk FOREIGN KEY ( smena )
        REFERENCES smeny ( id_smena );

ALTER TABLE skutecne_rady
    ADD CONSTRAINT skutecne_rady_plany_smen_fk FOREIGN KEY ( plan )
        REFERENCES plany_smen ( id_plan_smeny );

ALTER TABLE smeny
    ADD CONSTRAINT smena_vozidlo_fk FOREIGN KEY ( vozidlo )
        REFERENCES vozidla ( id_vozidlo );

ALTER TABLE smeny
    ADD CONSTRAINT smeny_zamestnanec_fk FOREIGN KEY ( zamestnanec )
        REFERENCES zamestnanci ( id_zamestnanec );

ALTER TABLE tramvaje
    ADD CONSTRAINT tramvaj_vozidlo_fk FOREIGN KEY ( id_vozidlo )
        REFERENCES vozidla ( id_vozidlo )
            ON DELETE CASCADE;

ALTER TABLE trolejbusy
    ADD CONSTRAINT trolejbus_vozidlo_fk FOREIGN KEY ( id_vozidlo )
        REFERENCES vozidla ( id_vozidlo )
            ON DELETE CASCADE;

ALTER TABLE uzivatele
    ADD CONSTRAINT uzivatel_role_fk FOREIGN KEY ( role )
        REFERENCES role ( id_role );

ALTER TABLE uzivatele
    ADD CONSTRAINT uzivatel_stav_fk FOREIGN KEY ( stav )
        REFERENCES stavy ( id_stav );

ALTER TABLE uzivatele
    ADD CONSTRAINT uzivatel_zamestnanec_fk FOREIGN KEY ( zamestnanec )
        REFERENCES zamestnanci ( id_zamestnanec );

ALTER TABLE vozidla
    ADD CONSTRAINT vozidlo_model_fk FOREIGN KEY ( model )
        REFERENCES modely ( id_model );

ALTER TABLE vozidla
    ADD CONSTRAINT vozidlo_provoz_fk FOREIGN KEY ( deponace )
        REFERENCES provozy ( id_provoz );

ALTER TABLE vyrobci
    ADD CONSTRAINT vyrobce_adresy_fk FOREIGN KEY ( sidlo )
        REFERENCES adresy ( id_adresa );

ALTER TABLE vyrobci
    ADD CONSTRAINT vyrobce_osoba_fk FOREIGN KEY ( kontakt )
        REFERENCES osoby ( id_osoba );

ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanci_zamestnanci_fk FOREIGN KEY ( nadrizeny )
        REFERENCES zamestnanci ( id_zamestnanec );

ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanec_adresa_fk FOREIGN KEY ( bydliste )
        REFERENCES adresy ( id_adresa );

ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanec_osoby_fk FOREIGN KEY ( osobni_udaje )
        REFERENCES osoby ( id_osoba );

ALTER TABLE zamestnanci
    ADD CONSTRAINT zamestnanec_uzivatel_fk FOREIGN KEY ( uzivatelsky_ucet )
        REFERENCES uzivatele ( id_uzivatel );

CREATE OR REPLACE TRIGGER arc_vozidla_arc_soupravy_metra BEFORE
    INSERT OR UPDATE OF id_vozidlo ON soupravy_metra
    FOR EACH ROW
DECLARE
    d CHAR(3);
BEGIN
    SELECT
        a.typ_vozidla
    INTO d
    FROM
        vozidla a
    WHERE
        a.id_vozidlo = :new.id_vozidlo;

    IF ( d IS NULL OR d <> 'MET' ) THEN
        raise_application_error(-20223, 'FK METRO_VOZIDLO_FK in Table SOUPRAVY_METRA violates Arc constraint on Table VOZIDLA - discriminator column typ_vozidla doesn''t have value ''MET'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_vozidla_arc_tramvaje BEFORE
    INSERT OR UPDATE OF id_vozidlo ON tramvaje
    FOR EACH ROW
DECLARE
    d CHAR(3);
BEGIN
    SELECT
        a.typ_vozidla
    INTO d
    FROM
        vozidla a
    WHERE
        a.id_vozidlo = :new.id_vozidlo;

    IF ( d IS NULL OR d <> 'TRA' ) THEN
        raise_application_error(-20223, 'FK TRAMVAJ_VOZIDLO_FK in Table TRAMVAJE violates Arc constraint on Table VOZIDLA - discriminator column typ_vozidla doesn''t have value ''TRA'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_vozidla_arc_autobusy BEFORE
    INSERT OR UPDATE OF id_vozidlo ON autobusy
    FOR EACH ROW
DECLARE
    d CHAR(3);
BEGIN
    SELECT
        a.typ_vozidla
    INTO d
    FROM
        vozidla a
    WHERE
        a.id_vozidlo = :new.id_vozidlo;

    IF ( d IS NULL OR d <> 'AUT' ) THEN
        raise_application_error(-20223, 'FK AUTOBUS_VOZIDLO_FK in Table AUTOBUSY violates Arc constraint on Table VOZIDLA - discriminator column typ_vozidla doesn''t have value ''AUT'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_vozidla_arc_trolejbusy BEFORE
    INSERT OR UPDATE OF id_vozidlo ON trolejbusy
    FOR EACH ROW
DECLARE
    d CHAR(3);
BEGIN
    SELECT
        a.typ_vozidla
    INTO d
    FROM
        vozidla a
    WHERE
        a.id_vozidlo = :new.id_vozidlo;

    IF ( d IS NULL OR d <> 'TRO' ) THEN
        raise_application_error(-20223, 'FK TROLEJBUS_VOZIDLO_FK in Table TROLEJBUSY violates Arc constraint on Table VOZIDLA - discriminator column typ_vozidla doesn''t have value ''TRO'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
