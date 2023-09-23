class selectPlayingWay1 extends Scene{
//ボタンの幅
int w=300;
//ボタンの高さ
int h=100;
//ボタン枠の丸さ
int r=20;
PFont mincho;
int bx, bdx, by, bdy;

void setup()
{
  size(700,500);
  
  //フォント読み込み
  mincho=createFont("ＭＳ ゴシック",48);

}

void draw()
{
  ortho();
    resetMatrix();
    translate(-width/2.0, -height/2.0);
    hint(DISABLE_DEPTH_TEST);
  //フォント読み込み
  textFont(mincho);
  
  background(252,241,110);
  
  //ボタンの枠線
  stroke(169,153,255);
  strokeWeight(4);
  
  rectMode(CENTER);
  
  fill(178,255,250);
  rect(width/2,150,w,h,r);
  
  
  fill(178,255,250);
  rect(width/2,350,w,h,r);
  
  
  //文字
  textAlign(CENTER,CENTER);
  textSize(30);
  fill(4,54,130);
  text("募集する",width/2,150);
  text("参加する",width/2,350);
  // ボタン処理ここから (mousePressedの中も作りました)
  bx = 80;
  bdx = 100;
  by = 450;
  bdy = 50;
  fill(200);
  ellipse(bx,by,bdx,bdy);
  fill(0);
  textAlign(CENTER,CENTER);
  textSize(20);
  text("back",80,450);
  // ボタン処理ここまで
}

void mousePressed()
{
  if(bx-bdx/2 < mouseX && mouseX < bx+bdx/2) {
    if(by-bdy/2 < mouseY && mouseY < by+bdy/2) {
      SceneDirector.sceneChange(7);
      //println("back");
    }
  }
  if(mouseX>=width/2-w/2&&mouseX<=width/2+w/2)
  {
    if(mouseY>=100&&mouseY<=200)
    {
      SceneDirector.sceneChange(10);
      //println("募集する");
    }
    if(mouseY>=300&&mouseY<=400)
    {
      SceneDirector.sceneChange(11);
      //println("参加する");
    }
  }
}
}
