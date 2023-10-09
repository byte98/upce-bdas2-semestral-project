# Semestrální projekt
Tento repozitář obsahuje semestrální projekt z předmětu 'Databázové systémy II' vyučovaný na Fakultě elektrotechniky a informatiky Univerzity Pardubice.

## Databáze
Schémata modelú databáze jsou vyzobrazeny v souborech [LOGICAL.PNG](https://github.com/byte98/upce-bdas2-semestral-project/blob/master/LOGICAL.PNG) obsahující logický model databáze, a v souboru [RELATIONAL.PNG](https://github.com/byte98/upce-bdas2-semestral-project/blob/master/RELATIONAL.PNG), obsahující relační model databáze. Skript, který vytvoří strukturu databáze se nachází v souboru [B23Z_BDAS2_SEMESTRAL_PROJECT.DDL](https://github.com/byte98/upce-bdas2-semestral-project/blob/master/B23Z_BDAS2_SEMESTRAL_PROJECT.DDL).


### Popis tabulek

#### Adresy
Tabulka sloužící jako adresář všech zadaných adres v systému.
- **id_adresa**: Identifikátor adresy
- **ulice**: Ulice adresy
- **cislo_popisne**: Číslo popisné adresy
- **cislo_orientacni**: Číslo orientační adresy
- **obec**: Identifikátor [obce](#obce) ve které se adresa nachází

#### Autobusy
Tabulka, jež ukládá informace o všech spravovaných autobusech.
- **id_vozidlo**: Identifikátor [vozidla](#vozidla)
- **kloubovy**: Příznak, zdali je autobus kloubový
- **prevodovka**: Identifikátor [převodovky](#prevodovky)t, která je na autobuse namontovaná

#### Cipove_karty
Tabulka se všemi vydanými čipovými kartami.
- **id_cipova_karta**: Identifikátor čipové karty
- **cislo_karty**: Číslo čipové karty; pokud dojde rozsah čísel karet, lze rotovat
- **datum_vydani**: Datum vydání karty
- **datum_platnosti**: Datum, do kdy je karta platná
- **povolena**: Příznak, zdali je karta v systému povolená (tedy zdali ji lze využívat)
- **drzitel**: Identifikátor [zaměstnance](#zamestnanci), kterému byla karta vydána

#### Jizdni_rady
Tabulka, jež uchovává všechny jízdní řády.
- **id_jizdni_rad**: Identifikátor záznamu,
- **cas_prijezdu**: Čas příjezdu na zastávku
- **cas_odjezdu**: Čas odjezdu ze zastávky
- **poradove_cislo**: Pořadové číslo zastávky na lince
- **varianta**: Varianta jízdního řádu (zde se bude ukládat například pořadí během dne, speciální noční či víkendové řády apod.)
- **linka**: Identifikátor [linky](#linky)
- **zastavka**: Identifikátor [zastavky](#zastavky)
Jeden záznam v této tabulce prezentuje informaci o jednom zastavení vozidla na zastávce. Pokud bychom chtěli získat celý jízdní řád jedné linky (pro jeden oběh), stačí získat všechny záznamy z této tabulky se stejnou linkou a variantou a tyto záznamy seřadit dle pořadového čísla.

#### Linky
Tabulka se všemi obsluhovanými linkami.
- **id_linka**: Identifikátor linky
- **kod**: Kód linky (zobrazitelný například na transparentech vozidel, jízdních a vozových řádech atp.)

#### Modely
Tabulka se všemi modely, které byly kdy podniku dodány. Tato tabulka existuje z důvodu, aby informace o jednotlivých vozidlech byly zapsány pouze jednou (a pak se u každého vozidla dalo odkazovat právě na tento model).
- **id_model**: Identifikátor modelu
- **nazev**: Název modelu
- **mista_sezeni**: Počet míst k sezení
- **mista_stani**: Počet míst ke stání
- **klimatizace**: Příznak, zdali je model vybaven klimatizací
- **nizkopodlazni**: Příznak, zdali je model nízkopodlažní
- **palivo**: Palivo, jež umožňuje modelu pohyb
- **vyrobce**: Identifikátor [výrobce](#vyrobci) modelu

#### Obce
Číselník všech obcí.
- **id_obec**: Identifikátor obce
- **nazev**: Název obce
- **cast_obce**: Název místní části obce
- **psc**: Poštovní směrovací číslo obce
- **stat**: Identifikátor [státu](#staty), ve kterém se obec nachází

#### Osoby
Tabulka se všemi potřebnými uchovávanými osobními údaji.
- **id_osoba**: Identifikátor záznamu
- **jmeno**: Jméno osoby
- **prijmeni**: Příjmení osoby
- **e_mail**: E-mailová adresa osoby
- **telefon**: Telefon na osoby

#### Plany_smen
Relační tabulka spojující směnu a jízdní řády, které má být na směně odjeta.
- **smena**: Identifikátor [směny](#smeny)
- **jizdni_rad**: Identifikátor [jízdního řádu](#jizdni_rady)
Jeden řádek tedy přiřazuje jeden jízdní řád směně, která ho má odjet. Pokud by bylo potřeba získat informace o celé jedné směně, stačí získat všechny jízdní řády této směny a poté je seřadit dle času příjezdu.

#### Prevodovky
Číselník všech převodovek montovaných do autobusů.
- **id_prevodovka**: Identifikátor převodovky
- **nazev**: Název převodovky

#### Provozy
Tabulka všech provozů dopravního podniku.
- **id_provoz**: Identifikátor provozu
- **nazev**: Název provozu
- **servisni_stredisko**: Příznak, zdali je provoz vybaven servisním střediskem
- **sidlo**: [Adresa](#adresy), na které se provoz nachází
- **vedouci**: [Zaměstnanec](#zamestnanci), který je za provoz odpovědný

#### Role
Číselník všech rolí uživatele (např. řidič, plánovač směn, THP apod.)
- **id_role**: Identifikátor role
- **nazev**: Název role

#### Skutecne_rady
Tabulka uchovávájící reálné projetí jízdních rádů.
- **id_skutecny_rad**: Identifikátor záznamu
- **cas_prijezdu**: Skutčený čas příjezdu
- **cas_odjezdu**: Skutečný čas odjezdu
- **plan**: [Plán](#planysmen), ve kterém je uložen pravidelný příjezd/odjezd
Jeden záznam tak reprezentuje zhruba toto: směna X relizovala jízdní řád Y (pro linku A a zastávku B) v tomto čase.

#### Smena
Tabulka s rozpisem všech směn.
- **id_smena**: Identifikátor směny
- **vozidlo**: [Vozidlo](#vozidla), kterým bude směna realizována
- **zamestnanec**: [Zaměstnanec](#zamestnanci), který směnu odjede

#### Soupravy_metra
Tabulka se všemi evidovanými soupravami metra
- **id_vozidlo**: Identifikátor [vozidla](#vozidla)
- **pocet_vozu**: Počet vozů, které tvoří soupravu
- **zabezpecovac**: [Zabezpečovač](#zabezpecovace), jenž je v soupravě nainstalován

#### Staty
Číselník všech evidovaných států.
- **id_stat**: Identifikátor záznamu
- **nazev**: Název státu

#### Stavy
Číselník všech stavů uživatelských účtů (např. aktivní, zablokován, zrušen apod.)
- **id_stav**: Identifikátor stavu
- **nazev**: Název stavu

#### Tramvaje
Tabulka se všemi spravovanými tramvajemi
- **id_vozidlo**: Identifikátor [vozidla](#vozidla)
- **pocet_clanku**: Počet článku tramvaje
- **rekuperace**: Příznak, zdali je tramvaj vybavena systémem rekuperace

#### Trolejbusy
Tabulka se všemi provozovanými trolejbusy
- **id_vozidlo**: Identifikátor [vozidla](#vozidla)
- **trakcni_baterie**: Příznak, zdali je trolejbus vybaven trakčními bateriemi
- **kloubovy**: Příznak, zdali je trolejbus kloubový

#### Uzivatele
Tabulka se všemi uživatelskými účty.
- **id_uzivatel**: Identifikátor uživatelského účtu
- **heslo**: Heslo uživatele
- **datum_registrace**: Datum registrace uživatele
- **role**: Identifikátor [role](#role) uživatele
- **stav**: Identifikátor [stavu](#stavy) uživatelského účtu
- **zamestnanec**: Identifikátor [zaměstnance](#zamestnanci), pro kterého byl uživatelský účet zřízen

#### Vozidla
Tabulka se všemi provozovanými vozidly podniku
- **id_vozidlo**: Identifikátor vozidla
- **evidencni_cislo**: Evidenční číslo vozidla
- **rok_vyroby**: Rok výroby vozidla
- **model**: [Typ](#modely) vozidla
- **deponace**: [Provoz](#provozy), ve kterém je vozidlo deponováno
- **typ_vozidla**: Typ vozidla (z důvodu přítomnosti arc oblouku); povolené názvy: AUT pro autobusy, TRA pro tramvaje, TRO pro trolejbusy a MET pro vozy metra

#### Vyrobci
Tabulka se všemi výrobci, kteří dodali nějaké vozidlo do podniku.
- **id_vyrobce**: Identifikátor výrobce
- **nazev**: Název výrobce
- **sidlo**: [Adresa](#adresy), na které výrobce sídlí
- **kontakt**: Kontakt na [osobu](#osoby) zastupující výrobce při jednání s podnikem

#### Zabezpecovace
Číselník všech vlakových zabezpečovačů montovaných do souprav metra.
- **id_zabezpecovac**: Identifikátor zabezpečovače
- **nazev**: Název zabezpečovače

#### Zamestnanci
Tabulka obsahující všechny zaměstnance podniku.
- **id_zamestnanec**: Identifikátor zaměstnance
- **osobni_cislo**: Osobní číslo zaměstnance
- **datum_nastupu**: Datum nástupu zaměstnance k podniku
- **bydliste**: [Adresa](#adresy) bydliště zaměstnance
- **uzivatelsky_ucet**: [Uživatelský účet](#uzivatele) zaměstnance pro přístup do informačního systému
