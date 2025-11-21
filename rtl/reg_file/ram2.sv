module ram2 #(
    parameter   ADDRESS_WIDTH = 5,
                DATA_WIDTH = 8
)(
    input logic clk,
    input logic wr_en,
    input logic [ADDRESS_WIDTH-1:0] wr_addr,
    input logic [ADDRESS_WIDTH-1:0] rd1_addr,
    input logic [ADDRESS_WIDTH-1:0] rd2_addr,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout1,
    output logic [DATA_WIDTH-1:0] dout2,
    output logic a0
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    dout1 <= ram_array[rd1_addr];
    dout2 <= ram_array[rd2_addr];
    if (wr_en == 1'b1)
        ram_array[wr_addr] <= din;
    a0 <= ram_array[wr_addr];
end
endmodule
