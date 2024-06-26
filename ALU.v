module ALU (
    input [511:0] input_data_1,
    input [511:0] input_data_2,
    input ALUOp,
    output signed [1023:0] output_data
);

    reg signed [1023:0] ALUOut;
    integer i;
    integer start_index;
    integer end_index;

    always @(*) begin
        ALUOut = 0; // Initialize ALUOut to avoid latches
        if (ALUOp == 1'b0) begin
            for (i = 0; i < 16; i = i + 1) begin
                start_index = i << 6;
                end_index = i << 5;
                ALUOut[start_index +: 64] = $signed(input_data_1[end_index +: 32]) + $signed(input_data_2[end_index +: 32]);
            end
        end else if (ALUOp == 1'b1) begin
            for (i = 0; i < 16; i = i + 1) begin
                start_index = i << 6;
                end_index = i << 5;
                ALUOut[start_index +: 64] = $signed(input_data_1[end_index +: 32]) * $signed(input_data_2[end_index +: 32]);
            end
        end
    end

    assign output_data = ALUOut;

endmodule
