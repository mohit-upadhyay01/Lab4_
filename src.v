`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2023 18:59:06
// Design Name: 
// Module Name: src
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


module src(a,b,switc,carry_in,  decimal_place,carry,neg1pos0);
//declare the inputs and outputs of the module with their sizes.
    input [3:0] a,b;
    input carry_in,switc;
    output [3:0] decimal_place;
    output carry,neg1pos0;
    
    //Internal variables
    wire [3:0] comp;
    
    complement_10generator c1(b, switc, comp); 
    
    reg [4:0] sum_temp;
    reg [3:0] sum_;
    reg carry_;  

    //always block for doing the addition
    always @(a,comp,carry_in)
       begin
        sum_temp = a+comp+carry_in; //add all the inputs
        if(sum_temp > 9)    begin
            sum_temp = sum_temp+6; //add 6, if result is more than 9.
            carry_ = 1;  //set the carry output
            sum_[0] = sum_temp[0];   
            sum_[1] = sum_temp[1];    
            sum_[2] = sum_temp[2];    
            sum_[3] = sum_temp[3];     
          end
        else    begin
            carry_ = 0;
            sum_[0] = sum_temp[0];   
            sum_[1] = sum_temp[1];    
            sum_[2] = sum_temp[2];    
            sum_[3] = sum_temp[3];
          end
    end    
    
//    wire logi;
    assign neg1pos0 = switc & ~(carry_); 
    assign carry = switc ? 0 : carry_;
//    assign carry = neg1pos0 ? 0 : ccarryarry_; //using carry as a sign bit

    complement_10generator c2(sum_, neg1pos0, decimal_place); 
    
endmodule


module complement_10generator(B, M, X);
  input [3:0]B;
  input M;
  output [3:0]X;
  wire [3:0] x;
//  wire [3:0] c;
  //assign x[3] = B[3]&~M |  (~B[3]&~B[2]&~B[1]&M);
  //assign x[2] = B[2]&~M |  (~B[2]&B[1] + B[2]&~B[1])&M;
  //assign x[1] = B[1];
  //assign x[0] = B[0]&~M | ~B[0]&M;
  wire w1,w2,w3,w4,w5,w6,w7,w8,w9;
  xor (x[0],B[0],M);
  assign x[1]=B[1];
  xor (w5,B[1],B[2]);
  and(w9,w5,M);
  not (w1,M);
  and (w6,B[2],w1);
  or (x[2],w9,w6);
  not (w2,B[1]);
  not (w3,B[2]);
  not (w4,B[3]);
  and (w8,M,w2,w3,w4);
  and (w7,B[3],w1);
  or (x[3],w8,w7);
  
//  assign c= 4'b0001;
//  wire ca;
//  assign X= x;

  wire ca;
  bit_adder b1(x,0 , M,  X,ca );
endmodule

module bit_adder(A, B, c_in,  S, cout);
    input [3:0] A,B;
    input c_in;
    output [3:0] S;
    output cout;

    wire c1,c2,c3;

    full_adder F1(A[0],B[0],c_in,S[0],c1);
    full_adder F2(A[1],B[1],c1,S[1],c2);
    full_adder F3(A[2],B[2],c2,S[2],c3);
    full_adder F4(A[3],B[3],c3,S[3],cout);

endmodule

module full_adder(a, b, carry,  s,c );
    input a,b,carry;
    output s,c;
    assign s = a^b^carry;
    assign c = (a&b) | (b&carry) | (a&carry);
endmodule


