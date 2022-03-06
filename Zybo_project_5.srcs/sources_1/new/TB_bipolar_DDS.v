`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2019 10:09:00 AM
// Design Name: 
// Module Name: TB_bipolar_DDS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_bipolar_DDS;

integer read_file_1,read_file_2;
integer cnt;
integer write_file_1,write_file_2 ;
reg [15:0] test_in1, test_in2;
reg clk, arstn;
wire [15:0] test_out1, test_out2;

DUT_top DUT (
  .clk         (clk), 
  .arstn        (arstn),
  .test_in1    (test_in1), 
  .test_in2    (test_in2), 
  .test_out1  (test_out1),   
  .test_out2  (test_out2)
  ); 

   initial 
   begin 
     test_in1 = 0; 
	 test_in2 = 0; 
     clk = 0;  
     arstn = 0;
     cnt=0;
	 read_file_1 = $fopen("Bipolar_DDS_input.txt", "r"); 
	 read_file_2 = $fopen("Bipolar_DDS_input_offset.txt", "r"); 
	 write_file_1 = $fopen("Bipolar_DDS_I_out.txt", "w"); 
	 write_file_2 = $fopen("Bipolar_DDS_Q_out.txt", "w"); 
	 #100;
	 arstn = 1; 	  
   end 
   
    always  #5  clk =  ! clk; //  clock 100 MHz
  
    initial begin 
    
    @(posedge arstn);
    $display("\t SRST gone LOW"); 
    while ( ! $feof(read_file_1)) begin
       $display("\t Loop "); 
       $monitor("\t cnt = %d ",cnt); 
      @(negedge clk);
       $fscanf(read_file_1,"%b\n",test_in1[15:0]);
       $fscanf(read_file_2,"%b\n",test_in2[15:0]);
       //$fscanf(read_file_2,"%b\n",test_in2[15:0]);
      @(posedge clk); 
       $fwrite(write_file_1,"%b\n",test_out1[15:0]);
       $fwrite(write_file_2,"%b\n",test_out2[15:0]);
       cnt=cnt+1;     
    end
       repeat (10) @ (posedge clk); // Wait 10 cycles
      $fclose(read_file_1);
      $fclose(read_file_2);
      $fclose(write_file_1);
      $fclose(write_file_2);
        #10  $finish;
    end


endmodule
