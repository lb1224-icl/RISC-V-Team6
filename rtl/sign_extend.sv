module sign_extend #(
    WIDTH = 32
) (
    input logic                    imm_src,
    input logic  [11:0]            imm,
    output logic [WIDTH-1:0]  imm_op
);

always_comb
if (imm_src)
    if (imm[11])
        assign imm_op <= {{WIDTH-12{1'b1}}, imm}
    else 
        assign imm_op <= {{WIDTH-12{1'b0}}, imm}

endmodule
