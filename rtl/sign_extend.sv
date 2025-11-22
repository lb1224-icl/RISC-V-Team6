module sign_extend #(
    parameter WIDTH = 32
)(
    input  logic [1:0]       imm_src, // type of instruction
    input  logic [WIDTH-1:0] ins,     // entire instruction word
    output logic [WIDTH-1:0] imm_op   // output sign extended imm
);

always_comb begin
    case (imm_src) // R-type ==> don't care as this instruction doesn't use immediates
        2'b00: begin    if (ins[31]) // I-type
                            imm_op = {{WIDTH-12{1'b1}}, ins[31:20]};
                        else 
                            imm_op = {{WIDTH-12{1'b0}}, ins[31:20]};
        end
        2'b01: begin    if (ins[31]) // S-type
                            imm_op = {{WIDTH-12{1'b1}}, ins[31:25], ins[11:7]};
                        else 
                            imm_op = {{WIDTH-12{1'b0}}, ins[31:25], ins[11:7]};
        end
        2'b10: begin    if (ins[31]) // B-type
                            imm_op = {{WIDTH-13{1'b1}}, ins[31], ins[7], ins[30:25], ins[11:8], 1'b0};
                        else 
                            imm_op = {{WIDTH-13{1'b0}}, ins[31], ins[7], ins[30:25], ins[11:8], 1'b0};
        end
        default: begin  if (ins[31])   
                            imm_op = {{WIDTH-12{1'b1}}, ins[31:20]};
                        else 
                           imm_op = {{WIDTH-12{1'b0}}, ins[31:20]};
        end
    endcase
end

endmodule
