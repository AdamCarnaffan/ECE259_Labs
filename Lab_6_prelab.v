////////////
// Part 1 //
////////////

module flip_flop(D, clk, out); // Flip Flop from lab5
    input D, clk;
    output reg out;
    always @(posedge clk)
    begin
        out <= D;
    end
endmodule

module part1(SW, KEY, LEDR);
    input [1:0] KEY, SW;
    output [9:0] LEDR;
    wire [8:0] Y;
    // Make calculations
    flip_flop F0 (~SW[0] | ((~Y[1] & ~Y[2] & ~Y[3] & ~Y[4] & ~Y[5] & ~Y[6] & ~Y[7] & ~Y[8]) & ~Y[0]), KEY[0], Y[0]);
    flip_flop F1 (~SW[1] & (Y[5] | Y[6] | Y[7] | Y[8] | Y[0]) & SW[0], KEY[0], Y[1]);
    flip_flop F2 (~SW[1] & Y[1] & SW[0], KEY[0], Y[2]);
    flip_flop F3 (~SW[1] & Y[2] & SW[0], KEY[0], Y[3]);
    flip_flop F4 (~SW[1] & (Y[3] | Y[4]) & SW[0], KEY[0], Y[4]);
    flip_flop F5 (SW[1] & (Y[1] | Y[2] | Y[3] | Y[4] | Y[0]) & SW[0], KEY[0], Y[5]);
    flip_flop F6 (SW[1] & Y[5] & SW[0], KEY[0], Y[6]);
    flip_flop F7 (SW[1] & Y[6] & SW[0], KEY[0], Y[7]);
    flip_flop F8 (SW[1] & (Y[7] | Y[8]) & SW[0], KEY[0], Y[8]);
    // Output
    assign LEDR[8:0] = Y;
    assign LEDR[9] = Y[4] | Y[8];
endmodule

module part1_modified(SW, KEY, LEDR);
    input [1:0] KEY, SW;
    output [9:0] LEDR;
    wire [8:0] Y;
    // Make calculations
    flip_flop F0 (SW[0], KEY[0], Y[0]);
    flip_flop F1 (~SW[1] & (Y[5] | Y[6] | Y[7] | Y[8] | ~Y[0]) & SW[0], KEY[0], Y[1]);
    flip_flop F2 (~SW[1] & Y[1] & SW[0], KEY[0], Y[2]);
    flip_flop F3 (~SW[1] & Y[2] & SW[0], KEY[0], Y[3]);
    flip_flop F4 (~SW[1] & (Y[3] | Y[4]) & SW[0], KEY[0], Y[4]);
    flip_flop F5 (SW[1] & (Y[1] | Y[2] | Y[3] | Y[4] | ~Y[0]) & SW[0], KEY[0], Y[5]);
    flip_flop F6 (SW[1] & Y[5] & SW[0], KEY[0], Y[6]);
    flip_flop F7 (SW[1] & Y[6] & SW[0], KEY[0], Y[7]);
    flip_flop F8 (SW[1] & (Y[7] | Y[8]) & SW[0], KEY[0], Y[8]);
    // Output
    assign LEDR[8:0] = Y;
    assign LEDR[9] = (Y[4] | Y[8]) & Y[0];
endmodule

////////////
// Part 2 //
////////////

module part2(SW, KEY, LEDR);
    input [1:0] KEY, SW;
    output reg [9:0] LEDR;
    reg [3:0] y_Q, y_D; // Q is current, D is next
    wire w; // Value for switch state
    parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;
    // Begin assignments
    assign w = SW[1];
    // Assign with state logic
    always @(w, y_Q)
    begin
        // Determine next state & light LEDs
        LEDR[9:0] = 10'b0;
        case (y_Q)
            A: begin if (w) y_D = F; else y_D = B; LEDR[0] = 1'b1; end
            B: begin if (w) y_D = F; else y_D = C; LEDR[1] = 1'b1; end
            C: begin if (w) y_D = F; else y_D = D; LEDR[2] = 1'b1; end
            D: begin if (w) y_D = F; else y_D = E; LEDR[3] = 1'b1; end
            E: begin if (w) y_D = F; else y_D = E; LEDR[4] = 1'b1; LEDR[9] = 1'b1; end
            F: begin if (w) y_D = G; else y_D = B; LEDR[5] = 1'b1; end
            G: begin if (w) y_D = H; else y_D = B; LEDR[6] = 1'b1; end
            H: begin if (w) y_D = I; else y_D = B; LEDR[7] = 1'b1; end
            I: begin if (w) y_D = I; else y_D = B; LEDR[8] = 1'b1; LEDR[9] = 1'b1; end
            default: y_D = 4'bxxxx;
        endcase
    end

    // Clocking
    always @(negedge SW[0], posedge KEY[0]) // clock and reset logic
    begin
        if (~SW[0]) y_Q <= A;
        else y_Q <= y_D;
    end
endmodule