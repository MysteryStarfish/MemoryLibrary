class VillageScene extends Scene{

    MapScene testScene;
    MapHandler mapHandler;
    JsonReader jsonReader;
    InputReader inputReader;
    GameObject player;
    GameObject boss;
    GameObject leader;
    GameObject farmer;
    GameObject npc;
    GameObject npc2;
    NPCHandler npcHandler;
    SmallGamehandler gameHandler;
    Event SwitchToLibraryEvent;

    

    VillageScene(JsonReader jsonReader, InputReader inputReader) {
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
        boss = CreatBOSSObject();
        leader = CreatLEADERObject();
        farmer = CreatFARMERObject();
        npc = CreatNPCObject();
        npc2 = CreatNPC2Object();
        OnNextStoryStep.Register(() -> {
            UpdateInteration();
        });

        SwitchToLibraryEvent = new Event();

        GameObject gameHandlerObject = CreatGameHandlerObject();

        mapHandler = new MapHandler(10, 10, "map1", jsonReader, player.getComponent(PlayerMove.class), inputReader, npcHandler);
        
        testScene = new MapScene(mapHandler);
        testScene.addGameObject(player);
        testScene.addGameObject(boss);
        testScene.addGameObject(leader);
        testScene.addGameObject(farmer);
        testScene.addGameObject(npc);
        testScene.addGameObject(npc2);

        testScene.addGameObject(gameHandlerObject);

        var airWall = CreatAirWallObject(2, 2);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 2);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 2);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 2);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 2);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 2);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(11, 4);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(12, 4);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(13, 5);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(14, 20);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 19);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(6, 19);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 20);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 19);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 20);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(3, 19);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 20);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 21);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(2, 3);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 4);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 5);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 6);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 7);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(3, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 7);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(8, 1);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(9, 1);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(10, 1);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 2);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(11, 3);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(12, 3);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(13, 3);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 3);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 4);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 5);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 6);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(13, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(12, 7);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 7);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(11, 8);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 9);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 11);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 12);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 13);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 14);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 15);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 16);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 18);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(12, 18);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(13, 18);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(14, 18);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(15, 19);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(15, 20);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(15, 21);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(14, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(13, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(12, 22);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(11, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(11, 23);
        testScene.addGameObject(airWall);


        airWall = CreatAirWallObject(7, 23);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 22);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(6, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 22);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 22);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(2, 21);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 20);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 19);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(3, 18);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 18);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 18);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 18);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(7, 18);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 17);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 16);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 15);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(6, 15);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 15);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 15);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 15);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(2, 15);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(1, 14);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(1, 11);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(2, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(3, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(4, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(5, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(6, 10);
        testScene.addGameObject(airWall);

        airWall = CreatAirWallObject(7, 10);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 9);
        testScene.addGameObject(airWall);
        airWall = CreatAirWallObject(7, 8);
        testScene.addGameObject(airWall);
    }

    GameObject CreatPlayerObject() {
        GameObject player = new GameObject("Player");

        Transform t = new Transform(width/2, height/2);
        player.addComponent(t);

        Sprite s = new Sprite("assets/Character/main_character_down_1.png", 3f);
        player.addComponent(s);

        PlayerMove m = new PlayerMove();
        player.addComponent(m);
        
        return player;
    }

    public void Register(Runnable r) {
        this.SwitchToLibraryEvent.Register(r);
        mapHandler.SwitchToLibraryAction.Register(SwitchToLibraryEvent::Invoke);
    }

    public void SetSpawn(int x, int y) {
        if (mapHandler != null) {
            mapHandler.SetPlayerPosition(x, y);
        }
    }

    private void UpdateInteration() {
        var m = boss.getComponent(NPC.class);
        m.ClearInteraction();
        if (storyStep == 1) {
            m.AddInteraction(() -> gameHandler.RunWithOnExit(gameHandler::Dialogue1, () -> 
                {
                    m.CompleteInteraction();
                    storyStep++;
                    OnNextStoryStep.Invoke();
                }
            ));
        } else if (storyStep == 2) {
            m.AddInteraction(() -> talkBox.ShowText("算出來都亂亂的...或許館長知道些什麼", "BOSS", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 3) {
            m.AddInteraction(() -> gameHandler.RunWithOnExit(gameHandler::Dialogue3, () -> 
                {
                    m.CompleteInteraction();
                    storyStep++;
                    OnNextStoryStep.Invoke();
                }
            ));
        } else if (storyStep == 4) {
            m.AddInteraction(() -> talkBox.ShowText("說到文字，村子裡有文字的地方應該就是村口的告...\n喔對你要買書嗎！", "BOSS", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 5) {
            m.AddInteraction(() -> talkBox.ShowText("語言本身有問題嗎...難怪沒人要買書...", "BOSS", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 6) {
            m.AddInteraction(() -> talkBox.ShowText("太好了，文字記憶恢復了，那你要買書了嗎！", "BOSS", () -> { m.CompleteInteraction(); }));
        } else if (storyStep == 7) {
            m.AddInteraction(() -> talkBox.ShowText("自然的規律？應該不會影響到書的價格吧...\n總之你要買書了嗎！", "BOSS", () -> { m.CompleteInteraction(); }));
        } else {
            m.AddInteraction(() -> talkBox.ShowText("嘿！就是你，要買書嗎", "BOSS", () -> { m.CompleteInteraction(); }));
        }

        var l = leader.getComponent(NPC.class);
        l.ClearInteraction();
        if (storyStep == 1) {
            l.AddInteraction(() -> talkBox.ShowText("厚厚厚，天氣真好...你誰，你是書店老闆？", "LEADER", () -> { l.CompleteInteraction(); }));
        } else if (storyStep == 2) {
            l.AddInteraction(() -> talkBox.ShowText("厚厚厚，你要找館長？年輕人，你老花了。\n我不是館長，也沒有老花，厚厚", "LEADER", () -> { l.CompleteInteraction(); }));
        } else if (storyStep == 3) {
            l.AddInteraction(() -> talkBox.ShowText("厚厚厚，天氣真好...你誰，你是書店老闆？", "LEADER", () -> { l.CompleteInteraction(); }));
        } else if (storyStep == 4) {
            l.AddInteraction(() -> gameHandler.RunWithOnExit(gameHandler::Dialogue4, () -> 
                {
                    l.CompleteInteraction();
                    storyStep++;
                    OnNextStoryStep.Invoke();
                }
            ));
        } else if (storyStep == 5) {
            l.AddInteraction(() -> talkBox.ShowText("厚厚...嗚，眼睛不舒服。\n去問問館長是我的老花眼變重，還是告示牌怪怪的，嗚", "LEADER", () -> { l.CompleteInteraction(); }));
        } else if (storyStep == 6) {
            l.AddInteraction(() -> talkBox.ShowText("厚厚厚，我的眼睛果然沒問題，書店老...年輕人。\n我才沒看錯，呃厚厚厚", "LEADER", () -> { l.CompleteInteraction(); }));
        } else if (storyStep == 7) {
            l.AddInteraction(() -> talkBox.ShowText("厚厚厚，自然的規律被改動？\n難怪我老了，我應該很年輕的，厚厚厚", "LEADER", () -> { l.CompleteInteraction(); }));
        } else {
            l.AddInteraction(() -> talkBox.ShowText("厚厚...呼呼，呼呼（睡著了）", "LEADER", () -> { l.CompleteInteraction(); }));
        }

        var f = farmer.getComponent(NPC.class);
        f.ClearInteraction();
        if (storyStep == 1) {
            f.AddInteraction(() -> talkBox.ShowText("這把鐮刀...不是，鋤頭真不好使，書店老闆不知道有沒有想法", "FARMER", () -> { f.CompleteInteraction(); }));
        } else if (storyStep == 2) {
            f.AddInteraction(() -> talkBox.ShowText("館長？他就住...喔沒有，\"待\"在圖書館裡阿，往上走就是了", "FARMER", () -> { f.CompleteInteraction(); }));
        } else if (storyStep == 3) {
            f.AddInteraction(() -> talkBox.ShowText("喔。你學會數數了。很棒。別打擾我種田", "FARMER", () -> { f.CompleteInteraction(); }));
        } else if (storyStep == 4) {
            f.AddInteraction(() -> talkBox.ShowText("我的農作物不會長出文字，有文字的植物我想只有門口的告示牌了", "FARMER", () -> { f.CompleteInteraction(); }));
        } else if (storyStep == 5) {
            f.AddInteraction(() -> talkBox.ShowText("我的胡蘿蔔可是很甜的，一根便宜算你 1000 元...\n問問題？切，有問題去找館長", "FARMER", () -> { f.CompleteInteraction(); }));
        } else if (storyStep == 6) {
            f.AddInteraction(() -> gameHandler.RunWithOnExit(gameHandler::Dialogue6, () -> 
                {
                    f.CompleteInteraction();
                    storyStep++;
                    OnNextStoryStep.Invoke();
                }
            ));
        } else if (storyStep == 7) {
            f.AddInteraction(() -> talkBox.ShowText("快去幫我問問館長，我的作物可都是寶阿！", "FARMER", () -> { f.CompleteInteraction(); }));
        } else {
            f.AddInteraction(() -> talkBox.ShowText("我手上的鐮刀...鋤頭可是不長眼的", "FARMER", () -> { f.CompleteInteraction(); }));
        }
    }

    GameObject CreatBOSSObject() {
        GameObject npc = new GameObject("BOSS");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/Character/bookseller.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(3, 6, 13, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(() -> gameHandler.RunWithOnExit(gameHandler::Dialogue1, () -> 
            {
                m.CompleteInteraction();
                storyStep++;
                OnNextStoryStep.Invoke();
            }
        ));
        
        return npc;
    }

    GameObject CreatLEADERObject() {
        GameObject npc = new GameObject("LEADER");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/Character/leader.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(4, 19, 4, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(() -> talkBox.ShowText("厚厚厚，天氣真好...你誰，書店老闆是你?", "LEADER", () -> { m.CompleteInteraction(); }));
        
        return npc;
    }

    GameObject CreatFARMERObject() {
        GameObject npc = new GameObject("FARMER");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/Character/farmer.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(5, 6, 4, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(() -> talkBox.ShowText("這把鐮刀...不是，鋤頭真不好使，書店老闆不知道有沒有想法", "FARMER", () -> { m.CompleteInteraction(); }));
        
        return npc;
    }

    GameObject CreatNPCObject() {
        GameObject npc = new GameObject("NPC");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/Character/npc.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(6, 21, 14, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(() -> talkBox.ShowText("嘻嘻嘻", "NPC", () -> { m.CompleteInteraction(); }));
        
        return npc;
    }

    GameObject CreatNPC2Object() {
        GameObject npc = new GameObject("NPC2");

        Transform t = new Transform(width/2, height/2);
        npc.addComponent(t);

        Sprite s = new Sprite("assets/Character/npc2.png", 50, 50);
        npc.addComponent(s);

        NPC m = new NPC(7, 19, 12, npcHandler);
        npc.addComponent(m);

        m.AddInteraction(() -> talkBox.ShowText("喔。", "NPC2", () -> { m.CompleteInteraction(); }));
        
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
