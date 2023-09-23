class Target {
  private PVector OpponentPos;
  private boolean collision = false;
  private float r;
  private color targetColor;
  Target(float x, float y, float r) {
    OpponentPos = new PVector(x, y);
    targetColor = (255);
    this.r = r;
  }
  void draw() {
    stroke(0);
    strokeWeight(1);
    fill(targetColor);
    circle(OpponentPos.x, OpponentPos.y, r*2);
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
}
