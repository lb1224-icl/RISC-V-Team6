module ram2 #(
    parameter D_WIDTH = 32, ADDRESS_WIDTH = 5
)(
    input  logic                     clk,
    input  logic                     wr_en,
    input  logic [ADDRESS_WIDTH-1:0] wr_addr,
    input  logic [ADDRESS_WIDTH-1:0] rd1_addr,
    input  logic [ADDRESS_WIDTH-1:0] rd2_addr,
    input  logic [D_WIDTH-1:0]       din,
    output logic [D_WIDTH-1:0]       dout1,
    output logic [D_WIDTH-1:0]       dout2,
    output logic [D_WIDTH-1:0]       a0
);

logic [D_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

initial begin
    // Initialize register file to zero for deterministic simulation
    integer i;
    for (i = 0; i < (2**ADDRESS_WIDTH); i = i + 1) begin
        ram_array[i] = '0;
    end
end

always_ff @(posedge clk) begin
    // synchronous write only; reads are provided combinationally below
    // do not allow writes to x0 (address 0)
    if (wr_en == 1'b1 && wr_addr != {ADDRESS_WIDTH{1'b0}})
        begin
            ram_array[wr_addr] <= din;
        end
end

// combinational read ports so single-cycle logic can use register values
always_comb begin
    dout1 = ram_array[rd1_addr];
    dout2 = ram_array[rd2_addr];
    // a0 is register x10 in RISC-V convention
    a0    = ram_array[5'd10];
end
endmodule
