module control_unit #(
    WIDTH = 32
) (
    input logic  [WIDTH-1:0]  ins,
    input logic               zero,
    output logic              pc_src,
    output logic              result_src,
    output logic              mem_write,
    output logic [2:0]        alu_ctrl,
    output logic              alu_src,
    output logic [1:0]        imm_src,
    output logic              reg_write
);

logic [1:0]     alu_op;

endmodule 
