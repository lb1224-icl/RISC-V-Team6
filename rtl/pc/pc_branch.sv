module pc_branch #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH-1:0] pc,
    input  logic [WIDTH-1:0] imm,
    output logic [WIDTH-1:0] branch_pc
);

assign branch_pc = pc + imm;

endmodule
