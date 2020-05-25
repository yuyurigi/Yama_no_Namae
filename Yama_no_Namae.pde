import java.util.Calendar;

float time = 1;
float duration = 20; 
ArrayList<Circle> circles;
color c1, c2, c3;
int dimborder = 50; //縁の太さ
String[] lines, mountains;
PFont font;
PImage img;

void setup() {
  size(800, 800);
  circles = new ArrayList<Circle>();
  rectMode(CENTER);

  //テキストデータ読み込み
  lines = loadStrings("mountains.txt");
  mountains = new String[lines.length];
  for (int i = 0; i < lines.length; i++) {
    String[] pieces = split(lines[i], '\t');
    mountains[i] = pieces[1];
  }

  //フォント情報
  font = createFont("crayon_1-1.ttf", 30);
  textFont(font);
  textAlign(CENTER, CENTER);

  //画像読み込み
  img = loadImage("aoi.png");
}

void draw() {
  background(241, 240, 238);
  fill(87, 76, 88); //こげ茶
  noStroke();
  ellipseMode(CENTER);
  ellipse(width/2, height/2, width-dimborder*2, width-dimborder*2);

  for (Circle c : circles) {
    c.display();
  }

  image(img, 0, 0, width, height);
  time += 1;
}

void mousePressed() {
  makeCircles();
}

void makeCircles() {
  c1 = color(random(255), random(255), random(255));
  c2 = color(random(255), random(255), random(255));
  c3 = color(random(255), random(255), random(255));
  circles = new ArrayList<Circle>();
  for (int i = 0; i < 1500; i++) {
    int tRandom = int(random(mountains.length)); //文字のランダム値
    String s = mountains[tRandom];
    int tsize = int(random(40, 120)); //文字の大きさ 
    textSize(tsize);
    float rwidth = textWidth(s); //文字の横幅
    float rheight = tsize; //文字の高さ
    float locSize = map(sqrt(random(1)), 0, 1, 0, (width-dimborder*2)/2);
    float locAng = random(TWO_PI);
    PVector loc = new PVector(width/2 + locSize * cos(locAng), height/2 + locSize * sin(locAng));

    boolean isOverlapped = false;

    //画面の外に文字がはみ出ないようにする
    int dimborder2 = dimborder - 20;
    if ((loc.x - rwidth/2 < dimborder2) ||
      (loc.x + rwidth/2 > width-dimborder2) ||
      (loc.y - rheight/2 < dimborder2) ||
      (loc.y + rheight/2 > height-dimborder2) 
      ) {
      isOverlapped = true;
    }

    //文字と文字の重なり判定
    if (!isOverlapped) {
      for (Circle other : circles) {
        if ((abs(loc.x - other.loc.x) < rwidth/2 + other.rwidth/2 + 10) &&
          (abs(loc.y - other.loc.y) < rheight/2 + other.rheight/2 + 10)) {
          isOverlapped = true;
          continue;
        }
      }
    }

    if (!isOverlapped) {
      circles.add(new Circle(loc, rwidth, rheight, s));
    }
  }
  time = 1;
}

void keyReleased() {
  if (key == 's' || key == 'S')saveFrame(timestamp()+"_####.png");
}


String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
