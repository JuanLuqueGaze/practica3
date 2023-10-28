-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY agrupador_tb IS
END agrupador_tb;

ARCHITECTURE test_bench OF agrupador_tb IS
    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL data_in : STD_LOGIC;
    SIGNAL reset : STD_LOGIC;
    SIGNAL enable : STD_LOGIC;
    SIGNAL data_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL wrenable : STD_LOGIC;

    -- Component declaration
    COMPONENT agrupador
        PORT (
            clk : IN STD_LOGIC;
            data_in : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            wrenable : OUT STD_LOGIC);
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : agrupador
    PORT MAP(
        clk => clk,
        data_in => data_in,
        reset => reset,
        enable => enable,
        data_out => data_out,
        wrenable => wrenable);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        data_in <= '0'; -- EDIT Initial value
        reset <= '0'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        reset <= '1';
        WAIT FOR 1 * clockPeriod;
        reset <= '0';
        data_in <= '1';
        WAIT FOR 1 * clockPeriod;
        data_in <= '0';
        WAIT FOR 1 * clockPeriod;
        data_in <= '0';
        WAIT FOR 1 * clockPeriod;
        enable <= '1';
        data_in <= '1';
        WAIT FOR 2 ms;
        data_in <= '1';
        WAIT FOR 1 ms;
        data_in <= '1';
        WAIT FOR 1 * clockPeriod;
        data_in <= '1';
        WAIT FOR 1 * clockPeriod;
        data_in <= '1';
        WAIT FOR 1 * clockPeriod;
        data_in <= '1';
        WAIT FOR 1 * clockPeriod;
        data_in <= '0';
        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;