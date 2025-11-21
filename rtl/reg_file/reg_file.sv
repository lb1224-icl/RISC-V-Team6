module reg_file #(
    parameter D_WIDTH = 8,
    parameter A_WIDTH = 5
) (
    input logic ad1,
    input logic ad2,
    input logic ad3,
    input logic we3,
    input logic imm_op,
    input logic alusrc,
    input logic aluctrl,
    input logic clk,
    output logic a0,
    output logic eq
);

logic wd3;
logic aluop2;

ram2 registers (
    .clk(clk),
    .wr_en(we3),
    .wr_addr(ad3),
    .rd1_addr(ad1),
    .rd2_addr(ad2),
    .din(wd3),
    .dout1(rd1),
    .dout2(rd2)
)

mux_2 imm_mux (
    .in0(dout2),
    .in1(imm_op),
    .sel(alusrc),
    .out(alu2)
)

alu ALU (
    .aluop1(dout1),
    .aluop2(alu2),
    .aluctrl(aluctrl),
    .aluout(wd3),
    .eq(eq)
)
endmodule
