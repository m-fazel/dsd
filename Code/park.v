module park (
    input car_entered,
    input is_uni_car_entered,
    input car_exited,
    input is_uni_car_exited,
    input [4:0] hour,
    output reg signed [9:0] uni_parked_car = 0,
    output reg signed [9:0] parked_car = 0,
    output signed [9:0] uni_vacated_space,
    output signed [9:0] vacated_space,
    output uni_is_vacated_space,
    output is_vacated_space,
    output parking_is_vacated_space
);

reg signed [9:0] free_space = 0;
wire signed [9:0] uni_free_space;

assign uni_vacated_space = uni_free_space - uni_parked_car;
assign vacated_space = free_space - parked_car;

assign uni_free_space = 700 - free_space;

assign uni_is_vacated_space = uni_vacated_space > 0;
assign is_vacated_space = vacated_space > 0;
assign parking_is_vacated_space = uni_vacated_space + vacated_space > 0;

always @(hour) begin
    if (hour >= 8 && hour < 13)
        free_space = 200;
    else if (hour >= 13 && hour < 16) 
        free_space = 200 + (hour - 12) * 50;
    else
        free_space = 500;
end

always @(posedge car_entered, posedge car_exited) begin
    if (car_entered) begin
        if (is_uni_car_entered)
        begin
            if (uni_is_vacated_space)
                uni_parked_car <= uni_parked_car + 1;
        end
        else
        begin
            if (is_vacated_space)
                parked_car <= parked_car + 1;
        end
    end

    else if (car_exited) begin
        if (is_uni_car_exited)
        begin
            if (uni_parked_car > 0)
                uni_parked_car <= uni_parked_car - 1;
        end
        else
        begin
            if (parked_car > 0)
                parked_car <= parked_car - 1;
        end
    end
end
endmodule