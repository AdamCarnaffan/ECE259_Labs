////////////
// PART 4 //
////////////

module part4 (SW, HEX0);
    input [1:0] SW; // Get switches
    output [6:0] HEX0; // Get output hex
    // Assign outputs
    assign HEX0[0] = ~(SW[0] & SW[1]);
    assign HEX0[1] = ~SW[1];
    assign HEX0[2] = (SW[0] & ~SW[1]) | (SW[1] & ~SW[0]);
    assign HEX0[3] = ~(SW[0] & SW[1]);
    assign HEX0[4] = ~SW[0] & ~SW[1];
    assign HEX0[5] = ~SW[0] & SW[1];
    assign HEX0[6] = ~(SW[0] & SW[1]);
endmodule

////////////
// PART 5 //
////////////

module char_7seg (C, Display);
    input [1:0] C; // Get switches
    output [6:0] Display; // Get output hex
    // Assign outputs
    assign Display[0] = ~(C[0] & C[1]);
    assign Display[1] = ~C[1];
    assign Display[2] = (C[0] & ~C[1]) | (C[1] & ~C[0]);
    assign Display[3] = ~(C[0] & C[1]);
    assign Display[4] = ~C[0] & ~C[1];
    assign Display[5] = ~C[0] & C[1];
    assign Display[6] = ~(C[0] & C[1]);
endmodule

module mux_2bit_3to1 (S, U, V, W, M)
    input [1:0] S, U, V, W;
    output [1:0] M;
    // Assign outputs
    assign M[0] = (~S[1] & ((~S[0] & U[0]) | (S[0] & V[0]))) | (S[1] & W[0]);
    assign M[1] = (~S[1] & ((~S[0] & U[1]) | (S[0] & V[1]))) | (S[1] & W[1]);
endmodule

module part5 (SW, LEDR, HEX0, HEX1, HEX2);
    input [9:0] SW; // Input switches
    output [9:0] LEDR; // LEDs
    output [6:0] HEX0, HEX1, HEX2; // Hex displays
    wire [1:0] M0, M1, M2; // Transfer output of Mux to Displayer
    // Begin calculating
    // Get Mux Results
    mux_2bit_3to1 MX0 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M0);
    mux_2bit_3to1 MX1 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M1);
    mux_2bit_3to1 MX2 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M2);
    // Assign to displays (Assigned in inverse to read in proper order)
    char_7seg Disp1 (M0, HEX2);
    char_7seg Disp2 (M1, HEX1);
    char_7seg Disp3 (M2, HEX0);
    // Assign LEDs to match Switches
    assign LEDR = SW;
endmodule