-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY contrango_tb IS
END contrango_tb;

ARCHITECTURE test_bench OF contrango_tb IS
    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL MODI : STD_LOGIC;
    SIGNAL reset : STD_LOGIC;
    SIGNAL rango1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL rango2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL rango3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL rango4 : STD_LOGIC_VECTOR(8 DOWNTO 0);

    -- Component declaration
    COMPONENT contrango
        PORT (
            clk : IN STD_LOGIC;
            MODI : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            rango1 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            rango2 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            rango3 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            rango4 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : contrango
    PORT MAP(
        clk => clk,
        MODI => MODI,
        reset => reset,
        rango1 => rango1,
        rango2 => rango2,
        rango3 => rango3,
        rango4 => rango4);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        MODI <= '0'; -- EDIT Initial value
        reset <= '0'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        reset <= '1';
        WAIT FOR 1 * clockPeriod;
        reset <= '0';
        MODI <= '1';
        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;