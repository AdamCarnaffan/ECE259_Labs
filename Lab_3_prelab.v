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

module part5 (SW, HEX0, HEX1, HEX2);
    input [9:0] SW;
    output [6:0] HEX0, HEX1, HEX2;

    // Begin calculating
endmodule