class Scene2 extends Scene{
  Integer a = null;
  void setup(){
    println("Scene2 setup ...");
    a = 24;
  }
  void draw(){
    background(255);
    rectMode(CENTER);
    rect(mouseX,mouseY,a,24);
  }
  void keyPressed(){
    SceneDirector.sceneChange(1);
  }
}
