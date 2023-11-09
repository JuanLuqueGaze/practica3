----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2023 09:53:25
-- Design Name: 
-- Module Name: jerarquico - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY jerarquico IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        button : IN STD_LOGIC;
        TX : OUT STD_LOGIC
    );
END jerarquico;

ARCHITECTURE Behavioral OF jerarquico IS

    COMPONENT div_frec
        PORT (
            enable : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            sat : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mi_memoria
        PORT (
            clka : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT FSM
        GENERIC (
            ancho_bus_dir : INTEGER := 5;
            VAL_SAT_CONT : INTEGER := 10415;
            ANCHO_CONTADOR : INTEGER := 14);
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            button : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            direcc : OUT STD_LOGIC_VECTOR(ancho_bus_dir - 1 DOWNTO 0);
            sending : OUT STD_LOGIC;
            TX : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT escribe
        PORT (
            data_in : IN STD_LOGIC;
            clk : IN STD_LOGIC
        );
    END COMPONENT;
    SIGNAL din : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL dir : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL TXi : STD_LOGIC;
    SIGNAL saturacion : STD_LOGIC;
    SIGNAL sendint : STD_LOGIC;
    SIGNAL clkwr : STD_LOGIC; --Indica que está en momento de guardar datos
BEGIN
    mm : mi_memoria
    PORT MAP(
        clka => clk,
        addra => dir,
        douta => din
    );
    dfu : div_frec
    PORT MAP(
        enable => sendint,
        clk => clk,
        reset => reset,
        sat => clkwr
    );
    fsj : FSM
    GENERIC MAP(
        ancho_bus_dir => 5,
        VAL_SAT_CONT => 10415,
        ANCHO_CONTADOR => 14
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        button => button,
        data => din,
        direcc => dir,
        sending => sendint,
        TX => TXi
    );
    TX <= Txi;
    writing : escribe
    PORT MAP(
        clk => clkwr,
        data_in => TXi
    );
END Behavioral;