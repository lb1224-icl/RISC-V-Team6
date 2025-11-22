module pc_inc #(
    parameter D_WIDTH = 32
) (
    input  logic [D_WIDTH-1:0] pc,
    output logic [D_WIDTH-1:0] inc_pc
);

assign inc_pc = pc + 32'b100;

endmodule
