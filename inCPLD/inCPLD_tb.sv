`timescale 1ns/100ps

module inCPLD_tb;

logic pclk_50M;
logic	[0:74] data_in;
logic spi_cs;
logic spi_clk;
logic miso; 


inCPLD DUT(.*);

always #10 pclk_50M	= ~pclk_50M;

initial begin
pclk_50M = 1'b0;
spi_cs 	= 1'bz;
spi_clk 	= 1'bz;
data_in 	= 75'bz;

#100
data_in	= 75'b010111010101110101011101010111010101110101011101010111010101110101011101101;

#100
spi_cs 	= 1'b1;
spi_clk	= 1'b0;

#100
spi_cs 	= 1'b0;

#100
repeat (180) #150 spi_clk = ~spi_clk;

#500
spi_cs = 1'b1;

#100
spi_cs 	= 1'b1;
spi_clk	= 1'b0;

#100
spi_cs 	= 1'b0;

#100
repeat (8) #150 spi_clk = ~spi_clk;
spi_cs = 1'b1;
repeat (92) #150 spi_clk = ~spi_clk;

#1000	$stop;
end


endmodule
