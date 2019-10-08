//////////////
/// Part 1 ///
//////////////

module hex_disp(C, Display);
    // Get inputs
    input [3:0] C;
    output [6:0] Display;
    // Make assignments
    assign Display[0] = ~C[3] & ((C[0] & ~C[2]) | (~C[0] & C[2]));
    assign Display[1] = C[2] & ((C[0] & ~C[1]) | (~C[0] & C[1]));
    assign Display[2] = C[0] & ~C[1] & C[2] & C[3];
    assign Display[3] = (C[0] & ~C[1] & ~C[2]) | (~C[3] & C[2] & ((~C[0] & ~C[1]) | (C[0] & C[1])));
    assign Display[4] = (~C[1] & ~C[3] & (C[0] | (~C[0] & C[2]))) | (C[0] & ((~C[1] & ~C[2] & C[3]) | (C[1] & ~C[3])));
    assign Display[5] = ~C[3] & ((C[1] & ~C[2]) | (C[0] & ((~C[1] & ~C[2]) | (C[1] & C[2]))));
    assign Display[6] = ~C[3] & ((~C[1] & ~C[2]) | (C[0] & C[1] & C[2]));
endmodule

module part1(SW, HEX0, HEX1);
    // Get externals
    input [7:0] SW;
    output [6:0] HEX0, HEX1;
    // Make assignments
    hex_disp D1 (SW[3:0], HEX0);
    hex_disp D2 (SW[7:4], HEX1);
endmodule

//////////////
/// Part 2 ///
//////////////

module hex_disp(C, Display); // From part1
    // Get inputs
    input [3:0] C;
    output [6:0] Display;
    // Make assignments
    assign Display[0] = ~C[3] & ((C[0] & ~C[2]) | (~C[0] & C[2]));
    assign Display[1] = C[2] & ((C[0] & ~C[1]) | (~C[0] & C[1]));
    assign Display[2] = C[0] & ~C[1] & C[2] & C[3];
    assign Display[3] = (C[0] & ~C[1] & ~C[2]) | (~C[3] & C[2] & ((~C[0] & ~C[1]) | (C[0] & C[1])));
    assign Display[4] = (~C[1] & ~C[3] & (C[0] | (~C[0] & C[2]))) | (C[0] & ((~C[1] & ~C[2] & C[3]) | (C[1] & ~C[3])));
    assign Display[5] = ~C[3] & ((C[1] & ~C[2]) | (C[0] & ((~C[1] & ~C[2]) | (C[1] & C[2]))));
    assign Display[6] = ~C[3] & ((~C[1] & ~C[2]) | (C[0] & C[1] & C[2]));
endmodule

module conv_9(VAL, RET);
    // Get inputs
    input [3:0] VAL;
    output [3:0] RET;
    // Make assignments
    assign RET[0] = VAL[0];
    assign RET[1] = ~VAL[1];
    assign RET[2] = VAL[1] & VAL[2];
    assign RET[3] = 1'b0;
endmodule

module part2(SW, HEX0, HEX1);
    // Get externals
    input [3:0] SW;
    output [6:0] HEX0, HEX1;
    wire r;
    wire [3:0] A, Z;
    assign Z = 4'b0;
    // Make assignments
    // Get val for > 9 eval
    assign r = SW[3] & (SW[2] | SW[1]);
    // Find value if converted (don't care about <10)
    conv_9 comp (SW, A);
    // Mux
    assign A[0] = (~r & SW[0]) | (r & A[0]);
    assign A[1] = (~r & SW[1]) | (r & A[1]);
    assign A[2] = (~r & SW[2]) | (r & A[2]);
    assign A[3] = (~r & SW[3]) | (r & A[3]);
    assign Z[0] = r;
    // Assign to displays
    hex_disp d0 (A, HEX0);
    hex_disp d1 (Z, HEX1);
endmodule

//////////////
/// Part 3 ///
//////////////

module adder(A, B, Cin, S, Cout);
    // Get inputs
    input A, B, Cin;
    output S, Cout;
    // Make assignments
    assign S = (B & Cin) | (A & B) | (A & Cin);
    assign Cout = (Cin & ((~A & B) | (A & ~B))) | (Cin & ((~A & ~B) | (A & B)));
endmodule

module part3(SW, LEDR);
    // Get externals
    input [8:0] SW;
    output [4:0] LEDR;
    wire C0, C1, C2, C3;
    // Make assignments
    adder A0 (SW[0], SW[4], SW[8], LEDR[0], C0);
    adder A1 (SW[1], SW[5], C0, LEDR[1], C1);
    adder A2 (SW[2], SW[6], C1, LEDR[2], C12;
    adder A3 (SW[3], SW[7], C2, LEDR[3], C3);
    assign LEDR[4] = C3;
endmodule

//////////////
/// Part 4 ///
//////////////

module adder(A, B, Cin, S, Cout); // Copied from part3
    // Get inputs
    input A, B, Cin;
    output S, Cout;
    // Make assignments
    assign S = (B & Cin) | (A & B) | (A & Cin);
    assign Cout = (Cin & ((~A & B) | (A & ~B))) | (Cin & ((~A & ~B) | (A & B)));
endmodule

module conv_9_5bit_4bit(VAL, RET); // Copied concept from part2
    // Get inputs
    input [4:0] VAL;
    output [3:0] RET;
    // Make assignments
    assign RET[0] = VAL[0];
    assign RET[1] = ~VAL[1];
    assign RET[2] = (VAL[3] & VAL[2] & VAL[1]) | (~VAL[3] & ~VAL[1]);
    assign RET[3] = VAL[4] & VAL[1];
endmodule

module hex_disp(C, Display); // From part1
    // Get inputs
    input [3:0] C;
    output [6:0] Display;
    // Make assignments
    assign Display[0] = ~C[3] & ((C[0] & ~C[2]) | (~C[0] & C[2]));
    assign Display[1] = C[2] & ((C[0] & ~C[1]) | (~C[0] & C[1]));
    assign Display[2] = C[0] & ~C[1] & C[2] & C[3];
    assign Display[3] = (C[0] & ~C[1] & ~C[2]) | (~C[3] & C[2] & ((~C[0] & ~C[1]) | (C[0] & C[1])));
    assign Display[4] = (~C[1] & ~C[3] & (C[0] | (~C[0] & C[2]))) | (C[0] & ((~C[1] & ~C[2] & C[3]) | (C[1] & ~C[3])));
    assign Display[5] = ~C[3] & ((C[1] & ~C[2]) | (C[0] & ((~C[1] & ~C[2]) | (C[1] & C[2]))));
    assign Display[6] = ~C[3] & ((~C[1] & ~C[2]) | (C[0] & C[1] & C[2]));
endmodule

module part4(SW, LEDR, HEX0, HEX1, HEX4, HEX5);
    // Get inputs
    input [9:0] SW;
    output [6:0] HEX0, HEX1, HEX4, HEX5;
    output [9:0] LEDR;
    wire [3:0] X, Y, Disp0, Disp1;
    wire [4:0] Res; // Result of addition
    wire C0, C1, C2, C3, C4, r;
    // Make assignments
    assign X = SW[7:4];
    assign Y = SW[3:0];
    assign C0 = SW[8];
    // Error check
    assign LEDR[9] = (X[3] & (X[2] | X[1])) | (Y[3] & (Y[2] | Y[1])); // Check if X or Y > 9
    // Calculate
    adder A0 (X[0], Y[0], C0, Res[0], C1);
    adder A1 (X[1], Y[1], C1, Res[1], C2);
    adder A2 (X[2], Y[2], C2, Res[2], C3);
    adder A3 (X[3], Y[3], C3, Res[3], C4);
    assign Res[4] = C4;
    // Assign display values
    assign r = 0; // boolean to determine if disp1 is 1 or 0
    conv_9_5bit_4bit Cv (Res, Disp0);
    // Assign Disp0 values individually
    assign Disp0[0] = (~r & Res[0]) | (r & Disp[0]);
    assign Disp0[1] = (~r & Res[1]) | (r & Disp[1]);
    assign Disp0[2] = (~r & Res[2]) | (r & Disp[2]);
    assign Disp0[3] = (~r & Res[3]) | (r & Disp[3]);
    // Get Disp1
    assign Disp1 = 4'b0;
    assign Disp1[0] = r;
    // Display values
    hex_disp D0 (Disp0, HEX0);
    hex_disp D1 (Disp1, HEX1);
    hex_disp D4 (X, HEX4);
    hex_disp D5 (Y, HEX5);
endmodule

//////////////
/// Part 5 ///
//////////////

module part5(SW, HEX0, HEX1, HEX4, HEX5);
    // Get inputs
    input [9:0] SW;
    output [6:0] HEX0, HEX1, HEX4, HEX5;
    wire [3:0] X, Y, Disp0, Disp1;
    wire [4:0] Res; // Result of addition
    wire C0, C1, C2, C3, C4;
    // Make assignments
    assign X = SW[7:4];
    assign Y = SW[3:0];
    assign C0 = SW[8];
    // Calculate
    adder A0 (X[0], Y[0], C0, Res[0], C1);
    adder A1 (X[1], Y[1], C1, Res[1], C2);
    adder A2 (X[2], Y[2], C2, Res[2], C3);
    adder A3 (X[3], Y[3], C3, Res[3], C4);
    assign Res[4] = C4;
    // Assign display values
    if (Resp > 9) then
        Disp1 = 4'b0001;
        conv_9_5bit_4bit Cv (Res, Disp0);
    else
        Disp1 = 4'b0000;
        Disp0 = Res[3:0];
    end if
    // Display values
    hex_disp D0 (Disp0, HEX0);
    hex_disp D1 (Disp1, HEX1);
    hex_disp D4 (X, HEX4);
    hex_disp D5 (Y, HEX5);
endmodule