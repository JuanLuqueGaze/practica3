----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2023 17:08:31
-- Design Name: 
-- Module Name: escribe - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY STD;
USE STD.textio.ALL;

ENTITY escribe IS
    PORT (

        data_in : IN STD_LOGIC;
        clk : IN STD_LOGIC

    );
END escribe;

ARCHITECTURE Behavioral OF escribe IS
    FILE f1 : text OPEN write_mode IS "C:\Users\juanl_00e1ytj\OneDrive\Escritorio\Sistemas Electronicos\practica3\escrituradedatos";
BEGIN

    escribir : PROCESS (clk, data_in)
        VARIABLE l : line;
        VARIABLE intwrite : INTEGER := 0;
    BEGIN
        IF (rising_edge(clk)) THEN
            CASE (data_in) IS
                WHEN '0' => intwrite := 0;
                WHEN '1' => intwrite := 1;
                WHEN OTHERS => intwrite := 2;
            END CASE;
            write(l, intwrite);
            writeline(f1, l);
        END IF;
    END PROCESS;
END Behavioral;