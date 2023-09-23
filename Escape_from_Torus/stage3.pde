class stage3 extends Scene {
  Laser3 laser;
  ArrayList<Target> targets = new ArrayList<Target>();
  int num_target;
  float[][] position;
  boolean hit;
  String[] result;
  float[][] set1;
  float[][] set2;
  float[][] set3;
  int bx, bdx, by, bdy;
  void setup() {
    //size(700, 500);
    laser = new Laser3();
    result = loadStrings("data.txt");
    num_target = 5;
    position = new float[num_target][3];

    /*
  position[0][0] = random(650)+20;
     position[1][0] = random(650)+20;
     position[2][0] = random(650)+20;
     position[3][0] = random(650)+20;
     position[4][0] = random(650)+20;
     position[0][1] = random(450)+20;
     position[1][1] = random(450)+20;
     position[2][1] = random(450)+20;
     position[3][1] = random(450)+20;
     position[4][1] = random(450)+20;  
     position[0][2] = 15;
     position[1][2] = 15;
     position[2][2] = 15;
     position[3][2] = 15;
     position[4][2] = 15;
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
    // println("clear");
    //result[2] = str(1);
    //saveStrings("data.txt", result);
    SceneDirector.sceneChange(6);
  }
  void mousePressed() {
    if (bx-bdx/2 < mouseX && mouseX < bx+bdx/2) {
      if (by-bdy/2 < mouseY && mouseY < by+bdy/2) {
        SceneDirector.sceneChange(2);
        //println("back");
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
      position[0][0] = 307.58710;
      position[1][0] = 228.75986;
      position[2][0] = 346.60464;
      position[3][0] = 592.56024;
      position[4][0] = 156.75693;
      position[0][1] = 265.09442;
      position[1][1] = 315.69360;
      position[2][1] = 407.46112;
      position[3][1] = 391.67044;
      position[4][1] = 156.63583;
    } else if (rand < 2) {
      position[0][0] = 530.25867;
      position[1][0] = 636.29670;
      position[2][0] = 646.09160;
      position[3][0] = 608.88370;
      position[4][0] = 183.20082;
      position[0][1] = 307.98334;
      position[1][1] = 342.04640;
      position[2][1] =  74.80378;
      position[3][1] = 105.05572;
      position[4][1] = 448.64313;
    } else {
      position[0][0] =  78.45636;
      position[1][0] = 283.85364;
      position[2][0] = 167.34640;
      position[3][0] = 250.81433;
      position[4][0] = 521.49500;
      position[0][1] = 253.83884;
      position[1][1] = 179.26760;
      position[2][1] =  98.79673;
      position[3][1] = 432.12653;
      position[4][1] = 396.19452;
    }
    position[0][2] = 15;
    position[1][2] = 15;
    position[2][2] = 15;
    position[3][2] = 15;
    position[4][2] = 15;
  }
}
