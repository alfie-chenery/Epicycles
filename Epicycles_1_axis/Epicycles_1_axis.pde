float theta = 0;
float dt;
ArrayList<PVector> path;
ArrayList<Complex> Z;
ArrayList<Complex> fourierZ;
int lineNum = 0;

Boolean loop = false;

String source = "DRAW"; //DRAW or FILE

//---file input only---
boolean flip_y = false; //flip y axis of necessary
PVector offset = new PVector(-1250/2, -480/2);
int skip = 5; //only sample 1 point in every skip points from file (for speed)
//---------------------

String mode;
ArrayList<PVector> drawing;

void setup(){
  //frameRate(15);
  size(800,800);
  drawing = new ArrayList<PVector>();
  
  
  path = new ArrayList<PVector>();
  Z = new ArrayList<Complex>();
  fourierZ = new ArrayList<Complex>();
  
  if(source == "FILE"){
    BufferedReader file = createReader("input_points.txt");
    String line = null;
    try{
      while ((line = file.readLine()) != null) {
        if(lineNum % skip == 0){
          String[] pieces = split(line, ' ');
          int x = int(pieces[0]);
          int y = int(pieces[1]);
          y = (flip_y ? -y : y); //if flip_y, y = -y, else y = y
          Complex z = new Complex(x+offset.x,y+offset.y);
          Z.add(z);
        }
        lineNum++;
      }
      
    } catch (IOException e){
      e.printStackTrace(); 
    }
    
    fourierZ = FourierTransform(Z);
    dt = TWO_PI / fourierZ.size();
    mode = "FOURIER";
  }
}

void mousePressed(){
  if(source == "DRAW"){
    mode = "USER";
    drawing = new ArrayList<PVector>();
    Z = new ArrayList<Complex>();
    theta = 0;
    path = new ArrayList<PVector>();
  }
}

void mouseReleased(){
  if(source == "DRAW"){
    mode = "FOURIER";
  
    for(PVector p : drawing){
      Complex z = new Complex(p.x,p.y);
      Z.add(z);
    }
    
    fourierZ = FourierTransform(Z);
    
    dt = TWO_PI / fourierZ.size();
  }
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
    
    PVector endpoint = drawEpicycles(width/2,height/2,0,fourierZ);
    path.add(endpoint);

    //draw image so far
    stroke(255);
    beginShape();
    noFill();
    for(int j=0; j<path.size(); j++){
      vertex(path.get(j).x,path.get(j).y); 
    }
    endShape();
    
    theta += dt;
    if (theta > TWO_PI){
       if(!loop){
         
         background(0);
         //show just path
         stroke(255);
         beginShape();
         noFill();
         for(int j=0; j<path.size(); j++){
           vertex(path.get(j).x,path.get(j).y); 
         }
         endShape();
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
    
    stroke(255,25); //circle colour and alpha
    noFill();
    circle(prevx,prevy, radius*2);
    stroke(255,50); //radius line colour and alpha
    line(prevx,prevy,x,y);
  }
  return new PVector(x,y);
}


ArrayList<Complex> FourierTransform(ArrayList<Complex> vals){
  int N = vals.size();
  ArrayList<Complex> fourier = new ArrayList<Complex>();
  
  for(int k=0; k<N; k++){
    Complex sum = new Complex(0,0);
    
    for(int n=0; n<N; n++){
      float phi = (TWO_PI*k*n)/N;
      Complex c = new Complex(cos(phi),-sin(phi));
      Complex temp = vals.get(n);
      temp = MULT(c,temp);
      sum = ADD(sum,temp);
      
    }    
    
    sum = DIV(sum,N);

    sum.calculateCycle(k);
    fourier.add(sum); 
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
