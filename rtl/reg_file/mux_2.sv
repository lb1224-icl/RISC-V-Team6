module mux_2 #(
    D_WIDTH = 32
)(
    input  logic [D_WIDTH-1:0] in0,
    input  logic [D_WIDTH-1:0] in1,
    input  logic               sel,
    output logic [D_WIDTH-1:0] out
);
    assign out = sel ? in1 : in0;

endmodule
