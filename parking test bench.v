module Parking_test_bench();
    reg clk;
    wire [10:0] upc, pc, uvs, vs;
    wire uivs, ivs;
    reg ci, uci, ce, uce;
    reg i;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    Parking parking(ci, uci, ce, uce, clk, upc, pc, uvs, vs, uivs, ivs);

    initial begin
        ci = 0;
        uci = 0;
        ce = 0;
        uce = 0;
        #280 ci = 1;
        #60 uci = 1;
        #40 ci = 0; uci = 0; ce = 1; uce = 1;
        #30 ci = 1; uci = 1; ce = 0; uce = 0;
        #160 $finish();
    end

    initial begin
        $monitor("%4.t: ci = %b | uci = %b | ce = %b | uce = %b --> upc = %d | pc = %d | uivs = %b | ivs = %b uvs = %d | vs = %d",
        $time, ci, uci, ce, uce, upc, pc, uivs, ivs, uvs, vs,);
    end
endmodule