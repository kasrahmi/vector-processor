module RF (
    input clk,
    input reset,
    input [511:0] input_data_1,
    input [511:0] input_data_2,
    input [1:0] write_address_1,
    input [1:0] write_address_2,
    input write_enable_1,
    input write_enable_2,
    input [1:0] read_address,
    output signed [511:0] output_data,
    output signed [511:0] A1,
    output signed [511:0] A2,
    output signed [511:0] A3,
    output signed [511:0] A4
);

    // Register file array to hold 4 registers of 512 bits each
    reg signed [511:0] reg_file [0:3];

    // Assignments to output individual registers
    assign A1 = reg_file[0];
    assign A2 = reg_file[1];
    assign A3 = reg_file[2];
    assign A4 = reg_file[3];

    integer i;
    // Sequential block to handle reset and write operations
    always @(negedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0
            for (i = 0; i < 4; i = i + 1) begin
                reg_file[i] <= 512'b0;
            end
        end else begin
            // Write data to registers if write enable signals are active
            if (write_enable_1) begin
                reg_file[write_address_1] <= input_data_1;
            end
            if (write_enable_2) begin
                reg_file[write_address_2] <= input_data_2;
            end
        end
    end

    // Output data from the selected register
    assign output_data = reg_file[read_address];

endmodule
