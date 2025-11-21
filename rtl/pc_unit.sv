module pc_unit #(
    parameter  WIDTH    = 32
) (
    input logic   rst,
    input logic   clk,
    input logic   pc_src,
    input logic   [WIDTH-1:0] pc_prev,
    input logic   [WIDTH-1:0] immop,
    output logic  [WIDTH-1:0] PC,

);

always_ff @(posedge clk, posedge rst) begin
    if(rst) begin 
        PC <= WIDTH'b0;
    end
    else begin
        PC <= pc_src ? pc_prev + immop : pc_prev + 3'b100;
    end
end


endmodule