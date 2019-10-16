//////////////
/// Part 1 ///
//////////////

module flip_flop(D, clk, out); // Flip Flop
    input D, clk;
    output reg out;
    always @(clk)
    begin
        if (clk == 1)
            out <= D;
    end
endmodule
   

module pos_latch(D, clk, out); // Negative D-Latch
    input D, clk;
    output reg out;
    always @(posedge clk)
    begin
        out <= D;
    end
endmodule

module neg_latch(D, clk, out); // Positive D-Latch
    input D, clk;
    output reg out;
    always @(negedge clk)
    begin
        out <= D;
    end
endmodule

module part1(SW, LEDR);
    input [1:0] SW; // 0 is D, 1 is Clk
    output [3:0] LEDR;
    // Assign
    assign LEDR[0] = SW[0];
    flip_flop F (SW[0], SW[1], LEDR[1]);
    pos_latch P (SW[0], SW[1], LEDR[2]);
    neg_latch N (SW[0], SW[1], LEDR[3]);
endmodule

//////////////
/// Part 2 ///
//////////////

module adder(A, B, Cin, S, Cout); // Copied from lab4 part3
    // Get inputs
    input A, B, Cin;
    output S, Cout;
    // Make assignments
    assign Cout = (B & Cin) | (A & ((~B & Cin) | (B & ~Cin)));
    assign S = (~Cin & ((~A & B) | (A & ~B))) | (Cin & ((~A & ~B) | (A & B)));
endmodule

module disp_4bit_hex(C, Disp);
    // Get inputs
    input [7:0] C;
    output [6:0] Disp;
    // Make assignments
    assign Disp[0] = (C[2] & ~C[1] & ~C[0]) | (C[0] & ((C[3] & (C[2] ^ C[1])) | (~C[1] & ~C[2] & ~C[3])));
    assign Disp[1] = (C[3] & ((C[1] & C[0]) | (C[2] & ~C[0]))) | (~C[3] & C[2] & (C[1] ^ C[0]));
    assign Disp[2] = (C[3] & C[2] & (C[1] | (~C[1] & ~C[0]))) | (~C[3] & ~C[2] & C[1] & ~C[0]);
    assign Disp[3] = (C[1] & ((C[2] & C[0]) | (C[3] & ~C[2] & ~C[0]))) | (~C[3] & ~C[1] & ((C[2] & ~C[0]) | (~C[2] & C[0])));
    assign Disp[4] = (C[0] & ((~C[3]) | (C[3] & ~C[1]))) | (~C[3] & C[2] & ~C[1] & ~C[0]);
    assign Disp[5] = (C[3] & C[2] & ~C[1]) | (~C[3] & ~C[2] & (C[1] | C[0]) | (~C[3] & C[2] & C[1] & C[0]));
    assign Disp[6] = ~C[3] & ((~C[2] & ~C[1]) | (C[2] & C[1] & C[0]));
endmodule

module part2(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    // Get inputs
    input [8:0] SW;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output LEDR;
    reg [7:0] A, B;
    wire [7:0] S, C;
    // Save A
    always @(posedge SW[8])
    begin
        A <= SW[7:0];
    end
    // Save B
    always @(negedge SW[8])
    begin
        B <= SW[7:0];
    end
    // Calculate
    adder A0 (A[0], B[0], 1'b0, S[0], C[0]);
    adder A1 (A[1], B[1], C[0], S[1], C[1]);
    adder A2 (A[2], B[2], C[1], S[2], C[2]);
    adder A3 (A[3], B[3], C[2], S[3], C[3]);
    adder A4 (A[4], B[4], C[3], S[4], C[4]);
    adder A5 (A[5], B[5], C[4], S[5], C[5]);
    adder A6 (A[6], B[6], C[5], S[6], C[6]);
    adder A7 (A[7], B[7], C[6], S[7], C[7]);
    // Display
    disp_4bit_hex D0 (A[3:0], HEX0);
    disp_4bit_hex D1 (A[7:4], HEX1);
    disp_4bit_hex D2 (B[3:0], HEX2);
    disp_4bit_hex D3 (B[7:4], HEX3);
    disp_4bit_hex D4 (S[3:0], HEX4);
    disp_4bit_hex D5 (S[7:4], HEX5);
endmodule

//////////////
/// Part 3 ///
//////////////

module disp_4bit_hex(C, Disp);
    // Get inputs
    input [7:0] C;
    output [6:0] Disp;
    // Make assignments
    assign Disp[0] = (C[2] & ~C[1] & ~C[0]) | (C[0] & ((C[3] & (C[2] ^ C[1])) | (~C[1] & ~C[2] & ~C[3])));
    assign Disp[1] = (C[3] & ((C[1] & C[0]) | (C[2] & ~C[0]))) | (~C[3] & C[2] & (C[1] ^ C[0]));
    assign Disp[2] = (C[3] & C[2] & (C[1] | (~C[1] & ~C[0]))) | (~C[3] & ~C[2] & C[1] & ~C[0]);
    assign Disp[3] = (C[1] & ((C[2] & C[0]) | (C[3] & ~C[2] & ~C[0]))) | (~C[3] & ~C[1] & ((C[2] & ~C[0]) | (~C[2] & C[0])));
    assign Disp[4] = (C[0] & ((~C[3]) | (C[3] & ~C[1]))) | (~C[3] & C[2] & ~C[1] & ~C[0]);
    assign Disp[5] = (C[3] & C[2] & ~C[1]) | (~C[3] & ~C[2] & (C[1] | C[0]) | (~C[3] & C[2] & C[1] & C[0]));
    assign Disp[6] = ~C[3] & ((~C[2] & ~C[1]) | (C[2] & C[1] & C[0]));
endmodule

module part3(SW, KEY, HEX0, HEX1, HEX2, HEX3)

//////////////
/// Part 4 ///
//////////////


//////////////
/// Part 5 ///
//////////////


//////////////
/// Part 6 ///
//////////////

