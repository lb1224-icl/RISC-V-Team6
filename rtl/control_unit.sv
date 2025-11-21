module control_unit #(
    WIDTH = 32
) (
    input logic  [WIDTH-1:0]  ins,
    input logic               EQ,        //?
    output logic              pc_src,    // pc branches or not
    output logic [2:0]        alu_ctrl,  // ALU operation: add, sub, OR
    output logic              alu_src,   // whether 2nd ALU input is a register data or immediate
    output logic [1:0]        imm_src,   // type of ins: R, I, S, B
    output logic              reg_write  // register write enable
);

logic [6:0]    opcode;
logic [2:0]    funct3;
    
assign opcode = ins[6:0];
assign funct3 = ins[14:12];

//--------     DECODER      --------//
// Only implementing two basic instructions addi and bne so logic can be very specific and not generalised.
always_comb
case (opcode)

    7'd19:  case (funct3) 
                0: begin    // addi ins
                    reg_write <= 1;  // storing the resut in register
                    imm_src <= 0;  
                    alu_src <= 1  // ALU uses immediate and not rs2
                    alu_ctrl <= 0 // addition of rs1 + imm
                    pc_src <= 0;
                end
    endcase
    
    7'd99:  case (funct3)
                1: begin    // bne ins
                    reg_write <= 0;
                    imm_src <= 2;  // type B ins
                    alu_src <= 0;  // the immediate will be fed into the PC and not used in the ALU
                    alu_ctrl <= 1; // we are doing a sub to find the difference between instruction addresses
                    pc_src <= EQ;   // pc increments to branch address
                end
    endcase
    
endcase

endmodule 
