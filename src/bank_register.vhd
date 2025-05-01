library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank_register is
    port(
        clk                   : in  std_logic;
        rst                   : in  std_logic;
        ctrl_wr_bank_register : in  std_logic;
        wr_addr               : in  std_logic_vector(3 downto 0);
        data_in               : in  std_logic_vector(15 downto 0);
        rd_addr_1             : in  std_logic_vector(3 downto 0);
        rd_addr_2             : in  std_logic_vector(3 downto 0);
        data_out_1            : out std_logic_vector(15 downto 0);
        data_out_2            : out std_logic_vector(15 downto 0)
    );
end entity bank_register;

architecture behavior of bank_register is
    type bank_register_array is array (0 to 15) of std_logic_vector(15 downto 0);
    signal bank_register : bank_register_array := (others => (others => '0'));
begin
    process(clk, rst)
    begin
        if rst = '1' then
            bank_register <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if ctrl_wr_bank_register = '1' then
                bank_register(to_integer(unsigned(wr_addr))) <= data_in;
            end if;
        end if;
    end process;

    data_out_1 <= bank_register(to_integer(unsigned(rd_addr_1)));
    data_out_2 <= bank_register(to_integer(unsigned(rd_addr_2)));
end architecture behavior;
