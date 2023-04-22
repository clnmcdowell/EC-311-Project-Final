`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 06:13:55 PM
// Design Name: 
// Module Name: Tennis
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

//Directiom: 0 = ball moving right, 1 = ball moving left
//Server: 0 = left player serves next, 1 = right player serves next

module Tennis(
    input clk,
    input rst,
    input p1press,
    input p2press,
    input modebutton,
    output [15:0]position,
    output [7:0] AN_Out,
    output [6:0] C_Out
    );
    wire p1button, p2button, moving, server, direction, rightStrike, leftStrike, slowclk, gamemode, gamemodetoggle;
    wire [3:0]p1score;
    wire [1:0]p2score;
    wire [23:0]speed;
    
    debouncer LD(.clk(clk),.push(p1press),.clean(p1button));
    debouncer RD(.clk(clk),.push(p2press),.clean(p2button));
    debouncer GM(.clk(clk),.push(modebutton),.clean(gamemodetoggle));
    clk_divider CD(.clk_in(clk),.rst(rst),.divided_clk(slowclk),.speed(speed));
    
    BallPositionUpdate BALL(.moving(moving),.slowclk(slowclk),.server(server),.direction(direction),.position(position));
    GameplayController GAME(.clk(clk),.p1button(p1button),.p2button(p2button),.position(position),.moving(moving),.server(server),.direction(direction),.gamemode(gamemode),.gamemodetoggle(gamemodetoggle),.p1score(p1score),.p2score(p2score),.speed(speed));
    ScoreKeeper SCORE(.clk(clk),.rst(rst),.p1score(p1score),.p2score(p2score),.AN_Out(AN_Out),.C_Out(C_Out),.gamemode(gamemode));
       
endmodule
