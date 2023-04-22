`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 12:14:09 PM
// Design Name: 
// Module Name: BallPositionUpdate
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

//direction: 0 = moving to the right 1 = moving to the left
//server: 0 = left is next to serve 1 = right is next to serve

module BallPositionUpdate(
        input moving,
        input slowclk,
        input server,
        input direction,
        output reg [15:0]position
    );
    
    always @(posedge slowclk)
    begin
        if(moving == 1'b1)
        begin
            if(direction == 1'b1)
                position = position << 1; //ball moving left
            else
                position = position >> 1; //ball moving right
        end
        else
        begin
            if(server == 1'b1)
                position = 16'b0000000000000001;
            else
                position = 16'b1000000000000000;
        end 
    end
endmodule
