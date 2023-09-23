class defeat extends Scene{
PImage defeat;

void setup()
{
  size(700, 500);
  background(0);
  defeat=loadImage("defeat.png");
}

void draw()
{
  ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  image(defeat, 230, 250, 250, 80);
}
void mousePressed()
{
  SceneDirector.sceneChange(1);
}
}
