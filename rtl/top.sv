module top #(
    parameter  D_WIDTH = 32
) (
    input  logic               clk,
    input  logic               rst,
    output logic [D_WIDTH-1:0] a0
);

    logic [D_WIDTH-1:0] pc_out;
    logic [D_WIDTH-1:0] instr;
    logic               EQ;
    logic               PCsrc;
    logic [2:0]         ALUctrl;
    logic               ALUsrc;
    logic [1:0]         Immsrc;
    logic               RegWrite;
    logic [D_WIDTH-1:0] ImmOp;

    logic [4:0]         rs1;
    logic [4:0]         rs2;
    logic [4:0]         rd;

    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd  = instr[11:7];

    pc_unit pc (
        .clk    (clk),
        .rst    (rst),
        .pc_src (PCsrc),
        .pc_in  (pc_out),
        .immop  (ImmOp),
        .pc_out (pc_out)
    );

    control_unit ctrl (
        .ins       (instr),
        .EQ        (EQ),
        .pc_src    (PCsrc),
        .alu_ctrl  (ALUctrl),
        .alu_src   (ALUsrc),
        .imm_src   (Immsrc),
        .reg_write (RegWrite)
    );

    instr_mem imem (
        .addr (pc_out),
        .dout (instr)
    );

    sign_extend sgn (
        .imm_src (Immsrc),
        .ins     (instr),
        .imm_op  (ImmOp)
    );

    reg_file rf (
        .ad1     (rs1),
        .ad2     (rs2),
        .ad3     (rd),
        .we3     (RegWrite),
        .imm_op  (ImmOp),
        .alusrc  (ALUsrc),
        .aluctrl (ALUctrl),
        .clk     (clk),
        .a0      (a0),
        .eq      (EQ)
    );

endmodule
