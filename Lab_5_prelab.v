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

module disp_8bit_hex(value, Disp1, Disp2); // Disp1 is the right-most display
    // Get inputs
    
endmodule

module 

//////////////
/// Part 3 ///
//////////////


//////////////
/// Part 4 ///
//////////////


//////////////
/// Part 5 ///
//////////////


//////////////
/// Part 6 ///
//////////////

