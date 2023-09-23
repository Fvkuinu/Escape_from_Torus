public PApplet applet = this;
void settings() {
  size(700, 500,P3D);
  SceneDirector.setScene(1, new startmenu());
  SceneDirector.setScene(2, new selectStage());
  SceneDirector.setScene(3, new stage1());
  SceneDirector.setScene(4, new stage2());
  SceneDirector.setScene(5, new stage3());
  SceneDirector.setScene(6, new clear());
  SceneDirector.setScene(7, new selectKanji());
  SceneDirector.setScene(8, new selectPlayingWay1());
  SceneDirector.setScene(9, new selectPlayingWay2());
  SceneDirector.setScene(10, new torusServer());
  SceneDirector.setScene(11, new torusClient());
  SceneDirector.setScene(12, new kanjiServer());
  SceneDirector.setScene(13, new kanjiClient());
  SceneDirector.setScene(14, new victory());
  SceneDirector.setScene(15, new defeat());
  SceneDirector.setFirstScene(1);
  
}
