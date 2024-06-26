module VECTOR_PROCESSOR (
        input clk,
        input reset,
        input [12 : 0] instruction,
        output signed [511 : 0] A1,
        output signed [511 : 0] A2,
        output signed [511 : 0] A3,
        output signed [511 : 0] A4
    );

    integer i;

    reg         [511 : 0]   ALUin1;
    reg         [511 : 0]   ALUin2;
    reg                     ALUOp;
    reg         [511 : 0]   RF_in_1;
    reg         [511 : 0]   RF_in_2;
    reg         [1 : 0]     write_address_1;
    reg         [1 : 0]     write_address_2;
    reg                     write_enable_1;
    reg                     write_enable_2;
    reg         [1 : 0]     read_address;
    reg         [8 : 0]     DM_address;
    reg                     DM_write_enable;
    reg  signed [511 : 0]   DM_in;
    wire signed [1023 : 0]  ALUout;
    wire signed [511 : 0]   RF_out;
    wire signed [511 : 0]   RF_A1;
    wire signed [511 : 0]   RF_A2;
    wire signed [511 : 0]   RF_A3;
    wire signed [511 : 0]   RF_A4;
    wire signed [511 : 0]   DM_out;

    localparam [1:0] load=2'b00, store=2'b01, add=2'b10, mul=2'b11;

    ALU alu (ALUin1, ALUin2, ALUOp, ALUout);
    
    RF register_file (clk, reset, RF_in_1, RF_in_2, write_address_1,write_address_2, write_enable_1, write_enable_2,read_address, RF_out, RF_A1, RF_A2, RF_A3, RF_A4);

    MEMORY data_memory (clk, reset, DM_in, DM_address, DM_write_enable, DM_out);

    assign A1 = RF_A1;
    assign A2 = RF_A2;
    assign A3 = RF_A3;
    assign A4 = RF_A4;

    task control_load;
        begin
            DM_write_enable <= 0;
            DM_address <= instruction[8 : 0];
            write_enable_1 <= 1;
            write_enable_2 <= 0;
            write_address_1 <= instruction[10 : 9];
            #5
            RF_in_1 <= DM_out;
        end
    endtask

    task control_store;
        begin
            DM_write_enable <= 1;
            DM_address <= instruction[8 : 0];
            write_enable_1 <= 0;
            write_enable_2 <= 0;
            read_address <= instruction[10 : 9];
            #5
            DM_in <= RF_out;
        end
    endtask

    task control_add_mull;
        begin
            DM_write_enable <= 0;
            write_enable_1 <= 1;
            write_enable_2 <= 1;
            write_address_1 <= 2'b10;
            write_address_2 <= 2'b11;
            ALUin1 <= RF_A1;
            ALUin2 <= RF_A2;
        end
    endtask

    integer start_index, finish_index1, finish_index2;

    always @(posedge clk) begin
        #5
        case (instruction[12 : 11])
            load: 
                control_load();
            store: 
                control_store();
            add: begin
                control_add_mull();
                ALUOp = 1'b0;
                #5
                for(i = 0; i < 16; i = i + 1) begin
                    start_index = i << 5;
                    finish_index1 = i << 6;
                    finish_index2 = finish_index1 + 32;
                    RF_in_1[start_index +: 32] = ALUout[finish_index1 +: 32];
                    RF_in_2[start_index +: 32] = ALUout[finish_index2 +: 32];
                end
            end
            mul: begin
                control_add_mull();
                ALUOp = 1'b1;
                #5
                for(i = 0; i < 16; i = i + 1) begin
                    start_index = i << 5;
                    finish_index1 = i << 6;
                    finish_index2 = finish_index1 + 32;
                    RF_in_1[start_index +: 32] = ALUout[finish_index1 +: 32];
                    RF_in_2[start_index +: 32] = ALUout[finish_index2 +: 32];
                end
            end
        endcase
    end

endmodule
