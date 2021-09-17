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

logic [0:31] cnt;	
logic [1:8] last_outP = 8'b0;
logic [1:28] last_out = 28'b0;
logic check;

logic [6:0] g1 = {outP[8] & out[22], outP[7] & out[16], outP[6] & out[11], outP[5] & out[7], outP[4] & out[4], outP[3] & out[2], outP[2] & out[1]};
logic [6:0] g2 = {outP[8] & out[23], outP[7] & out[17], outP[6] & out[12], outP[5] & out[8], outP[4] & out[5], outP[3] & out[3], outP[1] & out[1]};
logic [6:0] g3 = {out[24], out[18], out[13], out[9], out[6], out[3], out[2]};
logic [6:0] g4 = {out[25], out[19], out[14], out[10],out[6], out[5], out[4]};
logic [6:0] g5 = {out[26], out[20], out[15], out[10],out[9], out[8], out[7]};
logic [6:0] g6 = {out[27], out[21], out[15], out[14],out[13],out[12],out[11]};
logic [6:0]	g7 = {out[28], out[21], out[20], out[19],out[16],out[15],out[14]};
	
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
						
						if ~(outP[1] ^ outP[2])  eout[1] <= out[1] & 1'b0; 
						if ~(outP[1] ^ outP[3])  eout[2] <= out[2] & 1'b0; 
						if ~(outP[2] ^ outP[3])  eout[3] <= out[3] & 1'b0; 
						if ~(outP[1] ^ outP[4])  eout[4] <= out[4] & 1'b0; 
						if ~(outP[2] ^ outP[4])  eout[5] <= out[5] & 1'b0;
						if ~(outP[3] ^ outP[4])  eout[6] <= out[6] & 1'b0; 
						if ~(outP[1] ^ outP[5])  eout[7] <= out[7] & 1'b0; 
						if ~(outP[2] ^ outP[5])  eout[8] <= out[8] & 1'b0; 
						if ~(outP[3] ^ outP[5])  eout[9] <= out[9] & 1'b0; 
						if ~(outP[4] ^ outP[5])  eout[10] <= out[10] & 1'b0; 
						if ~(outP[1] ^ outP[6])  eout[11] <= out[11] & 1'b0; 
						if ~(outP[2] ^ outP[6])  eout[12] <= out[12] & 1'b0; 
						if ~(outP[3] ^ outP[6])  eout[13] <= out[13] & 1'b0; 
						if ~(outP[4] ^ outP[6])  eout[14] <= out[14] & 1'b0; 
						if ~(outP[5] ^ outP[6])  eout[15] <= out[15] & 1'b0; 
						if ~(outP[1] ^ outP[7])  eout[16] <= out[16] & 1'b0; 
						if ~(outP[2] ^ outP[7])  eout[17] <= out[17] & 1'b0; 
						if ~(outP[3] ^ outP[7])  eout[18] <= out[18] & 1'b0; 
						if ~(outP[4] ^ outP[7])  eout[19] <= out[19] & 1'b0; 
						if ~(outP[5] ^ outP[7])  eout[20] <= out[20] & 1'b0; 
						if ~(outP[6] ^ outP[7])  eout[21] <= out[21] & 1'b0; 
						if ~(outP[1] ^ outP[8])  eout[22] <= out[22] & 1'b0; 
						if ~(outP[2] ^ outP[8])  eout[23] <= out[23] & 1'b0; 
						if ~(outP[3] ^ outP[8])  eout[24] <= out[24] & 1'b0; 
						if ~(outP[4] ^ outP[8])  eout[25] <= out[25] & 1'b0; 
						if ~(outP[5] ^ outP[8])  eout[26] <= out[26] & 1'b0; 
						if ~(outP[6] ^ outP[8])  eout[27] <= out[27] & 1'b0; 
						if ~(outP[7] ^ outP[8])  eout[28] <= out[28] & 1'b0; 

						%% outP1
						if (outP[1] == 1'b0)
							if ((g1 & 7'b0000001) == 7'b0000001) begin
								eout[1]	<= (out[1] 	& 1'b1);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b0);
							end else if ((g1 & 7'b0000011) == 7'b0000010) begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b1);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b0);
							end else if ((g1 & 7'b0000111) == 7'b0000100) begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b1);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b0);
							end else if ((g1 & 7'b0001111) == 7'b0001000) begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b1);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b0);
							end else if ((g1 & 7'b0011111) == 7'b0010000) begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b1);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b0);							
							end else if ((g1 & 7'b0111111) == 7'b0100000) begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b1);
								eout[22]<= (out[22] & 1'b0);
							end else if ((g1 & 7'b1111111) == 7'b1000000) begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b1);
							end else begin
								eout[1]	<= (out[1] 	& 1'b0);
								eout[2]	<= (out[2]	& 1'b0);
								eout[4]	<= (out[4] 	& 1'b0);
								eout[7]	<= (out[7] 	& 1'b0);
								eout[11]<= (out[11] & 1'b0);
								eout[16]<= (out[16] & 1'b0);
								eout[22]<= (out[22] & 1'b0);
							end
						else begin
							if (outP[2] == 1'b1)	eout[1]	<= (out[1]	& 1'b0);
							if (outP[3] == 1'b1)	eout[2]	<= (out[2]	& 1'b0);
							if (outP[4] == 1'b1)	eout[4]	<= (out[4]	& 1'b0);
							if (outP[5] == 1'b1)	eout[7]	<= (out[7] 	& 1'b0);
							if (outP[6] == 1'b1)	eout[11]<= (out[11] & 1'b0);
							if (outP[7] == 1'b1)	eout[16]<= (out[16] & 1'b0);
							if (outP[8] == 1'b1)	eout[22]<= (out[22] & 1'b0);
						end


						%% outP2
						if (outP[2] == 1'b0)
							if ((g2 & 7'b0000001) == 7'b0000001) begin
								eout[1]	<= (out[1] 	& 1'b1);
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b0);
							end else if ((g2 & 7'b0000011) == 7'b0000010) begin
								eout[3]	<= (out[3]	& 1'b1);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b0);
							end else if ((g2 & 7'b0000111) == 7'b0000100) begin
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b1);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b0);
							end else if ((g2 & 7'b0001111) == 7'b0001000) begin
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b1);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b0);
							end else if ((g2 & 7'b0011111) == 7'b0010000) begin
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b1);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b0);							
							end else if ((g2 & 7'b0111111) == 7'b0100000) begin
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b1);
								eout[23]<= (out[23] & 1'b0);
							end else if ((g2 & 7'b1111111) == 7'b1000000) begin
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b1);
							end else
								eout[3]	<= (out[3]	& 1'b0);
								eout[5]	<= (out[5] 	& 1'b0);
								eout[8]	<= (out[8] 	& 1'b0);
								eout[12]<= (out[12] & 1'b0);
								eout[17]<= (out[17] & 1'b0);
								eout[23]<= (out[23] & 1'b0);
						else begin
							if (outP[3] == 1'b1)	eout[3]	<= (out[3]	& 1'b0);
							if (outP[4] == 1'b1)	eout[5]	<= (out[5]	& 1'b0);
							if (outP[5] == 1'b1)	eout[8]	<= (out[8] 	& 1'b0);
							if (outP[6] == 1'b1)	eout[12]<= (out[12] & 1'b0);
							if (outP[7] == 1'b1)	eout[17]<= (out[17] & 1'b0);
							if (outP[8] == 1'b1)	eout[23]<= (out[23] & 1'b0);
						end


						%% outP3
						if (outP[3] == 1'b0)
							if ((g3 & 7'b0000001) == 7'b0000001) begin
								eout[2]	<= (out[2] 	& 1'b1);
								eout[3]	<= (out[3]	& 1'b0);
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b0);
							end else if ((g3 & 7'b0000011) == 7'b0000010) begin
								eout[3]	<= (out[3]	& 1'b1);
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b0);
							end else if ((g3 & 7'b0000111) == 7'b0000100) begin
								eout[6]	<= (out[6] 	& 1'b1);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b0);
							end else if ((g3 & 7'b0001111) == 7'b0001000) begin
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b1);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b0);
							end else if ((g3 & 7'b0011111) == 7'b0010000) begin
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b1);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b0);							
							end else if ((g3 & 7'b0111111) == 7'b0100000) begin
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b1);
								eout[24]<= (out[24] & 1'b0);
							end else if ((g3 & 7'b1111111) == 7'b1000000) begin
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b1);
							end else
								eout[6]	<= (out[6] 	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[13]<= (out[13] & 1'b0);
								eout[18]<= (out[18] & 1'b0);
								eout[24]<= (out[24] & 1'b0);
						else begin
							if (outP[4] == 1'b1)	eout[6]	<= (out[6]	& 1'b0);
							if (outP[5] == 1'b1)	eout[9]	<= (out[9] 	& 1'b0);
							if (outP[6] == 1'b1)	eout[13]<= (out[13] & 1'b0);
							if (outP[7] == 1'b1)	eout[18]<= (out[18] & 1'b0);
							if (outP[8] == 1'b1)	eout[24]<= (out[24] & 1'b0);
						end


						%% outP4
						if (outP[4] == 1'b0)
							if ((g4 & 7'b0000001) == 7'b0000001) begin
								eout[7]	<= (out[7] 	& 1'b1);
								eout[8]	<= (out[8]	& 1'b0);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b0);
							end else if ((g4 & 7'b0000011) == 7'b0000010) begin
								eout[8]	<= (out[8]	& 1'b1);
								eout[9]	<= (out[9] 	& 1'b0);
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b0);
							end else if ((g4 & 7'b0000111) == 7'b0000100) begin
								eout[9]	<= (out[9] 	& 1'b1);
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b0);
							end else if ((g4 & 7'b0001111) == 7'b0001000) begin
								eout[10]<= (out[10] & 1'b1);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b0);
							end else if ((g4 & 7'b0011111) == 7'b0010000) begin
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b1);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b0);							
							end else if ((g4 & 7'b0111111) == 7'b0100000) begin
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b1);
								eout[25]<= (out[25] & 1'b0);
							end else if ((g4 & 7'b1111111) == 7'b1000000) begin
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b1);
							end else
								eout[10]<= (out[10] & 1'b0);
								eout[14]<= (out[14] & 1'b0);
								eout[19]<= (out[19] & 1'b0);
								eout[25]<= (out[25] & 1'b0);
						else begin
							if (outP[5] == 1'b1)	eout[9]	<= (out[10] 	& 1'b0);
							if (outP[6] == 1'b1)	eout[13]<= (out[14] & 1'b0);
							if (outP[7] == 1'b1)	eout[18]<= (out[19] & 1'b0);
							if (outP[8] == 1'b1)	eout[24]<= (out[25] & 1'b0);
						end






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


