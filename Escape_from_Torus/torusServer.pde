import processing.net.*;
class torusServer extends Scene{
Server myServer;
Laser4 laser;
Target4[][] target =new Target4[3][3];
boolean client = false;
int time = 30;
int startTime;
void setup() {
  //size(700, 500);
  time=30;
  myServer = new Server( applet, 12222 );
  laser = new KleinBottleLaser();
  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      target[i][j] = new Target4(350, 250, 25);//x座標、ｙ座標、半径（直径ではない）
    }
  }
  client=false;
}

void draw() {
    ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  Client nextClient = myServer.available();
  if ( nextClient != null ) {
    if (client ==false) {
      startTime = millis();
      for (int i = 0; i<3; i++) {
        for (int j = 0; j<3; j++) {
          target[i][j].hp = 100;
        }
      }
      client = true;
    }

   // println(time);
    // readString() でデータ受信
    String recvStr = nextClient.readString();
    String [] data = split( recvStr, ',' );
    for (int i = 0; i<3; i++) {
      for (int j = 0; j<3; j++) {
        target[i][j].setPos(float(data[0])-width+width*i, float(data[1])-height+height*j);
      }
    }
    //target.setPos(float(data[0]), float(data[1]));
  }
  if (client) {
    time = 30-(millis()-startTime)/1000;
    textSize(24);
    fill(0);
    text(time, 10, 25);
  }
  text(time, 100, 205);
  //println(time);
  laser.draw();//レーザーの描画処理
  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      target[i][j].draw();
    }
  }
  boolean b = false;
  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      if (target[i][j].collision(laser.getLineList())) b = true;
    }
  }
  if (b) {
    for (int i = 0; i<3; i++) {
      for (int j = 0; j<3; j++) {
        target[i][j].hit();
      }
    }
  }
  
  String msg = "";
  msg+=time+",";
  msg+=target[0][0].hp+",";
  PVector p = laser.getPosition();
  msg += p.x+","+p.y+",";
  PVector[][] list= laser.getLineList();
  for (int i=0; i<list.length; i++) {
    for (int j=0; j<list[i].length; j++) {
      msg += list[i][j].x+","+list[i][j].y+",";
    }
  }
  //println(msg);
  myServer.write(msg);
  fill(0,0,255);
  textSize(24);
   text(time, 10, 25);
   if (target[0][0].hp<=0) {
     SceneDirector.sceneChange(14);
    //println("VICTORY");
  }
  if(time<=0){
    SceneDirector.sceneChange(15);
    //println("DEFEAT");
  }
}

void keyPressed() {
  laser.keyPressed();//レーザーの移動処理
}
void keyReleased() {
  laser.keyReleased();//レーザーの移動処理
}
void stop() {
  myServer.stop();
  myServer = null;
}
}
