import java.io.BufferedWriter;
import java.io.FileWriter;

PImage image;
ArrayList<PVector> points;
int i = 0;

void printf(float x, float y){
  String text = str(x) + " " + str(y);
  File f = new File(dataPath("output_points.txt"));
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

void setup(){
  image = loadImage(sketchPath("") + "../image3.png");
  size(1, 1);//temp size
  surface.setResizable(true);
  surface.setSize(image.width,image.height);
  strokeWeight(1);
  points = new ArrayList<PVector>();
  
 
  //----------------------------------------------
  stroke(0,255,0);
  
  //top edge - A
  for(int x=1; x<image.width - 1; x++){//skip edges (all black so doesnt matter)
    boolean found = false;
    for(int y=1; y<image.height - 1; y++){
      boolean thisedge = x<=648;
      color col = image.pixels[x+(y*image.width)];
      color colN = image.pixels[x+((y-1)*image.width)];
      color colE = image.pixels[(x+1)+(y*image.width)];
      color colS = image.pixels[x+((y+1)*image.width)];
      color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colN == color(0) || colE == color(0) || colS == color(0) || colW == color(0);
      if(thisedge && col != color(0) && edge && (!found || (x==648 && y<245))){ //if x=648 doesnt matter if found already true
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
        found = true;
      }
    }
  }

  //right edge A - x=648

//top half outer edge - C
  for(int x=1; x<image.width - 1; x++){//skip edges (all black so doesnt matter)
  boolean found = false;
    for(int y=image.height-2; y>=1; y--){
      boolean thisedge = x>648 && y<245;
      color col = image.pixels[x+(y*image.width)];
      color colN = image.pixels[x+((y-1)*image.width)];
      //color colE = image.pixels[(x+1)+(y*image.width)];
      //color colS = image.pixels[x+((y+1)*image.width)];
      color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colN == color(0) || colW == color(0);
      if(thisedge && col != color(0) && edge && (!found || x<675)){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
        found = true;
      }
    }
  }

  
//top half inner edge - C
  for(int x=image.width-2; x>=1; x--){//skip edges (all black so doesnt matter)
    for(int y=1; y<image.height-1; y++){
      boolean thisedge = x>660 && y<240;
      color col = image.pixels[x+(y*image.width)];
      //color colN = image.pixels[x+((y-1)*image.width)];
      color colE = image.pixels[(x+1)+(y*image.width)];
      color colS = image.pixels[x+((y+1)*image.width)];
      //color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colE == color(0) || colS == color(0);
      if(thisedge && col != color(0) && edge){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
      }
    }
  }  
  
  //bottom half inner edge - C
  for(int x=1; x<image.width-1; x++){//skip edges (all black so doesnt matter)
    for(int y=1; y<image.height-1; y++){
      boolean thisedge = x>660 && y>=240;
      color col = image.pixels[x+(y*image.width)];
      color colN = image.pixels[x+((y-1)*image.width)];
      color colE = image.pixels[(x+1)+(y*image.width)];
      //color colS = image.pixels[x+((y+1)*image.width)];
      //color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colN == color(0) || colE == color(0);
      if(thisedge && col != color(0) && edge){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
      }
    }
  }

  //bottom half outer edge - C
  for(int x=image.width-2; x>=1; x--){//skip edges (all black so doesnt matter)
    for(int y=image.height-2; y>=1; y--){
      boolean thisedge = x>648 && y>=240;
      color col = image.pixels[x+(y*image.width)];
      //color colN = image.pixels[x+((y-1)*image.width)];
      //color colE = image.pixels[(x+1)+(y*image.width)];
      color colS = image.pixels[x+((y+1)*image.width)];
      color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colS == color(0) || colW == color(0);
      if(thisedge && col != color(0) && edge){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
      }
    }
  }
  
  //bottom/right edge - A
  for(int x=image.width-2; x>=1; x--){//skip edges (all black so doesnt matter)
    boolean found = false;
    for(int y=1; y<image.height - 1; y++){
      boolean thisedge = x<=648 && x >= 630 && y>245;
      color col = image.pixels[x+(y*image.width)];
      color colN = image.pixels[x+((y-1)*image.width)];
      color colE = image.pixels[(x+1)+(y*image.width)];
      color colS = image.pixels[x+((y+1)*image.width)];
      color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colN == color(0) || colE == color(0) || colS == color(0) || colW == color(0);
      if(thisedge && col != color(0) && edge && (!found || (x==648 && y>245))){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
        found = true;
      }
    }
  }
  
  //bottom/left edge - A
  for(int x=image.width-2; x>=1; x--){//skip edges (all black so doesnt matter)
    boolean found = false;
    for(int y=image.height-2; y>=1; y--){
      boolean thisedge = x<630 && x>=520 && y>280;
      color col = image.pixels[x+(y*image.width)];
      //color colN = image.pixels[x+((y-1)*image.width)];
      //color colE = image.pixels[(x+1)+(y*image.width)];
      color colS = image.pixels[x+((y+1)*image.width)];
      color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colS == color(0) || colW == color(0);
      if(thisedge && col != color(0) && edge && (!found || x==619)){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
        found = true;
      }
    }
  }

  //left inner edge - A
  for(int x=1; x<image.width-1; x++){//skip edges (all black so doesnt matter)
    boolean found = false;
    for(int y=image.height-2; y>=1; y--){
      boolean thisedge = x>534 && x<630 && y<299 && y>100;
      color col = image.pixels[x+(y*image.width)];
      color colN = image.pixels[x+((y-1)*image.width)];
      //color colE = image.pixels[(x+1)+(y*image.width)];
      //color colS = image.pixels[x+((y+1)*image.width)];
      color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colN == color(0) || colW == color(0);
      if(thisedge && col != color(0) && edge && (!found || x==619)){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
        found = true;
      }
    }
  }
  
  //bottom edge - A
  for(int x=image.width-2; x>=1; x--){//skip edges (all black so doesnt matter)
    boolean found = false;
    for(int y=1; y<image.height-1; y++){
      boolean thisedge = x<619;
      color col = image.pixels[x+(y*image.width)];
      //color colN = image.pixels[x+((y-1)*image.width)];
      color colE = image.pixels[(x+1)+(y*image.width)];
      color colS = image.pixels[x+((y+1)*image.width)];
      //color colW = image.pixels[(x-1)+(y*image.width)];
      boolean edge = colE == color(0) || colS == color(0);
      if(thisedge && col != color(0) && edge && !found){
        point(x,y);
        points.add(new PVector(x,y));
        printf(x,y);
        found = true;
      }
    }
  }
  
  
  //display
  image.loadPixels();
  for(int x=0; x<image.width; x++){
    for(int y=0; y<image.height; y++){
      color col = image.pixels[x+(y*image.width)];
      stroke(col);
      point(x,y);
    }
  }
  image.updatePixels();
  
  
  ////---print points---
  //for(PVector p : points){
  //  println(p.x,p.y); 
  //}
  ////-------------
  
}

void draw(){
  
  //show order
  //delay(1000);
  stroke(0,0,255);
  strokeWeight(3);
  PVector p = points.get(i);
  point(p.x,p.y);
  //delay(1);
  i++;
  
  if(i==2436){
    noLoop(); 
  }
}
