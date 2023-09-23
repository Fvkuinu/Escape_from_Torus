class Target5 {
  private PVector OpponentPos;
  private boolean collision = false;
  private float velocity=4;
  private float r;
  private color targetColor;
  private HashMap<Integer, Boolean> keyState = new HashMap();
  Target5(float x, float y, float r) {
    OpponentPos = new PVector(x, y);
    targetColor = (255);
    this.r = r;
  }
  void draw() {
    move();
    stroke(0);
    strokeWeight(1);
    fill(targetColor);
    //circle(OpponentPos.x, OpponentPos.y, r*2);
  }
  boolean collision(PVector[][] lineList) {
    for (int i=0; i<lineList.length; i++) {
      PVector S = PVector.sub(lineList[i][1], lineList[i][0]);
      PVector A = PVector.sub(OpponentPos, lineList[i][0]);
      PVector B = PVector.sub(OpponentPos, lineList[i][1]);
      float d = (S.cross(A)).mag()/S.mag();
      if (d>r) {
        continue;
      }
      if (A.dot(S)*B.dot(S)<=0) {
        return true;
      } else {
        if (r>A.mag() || r>B.mag()) {
          return true;
        }
      }
    }
    return false;
  }
  void setColor(color c){
    targetColor=c;
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
    OpponentPos.add(d);
    if(OpponentPos.x > width){
      OpponentPos.x -= width;
    }
    if(OpponentPos.x < 0){
      OpponentPos.x += width;
    }
    if(OpponentPos.y > height){
      OpponentPos.y -= height;
    }
    if(OpponentPos.y < 0){
      OpponentPos.y += height;
    }
  }
  PVector getPos(){
    return OpponentPos;
  }
}
