module instr_mem #(
    parameter ADDRESS_WIDTH = 16
)(
    input  logic [31:0] addr,
    output logic [31:0] dout
);

logic [7:0] mem_array [2**ADDRESS_WIDTH-1:0];

initial begin
    $display("Loading Instruction Memory.");
    $readmemh("../rtl/program.hex", mem_array);
end;

always_comb begin
    // use low bits of PC as byte address into ROM
    logic [ADDRESS_WIDTH-1:0] byte_addr;
    byte_addr = addr[ADDRESS_WIDTH-1:0];

    // little-endian: lowest-address byte is least significant
    dout = {mem_array[byte_addr + 3],
                mem_array[byte_addr + 2],
                mem_array[byte_addr + 1],
                mem_array[byte_addr + 0]};
end

endmodule
