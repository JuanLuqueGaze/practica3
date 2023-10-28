-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY escribe_tb IS
END escribe_tb;

ARCHITECTURE test_bench OF escribe_tb IS
    -- Signals for connection to the DUT
    SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL wen : STD_LOGIC;

    -- Component declaration
    COMPONENT escribe
        PORT (
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            clk : IN STD_LOGIC;
            wen : IN STD_LOGIC);
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : escribe
    PORT MAP(
        data_in => data_in,
        clk => clk,
        wen => wen);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        data_in <= "00000000"; -- EDIT Initial value
        wen <= '0';
        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        data_in <= "01000111";
        WAIT FOR 2 * clockPeriod;
        wen <= '1';
        WAIT FOR 1 * clockPeriod;
        data_in <= "01001000";
        WAIT FOR 1 * clockPeriod;

        data_in <= "01001001";
        wen <= '0';
        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;