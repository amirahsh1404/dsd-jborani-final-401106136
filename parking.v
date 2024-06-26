module Parking (
   input car_entered, is_uni_car_entered, car_exited, is_uni_car_exited, clk,
    output reg [10:0] uni_parked_car,
    output reg [10:0] parked_car,
    output reg [10:0] uni_vacated_space,
    output reg [10:0] vacated_space,
    output reg uni_is_vacated_space,
    output reg is_vacated_space);

    reg [10:0] uni_capacity;
    reg [10:0] capacity;
    wire hour;
    integer i;
    reg [10:0] changed_capacity;

    initial begin
        i = 8;
        uni_capacity = 500;
        capacity = 200;
        uni_parked_car = 0;
        parked_car = 0;
        uni_vacated_space = 500;
        vacated_space = 200;
    end

   //localparam n = 5;
    //reg hour_reg;
    //integer hour_counter;
//
    //initial begin
    //    hour_reg = 0;
    //    hour_counter = 0;
    //end
    //always @(posedge clk) begin
    //    hour_counter = hour_counter + 1;
    //    if (hour_counter % n == 0)
    //        hour_reg = 1;
    //    else
    //        hour_reg = 0;
    //end
    //assign hour = hour_reg;

    ClockCounter #(5) clock_counter(clk, hour);
    always @(posedge hour or posedge clk) begin
        if (hour) begin
			   i = i+1;
				if (i%24 == 14 || i%24== 15) begin
					changed_capacity= (uni_vacated_space<50) ? uni_vacated_space : 50;
					uni_capacity=uni_capacity-changed_capacity;
					uni_vacated_space = uni_vacated_space-changed_capacity;
					capacity = capacity+changed_capacity;
					vacated_space = vacated_space+changed_capacity;
				end else if (i%24 == 16) begin
					uni_capacity = (uni_parked_car>200) ? uni_parked_car : 200;
					capacity = 700-uni_capacity;
					vacated_space = capacity-parked_car;
					uni_vacated_space = uni_capacity-uni_parked_car;
				end
		  end else if (clk) begin
				uni_is_vacated_space =(uni_vacated_space != 0) ? 1 : 0;
				is_vacated_space = (vacated_space != 0) ? 1 : 0;

				if (car_entered && is_uni_car_entered && uni_is_vacated_space) begin
					uni_parked_car= uni_parked_car+1;
					uni_vacated_space = uni_vacated_space-1;
				end else if (car_entered && !is_uni_car_entered && is_vacated_space) begin
					parked_car = parked_car+1;
					vacated_space = vacated_space-1;
				end else if (car_exited && is_uni_car_exited && uni_vacated_space > 0) begin
					uni_parked_car = uni_parked_car-1;
					uni_vacated_space = uni_vacated_space+ 1;
				end else if (car_exited && !is_uni_car_exited && vacated_space > 0) begin
					parked_car = parked_car -1;
					vacated_space = vacated_space +1;
				end
		  end
    end
endmodule