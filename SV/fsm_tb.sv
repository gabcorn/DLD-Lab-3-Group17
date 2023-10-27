`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  [1:0]in;
   logic reset;
   logic  [5:0]y;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, in, y);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%h || %h", 
		      in, y);
     end   
   
   initial 
     begin      
     #0   reset = 1'b1;
     #10  reset = 1'b0;
	#41   in = 2'b01;
     end

endmodule // FSM_tb

