////////////
// PART 1 //
////////////

// Simple module that connects the SW switches to the LEDR lights
module part1 (SW, LEDR);
    input [9:0] SW; // toggle switches
    output [9:0] LEDR; // red LEDs
    assign LEDR = SW;
endmodule

////////////
// PART 2 //
////////////

module part2 (SW, LEDR);
    input [9:0] SW; // Get Switches
    output [9:0] LEDR; // Get LEDs
    wire [3:0] X, Y, M;
    wire s;
    // Make variable assignments
    assign X[0] = SW[0];
    assign X[1] = SW[1];
    assign X[2] = SW[2];
    assign X[3] = SW[3];
    assign Y[0] = SW[4];
    assign Y[1] = SW[5];
    assign Y[2] = SW[6];
    assign Y[3] = SW[7];
    assign s = SW[9];
    // Get outputs
    assign M[0] = (∼s & X[0]) | (s & Y[0]);
    assign M[1] = (∼s & X[1]) | (s & Y[1]);
    assign M[2] = (∼s & X[2]) | (s & Y[2]);
    assign M[3] = (∼s & X[3]) | (s & Y[3]);
    // Output
    assign LEDR[9] = s;
    assign LEDR[0] = M[0];
    assign LEDR[1] = M[1];
    assign LEDR[2] = M[2];
    assign LEDR[3] = M[3];
endmodule


////////////
// PART 3 //
////////////

module part3 (SW, LEDR);
    input [9:0] SW; // Get switches
    output [9:0] LEDR; // Get LEDs
    wire [1:0] U, V, W, M, S;
    // Assign Values
    assign U[0] = SW[0];
    assign U[1] = SW[1];
    assign V[0] = SW[2];
    assign V[1] = SW[3];
    assign W[0] = SW[4];
    assign W[1] = SW[5];
    assign S[0] = SW[9];
    assign S[1] = SW[8];
    // Get Outputs
    assign M[0] = (~S[1] & ((~S[0] & U[0]) | (S[0] & V[0]))) | (S[1] & W[0]);
    assign M[1] = (~S[1] & ((~S[0] & U[1]) | (S[0] & V[1]))) | (S[1] & W[1]);
    // Output
    assign LEDR[0] = M[0];
    assign LEDR[1] = M[1];
endmodule
