class Circle {
  float x;
  float y;
  float r;
  color clr;

  boolean growing = true;

  Circle(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    clr = color(random(270,360),random(60,90),random(95,100));
  }

  void grow() {
    if (growing) {
      r = r + 0.1;
    }
  }
  
  boolean edges() {
    return (x + r > width || x -  r < 0 || y + r > height || y -r < 0);
  }

  void show() {
    noStroke();
    strokeWeight(2);
    fill(clr);
    ellipse(x, y, r*2, r*2);
  }
}
