import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
velocimetro vel = new velocimetro();
velocimetro tacometro = new velocimetro();
Serial myPort;

int valVelocimeter = 0;
int timer;
String dataVel = "";
String dataVelTaco = "";

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
  cp5.addTextfield("valueVelocimeter")
  .setPosition(215,450)
  .setSize(70,40)
  .setColor(255)
  .setFont(font)
  ;
  
  cp5.addButton("velMinus")
  .setPosition(150,455)
  .setSize(40,30)
  .setFont(font)
  .setCaptionLabel("-")
  ;
  
  cp5.addButton("velPlus")
  .setPosition(310,455)
  .setSize(40,30)
  .setFont(font)
  .setCaptionLabel("+")
  ;
  
  cp5.addSlider("rpmSlider")
  .setPosition(630,455)
  .setRange(0,7000)
  .setSize(150,30)
  .setFont(font)
  .setValue(1000)
  ;
  
  timer = millis();
  
}

void draw(){
  background(255,255,255);
  textSize(32);
  fill(0);
  text("SPEED:",200,50);
  vel.show();
  text("RPM:",680,50);
  tacometro.show();
  updateValue();
  // sendingToArduino();
}
void updateValue(){
  if(valVelocimeter == 0){
    valVelocimeter = 0;
    vel.valor = 0;
  }else if(valVelocimeter>255){
    valVelocimeter = 255;
    vel.valor = 255;
  }
  else{
    vel.valor = valVelocimeter+1;
  }
}

public void sendingToArduino(){
  if((vel.getValue()!=valVelocimeter) && ((millis()-timer)>500)){
    dataVel = "0D"+hex(vel.getValue(),2)+"000000\n";
    myPort.write(dataVel);
    println(dataVel);
    timer = millis();
  }
}

public void velMinus(){
  valVelocimeter--;
  cp5.getController("valueVelocimeter").setCaptionLabel(str(valVelocimeter));
}

public void velPlus(){
  valVelocimeter++;
  cp5.getController("valueVelocimeter").setCaptionLabel(str(valVelocimeter));
}

public void valueVelocimeter(String text){
  valVelocimeter = Integer.parseInt(text);
}

public void rpmSlider(int rpm){
  tacometro.valor(rpm);
}
