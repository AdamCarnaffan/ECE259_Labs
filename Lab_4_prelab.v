//////////////
/// Part 1 ///
//////////////

module hex_disp(C, Display);
    // Get inputs
    input [3:0] C;
    output [6:0] Display;
    // Make assignments
    assign Display[0] = 
    assign Display[1] = 
    assign Display[2] = 
    assign Display[3] = 
    assign Display[4] = 
    assign Display[5] = 
    assign Display[6] = 
endmodule

module part1(SW, HEX0, HEX1);
    // Get externals
    input [7:0] SW;
    output [6:0] HEX0, HEX1;
    // Make assignments
    hex_disp D1 (SW[3:0], HEX0);
    hex_disp D2 (SW[7:4], HEX1);
endmodule