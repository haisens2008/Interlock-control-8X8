module	outCPLD (
						input pclk_50M,
						input [1:8] outP,
						input [1:28] out,
						output logic [1:8] eoutP = 8'b0,
						output logic [1:28] eout = 28'b0);
								
enum {IDLE,
		EXU_OFF,
		WAIT,
		EXU_ON
		} current_state, next_state; 								

logic [0:18] cnt;	
logic [1:8] last_outP = 8'b0;
logic	[1:28] last_out = 28'b0;
logic check;

	
always_ff @(posedge pclk_50M)
		current_state <= next_state;

always_comb begin
	next_state = IDLE;
	
	case (current_state)
						
		IDLE:	
				if (!check)												next_state = EXU_OFF;
				else														next_state = IDLE;

		EXU_OFF:															next_state = WAIT;
		
		WAIT:	
				if (!check)												next_state = EXU_OFF;
				else if (cnt == 500000) 							next_state = EXU_ON;
				else														next_state = WAIT;
				
						
		EXU_ON:															next_state = IDLE;
		
		default:															next_state = IDLE;
	endcase
end

always_ff @(posedge pclk_50M)	begin
	if (outP >= 0) 
		begin 
			last_outP <= outP;
			last_out	<=	out;
			check <= (outP == last_outP) & (out == last_out);
		end
								
	case (next_state)
								
		EXU_OFF:
			begin
						cnt <= 0;
						
						if (outP[1] == 1'b0) eoutP[1] <= (outP[1] & 1'b1);
						if (outP[2] == 1'b0) eoutP[2] <= (outP[2] & 1'b1);
						if (outP[3] == 1'b0) eoutP[3] <= (outP[3] & 1'b1);
						if (outP[4] == 1'b0) eoutP[4] <= (outP[4] & 1'b1);
						if (outP[5] == 1'b0) eoutP[5] <= (outP[5] & 1'b1);
						if (outP[6] == 1'b0) eoutP[6] <= (outP[6] & 1'b1);
						if (outP[7] == 1'b0) eoutP[7] <= (outP[7] & 1'b1);
						if (outP[8] == 1'b0) eoutP[8] <= (outP[8] & 1'b1);
						
						if (outP[1] & outP[2])  eout[1] <= out[1] & 1'b0; else eout[1] <= out[1] & 1'b1;
						if (outP[1] & outP[3])  eout[2] <= out[2] & 1'b0; else eout[2] <= out[2] & 1'b1;
						if (outP[2] & outP[3])  eout[3] <= out[3] & 1'b0; else eout[3] <= out[3] & 1'b1;
						if (outP[1] & outP[4])  eout[4] <= out[4] & 1'b0; else eout[4] <= out[4] & 1'b1;
						if (outP[2] & outP[4])  eout[5] <= out[5] & 1'b0; else eout[5] <= out[5] & 1'b1;
						if (outP[3] & outP[4])  eout[6] <= out[6] & 1'b0; else eout[6] <= out[6] & 1'b1;
						if (outP[1] & outP[5])  eout[7] <= out[7] & 1'b0; else eout[7] <= out[7] & 1'b1;
						if (outP[2] & outP[5])  eout[8] <= out[8] & 1'b0; else eout[8] <= out[8] & 1'b1;
						if (outP[3] & outP[5])  eout[9] <= out[9] & 1'b0; else eout[9] <= out[9] & 1'b1;
						if (outP[4] & outP[5])  eout[10] <= out[10] & 1'b0; else eout[10] <= out[10] & 1'b1;
						if (outP[1] & outP[6])  eout[11] <= out[11] & 1'b0; else eout[11] <= out[11] & 1'b1;
						if (outP[2] & outP[6])  eout[12] <= out[12] & 1'b0; else eout[12] <= out[12] & 1'b1;
						if (outP[3] & outP[6])  eout[13] <= out[13] & 1'b0; else eout[13] <= out[13] & 1'b1;
						if (outP[4] & outP[6])  eout[14] <= out[14] & 1'b0; else eout[14] <= out[14] & 1'b1;
						if (outP[5] & outP[6])  eout[15] <= out[15] & 1'b0; else eout[15] <= out[15] & 1'b1;
						if (outP[1] & outP[7])  eout[16] <= out[16] & 1'b0; else eout[16] <= out[16] & 1'b1;
						if (outP[2] & outP[7])  eout[17] <= out[17] & 1'b0; else eout[17] <= out[17] & 1'b1;
						if (outP[3] & outP[7])  eout[18] <= out[18] & 1'b0; else eout[18] <= out[18] & 1'b1;
						if (outP[4] & outP[7])  eout[19] <= out[19] & 1'b0; else eout[19] <= out[19] & 1'b1;
						if (outP[5] & outP[7])  eout[20] <= out[20] & 1'b0; else eout[20] <= out[20] & 1'b1;
						if (outP[6] & outP[7])  eout[21] <= out[21] & 1'b0; else eout[21] <= out[21] & 1'b1;
						if (outP[1] & outP[8])  eout[22] <= out[22] & 1'b0; else eout[22] <= out[22] & 1'b1;
						if (outP[2] & outP[8])  eout[23] <= out[23] & 1'b0; else eout[23] <= out[23] & 1'b1;
						if (outP[3] & outP[8])  eout[24] <= out[24] & 1'b0; else eout[24] <= out[24] & 1'b1;
						if (outP[4] & outP[8])  eout[25] <= out[25] & 1'b0; else eout[25] <= out[25] & 1'b1;
						if (outP[5] & outP[8])  eout[26] <= out[26] & 1'b0; else eout[26] <= out[26] & 1'b1;
						if (outP[6] & outP[8])  eout[27] <= out[27] & 1'b0; else eout[27] <= out[27] & 1'b1;
						if (outP[7] & outP[8])  eout[28] <= out[28] & 1'b0; else eout[28] <= out[28] & 1'b1;
						
						if (outP == 8'b0) eout <= 28'b0;
			end
		
		WAIT:		cnt <= cnt + 1;
	
		EXU_ON:		
			begin 	if (outP[1] == 1'b1) eoutP[1] <= (outP[1] & 1'b1);
						if (outP[2] == 1'b1) eoutP[2] <= (outP[2] & 1'b1);
						if (outP[3] == 1'b1) eoutP[3] <= (outP[3] & 1'b1);
						if (outP[4] == 1'b1) eoutP[4] <= (outP[4] & 1'b1);
						if (outP[5] == 1'b1) eoutP[5] <= (outP[5] & 1'b1);
						if (outP[6] == 1'b1) eoutP[6] <= (outP[6] & 1'b1);
						if (outP[7] == 1'b1) eoutP[7] <= (outP[7] & 1'b1);
						if (outP[8] == 1'b1) eoutP[8] <= (outP[8] & 1'b1);
			end
		
			
	endcase		

end
	
endmodule


