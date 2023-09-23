class stage1 extends Scene {
  Laser laser;
  ArrayList<Target> targets = new ArrayList<Target>();
  int num_target;
  float[][] position;
  boolean hit;
  String[] result;
  int bx, bdx, by, bdy;

  void setup() {
    size(700, 500);
    laser = new ReflectLaser();
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
     position[0][2] = 30;
     position[1][2] = 30;
     position[2][2] = 30;
     */

    set();

    hit = true;
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
    for (int i = 0; i < num_target; i++) { 
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
    result[1] = str(1);
    saveStrings("data.txt", result);
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
      position[0][0] = 301.14157;
      position[1][0] = 247.66480;
      position[2][0] = 495.17093;
      position[0][1] = 458.65454;
      position[1][1] = 170.81007;
      position[2][1] = 466.08980;
    } else if (rand < 2) {
      position[0][0] = 141.18510;
      position[1][0] = 327.18204;
      position[2][0] = 547.09010;
      position[0][1] = 301.11307;
      position[1][1] =  93.69214;
      position[2][1] = 389.03986;
    } else {
      position[0][0] = 371.13790;
      position[1][0] = 517.86370;
      position[2][0] = 589.11600;
      position[0][1] = 175.48318;
      position[1][1] = 110.75863;
      position[2][1] = 458.34396;
    }
    position[0][2] = 30;
    position[1][2] = 30;
    position[2][2] = 30;
  }
}
