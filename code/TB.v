module TB;
    reg car_entered;
    reg is_uni_car_entered;
    reg car_exited;
    reg is_uni_car_exited;
    reg [4:0] hour;
    wire [9:0] uni_parked_car;
    wire [9:0] parked_car;
    wire [9:0] uni_vacated_space;
    wire [9:0] vacated_space;
    wire uni_is_vacated_space;
    wire is_vacated_space;
    wire parking_is_vacated_space;
    
    integer i;

    park park (
        .car_entered(car_entered),
        .is_uni_car_entered(is_uni_car_entered),
        .car_exited(car_exited),
        .hour(hour),
        .is_uni_car_exited(is_uni_car_exited),
        .uni_parked_car(uni_parked_car),
        .parked_car(parked_car),
        .uni_vacated_space(uni_vacated_space),
        .vacated_space(vacated_space),
        .uni_is_vacated_space(uni_is_vacated_space),
        .is_vacated_space(is_vacated_space),
        .parking_is_vacated_space(parking_is_vacated_space)
    );

    initial
        hour = 0;
    always begin
        #30
        if (hour >= 23)
            hour = 0;
        else
            hour = hour + 1;
    end

    initial begin
        car_entered <= 1;
        is_uni_car_entered <= 1;
        car_exited <= 1;
        is_uni_car_exited <= 1;

        for (i = 0; i < 300; i = i + 1) begin
        #1 car_entered <= !car_entered;
        end
        
        for (i = 0; i < 300; i = i + 1) begin
            #1 car_exited <= !car_exited;
        end
        #100

        is_uni_car_entered <= 0;
        is_uni_car_exited <= 0;

        for (i = 0; i < 300; i = i + 1) begin
        #1 car_entered <= !car_entered;
        end
        
        for (i = 0; i < 300; i = i + 1) begin
            #1 car_exited <= !car_exited;
        end

        #100 $stop();
    end

endmodule