`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2023 19:02:44
// Design Name: 
// Module Name: simulatn
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


module simulatn( );
    reg [3:0] a,b;
    reg carry_in,switc;
    wire [3:0] decimal_place;
    wire carry,neg1pos0;
    src sssss(a,b,switc,carry_in,decimal_place,carry,neg1pos0);
    initial 
        begin
            a=4'b0010;b=4'b0001;switc=0;carry_in=0;
        #10 a=4'b0101;b=4'b0111;switc=0;carry_in=0;
        #10 a=4'b1001;b=4'b0110;switc=0;carry_in=0;
        #10 a=4'b1001;b=4'b0110;switc=1;carry_in=0;
        #10 a=4'b0100;b=4'b0011;switc=1;carry_in=0;
        #10 a=4'b0011;b=4'b0100;switc=1;carry_in=0;
        #10 a=4'b0100;b=4'b0100;switc=1;carry_in=0;
        #10 a=4'b1000;b=4'b1001;switc=1;carry_in=0;
        #10 a=4'b1001;b=4'b1000;switc=1;carry_in=0;
        #10 a=4'b1000;b=4'b1000;switc=1;carry_in=0;
        #10 a=4'b0000;b=4'b0000;switc=1;carry_in=0;
        
        #10$finish;

end

endmodule
