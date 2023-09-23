class startmenu extends Scene{
PImage start;
PImage p1;
PImage p2;

void setup()
{
  cursor();
  //size(700, 500);
  background(252, 241, 110);
//  textAlign(CENTER, CENTER);
  start=loadImage("start.png");
  p1=loadImage("p1.png");
  p2=loadImage("p2.png");
}

void draw()
{
  ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  image(start, 100, 100, 500, 100);
  image(p1, 250, 250, 180, 80);
  image(p2, 250, 350, 180, 80);
}

void mousePressed()
{
  if (mouseX>250&&mouseY>250&&mouseX<430&&mouseY<330)
  {
    SceneDirector.sceneChange(2);
    //println("ソロ");
  }
  if (mouseX>250&&mouseY>350&&mouseX<430&&mouseY<430)
  {
    SceneDirector.sceneChange(7);
    //println("マルチ");
  }
}
}
