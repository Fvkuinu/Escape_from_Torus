import processing.net.*;
class torusClient extends Scene{
Client myClient;
int hp = 100;
int R = 25;
int time = 30;
Target5 target;
boolean check;
void setup() {
  check = false;
  myClient = new Client(applet, "127.0.0.1", 12222);
  check = false;

 // size(700, 500);
  if(myClient.active()==false){
    check=true;
    SceneDirector.sceneChange(7); 
    return;
  }
  int count = 0;
  while(myClient.available() <= 0){
    delay(3);
    count++;
    if(count>60){
      check=true;
    SceneDirector.sceneChange(7); 
    return;
    }
  }
  target = new Target5(350, 250, 25);//x座標、ｙ座標、半径（直径ではない）
}

void draw() {
  if(check) return;
  ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  background(255);
  if (myClient.available() > 0) { 
    // 文字列として受信
    String msg = myClient.readString();
    // 描画してみよう！
    //println(msg);
    String[] data = split(msg, ",");
    time = int(data[0]);
    hp = int(data[1]);
    ellipse(float(data[2]), float(data[3]), 10, 10);
    for (int i = 4; i<data.length-4; i+=4) {
      line(float(data[i]), float(data[i+1]), float(data[i+2]), float(data[i+3]));
    }
  }
  textSize(24);
  fill(0,0,255);
  text(time,10,25);
  //laser.draw();//レーザーの描画処理

  target.draw();//的となる円の描画処理
  if(hp <= 0){
    println(222);
  }
  target.r=map(hp,0,100,10,R*2)/2.0;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j< 3; j++) {
      circle(target.OpponentPos.x-width+width*i, target.OpponentPos.y-height+height*j, target.r*2);
    }
  }
  PVector p = target.getPos();
  myClient.write(p.x+","+p.y+",");
  if (hp<=0) {
   // println("DEFEAT");
   SceneDirector.sceneChange(15);
  }
  if(time<=0){
    //println("VICTORY");
    SceneDirector.sceneChange(14);
  }
}

void keyPressed() {
  target.keyPressed();//レーザーの移動処理
}
void keyReleased() {
  target.keyReleased();//レーザーの移動処理
}
void stop() {
  myClient.stop();
  myClient = null;
}
}
