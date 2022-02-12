
ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage img;
int ranTotal;
boolean go = false;

void setup() {
  size(800, 800);
  spots = new ArrayList<PVector>();
  
  img = loadImage("black-heart-hi.png");
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
  circles = new ArrayList<Circle>();
  colorMode(HSB, 360,100,100);
  ranTotal = int(random(1,3));
  frameRate(30);
  //translate((width-img.width)/2, (height-img.height)/2);
}

void mouseClicked(){

Circle start = new Circle(mouseX, mouseY, 45);
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
}

Circle newCircle() {
  
  int r = int(random(0,spots.size()));
  PVector spot = spots.get(r);
  float x = spot.x;
  float y = spot.y;

  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  if (valid) {
    return new Circle(x, y, 3);
  } else {
    return null;
  }
}
