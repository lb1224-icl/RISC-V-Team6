module top #(
    parameter  WIDTH = 32,
) (
    input  logic        clk,
    input  logic        rst,
    output logic [WIDTH-1:0] a0
);

    logic [WIDTH-1:0] pc_out;
    logic             PCsrc;
    logic [WIDTH-1:0] immop;

    pc_unit #(.WIDTH(WIDTH)) pc (
        .clk    (clk),
        .rst    (rst),
        .pc_src (PCsrc),
        .pc_in  (pc_out),
        .immop  (immop),
        .pc_out (pc_out)
    );

    instr_mem imem (
        .addr (pc_out),
        .dout (instr)
    );


    assign alu_in2 = ALUSrc ? immop : RD2;

    alu_unit alu (
        .opA     (RD1),
        .opB     (alu_in2),
        .ALUctrl (ALUctrl),
        .sum     (alu_out),
        .eq      (EQ)
    );

    assign a0 = alu_out;

endmodule
