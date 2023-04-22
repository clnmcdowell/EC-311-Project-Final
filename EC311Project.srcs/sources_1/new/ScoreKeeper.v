`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2023 02:10:56 PM
// Design Name: 
// Module Name: ScoreKeeper
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


module ScoreKeeper(
    input clk,
    input rst,
    input gamemode,
    input [3:0]p1score,
    input [1:0]p2score,
    output [7:0]AN_Out,
    output [6:0]C_Out
    );
    reg [7:0] AN_In; 
    reg [55:0] C_In;
    
    parameter ZERO = 7'b0111111, ONE = 7'b0000110, TWO = 7'b1011011,  THREE=7'b1001111, FOUR = 7'b1100110, FIVE = 7'b1101101, SIX = 7'b1111101, SEVEN = 7'b0000111, EIGHT = 7'b1111111, NINE = 7'b1101111, P = 7'b1110011;
    
    SevenSegmentLED SevenSegmentLED(.clk(clk),.rst(rst),.AN_In(AN_In),.C_In(C_In),.AN_Out(AN_Out),.C_Out(C_Out));
    
    always @ (posedge clk)
    begin
        if(rst)
        begin
            AN_In <= 8'h0;
            C_In <= 56'h0;
        end
        else if(gamemode == 1'b1)
        begin
            AN_In <= 8'b11000000;
            case(p1score)
            4'b0001: C_In <= {ZERO,ONE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b0010: C_In <= {ZERO,TWO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b0011: C_In <= {ZERO,THREE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b0100: C_In <= {ZERO,FOUR,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b0101: C_In <= {ZERO,FIVE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b0110: C_In <= {ZERO,SIX,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b0111: C_In <= {ZERO,SEVEN,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1000: C_In <= {ZERO,EIGHT,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1001: C_In <= {ZERO,NINE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1010: C_In <= {ONE,ZERO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1011: C_In <= {ONE,ONE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1100: C_In <= {ONE,TWO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1101: C_In <= {ONE,THREE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1110: C_In <= {ONE,FOUR,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            4'b1111: C_In <= {ONE,FIVE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            default: C_In <= {ZERO,ZERO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000};
            endcase
        end
        else
        begin
            if((p1score == 4'b0001) && (p2score == 2'b00))
            begin
                AN_In <= 8'b10000001;
                C_In <= {ONE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,ZERO};
            end
            else if((p1score == 4'b0010) && (p2score == 2'b00))
            begin
                AN_In <= 8'b10000001;
                C_In <= {TWO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,ZERO};
            end
            else if((p1score == 4'b0011) && (p2score == 2'b00))
            begin
                AN_In <= 8'b10011001;
                C_In <= {THREE,7'b0000000,7'b0000000,P,ONE,7'b0000000,7'b0000000,ZERO};
            end
            else if((p1score == 4'b0000) && (p2score == 2'b01))
            begin
                AN_In <= 8'b10000001;
                C_In <= {ZERO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,ONE};
            end
            else if((p1score == 4'b0001) && (p2score == 2'b01))
            begin
                AN_In <= 8'b10000001;
                C_In <= {ONE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,ONE};
            end
            else if((p1score == 4'b0010) && (p2score == 2'b01))
            begin
                AN_In <= 8'b10000001;
                C_In <= {TWO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,ONE};
            end
            else if((p1score == 4'b0011) && (p2score == 2'b01))
            begin
                AN_In <= 8'b10011001;
                C_In <= {THREE,7'b0000000,7'b0000000,P,ONE,7'b0000000,7'b0000000,ONE};
            end
            else if((p1score == 4'b0000) && (p2score == 2'b10))
            begin
                AN_In <= 8'b10000001;
                C_In <= {ZERO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,TWO};
            end
            else if((p1score == 4'b0001) && (p2score == 2'b10))
            begin
                AN_In <= 8'b10000001;
                C_In <= {ONE,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,TWO};
            end
            else if((p1score == 4'b0010) && (p2score == 2'b10))
            begin
                AN_In <= 8'b10000001;
                C_In <= {TWO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,TWO};
            end
            else if((p1score == 4'b0011) && (p2score == 2'b10))
            begin
                AN_In <= 8'b10011001;
                C_In <= {THREE,7'b0000000,7'b0000000,P,ONE,7'b0000000,7'b0000000,TWO};
            end
            else if((p1score == 4'b0000) && (p2score == 2'b11))
            begin
                AN_In <= 8'b10011001;
                C_In <= {ZERO,7'b0000000,7'b0000000,P,TWO,7'b0000000,7'b0000000,THREE};
            end
            else if((p1score == 4'b0001) && (p2score == 2'b11))
            begin
                AN_In <= 8'b10011001;
                C_In <= {ONE,7'b0000000,7'b0000000,P,TWO,7'b0000000,7'b0000000,THREE};
            end
            else if((p1score == 4'b0010) && (p2score == 2'b11))
            begin
                AN_In <= 8'b10011001;
                C_In <= {TWO,7'b0000000,7'b0000000,P,TWO,7'b0000000,7'b0000000,THREE};
            end
            else
            begin
                AN_In <= 8'b10011001;
                C_In <= {ZERO,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,ZERO};
            end
        end
    end
endmodule
