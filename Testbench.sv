`timescale 1ns/1ps
module traffic_light_tb;

    //Declaring testbench signals
    reg clk;
    reg reset;

    wire a_green, a_yellow, a_red;
    wire b_green, b_yellow, b_red;

    //Connect the traffic light controller
    //CLK_FREQ = 10 for faster simulation

  traffic_light #(10) dut (.clk(clk), .reset(reset),

        .a_green(a_green),
        .a_yellow(a_yellow),
        .a_red(a_red),

        .b_green(b_green),
        .b_yellow(b_yellow),
        .b_red(b_red)
    );

    //Generating clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
	
  	//Display waveform after running
   initial begin
    $dumpfile("traffic_light.vcd");
    $dumpvars(0, traffic_light_tb);
	end
  
    //Display output changes
    initial begin
        $monitor("Time=%0t | A: %b%b%b | B: %b%b%b",
                 $time,
                 a_red, a_yellow, a_green,
                 b_red, b_yellow, b_green);
    end

    // Check that both roads are never Green together
    always @(posedge clk) begin
        #1;
        if (a_green && b_green) begin
            $display("ERROR: Both roads are Green!");
            $finish;
        end
    end

    // Apply reset and test the sequence
    initial begin

        reset = 1;

        // Hold reset through two rising clock edges
        repeat (2) @(posedge clk);
        #1 reset = 0;

        // S1: Road A Green, Road B Red
        if (a_green && b_red)
            $display("PASS: S1 - Road A Green");
        else begin
            $display("FAIL: S1");
            $finish;
        end

        // Wait 100 clock cycles
        repeat (100) @(posedge clk);
        #1;

        // S2: Road A Yellow, Road B Red
        if (a_yellow && b_red)
            $display("PASS: S2 - Road A Yellow");
        else begin
            $display("FAIL: S2");
            $finish;
        end

        // Wait 30 clock cycles
        repeat (30) @(posedge clk);
        #1;

        // S3: Road A Red, Road B Green
        if (a_red && b_green)
            $display("PASS: S3 - Road B Green");
        else begin
            $display("FAIL: S3");
            $finish;
        end

        // Wait 100 clock cycles
        repeat (100) @(posedge clk);
        #1;

        // S4: Road A Red, Road B Yellow
        if (a_red && b_yellow)
            $display("PASS: S4 - Road B Yellow");
        else begin
            $display("FAIL: S4");
            $finish;
        end

        // Wait 30 clock cycles
        repeat (30) @(posedge clk);
        #1;

        // Check that the sequence repeats
        if (a_green && b_red)
            $display("PASS: Sequence repeated - Back to S1");
        else begin
            $display("FAIL: Sequence did not repeat");
            $finish;
        end

        $display("ALL TESTS COMPLETED.");
        $finish;

    end

endmodule
