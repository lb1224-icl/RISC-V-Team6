module pc_branch #(
    parameter D_WIDTH = 32
) (
    input  logic [D_WIDTH-1:0] pc,
    input  logic [D_WIDTH-1:0] imm,
    output logic [D_WIDTH-1:0] branch_pc
);

assign branch_pc = pc + imm;

endmodule
