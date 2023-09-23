import com.jogamp.newt.opengl.GLWindow;
class Scene1 extends Scene{
  Integer a = null;
  void setup(){
    println("Scene1 setup ....");
    a = 24;
    noLights();
    
    //camera();
  }
  void draw(){
    ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
    cursor();
    background(255);
    fill(255);
    stroke(0);
    line(width/2,height/2,mouseX,mouseY);
    ellipse(mouseX,mouseY,24,25);
    //println(width,height);
  }
  void keyPressed(){
    SceneDirector.sceneChange(3);
  }
}
