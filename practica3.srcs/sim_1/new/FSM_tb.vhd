-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY FSM_tb IS
END FSM_tb;

ARCHITECTURE test_bench OF FSM_tb IS

    -- Constants for generic values
    CONSTANT ancho_bus_dir : INTEGER := 4; -- EDIT Value for the generic
    CONSTANT VAL_SAT_CONT : INTEGER := 10415; -- EDIT Value for the generic
    CONSTANT ANCHO_CONTADOR : INTEGER := 14; -- EDIT Value for the generic

    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL button : STD_LOGIC;
    SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL direcc : STD_LOGIC_VECTOR(ancho_bus_dir - 1 DOWNTO 0);
    SIGNAL TX : STD_LOGIC;

    -- Component declaration
    COMPONENT FSM
        GENERIC (
            ancho_bus_dir : INTEGER := 4;
            VAL_SAT_CONT : INTEGER := 10415;
            ANCHO_CONTADOR : INTEGER := 14);
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            button : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            direcc : OUT STD_LOGIC_VECTOR(ancho_bus_dir - 1 DOWNTO 0);
            TX : OUT STD_LOGIC);
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : FSM
    GENERIC MAP(
        ancho_bus_dir => ancho_bus_dir,
        VAL_SAT_CONT => VAL_SAT_CONT,
        ANCHO_CONTADOR => ANCHO_CONTADOR)
    PORT MAP(
        clk => clk,
        reset => reset,
        button => button,
        data => data,
        direcc => direcc,
        TX => TX);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        reset <= '0'; -- EDIT Initial value
        button <= '0'; -- EDIT Initial value
        data <= "10010001"; -- EDIT Initial value

        -- Wait one clock period

        WAIT FOR 1 * clockPeriod;
        reset <= '1';
        WAIT FOR 1 * clockPeriod;
        reset <= '0';
        button <= '1';
        WAIT FOR 2 * clockPeriod;
        button <= '0';
        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;