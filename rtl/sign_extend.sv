module sign_extend #(
    WIDTH = 32
) (
    input logic  [1:0]             imm_src,  // type of instruction
    input logic  [WIDTH-1:0]       ins,      // entire instruction word
    output logic [WIDTH-1:0]       imm_op
);

always_comb
case (imm_src)   // 2: R type -> do no care as this instruction doesn't use immediates
    0:  if (ins[31])    // I type
            imm_op <= {{WIDTH-12{1'b1}}, ins[31:20]}
        else 
            imm_op <= {{WIDTH-12{1'b0}}, ins[31:20]}
    1:  if (ins[31])    // S type
            imm_op <= {{WIDTH-12{1'b1}}, ins[31:25], ins[11:7]}
        else 
            imm_op <= {{WIDTH-12{1'b0}}, ins[31:20]}
    3:  if (ins[31])    // B type
            imm_op <= {{WIDTH-13{1'b1}}, ins[31], ins[7], ins[30:25], ins[11:8], 0}
        else 
            imm_op <= {{WIDTH-13{0'b1}}, ins[31], ins[7], ins[30:25], ins[11:8], 0}

    default: if (ins[31])   
                imm_op <= {{WIDTH-12{1'b1}}, ins[31:20]}
             else 
                imm_op <= {{WIDTH-12{1'b0}}, ins[31:20]}              
endcase

endmodule
