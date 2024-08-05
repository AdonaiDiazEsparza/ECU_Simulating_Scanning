import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
velocimetro vel = new velocimetro("Km/h");
velocimetro tacometro = new velocimetro("RPM");
Serial myPort;

String data;
String[] datas = new String[3];

int debug;

int start;
int velA;
int rpmA;
int rpmB;

void setup(){
  
  myPort = new Serial(this,"/dev/ttyUSB1",115200);
  
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
  
  
  // Start and Stop buttons
  cp5.addButton("startDiagnostic")
  .setPosition(325,455)
  .setSize(100,30)
  .setFont(font)
  .setCaptionLabel("START")
  ;
  
  cp5.addButton("stopDiagnostic")
  .setPosition(525,455)
  .setSize(100,30)
  .setFont(font)
  .setCaptionLabel("STOP")
  ;
}

void draw(){
  background(255,255,255);
  textSize(32);
  fill(0);
  text("SPEED:",200,50);
  vel.show();
  text("RPM:",680,50);
  tacometro.show();
  
  if(start == 1){
    update();
  }
  else{
    vel.valor = 0;
    tacometro.valor = 0;
  }
}

public void startDiagnostic(){
  myPort.write("1");
  start = 1;
  
}

public void stopDiagnostic(){
  myPort.write("0");
  start = 0;
}

public void update(){
  if(myPort.available()>0){
    data = myPort.readString();
    datas = data.split(",");
  }
  
  velA = Integer.parseInt(datas[0]);
  rpmA = Integer.parseInt(datas[1]);
  rpmB = Integer.parseInt(datas[2]);
  
  vel.valor = velA;
  tacometro.valor = 64*rpmA + rpmB/4;
}


public int get_rpm(){
  return 0;
}
