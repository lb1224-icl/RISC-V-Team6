module alu #(
    parameter DATA_WIDTH 32
) (
    input logic [DATA_WIDTH-1:0] aluop1,
    input logic [DATA_WIDTH-1:0] aluop2,
    input logic [2:0] aluctrl,
    output logic [DATA_WIDTH-1:0] aluout,
    output logic eq
)

always_comb begin
    case (aluctrl)
        0: begin
            aluout <= aluop1 + aluop2;
            eq <= 1b'0;
        end
        1: begin
            aluout <= aluop1 - aluop2;
            eq <= aluout == 1b'0;
        end
        default: begin
            aluout <= 1b'0;
            eq <= 1b'0;
        end
    endcase
end

endmodule
