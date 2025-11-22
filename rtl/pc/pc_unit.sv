module pc_unit #(
    parameter D_WIDTH = 32
) (
    input  logic             clk,
    input  logic             rst,
    input  logic             pc_src,
    input  logic [D_WIDTH-1:0] pc_in,
    input  logic [D_WIDTH-1:0] immop,
    output logic [D_WIDTH-1:0] pc_out
);

logic [D_WIDTH-1:0] inc_pc;
logic [D_WIDTH-1:0] branch_pc;
logic [D_WIDTH-1:0] next_pc;

// Increment PC (pc + 4)
pc_inc #(.D_WIDTH(D_WIDTH)) u_inc (
    .pc(pc_in),
    .inc_pc(inc_pc)
);

// Branch PC (pc + imm)
pc_branch #(.D_WIDTH(D_WIDTH)) u_branch (
    .pc(pc_in),
    .imm(immop),
    .branch_pc(branch_pc)
);

// Next PC multiplexer 
mux_2 #(.D_WIDTH(D_WIDTH)) u_mux_next_pc (
    .in0(inc_pc),
    .in1(branch_pc),
    .sel(pc_src),
    .out(next_pc)
);

// PC register
pc_reg #(.D_WIDTH(D_WIDTH)) u_pc_reg (
    .clk(clk),
    .rst(rst),
    .pc_in(next_pc),
    .pc_out(pc_out)
);

endmodule
