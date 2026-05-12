abstract class Scene {
    ArrayList<GameObject> gameObjects;
  
    public Scene() {
        gameObjects = new ArrayList();
    }
    void addGameObject(GameObject gameObject) {
        gameObjects.add(gameObject);
    }

    void start() {
        for (var gameObject : gameObjects) {
            //gameObject.start();
        }
    }

    void update() {
        for (var gameObject : gameObjects) {
            gameObject.update();
        }
        gameObjects.removeIf(go -> go.isDestroyed);
    }
}
