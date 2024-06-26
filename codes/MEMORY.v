module MEMORY(
        input clk,
        input reset,
        input signed [511 : 0] input_data,
        input [8 : 0] data_address,
        input write_enable,
        output signed [511 : 0] output_data
    );

    reg signed [31 : 0] data_memory [0 : 511];
    reg signed [511 : 0] MemOut;
    integer i, j;
    integer i1, i2;
    integer j1, j2;
 
    initial
        reset_mem();

    always @(negedge clk or posedge reset) begin
        if(reset) begin
            reset_mem();
        end else begin
            if (write_enable) begin
                for (i = 0; i < 16; i = i + 1) begin
                    i1 = (data_address + i) % 512;
                    i2 = i << 5;
                    data_memory[i1] <= $signed(input_data[i2 +: 32]);
                end
            end
        end
    end

    always @(*) begin
        for (j = 0; j < 16; j = j + 1) begin
            j1 = j << 5;
            j2 = (j + data_address) % 512;
            MemOut[j1 +: 32] = $signed(data_memory[j2]);
        end 
    end


    assign output_data = MemOut;

    task reset_mem;
        begin
            data_memory[0] <= 32'h0;
            data_memory[1] <= 32'h0;
            data_memory[2] <= 32'hFFFFFFFF;
            data_memory[3] <= 32'hF0000000;
            data_memory[4] <= 32'hF0000000;
            data_memory[5] <= 32'h0000000F;
            data_memory[6] <= 32'h1;
            data_memory[7] <= 32'h1;
            data_memory[8] <= 32'h80000000;
            data_memory[9] <= 32'h0F0000F0;
            data_memory[10] <= 32'h0F0000F0;
            data_memory[11] <= 32'h000FF000;
            data_memory[12] <= 32'h7FFFFFFF;
            data_memory[13] <= 32'hFFFF0000;
            data_memory[14] <= 32'h0000FFFF;
            data_memory[15] <= 32'h15;
            data_memory[16] <= 32'h0;
            data_memory[17] <= 32'hFFFFFFFF;
            data_memory[18] <= 32'hFFFFFFFF;
            data_memory[19] <= 32'hF0000000;
            data_memory[20] <= 32'h0000000F;
            data_memory[21] <= 32'h0000000F;
            data_memory[22] <= 32'h1;
            data_memory[23] <= 32'h80000000;
            data_memory[24] <= 32'h80000000;
            data_memory[25] <= 32'h0F0000F0;
            data_memory[26] <= 32'h000FF000;
            data_memory[27] <= 32'h000FF000;
            data_memory[28] <= 32'h7FFFFFFF;
            data_memory[29] <= 32'h0000FFFF;
            data_memory[30] <= 32'h0000FFFF;
            data_memory[31] <= 32'h2;
        end
    endtask

endmodule
