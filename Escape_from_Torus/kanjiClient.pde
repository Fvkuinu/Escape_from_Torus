import javax.swing.*;
import java.awt.*;
import controlP5.*;
import javax.swing.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import processing.net.*;
class kanjiClient extends Scene{
//------------------------
// ここはメインウィンドウ側
//------------------------
SecondApplet sa = null;
int exitCode = -1;  //サブ側終了ステータス
float mainTextX = 0;
Client myClient;
PVector pp = new PVector();
PShape shape;
PShape[] shape1 = new PShape[58];
PVector pos = new PVector();
float theta = 0;
int anime = 0;
int clear;
int pClear;
String answer;
CameraControl c;
boolean check;

void setup() { 
  try{
  myClient = new Client(applet, "127.0.0.1", 52223);
  }
  catch(Exception ex){
    check=true;
    SceneDirector.sceneChange(7); 
    return;
  }
  //println(111);
  //translate(width/2,height/2);
  check = false;
  clear= 0;
  pClear = 0;
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
  //if(myClient.available() <= 0){
  //  check=true;
  //  SceneDirector.sceneChange(7); 
  //  return;
  //}
  String msg = myClient.readString();
    String [] data = split( msg, ',' );
    clear = int(data[0]);
    answer = data[1];
  // 文字指定
  textSize(24);
  textAlign(LEFT, TOP);
  c= new CameraControl(applet);
  camera(100, 100, 100, 0, 0, 0, 0, 0, -1);
  for (int i = 0; i < 58; i++) {
    shape1[i] = loadShape("untitled_"+nf(i+1, 6)+".obj");
    shape1[i].scale(100);
  }
  shape = loadShape(answer+".obj");
  shape.scale(100);
  //サブウィンドウを開く
  String[] args = {"Answer"};   
  sa = new SecondApplet(applet, answer);
  PApplet.runSketch(args, sa);
}

void draw() {
  if(check) return;
  
  background(0);
  fill(255);
  int m = 0;
  if (myClient.available() > 0) { 
    // 文字列として受信
    String msg = myClient.readString();
    String [] data = split( msg, ',' );
    clear = int(data[0]);
    answer = data[1];
    m = int(data[2]);
    pos.set(float(data[3]), float(data[4]), float(data[5]));
    theta = float(data[6]);
  }
  if (m==1) {
    anime++;
  } else {
    anime=32;
  }
  c.pre();
  hint(ENABLE_DEPTH_TEST);
  background(0);
  lights();
  directionalLight(128, 128, 128, 0, -1, 0);
  directionalLight(128, 128, 128, 0, 1, 0);
  noStroke();
  //sphere(10);
  shape(shape);
  pushMatrix();
  {//translate(width/2,height/2,0);
    translate(pos.x, pos.y, pos.z);
    rotate(radians(theta+90));
    shape(shape1[anime%58]);
  }
  popMatrix();
  //pushMatrix();
  ////translate(width/2,height/2,0);
  //translate(0, 0, -160);
  //fill(255);
  ////box(5000,5000,1);
  //popMatrix();
  hint(DISABLE_DEPTH_TEST);
  
  
  // サブウィンドウが終了したか監視する
  if ( sa != null && !sa.getSurface().isStopped()) {
    // サブウィンドウが生きている
    //text("Main", mainTextX++, height/2 );
    //if(mainTextX > width){
    //  mainTextX = 0;
    //}
    if(clear == 1 && pClear == 0){
      sa.congra();
    }
    pClear=clear;
    if(sa.clear){
      clear=1;
    }
    
  } else {
    // サブウィンドウは停止した
    //text("Sub is stoped. \nCode=" + exitCode, 0, height/2 );
    if ( sa != null ) {
      sa.dispose();
      sa = null;
    }
    SceneDirector.sceneChange(1);
    println("title");
  }
  String msg = "";
  PVector p = c.getCameraPos();
  int moving = 1;
  if (p.x == pp.x && p.y == pp.y) {
    moving = 0;
  }
  msg+=clear+","+answer+","+moving+","+p.x+","+p.y+","+p.z+","+c.getPan()+",";
  pp=p.copy();
   myClient.write(msg+"\n");
  c.post();
}     

// サブウィンドウから終了ステータスを受け取るメソッド
public void GetSubStatus(int status) {
  exitCode = status;
}
void stop(){
  myClient.stop();
  myClient = null;
}
//------------------------
// ここはサブウィンドウ側
//------------------------
public class SecondApplet extends PApplet {
  PApplet  mainApplet;
  int exitStatus = 0;
  Method method = null;
  float subTextX = 0;
  ControlP5 cp5;
  JLayeredPane pane;
  JTextField jt1;
  String input = "";
  int count = 256;
  String answer = "";
  boolean clear = false;
  int time = 100;
  int timer = 0;
  // コンストラクタ
  public SecondApplet(PApplet _mainApplet, String str) {
    mainApplet = _mainApplet;
    answer = str;
  }

  void settings() {
    size(250, 150);
  }

  void setup() {
    surface.setLocation(displayWidth/2+500, displayHeight/2-height);
    PFont font = createFont("MS UI Gothic", 12);
    textFont(font);
    cp5 = new ControlP5(this);
    ControlFont cf1 = new ControlFont(font, 12);
    cp5.setFont(cf1);
    java.awt.Canvas canvas =
      (java.awt.Canvas) surface.getNative();
    pane = (JLayeredPane) canvas.getParent().getParent();

    jt1 = new JTextField();
    jt1.setBounds(10, 60, 150, 30);
    pane.add(jt1);

    cp5.addBang("enter", 170, 60, 50, 30)
      .setCaptionLabel("入力")
      .getCaptionLabel()
      .align(ControlP5.CENTER, ControlP5.CENTER)
      ;
    // メインウィンドウ側の終了ステータス受信メソッドを取得
    try {
      method = mainApplet.getClass().getMethod("GetSubStatus", int.class);
    } 
    catch( NoSuchMethodException ex) {
      ex.printStackTrace();
    } 

    // Window操作イベントを書き換える
    redefineExitEvent();

    // 文字指定
    textSize(24);
    textAlign(LEFT, TOP);
  }  

  void draw() {
    background(200, 200, 200);

    textSize(24);
    textAlign(CENTER, CENTER);
    if (clear) {
      fill(255, 0, 0);
      text("〇 正解", width/2, 30);
      fill(0,0,0);
      text("タイトルに戻るまで "+time,width/2,height-40);
      time = 8-(millis()-timer)/1000;
      if(time<0){
        close();
      }
    } else {
      fill(0, 0, 255, 255-count);
      text("× 不正解", width/2, 30);
    }
    fill(255, 0, 0);
    ellipse(235, 135, 20, 20);
    fill(0);
    textSize(12);
    text("あきらめるボタン→", width/2+50, 135);
    count++;
  }
  void enter() {
    input = jt1.getText();
    jt1.setText("");
    if (input.equals(answer)) {
      congra();
    } else {
      count = 0;
    }
  }
  void congra(){
    clear= true;
      timer=millis();
      count = 0;
      jt1.setText("答えは     "+answer);
  }
  // マウスクリックで終了する
  public void mouseClicked() {
    if(dist(mouseX,mouseY,235, 135)<10){
      close();
    }
  }
  void close() {
    // メインウィンドウのメソッドを呼び出す
    try {
      // 終了コード（ここではフレームカウント）を渡す
      if ( method != null ) {
        method.invoke(mainApplet, frameCount );
      }
    } 
    catch(IllegalAccessException ex ) {
      ex.printStackTrace();
    } 
    catch(InvocationTargetException ex) {
      ex.printStackTrace();
    }

    // 自分自身のWindowを閉じる
    JFrame frame = getJFrame();
    frame.dispatchEvent(new WindowEvent(frame, WindowEvent.WINDOW_CLOSING));
  }
  // PSurface がもつ Windowフレームを取得
  private JFrame getJFrame() {
    return (JFrame)
      ((processing.awt.PSurfaceAWT.SmoothCanvas)getSurface()
      .getNative()).getFrame();
  }

  // Window操作用のイベントを再定義する
  private void redefineExitEvent() {
    // Windowフレームを取得する
    JFrame frame = getJFrame();

    // 該当Windowから、全てのWindow操作用イベントを削除し
    // 新しいイベントに書き換える
    for (final java.awt.event.WindowListener evt : 
      frame.getWindowListeners()) {
      // イベントを削除する
      frame.removeWindowListener(evt);
      // Window Close 動作を再定義する
      // → 登録されている任意の WindowListener を呼び出したあとで
      //   自動的にフレームを隠して破棄する
      frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE );
      // 新しいWindow 操作イベントをセットする
      frame.addWindowListener(new WindowManage(this));
    }
  }
}

//-----------------------
// Window 操作イベントクラス
//-----------------------
class WindowManage extends WindowAdapter {
  PApplet subApp;

  // コンストラクタ
  public WindowManage( PApplet _subApp ) {
    subApp = _subApp;
  }

  // Closeされた直後に動作する部分
  public void windowClosed(WindowEvent e) {   
    // 自分を終了する
    subApp.noLoop();
    subApp.getSurface().stopThread();
  }
}
}
