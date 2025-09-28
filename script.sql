--testar
--22/10/2022: válida
--29/02/2020: bissexto, válida
--29/02/2021: inválida
--28/02/2021: válida
--31/06/2021: inválida

-- 223
--centenas := 253 / 100 = 2
-- dezenas := 253 % 100 / 50 = 1
--  
DO $$
DECLARE
  data INT := 31062021;
  dia INT;
  mes INT;
  ano INT;
  data_valida BOOL = TRUE;
BEGIN
  dia := data / 1000000;
  mes := data % 1000000 / 10000;
  ano := data % 1000000 % 10000;
  RAISE NOTICE '%/%/%', dia, mes, ano;
  IF ano >= 1 THEN
    CASE
      WHEN mes > 12 OR mes < 1 OR dia < 1 OR dia > 31 THEN
        data_valida := FALSE;
      ELSE
        IF ((mes = 4 OR mes = 6 OR mes = 9 OR mes = 11) AND dia > 30) THEN
          data_valida := FALSE;
        ELSE
          IF mes = 2 THEN
            CASE
              --é bissexto
              WHEN ((ano % 4 = 0 AND ano % 100 <> 0) OR ano % 400 = 0) THEN
                IF dia > 29 THEN
                  data_valida := FALSE;
                END IF;
              ELSE
                IF dia > 28 THEN
                  data_valida := FALSE;
                END IF;
            END CASE;
          END IF;
        END IF;
    END CASE;  
  ELSE
    data_valida := FALSE;
  END IF;
  CASE
    WHEN data_valida THEN
      RAISE NOTICE 'Data válida';
    ELSE
      RAISE NOTICE 'Data inválida';
  END CASE;
END;
$$


-- DO $$
-- DECLARE
--   --ax^2 + bx + c = 0
--   a INT := fn_valor_aleatorio_entre(0, 5);
--   b INT := fn_valor_aleatorio_entre(4, 8);
--   c INT := fn_valor_aleatorio_entre(0, 15);
--   delta NUMERIC(10, 2);
--   raiz_um NUMERIC(10, 2);
--   raiz_dois NUMERIC(10, 2);
-- BEGIN
--   RAISE NOTICE 'Equação: %x% + %x + % = 0', a, U&'\00B2', b, c;
--   IF a = 0 THEN
--     RAISE NOTICE 'Não é equação de segundo grau';
--   ELSE
--     delta := b ^ 2 - (4 * a * c);
--     RAISE NOTICE 'Delta: %', delta;
--     IF delta < 0 THEN
--       RAISE NOTICE 'Não tem raiz';
--     ELSIF delta = 0 THEN
--       raiz_um := (-1 * b) / (2 * a);
--       RAISE NOTICE 'Tem uma raiz: %', raiz_um;
--     ELSE
--       raiz_um := (-1 * b + |/delta) / (2 * a);
--       raiz_dois := (-1 * b - |/delta) / (2 * a);
--       RAISE NOTICE 'Tem duas raizes: % e %', raiz_um, raiz_dois;
--     END IF;
--   END IF; 
-- END;
-- $$

-- DO $$
-- DECLARE
--   valor INT := fn_valor_aleatorio_entre(1, 100);
-- BEGIN
--   RAISE NOTICE 'Valor gerado: %', valor;
--   IF valor % 2 = 0 THEN
--     RAISE NOTICE 'O valor é par';
--   ELSE
--     RAISE NOTICE 'O valor é ímpar';
--   END IF;
-- END;
-- $$


-- DO $$
-- DECLARE
--   valor INT;
-- BEGIN
--   valor := fn_valor_aleatorio_entre(1, 20);
--   RAISE NOTICE 'Valor gerado: %', valor;
--   IF valor <= 10 THEN
--     RAISE NOTICE 'O valor é menor ou igual a 10';
--   END IF;
-- END;
-- $$

-- DROP FUNCTION fn_valor_aleatorio_entre;
-- CREATE OR REPLACE FUNCTION fn_valor_aleatorio_entre(
--   lim_inferior INT, lim_superior INT
-- )RETURNS INT AS
-- $$
-- BEGIN
--   RETURN lim_inferior + floor(random() * (lim_superior - lim_inferior + 1))::INT;
-- END;
-- $$ LANGUAGE plpgsql;