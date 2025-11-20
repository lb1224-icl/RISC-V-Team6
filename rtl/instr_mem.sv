module instr_mem #(
    parameter  ADDRESS_WIDTH = 16,
               DATA_WIDTH = 32
)(
    input logic  [ADDRESS_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0]    dout
);

logic [DATA_WIDTH-1:0]  mem_array [2**ADDRESS_WIDTH-1:0];

initial begin
    $display("Loading Instruction Memory.");
    $readmemh("instr.mem", mem_array);
end;

always_ff @(posedge addr)

    dout <= mem_array [addr];

endmodule
