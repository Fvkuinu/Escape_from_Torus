class clear extends Scene{
PImage clear;

void setup()
{
  size(700, 500);
  background(252, 241, 110);
   clear=loadImage("clear.png");
}

void draw()
{
  ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  image(clear, 230, 250, 250, 80);
}

void mousePressed()
{
  SceneDirector.sceneChange(1);
  //println("スタート画面に戻る");
}
}
