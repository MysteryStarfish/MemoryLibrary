abstract class Scene {
    ArrayList<GameObject> gameObjects;
    ArrayList<Runnable> OnUpdate;
  
    public Scene() {
        gameObjects = new ArrayList();
        OnUpdate = new ArrayList();
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
        for (var action : OnUpdate) {
            action.run();
            // println("hi");
        }
        for (var gameObject : gameObjects) {
            gameObject.update();
            // println("hi");
        }
        gameObjects.removeIf(go -> go.isDestroyed);
    }

    void mousePressed() {
        for (var gameObject : gameObjects) {
            gameObject.mousePressed();
        }
    }

    void mouseReleased() {
        for (var gameObject : gameObjects) {
            gameObject.mouseReleased();
        }
    }

    public void addOnUpdate(Runnable action) {
        OnUpdate.add(action);
    }
}
