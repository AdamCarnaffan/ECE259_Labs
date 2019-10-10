//////////////
/// Part 1 ///
//////////////

module part1(SW, LEDR);
    input [1:0] SW;
    output [5:0] LEDR;
    // Flip Flop
    always @(SW[1])
    begin
        LEDR[1] = LEDR[0];
        LEDR[0] <= SW[0];
    end
    // Positive D-Latch
    always @(posedge SW[1])
    begin
        LEDR[3] = LEDR[2];
        LEDR[2] <= SW[0];
    end
    // Negative D-Latch
    always @(negedge SW[1])
    begin
        LEDR[5] = LEDR[4];
        LEDR[4] <= SW[0];
    end
endmodule

//////////////
/// Part 2 ///
//////////////



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

