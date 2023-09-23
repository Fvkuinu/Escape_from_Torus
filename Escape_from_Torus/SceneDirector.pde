static class SceneDirector{
  static HashMap<Integer, Scene> sceneMap = new HashMap<Integer, Scene>();
  static private int currentSceneNumber  = -1;
  static private int frameCount = 0;
  static void setFirstScene(int sceneNumber){
    currentSceneNumber = sceneNumber;
  }
  static void sceneChange(int sceneNumber){
    getCurrentScene().stop();
    
    currentSceneNumber = sceneNumber;
    frameCount = -1;
  }
  static int getCurrentSceneNumber(){
    return currentSceneNumber;
  }
  static Scene getCurrentScene(){
    return sceneMap.get(currentSceneNumber);
  }
  static void setScene(int sceneNumber, Scene scene){
    sceneMap.put(sceneNumber, scene);
  }
  static int getFrameCount(){
    return frameCount;
  }
  static public void incrementFrameCount() {
    frameCount++;
  } 
}
