MapScene testScene;
JsonReader jsonReader;
GameObject player;

void setup() {
    size(800, 600);

    player = CreatPlayerObject();
    jsonReader = new JsonReader();
    CreatTestScene();
}

void CreatTestScene() {
    MapHandler testMap;
    testMap = new MapHandler(10, 10, 0, 0, jsonReader, player.getComponent(PlayerMove.class));
    testScene = new MapScene(testMap);
    testScene.addGameObject(player);
}

GameObject CreatPlayerObject() {
    GameObject player = new GameObject("Player");

    Transform t = new Transform(width/2, height/2);
    player.addComponent(t);

    Sprite s = new Sprite("Raphtalia.png", 0.5);
    player.addComponent(s);

    PlayerMove m = new PlayerMove();
    player.addComponent(m);
    
    return player;
}

void draw() {
    testScene.update();
    //println(player.transform().position.x);
    //println(player.transform().position.y);
    //var image = loadImage("Raphtalia.png");
    //image(image, player.transform().position.x, player.transform().position.y);
}
