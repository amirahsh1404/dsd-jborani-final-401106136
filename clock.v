module ClockCounter #(parameter n = 5) (input clk, output reg hour);
    integer i;
    
    initial begin
        hour = 0;
        i = 0;
    end

    always @(posedge clk) begin
        i = i + 1;
        if (i % n == 0)
            hour = 1;
        else
            hour = 0;
    end
endmodule
