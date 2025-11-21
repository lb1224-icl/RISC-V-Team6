module pc_unit #(
    parameter WIDTH = 32
) (
    input  logic                 clk,
    input  logic                 rst,
    input  logic                 pc_src,
    input  logic [WIDTH-1:0]     pc_in,
    input  logic [WIDTH-1:0]     immop,
    output logic [WIDTH-1:0]     PC
);

localparam int INCREMENT = 4;

logic [WIDTH-1:0] next_PC;

assign next_PC = pc_src ? (pc_in + immop) : (pc_in + INCREMENT);

always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        PC <= '0;
    end
    else begin
        PC <= next_PC;
    end
end

endmodule
