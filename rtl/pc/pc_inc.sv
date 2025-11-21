module pc_inc #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH-1:0] pc,
    output logic [WIDTH-1:0] inc_pc
);

assign inc_pc = pc + 32'b100;

endmodule
