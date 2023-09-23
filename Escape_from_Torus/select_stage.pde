
class selectStage extends Scene{
//ボタンの幅
int w=300;
//ボタンの高さ
int h=100;
//ボタン枠の丸さ
int r=20;
PFont mincho;
//クリア判定の配列
int[] clear=new int[4];
int bx, bdx, by, bdy;
void setup()
{
  size(700,500);
  
  //フォント読み込み
  mincho=createFont("ＭＳ ゴシック",48);
  
  //データ読み込み
  String[] lines = loadStrings("data.txt");
  
  //データ移行
  for(int i=1;i<=3;i++)
  {
    clear[i]=int(lines[i-1]);
  }
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
  
  //ステージ1ボタン
  //プレイできない場合0,プレイできる場合1
  if(clear[1]==0)
  {
    //プレイできない場合、ボタンが灰色
    fill(150);
  }
  else if(clear[1]==1)
  {
    //プレイできる場合、ボタンがピンク
    fill(178,255,250);
  }
  rect(width/2,100,w,h,r);
  
  //ステージ2ボタン
  if(clear[2]==0)
  {
    fill(150);
  }
  else if(clear[2]==1)
  {
    fill(178,255,250);
  }
  rect(width/2,250,w,h,r);
  
  //ステージ3ボタン
  if(clear[3]==0)
  {
    fill(150);
  }
  else if(clear[3]==1)
  {
    fill(178,255,250);
  }
  rect(width/2,400,w,h,r);
  
  //文字
  textAlign(CENTER,CENTER);
  textSize(30);
  fill(4,54,130);
  text("ステージ1",width/2,100);
  text("ステージ2",width/2,250);
  text("ステージ3",width/2,400);
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
      SceneDirector.sceneChange(1);
      //println("back");
    }
  }
  if(mouseX>=width/2-w/2&&mouseX<=width/2+w/2)
  {
    if(mouseY>=50&&mouseY<=150)
    {
      //プレイできる場合
      if(clear[1]==1)
      {
        SceneDirector.sceneChange(3);
        //println("ステージ1へGO!!");
      }
    }
    if(mouseY>=200&&mouseY<=300)
    {
      //プレイできる場合
      if(clear[2]==1)
      {
        SceneDirector.sceneChange(4);
        //println("ステージ2へGO!!");
      }
    }
    if(mouseY>=350&&mouseY<=450)
    {
      //プレイできる場合
      if(clear[3]==1)
      {
        SceneDirector.sceneChange(5);
        //println("ステージ3へGO!!");
      }
    }
  }
}
}
