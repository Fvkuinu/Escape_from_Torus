class stage2 extends Scene {
  Laser2 laser;
  ArrayList<Target> targets = new ArrayList<Target>();
  int num_target;
  float[][] position;
  boolean hit;
  String[] result;
  int bx, bdx, by, bdy;
  void setup() {
    //size(700, 500);
    laser = new Laser2();
    result = loadStrings("data.txt");
    num_target = 3;
    position = new float[num_target][3];

    /*
  position[0][0] = random(650)+20;
     position[1][0] = random(650)+20;
     position[2][0] = random(650)+20;
     position[0][1] = random(450)+20;
     position[1][1] = random(450)+20;
     position[2][1] = random(450)+20;
     position[0][2] = 10;
     position[1][2] = 10;
     position[2][2] = 10;
     */

    set();

    for (int i = 0; i < num_target; i++) {
      targets.add(new Target(position[i][0], position[i][1], position[i][2]));//x座標、ｙ座標、半径（直径ではない）
    }
  }

  void draw() {
    hit = true;
    ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
    laser.draw();//レーザーの描画処理
    for (int i = 0; i < targets.size(); i++) { 
      targets.get(i).draw();//的となる円の描画処理
      if (targets.get(i).collision(laser.getLineList())) {  //的にレーザーが当たっているか判定するもの
        targets.get(i).setColor(color(255, 255, 0));  //的の色を変える関数
      } else {
        targets.get(i).setColor(color(255, 255, 255));  //的の色を変える関数
        hit = false;
      }
    }
    // ボタン処理ここから (mousePressedの中も作りました)
    bx = 80;
    bdx = 100;
    by = 450;
    bdy = 50;
    fill(200);
    ellipse(bx, by, bdx, bdy);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("back", 80, 450);
    // ボタン処理ここまで

    if (!hit) {
      return;
    }
    //println("clear");
    result[2] = str(1);
    saveStrings("data.txt", result);
    SceneDirector.sceneChange(6);
  }
  void mousePressed() {
    if (bx-bdx/2 < mouseX && mouseX < bx+bdx/2) {
      if (by-bdy/2 < mouseY && mouseY < by+bdy/2) {
        SceneDirector.sceneChange(2);
        // println("back");
      }
    }
  }
  void keyPressed() {
    laser.keyPressed();//レーザーの移動処理
  }
  void keyReleased() {
    laser.keyReleased();//レーザーの移動処理
  }
  void set() {
    int rand = (int)random(3);
    if (rand < 1) {
      position[0][0] = 163.34778;
      position[1][0] = 311.95047;
      position[2][0] = 599.65320;
      position[0][1] = 177.80699;
      position[1][1] = 357.37326;
      position[2][1] = 176.11328;
    } else if (rand < 2) {
      position[0][0] = 328.06690;
      position[1][0] = 634.52916;
      position[2][0] = 657.83790;
      position[0][1] = 450.52950;
      position[1][1] = 405.47116;
      position[2][1] = 108.10429;
    } else {
      position[0][0] = 661.45935;
      position[1][0] = 487.84293;
      position[2][0] = 304.61823;
      position[0][1] = 398.20780;
      position[1][1] = 241.62994;
      position[2][1] = 228.52289;
    }
    position[0][2] = 10;
    position[1][2] = 10;
    position[2][2] = 10;
  }
}
