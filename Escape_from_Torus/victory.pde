class victory extends Scene{
PImage victory;

void setup()
{
  size(700, 500);
  background(252, 241, 110);

  victory=loadImage("victory.png");
}

void draw()
{
  ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  image(victory, 230, 250, 250, 80);
}
void mousePressed()
{
  SceneDirector.sceneChange(1);
}
}
