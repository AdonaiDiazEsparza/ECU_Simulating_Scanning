# SIMULATING AND DIAGNOSTIC AN ECU COMPUTER WITH OBDII CODES
The purpose of this project is to watch how the PID codes work with an visual interface where you can change the values of the speed, rpm, temperature, and other sensor values that an ECU has.  The ECU is simulated with an arduino nano. It supports Arduino UNO. 

 <p align="center">
<img width="460" src="https://github.com/user-attachments/assets/d5c0374d-5059-4c7e-ba18-dfde2adc0c2a">
 </p>
 
The simulated ECU was taken from this [repository](https://github.com/sugiuraii/ECUSim?tab=readme-ov-file) made by sugiuraii. There explain how to set values of the ECU to simulate it values. For now the HMI can set the Speed and RPM Speed from a car. Hope this repository can work to your projects and to lear more about cars and CANBUS protocol.

## NECESARY LIBRARIES TO INSTALL ON ARDUINO IDE
- The [ISO-TP](https://github.com/altelch/iso-tp) library from altelch (it is necesary to download and install manually because it doesnt appear in the library manager in Arduino IDE).
- The [MCP2515](https://github.com/coryjfowler/MCP_CAN_lib) library is usefull to send and receive CAN messages with the MCP2515 module.
