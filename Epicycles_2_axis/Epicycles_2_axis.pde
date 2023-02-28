float theta = 0;
float dt;
ArrayList<PVector> path;
FloatList X;
FloatList Y;
ArrayList<Complex> fourierX;
ArrayList<Complex> fourierY;

Boolean sort = false; //if true sort by amplitude
                     //if false sort by frequency
Boolean loop = true;

String source = "DRAW";
String mode;
ArrayList<PVector> drawing;

void setup(){
  size(800,800);
  drawing = new ArrayList<PVector>();
  //if (source == "DRAW"){
  //  mode = "USER";
  //}
  
  
  path = new ArrayList<PVector>();
  fourierX = new ArrayList<Complex>();
  fourierY = new ArrayList<Complex>();
  X = new FloatList();
  Y = new FloatList();
  
}

void mousePressed(){
  mode = "USER";
  drawing = new ArrayList<PVector>();
  X = new FloatList();
  Y = new FloatList();
  theta = 0;
  path = new ArrayList<PVector>();
}

void mouseReleased(){
  mode = "FOURIER";
  
  for(PVector p : drawing){
    X.append(p.x);
    Y.append(p.y);
  }
  
  fourierX = FourierTransform(X);
  fourierY = FourierTransform(Y);
    

  
  dt = TWO_PI / fourierY.size();
}

void draw(){
  background(0);
  
  if(mode == "USER"){
    PVector point = new PVector(mouseX-width/2,mouseY-height/2);
    drawing.add(point);
    
    beginShape();
    noFill();
    stroke(255);
    for(PVector p : drawing){
      vertex(p.x+width/2,p.y+height/2);
    }
    endShape();
    
  }else if (mode == "FOURIER"){
    
    PVector endpointX = drawEpicycles(width/2,100,0,fourierX);
    PVector endpointY = drawEpicycles(100,height/2,HALF_PI,fourierY);
    PVector point = new PVector(endpointX.x,endpointY.y);
  
    path.add(point);
    
    stroke(255,100);
    //line(endpointX.x,endpointX.y,point.x,point.y);
    //line(endpointY.x,endpointY.y,point.x,point.y);
    line(endpointX.x, 0, point.x, height);
    line(0, endpointY.y, width, point.y);
  
    stroke(255);
    beginShape();
    noFill();
    for(int j=0; j<path.size(); j++){
      vertex(path.get(j).x,path.get(j).y); 
    }
    endShape();
    
    theta += dt;
    if (theta > TWO_PI){
       if(loop==false){
         noLoop();
       }else{
         theta = 0;
         path = new ArrayList();
       }
    }
  }
}


PVector drawEpicycles(float x, float y, float angleoffset, ArrayList<Complex> fourier){
  for(int i=0; i<fourier.size(); i++){
    float prevx = x;
    float prevy = y;
    
    int freq = fourier.get(i).freq;
    float radius = fourier.get(i).amp;
    float phase = fourier.get(i).phase;
    
    x += radius * cos(freq * theta + phase + angleoffset);
    y += radius * sin(freq * theta + phase + angleoffset);
    
    
    
    stroke(255,100);
    noFill();
    circle(prevx,prevy, radius*2);
    stroke(255);
    line(prevx,prevy,x,y);
  }
  return new PVector(x,y);
}


ArrayList<Complex> FourierTransform(FloatList vals){
  int N = vals.size();
  ArrayList<Complex> fourier = new ArrayList<Complex>();
  
  for(int k=0; k<N; k++){
    float re = 0;
    float im= 0;
    
    for(int n=0; n<N; n++){
      float phi = (TWO_PI*k*n)/N;
      re += vals.get(n) *cos(phi);
      im -= vals.get(n) *sin(phi);
    }    
    
    re = re/N;
    im = im/N;
    float amp = sqrt(re*re+im*im);
    int freq = k;
    float phase = atan2(im,re);
    
    Complex c = new Complex(re,im,amp,freq,phase);
    fourier.add(c); 
  }
  
  
  return fourier;
}



////equivilant of p5js unshift
//ArrayList<PVector> appendStart(ArrayList<PVector> array, PVector item){
//  if(array.size() == 0){
//    array.add(item); 
//  }else{
//    for(int i=array.size(); i>0; i--){
//      array.set(i,array.get(i-1));
//      //set index to value before it
//    }//has effect of shifting everything to the right one
//    array.set(0,item);
    
//  }
//  return array;
//}
