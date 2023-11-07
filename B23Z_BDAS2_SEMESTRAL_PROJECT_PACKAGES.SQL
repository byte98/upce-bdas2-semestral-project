CREATE PACKAGE sempr_crud AS 
    PROCEDURE prod_staty_create(p_name IN staty.nazev%TYPE);
    FUNCTION func_staty_create(p_name IN staty.nazev%TYPE) RETURN staty.id_stat%TYPE;
END sempr_crud;
