
ArrayList<Circle> circles;
ArrayList<PVector> spots;
ArrayList<PVector> spots2;

PImage img, img2;
int ranTotal;
boolean go = false;
float mX, mY; // mouse X and Y

void setup() {
  size(800, 800);
  frameRate(30);
  spots = new ArrayList<PVector>();
  spots2 = new ArrayList<PVector>();

  
  img = loadImage("black-heart-hi.png");
  img2 = loadImage("vstr.png");
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = x + y * img.width;
      color c = img.pixels[index];
      float b = brightness(c);
      if (b < 1) {
        spots.add(new PVector(x,y));
      }
      
    } 
  }
  img2.loadPixels();
  for (int x = 0; x < img2.width; x++) {
    for (int y = 0; y < img2.height; y++) {
      int index = x + y * img2.width;
      color c = img2.pixels[index];
      float b = brightness(c);
      if (b < 1) {
        spots2.add(new PVector(x,y));
      }
      
    } 
  }
  circles = new ArrayList<Circle>();
  colorMode(HSB, 360,100,100);
  ranTotal = int(random(5,7));
  frameRate(30);
  //beginRecord(PDF, "frame-####.pdf");
  //translate((width-img.width)/2, (height-img.height)/2);
}

void mouseClicked(){

mX = mouseX;
mY= mouseY;
Circle start = new Circle(mX, mY, 10);
//print((width-img.width)/2, " ");
//print((height-img.height)/2, " ");
//print(mouseX," ", mouseY);

circles.add(start);
go = true;
}

void draw() {
  //translate((width-img.width)/2, (height-img.height)/2);
  background(360,0,100);
  if (go){
  

  int total = ranTotal;
  int count = 0;
  int attempts = 0;

  while (count <  total) {
    Circle newC = newCircle();
    if (newC != null) {
      circles.add(newC);
      count++;
    }
    Circle newC2 = newCircle2();
    if (newC2 != null) {
      circles.add(newC2);
      count++;
    }
    attempts++;
    if (attempts > 30) {
      noLoop();
      println("FINISHED");
      
      break;
    } 
  }


  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d - 2 < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }
    c.show();
    c.grow();
  }
}
//saveFrame("output/frame_####.png");
}
void keyPressed(){
//endRecord();
}

Circle newCircle() {
  
  int r = int(random(0,spots.size()));
  PVector spot = spots.get(r);
  float x = spot.x + mX - img.width / 2;
  float y = spot.y+ mY - img.height / 2;

  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  if (valid) {
    return new Circle(x , y , 3);
  } else {
    return null;
  }
}

Circle newCircle2() {
  
  int r = int(random(0,spots2.size()));
  PVector spot = spots2.get(r);
  float x = spot.x + mX - img2.width / 2;
  float y = spot.y+ mY - img2.height / 2+350;

  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  if (valid) {
    return new Circle(x , y , 3);
  } else {
    return null;
  }
}
