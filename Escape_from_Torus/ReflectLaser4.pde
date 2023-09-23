class ReflectLaser4 extends Laser4{
  ReflectLaser4(){
    super();
  }
  void setStart(PVector start, PVector end, PVector d, int wallNum) {
    if (wallNum==0) {
      d.set(-d.x, d.y);
      start.set(+1, end.y);
    }
    if (wallNum==1) {
      d.set(-d.x, d.y);
      start.set(width-1, end.y);
    }
    if (wallNum==2) {
      d.set(d.x, -d.y);
      start.set(end.x, +1);
    }
    if (wallNum==3) {
      d.set(d.x, -d.y);
      start.set(end.x, height-1);
    }
  }
}
