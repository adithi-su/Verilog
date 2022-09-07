# Verilog
#### Required software tools:
1. <a href="https://bleyer.org/icarus/">Icarus verilog</a> - Verilog Compilation and Simulation
2. GTKWave - Wavefom Visualizer

#### Procedure to run and verify the code
Run the code below on command prompt/terminal - 
```
 iverilog -o muxtest.vvp muxtest.v
 vvp muxtest.vvp
 gtkwave 
```
Once the gtkwave window opens, go to File -> Open New tab -> add the .vcd file. Now select the required module/signals, and "Append" them to view the waveforms. 

