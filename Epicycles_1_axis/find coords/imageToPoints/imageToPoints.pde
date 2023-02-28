int res = 5;
int cx = 0;
PImage image;
ArrayList<PVector> points;

void setup(){
  image = loadImage("image-cropped.png");
  size(1, 1);//temp size
  surface.setResizable(true);
  surface.setSize(res*image.width,res*image.height);
  noStroke();
  points = new ArrayList<PVector>();
  
}

void keyPressed(){
  if(key=='d'){
    cx += 10;
  }
  if(key=='a'){
    cx -= 10;
  }
  
  if(key==' '){
    println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    for(PVector p : points){
      println(p.x, p.y);
    }
  }
  
  if(key=='z'){
    points.remove(points.size()-1); 
  }

}

void mouseClicked(){
  int x = (mouseX)/res;
  int y = (mouseY)/res;
  //println(mouseX,mouseY);
  println(x+148,y+200); //apply offset from cropping image
  points.add(new PVector(x+148,y+200));
  image.loadPixels();
  image.pixels[(x-cx/res)+(y*image.width)] = color(255,0,0);
  image.updatePixels();
}

void draw(){
  background(0);
  for(int y=0; y<image.height; y++){
    for(int x=0; x<image.width; x++){
      color col = image.pixels[x+(y*image.width)];
      fill(col);
      rect(cx+(x*res),y*res,res,res);
    }
  }
}
