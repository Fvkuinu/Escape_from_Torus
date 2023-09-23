import java.awt.*;
import java.awt.Robot.*;
public class CameraControl {
  PApplet parent;
  Robot bot;
  private PVector cameraPos;
  private PVector cameraTarget = new PVector(1, 0, 0);
  private int mouseSensitivity = 15;
  private float moveVelocity = 5;
  private HashMap<Integer, Boolean> keyMap = new HashMap<Integer, Boolean>();
  private int fov = 90;
  private float near = 1.0;
  private float far = 5000.0;
  private float thetaV = 180;
  private float thetaH = 0;
  private boolean cameraRotate = true;
  private float ascentVelocity = 0;
  private float jumpPower = 3.5;
  private float gravity = 9.8;
  private float ground = 0;
  private boolean jump = false;
  private final boolean continuousJump = false; 
  CameraControl(PApplet parent) {
    this(parent, 0.0, 0.0, 0.0);
  }
  CameraControl(PApplet parent, float x, float y, float z) {
    noCursor();
    //Robot使うための処理
    try {
      bot = new Robot();
      bot.mouseMove(50, 50);
    }
    catch (AWTException e) {
      e.printStackTrace();
    }
    this.parent = parent;
    parent.registerMethod("dispose", this);
    //parent.registerMethod("pre", this);
    //parent.registerMethod("post", this);
    parent.registerMethod("keyEvent", this);
    cameraPos = new PVector(x, y, z);
  }

  public void dispose() {
    parent.unregisterMethod("dispose", this);
    //parent.unregisterMethod("pre", this);
    //parent.unregisterMethod("post", this);
    parent.unregisterMethod("keyEvent", this);
  }

  public void pre() {
    control();
  }

  public void control() {
    perspective(radians(fov), float(width)/float(height), near, far);

    if (cameraRotate) {    
      cameraRotate();
    }

    cameraTranslate();

    //PMatrix3D C = ((PGraphicsOpenGL)(this.parent.g)).camera.get(); // コピー
    //C.preApply(M);
    //// 上を向くように修正
    //C.invert();
    //float ex = C.m03;
    //float ey = C.m13;
    //float ez = C.m23;
    //float cx = -C.m02 + ex;
    //float cy = -C.m12 + ey;
    //float cz = -C.m22 + ez;
    parent.camera( cameraPos.x, cameraPos.y, cameraPos.z, cameraPos.x+cameraTarget.x, cameraPos.y+cameraTarget.y, cameraPos.z+cameraTarget.z, 0, 0, -1 );
  }

  public void cameraRotate() {
    PointerInfo pi = MouseInfo.getPointerInfo();
    Point pt = pi.getLocation();
    float x = (float)pt.getX();    //  マウスカーソルのスクリーンX座標
    float y = (float)pt.getY();    //  マウスカーソルのスクリーンY座標
    bot.mouseMove(displayWidth/2, displayHeight/2);
    thetaH += mouseSensitivity/400.0*(x-displayWidth/2.0); 
    thetaV -= mouseSensitivity/400.0*(y-displayHeight/2.0);
    thetaV = constrain(thetaV, 91, 269);
    PVector h = PVector.fromAngle(radians(thetaH));
    float targetZ = -sin(radians(thetaV));
    cameraTarget.set(h.x, h.y, targetZ);
  }

  public void cameraTranslate() {
    PVector v = new PVector(0, 0);

    if (keyMap.getOrDefault(87, false)) { //'w'
      v.add(PVector.fromAngle(radians(thetaH)));
      //M.translate(0,0,5);
    }
    if (keyMap.getOrDefault(65, false)) { //'a' 
      v.add(PVector.fromAngle(radians(thetaH-90)));
      // M.translate(5,0,0);
    }
    if (keyMap.getOrDefault(83, false)) { //'s'
      v.add(PVector.fromAngle(radians(thetaH+180)));
      // M.translate(0,0,-5);
    }
    if (keyMap.getOrDefault(68, false)) { //'d'
      v.add(PVector.fromAngle(radians(thetaH+90)));
      //M.translate(-5,0,0);
    }
    //if (keyMap.getOrDefault(32, false)) { //'space'
    //  M.translate(0, moveVelocity, 0);
    //}
    //if (keyMap.getOrDefault(16, false)) { //'shift'
    //  M.translate(0, -moveVelocity, 0);
    //}
    v.setMag(moveVelocity);
    cameraPos.add(v.x, v.y, ascentVelocity);
    if (cameraPos.z < ground) {
      cameraPos.z = ground;
      jump=false;
    }
    if (jump) {
      ascentVelocity -= gravity/frameRate;
    }
  }

  public void post() {
    noLights();
    pushMatrix();
    ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
    fill(255); 
    textSize(12);
    
    text("[w],[s] : Move forward/backward", 10, 20);
    text("[a],[d] : Move left/right", 10, 35 );
    text("[h] : mouseCursor visible/invisible", 10, 50 );
    hint(ENABLE_DEPTH_TEST);
    popMatrix();
  }

  public void keyEvent(KeyEvent evt) {
    //println(evt.getAction());
    int keyEventAction = evt.getAction();
    switch(keyEventAction) {
    case KeyEvent.PRESS: 
      keyPressed();
      break;
    case KeyEvent.RELEASE: 
      keyReleased();
      break;
    case KeyEvent.TYPE: 
      keyTyped();
      break;
    }
  }
  public PVector getCameraPos() {
    return cameraPos;
  }
  public void setCameraPos(float x, float y, float z) {
    cameraPos.set(x, y, z);
  }
  public float getPan() {
    return thetaH;
  }
  public float getTilt() {
    return thetaV;
  }
  private void keyPressed() {
    keyMap.put(keyCode, true);
    //println(keyCode);

    if (keyCode == 72) {//'h'
      if (cameraRotate) {
        cameraRotate = false;
        cursor();
      } else {
        cameraRotate = true;
        noCursor();
      }
    }
    if (keyCode == 32) {//space
      if (continuousJump) {
        jump = true;
        ascentVelocity = jumpPower;
      } else {
        if (!jump) {
          jump = true;
          ascentVelocity = jumpPower;
        }
      }
    }
  }
  private void keyReleased() {
    keyMap.put(keyCode, false);
  }
  private void keyTyped() {
    //println(key);
  }
}
