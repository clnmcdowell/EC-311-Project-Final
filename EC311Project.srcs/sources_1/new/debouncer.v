`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 05:07:44 PM
// Design Name: 
// Module Name: debouncer
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

module debouncer(
    input push,
    input clk,
    output reg clean
    );
    reg [22:0]count;
    
    always @(posedge clk)
    begin
        if(push == 1'b0)
        begin
            count <= 1'b0;
            clean <= 1'b0;
        end
        else
        begin
            count = count + 1'b1;
            clean = 1'b0;
            if(count == 23'b11111111111111111111111)
            begin
                clean = 1'b1;
                count = 1'b0;
            end
        end
    end
    
endmodule

