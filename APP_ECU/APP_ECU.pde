import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
velocimetro vel = new velocimetro("Km/h");
velocimetro tacometro = new velocimetro("RPM");
Serial myPort;

int valVelocimeter = 0;
int valueRPM = 0;

int velocidad;
int rpmValue;

String dataVel = "";
String dataRpm = "";

int timer;
int timer2;

void setup(){
  
  // myPort = new Serial(this,"/dev/ttyUSB0",115200);
  
  cp5 = new ControlP5(this);
  PFont pfont = createFont("Consolas",18,true);
  ControlFont font = new ControlFont(pfont,22);
  
  
  size(950,500);
  
  // Velocimeter 
  vel.setSize(2);
  vel.setPaso(25);
  vel.setMinMax(0,255);
  vel.setColorText(0,0,0);
  
  // Tacometer
  tacometro.setPosicion(700,250);
  tacometro.setSize(2);
  tacometro.setPaso(1000);
  tacometro.setMinMax(0,7000);
  tacometro.setColorText(0,0,0);
  
  //  This give the value in the velocimeter
  cp5.addSlider("velSlider")
  .setCaptionLabel("")
  .setPosition(170,455)
  .setRange(0,255)
  .setSize(150,30)
  .setFont(font)
  .setValue(10)
  ;
  
  cp5.addButton("velMinus")
  .setPosition(110,455)
  .setSize(40,30)
  .setFont(font)
  .setCaptionLabel("-")
  ;
  
  cp5.addButton("velPlus")
  .setPosition(340,455)
  .setSize(40,30)
  .setFont(font)
  .setCaptionLabel("+")
  ;
  
  
  // For the tacometer
  cp5.addSlider("rpmSlider")
  .setCaptionLabel("")
  .setPosition(630,455)
  .setRange(0,7000)
  .setSize(150,30)
  .setFont(font)
  .setValue(1000)
  ;
  
  cp5.addButton("rpmMinus")
  .setPosition(570,455)
  .setSize(40,30)
  .setFont(font)
  .setCaptionLabel("-")
  ;
  
  cp5.addButton("rpmPlus")
  .setPosition(800,455)
  .setSize(40,30)
  .setFont(font)
  .setCaptionLabel("+")
  ;
  
  timer = millis();
  timer2 =millis();
  
}

void draw(){
  background(255,255,255);
  textSize(32);
  fill(0);
  text("SPEED:",200,50);
  vel.show();
  text("RPM:",680,50);
  tacometro.show();
  sendingToArduino();
}

public void sendingToArduino(){
  // This is for velocimeter
  if((vel.valorEntero!=velocidad) && ((millis()-timer)>100)){
    dataVel = "0D"+hex(vel.valorEntero,2)+"000000\n";
    // myPort.write(dataVel);  
    //println(dataVel);
    timer = millis();
    velocidad = vel.valorEntero;
  }
  
  if((tacometro.valorEntero!=rpmValue)&&((millis()-timer2)>100)){
    int A = valueA(tacometro.valorEntero);
    int B = valueB(A,tacometro.valorEntero);
    dataRpm = "0C"+hex(A,2)+hex(B,2)+"0000";
    println(dataRpm);
    timer2 = millis();
    rpmValue = tacometro.valorEntero;
  }
}

public void velSlider(int valueVel){
  vel.valor = valueVel;
}

public void velMinus(){
  vel.valor--;
  cp5.getController("velSlider").setValue(vel.valor);
}

public void velPlus(){
  vel.valor++;
  cp5.getController("velSlider").setValue(vel.valor);
}


// This is used for the rpm 
public void rpmSlider(int rpm){
  tacometro.valor = rpm;
}

public void rpmMinus(){
  tacometro.valor--;
  cp5.getController("rpmSlider").setValue(tacometro.valor);
}

public void rpmPlus(){
  tacometro.valor = tacometro.valor+1;
  cp5.getController("rpmSlider").setValue(tacometro.valor);
}

public int valueA(int rpm){
  return rpm/64;
}

public int valueB(int valA, int rpm){
  int valB = 4*rpm - 256*valA;
  return valB;
}
