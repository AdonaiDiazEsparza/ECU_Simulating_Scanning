class velocimetro
{
  float posx,posy,diam,size,valor,valor2,dv;
  int r,g,b,rt,gt,bt,min,max,paso;
  public velocimetro()
  {
    posx=250;
    posy=250;
    diam=100;
    size=1;
    valor=0;
    valor2=50;
    r=255;
    g=0;
    b=0;
    rt=255;
    gt=255;
    bt=255;
    min=0;
    max=180;
    paso=10;
    
  }
  public void setPosicion(float x,float y)
{
  posx=x;
  posy=y;  
}
public void setSize(float size)
{
  this.size=size;
  diam=diam*size;
}
public void setMinMax(int min,int max)
{
  this.min=min;
  this.max=max;
}
public void setPaso(int paso)
{
  this.paso=paso;
}
public void setColor( int r,int g, int b)
{
  this.r=r;
  this.g=g;
  this.b=b;
  
}
public void setColorText( int r,int g, int b)
{
  this.rt=r;
  this.gt=g;
  this.bt=b;
  
}
public void valor(float v)
{
  valor=v;
}

public int getValue(){
  return int(valor2);
}
public void show()
{
  dv=valor-valor2;
  valor2+=dv*0.01;
  pushStyle();
  pushMatrix();
  translate(posx,posy);
  noFill();
  stroke(r,g,b,120);
  strokeWeight(diam*0.03);
  arc(0,0,diam,diam,radians(135),radians(405));
  stroke(r,g,b);
  ellipse(0,0,diam*1.5,diam*1.5);
  fill(rt,gt,bt);
  textSize(diam*0.1);
  text(str(int(valor2)),-textWidth(str(int(valor2)))/2,diam*0.35);
  text("Kms/Hs",-textWidth("Kms/Hs")/2,diam/2);
  noFill();
  strokeWeight(diam*0.01);
  stroke(r,g,b);
  rect(-textWidth("Kms/Hs")*1.1/2,diam/2-textAscent(),textWidth("Kms/Hs")*1.1,textAscent()*1.2);
  fill(rt,gt,bt);
  for(int i=min;i<=max;i+=paso)
  {
    text(str(i),0.62*diam*cos(map(i,min,max,radians(135),radians(405)))-textWidth(str(i))/2,0.62*diam*sin(map(i,min,max,radians(135),radians(405)))+textAscent()/2);
  }
  rotate(map(valor2,min,max,radians(225),radians(495)));
  fill(r-30,g-30,b-30);
  triangle(-diam*0.07,0,0,-diam*0.45,diam*0.07,0);
  popMatrix();
  stroke(r-80,g-80,b-80);
  strokeWeight(diam*0.03);
  fill(r-70,g-70,b-70);
  ellipse(posx,posy,diam*0.2,diam*0.2);
  popStyle();
}  
}
