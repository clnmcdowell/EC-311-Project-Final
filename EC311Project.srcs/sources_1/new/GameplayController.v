`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 12:27:28 PM
// Design Name: 
// Module Name: GameplayController
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


module GameplayController(
    input clk,
    input p1button,
    input p2button,
    input gamemodetoggle,
    input [15:0]position,
    output reg moving,
    output reg gamemode,
    output reg server,
    output reg direction,
    output reg [3:0]p1score,
    output reg [1:0]p2score,
    output reg [23:0]speed
    );
    reg [1:0]strikes;
    
    always @(posedge clk) begin
    if((gamemodetoggle == 1'b1) && (gamemode == 1'b1))
        gamemode <= 1'b0;
    else if(gamemodetoggle == 1'b1)
        gamemode <= 1'b1;
    else
        gamemode <= gamemode;
    
    
    if (gamemode == 1'b1)//squash mode
    begin
        server <= 1'b0;
        if((moving == 1'b1) && (direction == 1'b0)) //moving towards player 2
        begin
            if(position == 16'b0000000000000001) //in position to be hit
                direction <= 1'b1; //change direction of ball
            else //button not pressed
                    direction <= 1'b0;
        end
        else if((moving == 1'b1) && (direction == 1'b1)) //moving towards player 1
        begin
            if(position == 16'b0000000000000000)//ball not hit in time
                moving <= 1'b0;
            else if(position != 16'b1000000000000000)//in the middle of the field
            begin
                if(p1button == 1'b1)
                    moving <= 1'b0;//set state to serve
                else//button not pressed
                    moving <= 1'b1;
            end
            else //in position to be hit
            begin
                if(p1button == 1'b1)//button pressed
                begin
                    direction <= 1'b0; //change direction of ball
                    p1score = p1score + 1'b1;
                    speed <= speed - 23'd250000;
                end
                else //button not pressed
                    direction <= 1'b1;
            end
        end
        else //player 1 serving
        begin
            if(p1button == 1'b1)//serve
            begin
                direction <= 1'b0;
                moving <= 1'b1;
                server <= 1'b1;
                speed <= 24'd5000000;
                p1score <= 1'b0;
            end
            else
            begin
                direction <= 1'b0;
                speed <= 24'd5000000;
            end
       end
   end
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else//regular tennis mode
    begin
    if((p1score == 2'b11)) //player 1 has won
    begin
        moving <= 1'b0;
        server <= 1'b1;
        direction <= 1'b1;
        
        if((p2button == 1'b1) || (p1button == 1'b1))
        begin
            p1score <= 2'b00;
            p2score <= 2'b00;
        end
        else
        begin
            p1score <= p1score;
            p2score <= p2score;
        end
    end
    else if((p2score == 2'b11))//player 2 has won
    begin
        moving <= 1'b0;
        server <= 1'b0;
        direction <= 1'b0;
        
        if((p2button == 1'b1) || (p1button == 1'b1))
        begin
            p1score <= 2'b00;
            p2score <= 2'b00;
        end
        else
        begin
            p1score <= p1score;
            p2score <= p2score;
        end
    end
    else
    begin
        if((moving == 1'b1) && (direction == 1'b0)) //moving towards player 2
        begin
            if(position == 16'b0000000000000000)//ball not hit in time
            begin
                p1score <= p1score + 1'b1;
                p2score <= p2score;
                moving <= 1'b0;
            end
            else if(position != 16'b0000000000000001)//in the middle of the field
            begin
                if(p2button == 1'b1)
                begin
                    if(strikes != 2'b10) //get a strike
                        strikes <= strikes + 1'b1; 
                    else //get last strike
                    begin
                        strikes <= 2'b00; //reset strikes
                        moving <= 1'b0;//set state to serve
                        server <= 1'b0;//set serve
                        p1score <= p1score + 1'b1; //give point to p1
                        p2score <= p2score;
                    end
                end
                else//button not pressed
                    strikes <= strikes;
            end
            else //in position to be hit
            begin
                if(p2button == 1'b1)//button pressed
                begin
                    strikes <= 2'b00; //reset strikes
                    direction <= 1'b1; //change direction of ball
                    speed <= speed - 23'd250000; //increase speed of ball
                end
                else //button not pressed
                    strikes <= strikes;
            end
        end
        else if((moving == 1'b1) && (direction == 1'b1)) //moving towards player 1
        begin
            if(position == 16'b0000000000000000)//ball not hit in time
            begin
                p2score <= p2score + 1'b1;
                p1score <= p1score;
                moving <= 1'b0;
            end
            else if(position != 16'b1000000000000000)//in the middle of the field
            begin
                if(p1button == 1'b1)
                begin
                    if(strikes != 2'b10) //get a strike
                        strikes <= strikes + 1'b1; 
                    else //get last strike
                    begin
                        strikes <= 2'b00; //reset strikes
                        moving <= 1'b0;//set state to serve
                        server <= 1'b1;//set serve
                        p2score <= p2score + 1'b1; //give point to p2
                        p1score <= p1score;
                    end
                end
                else//button not pressed
                    strikes <= strikes;
            end
            else //in position to be hit
            begin
                if(p1button == 1'b1)//button pressed
                begin
                    strikes <= 2'b00; //reset strikes
                    direction <= 1'b0; //change direction of ball
                    speed <= speed - 23'd250000;
                end
                else //button not pressed
                    strikes <= strikes;
            end
        end
        else if((moving == 1'b0) && (server == 1'b1)) //player 2 serving
        begin
            if(p2button == 1'b1)//serve
            begin
                direction <= 1'b1;
                moving <= 1'b1;
                server <= 1'b0;
                speed <= 24'd5000000;
            end
            else
            begin
                direction <= 1'b1;
                speed <= 24'd5000000;
            end
        end
        else //player 1 serving
             if(p1button == 1'b1)//serve
            begin
                direction <= 1'b0;
                moving <= 1'b1;
                server <= 1'b1;
                speed <= 24'd5000000;
            end
            else
            begin
                direction <= 1'b0;
                speed <= 24'd5000000;
            end
    end
    end
end
endmodule
