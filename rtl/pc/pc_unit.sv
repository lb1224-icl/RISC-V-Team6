module pc_unit #(
    parameter WIDTH = 32
) (
    input  logic             clk,
    input  logic             rst,
    input  logic             pc_src,
    input  logic [WIDTH-1:0] pc_in,
    input  logic [WIDTH-1:0] immop,
    output logic [WIDTH-1:0] pc_out
);


localparam logic [WIDTH-1:0] inc_pc;
localparam logic [WIDTH-1:0] branch_pc;
localparam logic [WIDTH-1:0] next_pc;

// Increment PC (pc + 4)
pc_inc #(.WIDTH(WIDTH)) u_inc (\
    .pc(pc_in),
    .inc_pc(inc_pc)
);

// Branch PC (pc + imm)
pc_branch #(.WIDTH(WIDTH)) u_branch (
    .pc(pc_in),
    .imm(immop),
    .branch_pc(branch_pc)
);

// Next PC multiplexer 
mux_2 #(.DATA_WIDTH(WIDTH)) u_mux_next_pc (
    .in0(inc_pc),
    .in1(branch_pc),
    .sel(pc_src),
    .out(next_pc)
);

// PC register
pc_reg #(.WIDTH(WIDTH)) u_pc_reg (
    .clk(clk),
    .rst(rst),
    .pc_in(next_pc),
    .pc_out(pc_out)
);

endmodule
