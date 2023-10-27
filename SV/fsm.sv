module FSM (clk, reset, in, y);

   input logic  clk;
   input logic  reset;
   input logic 	[1:0]in;
   
   output logic [5:0]y;

   typedef enum 	logic [3:0] {S0, SL1, SL2, SL3, SR1, SR2, SR3, SH1, SH2, SH3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  y <= 6'b000_000;	  
	  
	  if (in == 2'b11)
      nextstate <= SH1;
    else if (in == 2'b10)
      nextstate <= SL1;
    else if (in == 2'b01)
      nextstate <= SR1;
    else nextstate <= S0;

       end
       SR1: begin
	  y <= 6'b000_100;	  	  
    nextstate = SR2;
       end
      SR2: begin
    y <= 6'b000_110;
    nextstate = SR3;
      end
      SR3: begin
      y <= 6'b000_111;
      nextstate = S0;
      end
      
       SL1: begin
	  y <= 6'b001_000;	  	  
    nextstate = SL2;
       end
      SL2: begin
    y <= 6'b011_000;
    nextstate = SL3;
      end
      SL3: begin
      y <= 6'b111_000;
      nextstate = S0;
      end

      
       SH1: begin
	  y <= 6'b001_100;	  	  
    nextstate = SH2;
       end
      SH2: begin
    y <= 6'b011_110;
    nextstate = SH3;
      end
      SH3: begin
      y <= 6'b111_111;
      nextstate = S0;
      end
       default: begin
	  y <= 6'b000_000;	  	  
	  nextstate <= S0;
       end
     endcase
   
endmodule
