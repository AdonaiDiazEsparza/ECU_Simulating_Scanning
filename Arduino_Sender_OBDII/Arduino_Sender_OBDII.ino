/*
 * This program works to send information to the processing project to get the values from the 
 * PID's codes from OBDII in the cars
 * 
*/

#include <mcp_can.h>
#include <SPI.h>

#define CAN0_INT 2                              // Set INT to pin 2
MCP_CAN CAN0(10);                               // Set CS to pin 10

long unsigned int rxId;
unsigned char len = 0;
unsigned char rxBuf[8];

unsigned long txId = 0x7DF;
unsigned char txlen = 8;
unsigned char txBuffs[2][8]={
  {0x02, 0x01, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00},
  {0x02, 0x01, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00},
  };

unsigned char rpmA;
unsigned char rpmB;
unsigned char velA;

bool diagnostic = false;
String start;

void setup() {
  
Serial.begin(115200);
  pinMode(3,INPUT_PULLUP);
  pinMode(2,INPUT);

  while(CAN0.begin(MCP_ANY, CAN_500KBPS, MCP_8MHZ) != CAN_OK){
    Serial.println("Error Initializing MCP2515...");
  }
  Serial.println("MCP2515 Initialize");
  CAN0.setMode(MCP_NORMAL);  

}

void loop() {
  if(Serial.available()>0){
    start = Serial.readString();
    if(start == "1") diagnostic = true;
    else diagnostic = false;
  }

  if(diagnostic){
    for(int i = 0; i<2;i++){
      CAN0.sendMsgBuf(txId,txlen, txBuffs[i]);
      delay(1);
      
      if(!digitalRead(2)){
        CAN0.readMsgBuf(&rxId,&len,rxBuf);
        if(rxId == 0x7E8){
          
          // For the RPM
          if(rxBuf[2] == 0x0C){
           rpmA = rxBuf[3];
           rpmB = rxBuf[4];
          }
          
          // For the velocity 
          if(rxBuf[2] == 0x0D){
            velA = rxBuf[3];
          }
          
        }
      }
      
      delay(1);
    }

    
  }
}
