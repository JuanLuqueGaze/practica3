
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FSM IS
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
        sending : OUT STD_LOGIC;
        TX : OUT STD_LOGIC);
END FSM;

ARCHITECTURE Behavioral OF FSM IS
    TYPE estado_type IS (REPOSO, INICIO, ESPERA, TEST_DATA, B_START, B_0, B_1, B_2,
        B_3, B_4, B_5, B_6, B_7, B_PARIDAD, B_STOP);
    SIGNAL estado : estado_type;
    SIGNAL newestado : estado_type;
    SIGNAL cont, pcont : unsigned(ANCHO_CONTADOR - 1 DOWNTO 0); -- 2 ^15 - 1 = 32768
    SIGNAL dir, pdir : unsigned(ancho_bus_dir - 1 DOWNTO 0);

BEGIN

    direcc <= STD_LOGIC_VECTOR(dir);

    sinc : PROCESS (clk, reset, pcont)
    BEGIN
        IF (reset = '1') THEN
            estado <= REPOSO;
        ELSIF (rising_edge(clk)) THEN
            estado <= newestado;
            dir <= pdir;
            cont <= pcont;
        END IF;
    END PROCESS;

    TTE : PROCESS (estado, button, data, cont, dir)
    BEGIN

        newestado <= estado;
        pcont <= cont;
        pdir <= dir;
        CASE estado IS

            WHEN REPOSO =>
                --Asignacion de salidas
                TX <= '1';
                sending <= '0';
                pdir <= (OTHERS => '0');
                pcont <= (OTHERS => '0');
                --Transicion a otros estados
                IF button = '1' THEN
                    newestado <= INICIO;
                END IF;

            WHEN INICIO =>
                --Asignacion de salidas
                TX <= '1';

                sending <= '0';
                --Transicion a otros estados
                IF button = '0' THEN
                    newestado <= ESPERA;
                END IF;

            WHEN ESPERA =>
                --Asignacion de salidas
                TX <= '1';

                sending <= '0';
                --Transicion a otros estados
                newestado <= TEST_DATA;

            WHEN TEST_DATA =>
                --Asignacion de salidas
                TX <= '1';

                sending <= '0';
                --Transicion a otros estados
                IF data = "00000000" THEN
                    newestado <= REPOSO;
                ELSE
                    newestado <= B_START;
                END IF;

            WHEN B_START =>
                --Asignacion de salidas
                TX <= '0';

                sending <= '0';
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_0;
                END IF;

            WHEN B_0 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(0);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_1;
                END IF;

            WHEN B_1 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(1);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_2;
                END IF;

            WHEN B_2 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(2);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');

                    newestado <= B_3;
                END IF;

            WHEN B_3 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(3);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_4;
                END IF;

            WHEN B_4 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(4);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_5;
                END IF;

            WHEN B_5 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(5);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_6;
                END IF;

            WHEN B_6 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(6);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_7;
                END IF;

            WHEN B_7 =>
                --Asignacion de salidas
                sending <= '1';
                TX <= data(7);

                sending <= '0';
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_PARIDAD;
                END IF;

            WHEN B_PARIDAD =>
                --Asignacion de salidas

                sending <= '0';
                TX <= data(0) XOR data(1) XOR data(2) XOR data(3) XOR data(4) XOR data(5) XOR data(6) XOR data(7);
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    newestado <= B_STOP;
                END IF;

            WHEN B_STOP =>
                --Asignacion de salidas
                sending <= '0';
                TX <= '1';
                pcont <= cont + 1;
                --Transicion a otros estados
                IF cont = VAL_SAT_CONT THEN
                    pcont <= (OTHERS => '0');
                    pdir <= dir + 1;
                    newestado <= INICIO;
                END IF;

            WHEN OTHERS =>
                sending <= 'Z';
                TX <= 'X';
                newestado <= REPOSO;
                pcont <= ((OTHERS => 'Z'));
                pdir <= ((OTHERS => 'Z'));

        END CASE;

    END PROCESS;

END Behavioral;