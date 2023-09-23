class Laser3 {
  private PVector pos;
  private float velocity=4;
  private float r;
  private float angle = 1;
  private float angularVelocity = 0.8;
  private final int numberOfReflections = 5;
  private PVector[][] lineList;
  private HashMap<Integer, Boolean> keyState = new HashMap();
  Laser3() {
    this(0, 0, 5);
  }
  Laser3(float x, float y, float r) {
    pos = new PVector(x, y);
    this.r = r;
    lineList=new PVector[numberOfReflections][2];
    for (int i=0; i<lineList.length; i++) {
      for (int j=0; j<lineList[i].length; j++) {
        lineList[i][j] = new PVector();
      }
    }
  }

  void draw() {
    background(255);
    noFill();
    laser();
    ellipse(pos.x, pos.y, r*2, r*2);
  }

  void laser() {
    strokeWeight(1);
    move();
    rotate();
    PVector d = PVector.fromAngle(radians(angle));
    PVector w = new PVector(width, 0);
    PVector h = new PVector(0, height);
    float s, t, u;

    int wallNum = 0;
    PVector start = pos.copy();
    for (int i=0; i<numberOfReflections; i++) {
      float min = 123456789;
      s=0;
      t=(s*w.x-start.x)/d.x;
      if (t>=0 && t<min) {
        wallNum=0;
        min = t;
      }
      s=1;
      t=(s*w.x-start.x)/d.x;
      if (t>=0 && t<min) {
        wallNum=1;
        min = t;
      }
      u=0;
      t=(u*h.y-start.y)/d.y;
      if (t>=0 && t<min) {
        wallNum=2;
        min = t;
      }
      u=1;
      t=(u*h.y-start.y)/d.y;
      if (t>=0 && t<min) {
        wallNum=3;
        min = t;
      }
      PVector end = PVector.add(start, d.mult(min));
      stroke(0);
      //println(wallNum, min);

      lineList[i][0].set(start.x, start.y);
      lineList[i][1].set(end.x, end.y);
      line(start.x, start.y, end.x, end.y);
      setStart(start, end, d, wallNum);
    }
  }
  void setStart(PVector start, PVector end, PVector d, int wallNum) {
    if (wallNum==0) {
      start.set(width-1, end.y);
    }
    if (wallNum==1) {
      start.set(+1, end.y);
    }
    if (wallNum==2) {
      start.set(end.x, height-1);
    }
    if (wallNum==3) {
      start.set(end.x, +1);
    }
  }
  void keyPressed() {
    keyState.put(keyCode, true);
  }
  void keyReleased() {
    keyState.put(keyCode, false);
  }
  void move() {
    PVector d = new PVector(0, 0);
    //w
    if (keyState.getOrDefault(87, false)) {
      d.add(0, -1);
    }
    //a
    if (keyState.getOrDefault(65, false)) {
      d.add(-1, 0);
    }
    //s
    if (keyState.getOrDefault(83, false)) {
      d.add(0, 1);
    }
    //d
    if (keyState.getOrDefault(68, false)) {
      d.add(1, 0);
    }
    d.setMag(velocity);
    pos.add(d);
    pos.x = constrain(pos.x,0+1,width-1);
    pos.y = constrain(pos.y,0+1,height-1);
  }
  void rotate() {
    //q
    if (keyState.getOrDefault(81, false)) {
      angle-=angularVelocity;
    }
    //e
    if (keyState.getOrDefault(69, false)) {
      angle+=angularVelocity;
    }
  }
  PVector[][] getLineList(){
    return lineList;
  }
  PVector getPosition(){
    return pos;
  }
}
