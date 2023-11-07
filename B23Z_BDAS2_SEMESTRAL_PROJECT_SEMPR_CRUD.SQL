CREATE PACKAGE sempr_crud AS 
    PROCEDURE prod_staty_create(p_name IN staty.nazev%TYPE);
    FUNCTION func_staty_create(p_name IN staty.nazev%TYPE) RETURN staty.id_stat%TYPE;
END sempr_crud;

CREATE PACKAGE BODY sempr_crud AS 
    PROCEDURE proc_staty_create(p_name IN staty.nazev%TYPE )
    IS
    BEGIN
        INSERT INTO staty(nazev) VALUES (p_name);
    END proc_staty_create;

    FUNCTION func_staty_create(p_name IN staty.nazev%TYPE)
    RETURN staty.id_stat%TYPE
    IS
        v_reti staty.id_stat%TYPE;
    BEGIN
        proc_staty_create(p_name);
        SELECT staty_seq.currval INTO v_reti FROM dual;
        COMMIT;
        RETURN v_reti;
    END func_staty_create;
END sempr_crud;
/
