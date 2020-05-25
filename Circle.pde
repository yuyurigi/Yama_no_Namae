class Circle {

  PVector loc;
  float rwidth, rheight;
  String s;
  color c;

  Circle(PVector _loc, float _rwidth, float _rheight, String _s) {
    loc = _loc;
    rwidth = _rwidth;
    rheight = _rheight;
    s = _s;
    
    int cr = (int)random(2);
    if(cr < 1){
    c = lerpColor(c1, c2, noise(loc.x * 0.1, loc.y * 0.1));
    } else{
    c = lerpColor(c2, c3, noise(loc.x * 0.1, loc.y * 0.1));
    } 
    colorMode(RGB,255,255,255,255);
  }

  void display() {
    float r = time > duration ? rheight: easing(time, 0, rheight, duration);
    fill(c);
    textSize(r);
    text(s, loc.x, loc.y);
  }

  float easing(float t, float b, float c, float d) {
    //easeOutBack
     float s = 1.0;
      t /= d;
    t--;
    return c * (t * t * ((s + 1) * t + s) + 1) + b;

  }
}
