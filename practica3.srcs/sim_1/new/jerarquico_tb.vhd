-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY jerarquico_tb IS
END jerarquico_tb;

ARCHITECTURE test_bench OF jerarquico_tb IS
    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL button : STD_LOGIC;
    SIGNAL TX : STD_LOGIC;

    -- Component declaration
    COMPONENT jerarquico
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            button : IN STD_LOGIC;
            TX : OUT STD_LOGIC);
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : jerarquico
    PORT MAP(
        clk => clk,
        reset => reset,
        button => button,
        TX => TX);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        reset <= '0'; -- EDIT Initial value
        button <= '0'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        reset <= '1';
        WAIT FOR 2 * clockPeriod;
        reset <= '0';
        button <= '1';
        WAIT FOR 10 * clockPeriod;
        button <= '0';

        WAIT FOR 10 * clockPeriod;
        button <= '0';

        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;