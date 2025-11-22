module alu #(
    parameter D_WIDTH = 32
) (
    input  logic [D_WIDTH-1:0] aluop1,
    input  logic [D_WIDTH-1:0] aluop2,
    input  logic [2:0]         aluctrl,
    output logic [D_WIDTH-1:0] aluout,
    output logic               eq
);

always_comb begin
    case (aluctrl)
        0: begin
            aluout = aluop1 + aluop2;
            eq = 1'b0;
        end
        1: begin
            aluout = aluop1 - aluop2;
            eq = aluout == 32'b0;
        end
        default: begin
            aluout = 32'b0;
            eq = 1'b0;
        end
    endcase
end

endmodule
