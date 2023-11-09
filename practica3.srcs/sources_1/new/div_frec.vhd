----------------------------------------------------------------------------------
-- Engineer: Juan Luque Girón
-- Create Date: 28.09.2023 13:23:57
-- Module Name: div_frec - Behavioral

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY div_frec IS
    PORT (
        enable : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        sat : OUT STD_LOGIC
    );
END div_frec;

ARCHITECTURE Behavioral OF div_frec IS
    SIGNAL cuenta, pcuenta : unsigned(13 DOWNTO 0);
BEGIN

    sinc : PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' THEN
            cuenta <= (OTHERS => '0');
        ELSIF (rising_edge(clk) AND enable = '1') THEN
            cuenta <= pcuenta;
        END IF;
    END PROCESS;

    comb : PROCESS (cuenta)
    BEGIN
        pcuenta <= cuenta + 1;
        IF cuenta = 10415 THEN
            pcuenta <= (OTHERS => '0');
            sat <= '1';
        ELSE
            sat <= '0';
        END IF;

    END PROCESS;

END Behavioral;