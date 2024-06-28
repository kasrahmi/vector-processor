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
            $readmemh("hex_file.txt", data_memory);
        end
    endtask

endmodule