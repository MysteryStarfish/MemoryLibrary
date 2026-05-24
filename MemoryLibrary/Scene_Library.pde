class LibraryScene extends Scene{

    MapScene testScene;
    MapHandler mapHandler;
    JsonReader jsonReader;
    InputReader inputReader;
    GameObject player;
    GameObject npc;
    NPCHandler npcHandler;
    SmallGamehandler gameHandler;
    Event SwitchToVillageEvent;

    LibraryScene(JsonReader jsonReader, InputReader inputReader) {
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
        npc = CreatGYMObject();
        SwitchToVillageEvent = new Event();
        OnNextStoryStep.Register(() -> {
            UpdateInteration();
        });

        GameObject gameHandlerObject = CreatGameHandlerObject();

        mapHandler = new MapHandler(10, 10, "map2", jsonReader, player.getComponent(PlayerMove.class), inputReader, npcHandler);

        testScene = new MapScene(mapHandler);
        testScene.addGameObject(player);
        testScene.addGameObject(npc);
        testScene.addGameObject(gameHandlerObject);

        var airWall = CreatAirWallObject(10, 8);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(10, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 8);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(12, 6);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(13, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 6);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(15, 6);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(16, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(16, 8);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(9, 6);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(8, 6);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 8);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 8);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 9);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 11);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 12);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 13);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 14);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 15);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 16);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(5, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(8, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(9, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(10, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(12, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(13, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(15, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(16, 17);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(9, 11);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(9, 12);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(8, 11);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(8, 12);
        testScene.addGameObject(airWall);
    }

    GameObject CreatPlayerObject() {
        GameObject player = new GameObject("Player");

        Transform t = new Transform(width/2, height/2);
        player.addComponent(t);

        Sprite s = new Sprite("assets/Character/main_character_down_1.png", 48, 48);
        player.addComponent(s);

        PlayerMove m = new PlayerMove();
        player.addComponent(m);
        
        return player;
    }

    public void Register(Runnable r) {
        this.SwitchToVillageEvent.Register(r);
        mapHandler.SwitchToVillageAction.Register(SwitchToVillageEvent::Invoke);
    }

    public void SetSpawn(int x, int y) {
        if (mapHandler != null) {
            mapHandler.SetPlayerPosition(x, y);
        }
    }

    private void UpdateInteration() {
        var m = npc.getComponent(NPC.class);
        m.ClearInteraction();
        // println("story step: " + storyStep);
        if (storyStep == 1) {
            m.AddInteraction(() -> talkBox.ShowText("前陣子書店老闆說他不會算數了，但...他明明是數學系出生阿...", "GYM", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 2) {
            // println("Starting math game...");
            m.AddInteraction(() -> gameHandler.RunWithOnExit(
                gameHandler::Math,
                () -> {
                    m.CompleteInteraction();
                    storyStep++;
                    bgmManager.Loop("bgm_library");
                    OnNextStoryStep.Invoke();
                }
            ));
        } else if (storyStep == 3) {
            m.AddInteraction(() -> talkBox.ShowText("書店老闆想謝謝你，希望沒有其他人也遇到同樣的問題", "GYM", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 4) {
            m.AddInteraction(() -> talkBox.ShowText("看起來文字也出現異動了，希望不是因為村長看太多電腦老花了...", "GYM", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 5) {
            m.AddInteraction(() -> gameHandler.RunWithOnExit(
                gameHandler::English,
                () -> {
                    m.CompleteInteraction();
                    storyStep++;
                    bgmManager.Loop("bgm_library");
                    OnNextStoryStep.Invoke();
                }
            ));
        } else if (storyStep == 6) {
            m.AddInteraction(() -> talkBox.ShowText("農夫說他之前是當工程師的，我猜他賺飽了，可以陪他多聊天", "GYM", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 7) {
            var r = int(random(2));
            if (r == 0) {
                m.AddInteraction(() -> gameHandler.RunWithOnExit(
                    gameHandler::Science,
                    () -> {
                        m.CompleteInteraction();
                        storyStep++;
                        bgmManager.Loop("bgm_library");
                        gameHandler.Dialogue8();
                    }
                ));
            } else {
                m.AddInteraction(() -> gameHandler.RunWithOnExit(
                    gameHandler::Science2,
                    () -> {
                        m.CompleteInteraction();
                        storyStep++;
                        bgmManager.Loop("bgm_library");
                        gameHandler.Dialogue8();
                    }
                ));
            }
        } 
    }

    GameObject CreatGYMObject() {
        GameObject npc = new GameObject("GYM");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/Character/farmer.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(2, 11, 7, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(() -> talkBox.ShowText("前陣子書店老闆說他不會算數了，但...他明明是數學系出生阿...", "GYM", () -> { m.CompleteInteraction(); }));

        return npc;
    }

    GameObject CreatAirWallObject(int x, int y) {
        GameObject npc = new GameObject("MockNPC");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        NPC m = new NPC(-1, y, x, npcHandler);
        npc.addComponent(m);
        
        return npc;
    }

    

    GameObject CreatGameHandlerObject() {
        GameObject g = new GameObject("GameHandler");
        
        g.addComponent(gameHandler);
        
        return g;
    }
}
