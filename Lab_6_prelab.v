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

////////////
// Part 3 //
////////////

module part3(SW, KEY, LEDR, CLOCK_50);
    // Get externals
    input [2:0] SW;
    input [1:0] KEY;
    input CLOCK_50;
    output reg [1:0] LEDR;
    // Wiring
    reg [2:0] N_DISP_ST, DISP_ST, LTTR_ST;
    reg [26:0] clk;
    reg w, CLK_TRG;
    // Parameters
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111; // Display states
    parameter J = 3'b000, K = 3'b001, L = 3'b010, M = 3'b011, N = 3'b100, O = 3'b101, P = 3'b110, Q = 3'b111; // Letter states (literal)
    parameter CLK_SH = 1'b0, CLK_LG = 1'b1; // Clocking 0.5s & 1.5s

	 // Default
	 initial CLK_TRG = CLK_SH;
	 initial DISP_ST = H;
	 initial N_DISP_ST = H;
	 
    // Clocking & Reset
    always @(posedge CLOCK_50, posedge KEY[0], posedge KEY[1])
    begin
		  if (KEY[0]) // Reset condition
		  begin
				LTTR_ST <= 0;
		   	DISP_ST <= H;
		  end
		  else if (KEY[1])
		  begin
				LTTR_ST[2:0] <= SW[2:0]; // Assign new letter input
			   DISP_ST <= A;
		  end
        else
		  begin
			case (CLK_TRG)
				CLK_SH:
					begin
					if (clk > 3)
						begin
							LEDR[1] = 1;
							DISP_ST <= N_DISP_ST;
							clk <= 27'b0;
							w <= 1;
						end
					else
						begin
							DISP_ST <= DISP_ST;
							LEDR[1] = 0;
							clk <= clk + 1;
							w <= 0;
						end
					end
				CLK_LG:
					begin
					if (clk > 9)
						begin
							LEDR[1] = 1;
							DISP_ST <= N_DISP_ST;
							clk <= 27'b0;
							w <= 1;
						end
					else
						begin
							DISP_ST <= DISP_ST;
							LEDR[1] = 0;
							clk <= clk + 1;
							w <= 0;
						end
					end
				default:
					clk <= clk + 1;
				endcase
		  end
    end

    // Display Updater
    always @(posedge w)
    begin
        // CHANGE DISPLAY STATE
        case (DISP_ST)
            A: // First Char
            begin
                N_DISP_ST <= B; // Assign next state
                case (LTTR_ST)
                    J, L, P: // Dots
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_SH;
                    end
                    K, M, N, O, Q: // Dashes
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_LG;
                    end
                    default:
                        LEDR[0] <= 1'b0;
                endcase
            end
            B: // Space
            begin
                N_DISP_ST <= C; // Assign next state
                LEDR[0] <= 1'b0;
                CLK_TRG <= CLK_SH;
            end
            C: // Second Char
            begin
                N_DISP_ST <= D; // Assign next state
                case (LTTR_ST)
                    K, N: // Dots
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_SH;
                    end
                    J, L, M, O, P, Q: // Dashes
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_LG;
                    end
                    default:
                        LEDR[0] <= 1'b0;
                endcase
            end
            D: // Space
            begin
                N_DISP_ST <= E; // Assign next state
                LEDR[0] <= 1'b0;
                CLK_TRG <= CLK_SH;
            end
            E: // Third Char
            begin
                N_DISP_ST <= F; // Assign next state
                case (LTTR_ST)
                    L, Q: // Dots
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_SH;
                    end
                    J, K, O, P: // Dashes
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_LG;
                    end
                    M, N: // No values
                    begin
                        LEDR[0] <= 1'b0;
                        CLK_TRG <= CLK_SH;
                    end
                    default:
                        LEDR[0] <= 1'b0;
                endcase
            end
            F: // Space
            begin
                N_DISP_ST <= G; // Assign next state
                LEDR[0] <= 1'b0;
                CLK_TRG <= CLK_SH;
            end
            G: // Fourth Char
            begin
                N_DISP_ST <= H; // Assign next state
                case (LTTR_ST)
                    L, P: // Dots
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_SH;
                    end
                    J, Q: // Dashes
                    begin
                        LEDR[0] <= 1'b1;
                        CLK_TRG <= CLK_LG;
                    end
                    K, M, N, O: // No values
                    begin
                        LEDR[0] <= 1'b0;
                        CLK_TRG <= CLK_SH;
                    end
                    default:
                        LEDR[0] <= 1'b0;
                endcase
            end
            H: // Space & Stagnant state
            begin
                N_DISP_ST <= H; // Change to A to make cyclical ;)
                LEDR[0] <= 1'b0;
                CLK_TRG <= CLK_SH;
            end
            default:
                N_DISP_ST <= A;
        endcase
    end
endmodule