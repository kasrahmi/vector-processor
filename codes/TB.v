module TB;

    reg clk;
    reg reset;
    reg [12 : 0] instruction;
    wire [511 : 0] A1;
    wire [511 : 0] A2;
    wire [511 : 0] A3;
    wire [511 : 0] A4;

    VECTOR_PROCESSOR processor (clk, reset, instruction, A1, A2, A3, A4);

    initial
        clk = 0;
    always
        #20 clk = ~clk;

    initial begin
        // LOAD FROM DIFFERENT ADDRESSES
        instruction <= {2'b00, 2'b00, 9'b01};
        #40
        instruction <= {2'b00, 2'b01, 9'b0};
        #40
        instruction <= {2'b00, 2'b10, 9'h111};
        #40
        instruction <= {2'b00, 2'b11, 9'h21};
        // STORE DATA AND THEN CHECK IF WE STORE IT CORRECT OR NOT
        #40
        instruction <= {2'b01, 2'b11, 9'b01};
        #40
        instruction <= {2'b00, 2'b00, 9'b01};
        // ADD TEST
        #40
        instruction <= {2'b10, 11'b0};
        // MULL TEST
        #40
        instruction <= {2'b11, 11'b0};
        // LOAD EDGE TEST CASES
        #40
        instruction <= {2'b00, 2'b00, 9'd480};
        #40
        instruction <= {2'b00, 2'b01, 9'd496};
        // ADD TEST EDGE CASES
        #40
        instruction <= {2'b10, 11'b0};
        // MULL TEST EDGE CASES
        #40
        instruction <= {2'b11, 11'b0};
        #40

        #10 $stop;
    end

    initial
        $monitor($time, ":\nA1 = %h\nA2 = %h\nA3 = %h\nA4 = %h\n--------------------",
                    A1, A2, A3, A4);

endmodule
