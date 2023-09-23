class KleinBottleLaser extends Laser4 {
  KleinBottleLaser() {
    super();
  }
  void setStart(PVector start, PVector end, PVector d, int wallNum) {
    if (wallNum==0) {
      start.set(width-1, end.y);
    }
    if (wallNum==1) {
      start.set(+1, end.y);
    }
    if (wallNum==2) {
      d.set(-d.x, d.y);
      start.set(width-end.x-1, height-1);
    }
    if (wallNum==3) {
      d.set(-d.x, d.y);
      start.set(width-end.x-1, +1);
    }
  }
}
