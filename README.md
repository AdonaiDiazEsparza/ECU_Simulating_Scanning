# SIMULATING AND SCANNING AN ECU COMPUTER WITH OBDII CODES
The purpose of this project is to watch how the PID codes work with an visual interface where you can change the values of the speed, rpm, temperature, and other sensor values that an ECU has.  The ECU is simulated with an arduino nano. It supports Arduino UNO. 

 <p align="center">
<img width="460" src="https://github.com/user-attachments/assets/d5c0374d-5059-4c7e-ba18-dfde2adc0c2a">
 </p>
 
The simulated ECU was taken from this [repository](https://github.com/sugiuraii/ECUSim?tab=readme-ov-file) made by sugiuraii. There explain how to set values of the ECU to simulate it values. For now the HMI can set the Speed and RPM Speed from a car. Hope this repository can work to your projects and to lear more about cars and CANBUS protocol.

## NECESSARY HARDWARE
- Arduino Uno or Nano
- MCP2515 Module

## NECESSARY SOFTWARE
- Processing
- Arduino IDE

## NECESARY LIBRARIES TO INSTALL ON ARDUINO IDE
- The [ISO-TP](https://github.com/altelch/iso-tp) library from altelch (it is necesary to download and install manually because it doesnt appear in the library manager in Arduino IDE).
- The [MCP2515](https://github.com/coryjfowler/MCP_CAN_lib) library is usefull to send and receive CAN messages with the MCP2515 module.

## ABOUT THE APP ECU
First you have to flash your Arduino with the "ECUSim" program (ECUSim.ino). Then you have to open the app to connect with your Arduino. 

<p align="center">
<img src="https://github.com/user-attachments/assets/a51a7f65-13dd-4038-a23e-6604e32230a0">
</p>

The app is coded in processing, it connects with an Arduino via USBSerial but, to choose the USB port you only need to change a code from a line, look for:
```
 myPort = new Serial(this,"YourPort",115200);
```
and between the "" put the USB port to connect with the Arduino.
At the moment the App only can set the speed and rpm from the ECU, you can use the other program of "SEND_CAN.ino" to request the values with the PID's codes.

<p align="center">
<img src=https://github.com/user-attachments/assets/780c0a49-474e-46f3-8a2b-89bd86bf5c2f>
</p>

## ABOUT SCANNER APP
First you have to flash your arduino to get the values with the program in Arduino (Arduino_Sender_OBDII.ino).
<p align="center">
<img src=https://github.com/user-attachments/assets/35040609-d129-4ae8-b132-25017b3741fc>
</p>

At the moment the only parameters that show their value are speed and engine RPM. Only need to open the program from the "Scanner_App" folder with the name <b>Scanner_App.pde</b>. The same as the App ECU simulator, you need to change the port USB that is written in the line:
```
 myPort = new Serial(this,"YourPort",115200);
```
After you modify this line, you can run the program and you'll see a window like the next image, with the Start button you will begin the scanner and can watch the values of RPM and Speed(Km/s). With the Stop buttton you end the scan.
<p align="center">
<img src=https://github.com/user-attachments/assets/25b64f95-c8df-4da3-a1f1-92d1645eb769>
</p>

## NOTE:
- The SEND_CAN.ino program was tested with a real ECU computer to receive the values of the Engine rpm.
- The Scanner app is already tested with a real ECU, it works and it shows the engine rpm and the speed.

