module reg_file #(
    parameter D_WIDTH = 32, A_WIDTH = 5
) (
    input  logic [A_WIDTH-1:0] ad1,
    input  logic [A_WIDTH-1:0] ad2,
    input  logic [A_WIDTH-1:0] ad3,
    input  logic               we3,
    input  logic [D_WIDTH-1:0] imm_op,
    input  logic               alusrc,
    input  logic [2:0]         aluctrl,
    input  logic               clk,
    output logic [D_WIDTH-1:0] a0,
    output logic               eq
);

logic [D_WIDTH-1:0] aluout;
logic [D_WIDTH-1:0] aluop1;
logic [D_WIDTH-1:0] aluop2;
logic [D_WIDTH-1:0] regop2;

ram2 registers (
    .clk(clk),
    .wr_en(we3),
    .wr_addr(ad3),
    .rd1_addr(ad1),
    .rd2_addr(ad2),
    .din(aluout),
    .dout1(aluop1),
    .dout2(regop2),
    .a0(a0)
);

mux_2 imm_mux (
    .in0(regop2),
    .in1(imm_op),
    .sel(alusrc),
    .out(aluop2)
);

alu ALU (
    .aluop1(aluop1),
    .aluop2(aluop2),
    .aluctrl(aluctrl),
    .aluout(aluout),
    .eq(eq)
);

endmodule
