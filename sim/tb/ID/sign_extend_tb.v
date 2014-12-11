module sign_extend_tb();

reg [15:0] word;
wire [31:0] word_sign;

//parameter valor1 = 16'b0000011111111111;
//parameter valor2 = 16b'1111000000000000;
//parameter valor3 = 16b'0000000000000000;
//parameter valor4 = 16b'1111111111111111;

initial begin
  word = 16'b0000000000000000;
    #10 $monitor("inst: %b, inst_out: %b", word, word_sign);
  word = 16'b1111111111111111;
    #10 $monitor("inst: %b, inst_out: %b", word, word_sign);
  word = 16'd0;
    #10 $monitor("inst: %b, inst_out: %b", word, word_sign);
  word = -16'd1;
    #10 $monitor("inst: %b, inst_out: %b", word, word_sign);
end


sign_extend BLOCO3 (
  .inst (word),
  .inst_out (word_sign)
  );
  
endmodule
