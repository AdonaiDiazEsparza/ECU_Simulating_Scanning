/*
 *  This program works to prove the ECU simulator if I can get the codes
 *  The porpuse of this code is to learn and prove the ECU simulator works to get the PID's codes so here we go
 * 
*/

#include <mcp_can.h>
#include <SPI.h>

unsigned long txId = 0x7DF;
unsigned char txlen = 8;
unsigned char txBuf[8] = {0x02, 0x01, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00};  // For the moment it will request for RPM if you want to ask for other PID code chage the 
                                                                            // 1rst byte for the quantity of bytes, 2nd the mode, 3rd the PID code.

long unsigned int rxId;
unsigned char len = 0;
unsigned char rxBuf[8];  

unsigned long tiempo = 0;

#define CAN0_INT 2                              // Set INT to pin 2
MCP_CAN CAN0(10);                               // Set CS to pin 10

void setup() {
  Serial.begin(115200);
  pinMode(3,INPUT_PULLUP);
  pinMode(2,INPUT);

  while(CAN0.begin(MCP_ANY, CAN_500KBPS, MCP_8MHZ) != CAN_OK){
    Serial.println("Error Initializing MCP2515...");
  }
  Serial.println("MCP2515 Initialize");
  CAN0.setMode(MCP_NORMAL);  

  tiempo = millis();
}

void loop() {
      if(!digitalRead(3)){
        CAN0.sendMsgBuf(txId,txlen, txBuf);
        /*if(CAN0.sendMsgBuf(txId,txlen, txBuf) == CAN_OK){
          Serial.println("Message sent okay");
        }
        else{
          Serial.println("Message sent wrong");
        }*/
        delay(10);
      }
   

  if(!digitalRead(2)){
    CAN0.readMsgBuf(&rxId,&len,rxBuf);
    if(rxId == 0x7E8){

      long rpmA = 64*rxBuf[3];
      long rpmB = rxBuf[4]/4;

      long rpm = rpmA+rpmB;

      long muestreo = millis()-tiempo;

      Serial.println("RPM SPEED: "+String(rpm)+"rpm  | "+String(muestreo)+" ms");

      tiempo = millis();
      
      delay(5);
    }
   }
}
   
