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
        begin
            clk = 0;
            forever begin
                #20
                clk = ~clk;
            end
        end


    initial begin
        // LOAD FROM DIFFERENT ADDRESSES
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b00;
        instruction[8:0] = 9'b01;
        #40
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b01;
        instruction[8:0] = 9'b0;
        #40
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b10;
        instruction[8:0] = 9'h111;
        #40
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b11;
        instruction[8:0] = 9'h21;

        // STORE DATA AND THEN CHECK IF WE STORE IT CORRECT OR NOT
        #40
        instruction[12:11] = 2'b01;
        instruction[10:9] = 2'b11;
        instruction[8:0] = 9'b01;
        #40
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b00;
        instruction[8:0] = 9'b01;

        // ADD TEST
        #40
        instruction[12:11] = 2'b10;
        instruction[10:0] = 11'b0;

        // MULL TEST
        #40
        instruction[12:11] = 2'b11;
        instruction[10:0] = 11'b0;

        // LOAD EDGE TEST CASES
        #40
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b00;
        instruction[8:0] = 9'd480;
        #40
        instruction[12:11] = 2'b00;
        instruction[10:9] = 2'b01;
        instruction[8:0] = 9'd496;

        // ADD TEST EDGE CASES
        #40
        instruction[12:11] = 2'b10;
        instruction[10:0] = 11'b0;

        // MULL TEST EDGE CASES
        #40
        instruction[12:11] = 2'b11;
        instruction[10:0] = 11'b0;
        #40

        #10 $stop;
    end
    
    initial
        begin
            $monitor($time," A1 = %h\n A2 = %h\n A3 = %h\n A4 = %h\n", A1, A2, A3, A4);

        end


endmodule
