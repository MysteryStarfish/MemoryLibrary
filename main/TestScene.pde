MapScene testScene;
class TestScene {

    MapHandler mapHandler;
    JsonReader jsonReader;
    InputReader inputReader;
    GameObject player;
    GameObject npc;
    NPCHandler npcHandler;
    SmallGamehandler gameHandler;

    TestScene(JsonReader jsonReader, InputReader inputReader) {
        this.jsonReader = jsonReader;
        this.inputReader = inputReader;
        this.npcHandler = new NPCHandler();

        testScene = new MapScene(mapHandler);

        setup();
    }

    public Scene CreatScene() {
        return testScene;
    }

    void setup() {
        gameHandler = new SmallGamehandler();
        player = CreatPlayerObject();
        npc = CreatNPCObject();
        GameObject gameHandlerObject = CreatGameHandlerObject();

        mapHandler = new MapHandler(1, 1, jsonReader, player.getComponent(PlayerMove.class), inputReader, npcHandler);
        
        testScene = new MapScene(mapHandler);
        testScene.addGameObject(player);
        testScene.addGameObject(npc);
        testScene.addGameObject(gameHandlerObject);
    }

    GameObject CreatPlayerObject() {
        GameObject player = new GameObject("Player");

        Transform t = new Transform(width/2, height/2);
        player.addComponent(t);

        Sprite s = new Sprite("Raphtalia.png", 0.2f);
        player.addComponent(s);

        PlayerMove m = new PlayerMove();
        player.addComponent(m);
        
        return player;
    }

    GameObject CreatNPCObject() {
        GameObject npc = new GameObject("NPC");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/NPC.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(2, 3, 3, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(gameHandler::Math);
        
        return npc;
    }

    GameObject CreatGameHandlerObject() {
        GameObject g = new GameObject("GameHandler");
        
        g.addComponent(gameHandler);
        
        return g;
    }
}
