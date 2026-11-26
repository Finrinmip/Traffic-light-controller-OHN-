# Traffic-light-controller-OHN-Testbench and Simulation
OHN Assignment

The testbench (`traffic_light_tb.v`) is used to verify the functionality of the digital traffic light controller.
It generates the required clock and reset signals and monitors the outputs of the controller during simulation.
The testbench verifies the following: Initialization of the traffic light controller, execution of the four traffic light states in their various orders, timing of Green and Yellow signals, Proper transition between the traffic light states, Continuous repetition of the traffic light sequence and Prevention of simultaneous Green signals on both roads.
A reduced clock frequency parameter is used during simulation to minimize simulation time while preserving the required timing relationship between the traffic light states.
The simulation results are examined using waveform visualization and PASS/FAIL messages.
