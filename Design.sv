//Design
module traffic_light #(parameter CLK_FREQ = 50000000)(
  input clk,
  input reset,
  output reg a_green, a_yellow, a_red,
  output reg b_green, b_yellow, b_red
);
  
  localparam S1 = 2'd0, S2 = 2'd1, S3 = 2'd2, S4 = 2'd3;
  //TICKS = SECONDS * CLK_FREG
  localparam LONG = 10 * CLK_FREQ;
  localparam SHORT = 3 * CLK_FREQ;
  
  reg [1:0]state;
  reg [31:0]count;//500million needs 29bits, so 32bits is enough
  reg [31:0]limit;
  
  always @(*) begin
    case(state)
      S1, S3: limit = LONG;
      default: limit = SHORT;
    endcase
  end
  
  always @(posedge clk) begin
    if (reset) begin
      state <= S1;
      count <= 0;
    end else if (count == limit-1) begin//when the limit is reached
      count <= 0;
      state <= state + 1;
    end else begin
      count <= count + 1;
    end
  end
    
  always @(*) begin
    a_green = 0; a_yellow = 0; a_red = 0;
    b_green = 0; b_yellow = 0; b_red = 0;
    case(state)
      S1 : begin a_green = 1; b_red = 1; end
      S2 : begin a_yellow = 1; b_red = 1; end
      S3 : begin a_red = 1; b_green = 1; end
      S4 : begin a_red = 1; b_yellow = 1; end
    endcase
  end
endmodule

  
  
  
  
  
  
  
  
