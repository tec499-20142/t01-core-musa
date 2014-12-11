`timescale 1ns/100ps

module dut_tb();

   reg          clk;
   wire         xclk;
   reg         busca = 1'b0;
   //reg [31:0]  instrucao;
   
   localparam CLK_SPEED = 4.07;  // IF clk = 122.88Mhz = 8.14nS, For half of clock, CLK_SPEED = 8.14nS/2 = 4.07nS

   assign xclk = clk;
      
   integer i = 0; 
   always @(posedge clk)
    begin 
      
      if (i == 0) begin      
          $display ("Busca Instrução");
      end       
          i = i + 1; 
          
      if (i == 1) begin 
          busca = 1'b1;
          #8
          busca = 1'b0;          
      end    
      
      if (i == 5) begin      
          $display ("Fim da Instrução");
          i = 0;
      end  
        
    end 

    modelo_referencia #(.XCLK_FREQ(122880000))
      dut (xclk);

   codigo #(.XCLK_FREQ(122880000))
      duv (xclk);

initial
begin
  $display ("clk started");
  clk = 1'b0;
  #15
  forever
  begin
    #CLK_SPEED clk = 1'b1;
    #CLK_SPEED clk = 1'b0;
  end
end

endmodule
