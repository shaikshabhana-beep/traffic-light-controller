```verilog
module traffic_light_controller (
    input  wire clk,
    input  wire reset,
    output reg red,
    output reg yellow,
    output reg green
);

    // State encoding
    parameter RED    = 2'b00;
    parameter GREEN  = 2'b01;
    parameter YELLOW = 2'b10;

    reg [1:0] state;
    reg [1:0] count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            count <= 0;
        end
        else begin
            case (state)

                RED: begin
                    if (count == 2) begin
                        state <= GREEN;
                        count <= 0;
                    end
                    else
                        count <= count + 1;
                end

                GREEN: begin
                    if (count == 3) begin
                        state <= YELLOW;
                        count <= 0;
                    end
                    else
                        count <= count + 1;
                end

                YELLOW: begin
                    if (count == 1) begin
                        state <= RED;
                        count <= 0;
                    end
                    else
                        count <= count + 1;
                end

                default: begin
                    state <= RED;
                    count <= 0;
                end

            endcase
        end
    end

    // Output logic
    always @(*) begin
        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;

        case (state)
            RED:    red    = 1'b1;
            GREEN:  green  = 1'b1;
            YELLOW: yellow = 1'b1;

            default: red = 1'b1;
        endcase
    end

endmodule
```
