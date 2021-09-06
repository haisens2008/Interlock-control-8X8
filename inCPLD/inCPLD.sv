module	inCPLD (
						input pclk_50M,
						input spi_clk,
						input spi_cs,
						input [0:74] data_in,
                  output logic miso);
								
enum {IDLE, 
		SEND,
		WAIT
		} current_state, next_state; 								
	
logic [7:0] cnt;	
	
always_ff @(posedge pclk_50M, posedge spi_cs)
	if (spi_cs)	current_state <= IDLE;
	else			current_state <= next_state;

always_comb begin
	next_state = IDLE;
	
	case (current_state)
						
		IDLE:	if (!spi_cs)			next_state = SEND;	// Wait for spi_clk
				else						next_state = IDLE; 	
						
		SEND:	if (spi_cs)				next_state = IDLE;	
				else if (cnt < 80)	next_state = SEND;
				else if (cnt >= 80)	next_state = WAIT;
		
		WAIT:	if (spi_cs)				next_state = IDLE;	// Do Not End Until spi_cs set 
				else						next_state = WAIT;
		
		default:							next_state = IDLE;
	endcase
end

always_ff @(posedge spi_clk, posedge spi_cs)	begin  
	if (spi_cs)							
			begin	
						cnt  <= 0;
						miso <= 1'bz;
			end
	else begin
		case (next_state)
		IDLE:								
			begin
						cnt	<= 0;
						miso	<= 1'bz;
			end
											
		SEND:
			begin
			if	(cnt < 75)	miso <= data_in[cnt];
			else				miso <= 1'b0;
								cnt <= cnt + 1;
			end
		
		WAIT:
			begin		
						cnt	<=0;
						miso	<= 1'bz;
			end
			
		endcase		
	end
end
	
endmodule
