class Dialogue {
  final int GAME_WIDTH = 800;
  final int GAME_HEIGHT = 600;
  float gameScale = 1.0f;
  float gameOffsetX = 0.0f;
  float gameOffsetY = 0.0f;

  PImage back;
  PImage library;
  PImage village;
  PImage village2;
  PImage farm;
  PImage shop;
  PImage farmer;
  PImage boss;
  PImage gym;
  PImage leader;
  PImage player;
  PImage npc;
  PImage npc2;
  HashMap<String, PImage> backgrounds = new HashMap<String, PImage>();

  public Event OnExit = new Event();
  
  boolean inDialogue = true;
  DialogueScene dialogue;

  DialogueSpeaker[] speakers;
  
  // 已經幫你格式化好的對話文本陣列
  String[] dialogues;

  void setup() {
    // 載入字型（請確保 Data 資料夾有此檔案）
    var font = createFont("NotoSansTC-VariableFont_wght.ttf", 28);
    textFont(font);
    
    // 載入圖片資源
    String background_path = "assets/background/";
    back = loadImage(background_path + "black.png");
    library = loadImage(background_path + "library.jpg");
    farm = loadImage(background_path + "farm.png");
    shop = loadImage(background_path + "shop.png");
    village = loadImage(background_path + "village.png");
    village2 = loadImage(background_path + "village2.png");
    backgrounds.put("default", back);
    backgrounds.put("library", library);
    backgrounds.put("farm", farm);
    backgrounds.put("shop", shop);
    backgrounds.put("village", village);
    backgrounds.put("village2", village2);

    String character_path = "assets/2DLive/";
    farmer = loadImage(character_path + "farmer.png");
    boss = loadImage(character_path + "boss.png");
    gym = loadImage(character_path + "gym.png");
    leader = loadImage(character_path + "leader.png");
    player = loadImage(character_path + "player.png");
    npc = loadImage(character_path + "npc1.png");
    npc2 = loadImage(character_path + "npc2.png");
   

    // 初始化角色設定
    speakers = new DialogueSpeaker[] {
        new DialogueSpeaker("PLAYER", "玩家：", player, 240),
        new DialogueSpeaker("PLAYER_THINK", "玩家（心想）：", player, 240),
        new DialogueSpeaker("GYM", "館長：", gym, GAME_WIDTH - 240),
        new DialogueSpeaker("BOSS", "書店老闆：", boss, GAME_WIDTH - 240),
        new DialogueSpeaker("LEADER", "村長：", leader, GAME_WIDTH - 240),
        new DialogueSpeaker("FARMER", "農夫：", farmer, GAME_WIDTH - 240),
        new DialogueSpeaker("NPC", "村民：", npc, GAME_WIDTH - 240), 
        new DialogueSpeaker("NPC2", "村民：", npc2, GAME_WIDTH - 240), 
        new DialogueSpeaker("SYSTEM", "", null, 0)
    };
    
    OnExit.Register(inputReader::Enable);

    println("register ", OnExit);
  }

  public void SetDiaLogues(String[] dialogues) {
    this.dialogues = dialogues;
    this.dialogue = new DialogueScene(GAME_WIDTH, GAME_HEIGHT, back, speakers, dialogues);
    applyBackgroundFromLine();
  }

  public void RegisterBackground(String key, String filecharacter_path) {
    backgrounds.put(key, loadImage(filecharacter_path));
  }

  public void SetBackground(String key) {
    if (!backgrounds.containsKey(key)) return;
    var bg = backgrounds.get(key);
    // println("Set background: " + backgrounds);
    if (dialogue != null) {
      dialogue.setBackground(bg);
    }
  }

  void update() {
    background(0);
    beginGameDraw();
    dialogue.draw();
    endGameDraw();
  }

  // 處理點擊前進對話
  void mousePressed() {
    if (inDialogue) {
      dialogue.advance();
      applyBackgroundFromLine();
      if (dialogue.isFinished()) {
        inDialogue = false; // 對話結束
        Exit(); // 觸發回呼函數退出此小遊戲
      }
      return;
    }
  }

  private void applyBackgroundFromLine() {
    while (dialogue != null && !dialogue.isFinished()) {
      String line = dialogue.getCurrentLine();
      if (line == null) return;
      if (line.startsWith("[BG:")) {
        String key = extractTagValue(line);
        if (key != null) SetBackground(key);
        dialogue.advance();
        continue;
      }
      return;
    }
  }

  private String extractTagValue(String line) {
    int start = line.indexOf(':');
    int end = line.indexOf(']');
    if (start < 0 || end <= start) return null;
    return line.substring(start + 1, end);
  }

  private void Exit() {
    println("exit ", OnExit);
    if (OnExit != null) {
      OnExit.Invoke();
    }
  }

  // 以下為縮放控制
  void beginGameDraw() {
    updateGameScale();
    pushStyle();
    pushMatrix();
    resetMatrix();
    translate(gameOffsetX, gameOffsetY);
    scale(gameScale);
  }

  void endGameDraw() {
    popMatrix();
    popStyle();
  }

  void updateGameScale() {
    float scaleX = (float)width / (float)GAME_WIDTH;
    float scaleY = (float)height / (float)GAME_HEIGHT;
    gameScale = min(scaleX, scaleY);
    gameOffsetX = (width - GAME_WIDTH * gameScale) / 2.0f;
    gameOffsetY = (height - GAME_HEIGHT * gameScale) / 2.0f;
  }
}
