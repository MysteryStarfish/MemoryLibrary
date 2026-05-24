class EnglishSolve extends SmallGame {

  final int GAME_WIDTH = 800;
  final int GAME_HEIGHT = 600;
  float gameScale = 1.0f;
  float gameOffsetX = 0.0f;
  float gameOffsetY = 0.0f;

  public EnglishSolve(Event onExit) {
    super(onExit);
  }

  PFont font;

  PImage back;
  PImage npc;
  PImage npc2;
  PImage npc3;
  PImage player;

  int gridSize = 10;
  int cellSize = 50;
  final int panelPaddingX = 80;
  final int panelPaddingY = 180;
  final int panelMargin = 20;

  int boardX;
  int boardY;

  int boardWidth;
  int boardHeight;

  char[][] grid = new char[gridSize][gridSize];
  boolean[][] found = new boolean[gridSize][gridSize];

  String[] words = {
    "BOOK",
    "APPLE",
    "TABLE",
    "CHAIR",
    "DOG",
    "RAIN"
  };

  boolean[] wordFound = new boolean[words.length];

  PVector start = null;
  PVector end = null;

  boolean selecting = false;

  boolean gameClear = false;
  int clearTime = 0;

  // ===== 劇情 =====
  boolean inDialogue = true;
  DialogueScene dialogue;

  String[] dialogues = {

  "[NPC]這次發現什麼了？",

  "[PLAYER]文字被改了。",
  "[PLAYER]拼法不對，但還能理解。",

  "[NPC]那就不是記憶片段。",
  "[NPC]是更基礎的東西……",

  "[SYSTEM]（看向書架）",

  "[NPC]語言結構。",

  "[SYSTEM]（書頁內容）",
  "[SYSTEM]BOK",
  "[SYSTEM]APLE",
  "[SYSTEM]TAEBL",
  "[SYSTEM]CHRAI",

  "[PLAYER]……少了字，或順序錯了。",
  "[PLAYER]這些原本應該是完整的單字。",

  "[NPC]只要把它們還原。",
  "[NPC]語言的異常就會消失。",

  "[PLAYER]……我知道該怎麼做了。"
  };

  @Override
  void setup() {
    bgmManager.Loop("bgm_game");
    // size(1024, 768);
    font = createFont("NotoSansTC-VariableFont_wght.ttf", 28);
    textFont(font);

    back = loadImage("assets/background/library.jpg");

    String path = "assets/2Dlive/";
    npc = loadImage(path + "gym.png");
    npc2 = loadImage(path + "boss.png");
    npc3 = loadImage(path + "leader.png");

    player = loadImage(path + "player.png");

    DialogueSpeaker[] speakers = new DialogueSpeaker[] {
      new DialogueSpeaker("PLAYER", "\u73a9\u5bb6\uff1a", player, 240),
      new DialogueSpeaker("PLAYER_THINK", "\u73a9\u5bb6\uff08\u5fc3\u60f3\uff09\uff1a", player, 240),
      new DialogueSpeaker("NPC", "\u9928\u9577\uff1a", npc, GAME_WIDTH - 240),
      new DialogueSpeaker("NPC2", "\u66f8\u5e97\u8001\u95c6\uff1a", npc2, GAME_WIDTH - 240),
      new DialogueSpeaker("NPC3", "\u6751\u9577\uff1a", npc3, GAME_WIDTH - 240),
      new DialogueSpeaker("SYSTEM", "", null, 0)
    };
    dialogue = new DialogueScene(GAME_WIDTH, GAME_HEIGHT, back, speakers, dialogues);

    int targetPanelHeight = GAME_HEIGHT - panelMargin * 2;
    int targetCellSize = (targetPanelHeight - panelPaddingY) / gridSize;
    cellSize = max(10, targetCellSize);
    boardWidth = gridSize * cellSize;
    boardHeight = gridSize * cellSize;

    // ===== 半透明面板大小 =====
    float panelWidth = boardWidth + panelPaddingX;
    float panelHeight = boardHeight + panelPaddingY;

    // ===== 面板置中 =====
    float panelX = (GAME_WIDTH - panelWidth) / 2;
    float panelY = (GAME_HEIGHT - panelHeight) / 2;

    // ===== grid 放進面板裡 =====
    boardX = int(panelX + 40);
    boardY = int(panelY + 30);

    generateGrid();
  }

  @Override
  void update() {
    background(0);
    beginGameDraw();

    // ===== 劇情 =====
    if (inDialogue) {
      dialogue.draw();
      endGameDraw();
      return;
    }

    // ===== 背景 =====
    imageMode(CORNER);
    image(back, 0, 0, GAME_WIDTH, GAME_HEIGHT);

    // ===== 過關 =====
    if (gameClear) {
      showWinScreen();
      endGameDraw();
      return;
    }

    // ===== 半透明背景板 =====
    noStroke();
    fill(255, 220);

    rect(
      boardX - 40,
      boardY - 30,
      boardWidth + 80,
      boardHeight + 180,
      25
    );

    // ===== 畫格子 =====
    for (int i = 0; i < gridSize; i++) {

      for (int j = 0; j < gridSize; j++) {

        if (found[i][j]) {

          // 已找到 → 綠色
          fill(150, 255, 150);

        } else if (
          selecting &&
          start != null &&
          int(start.x) == j &&
          int(start.y) == i
        ) {

          // 第一個點到的格子 → 紅色
          fill(255, 120, 120);

        } else {

          // 一般格子 → 白色
          fill(255);
        }

        stroke(0);

        rect(
          boardX + j * cellSize,
          boardY + i * cellSize,
          cellSize,
          cellSize
        );

        
        fill(0);

        textAlign(CENTER, CENTER);
        textSize(26);

        text(
          grid[i][j],
          boardX + j * cellSize + cellSize/2,
          boardY + i * cellSize + cellSize/2
        );
      }
    }

    // ===== 提示文字 =====
    fill(0);

    textAlign(LEFT, CENTER);
    textSize(24);

    text(
      "Find These Words:",
      boardX,
      boardY + boardHeight + 40
    );

    for (int i = 0; i < words.length; i++) {

    if (wordFound[i]) {
      fill(120);
    } else {
      fill(0);
    }

    // ===== 每排 3 個 =====
    int col = i % 3;
    int row = i / 3;

    float wordX = boardX + col * 160;
    float wordY = boardY + boardHeight + 85 + row * 40;

    text(
      words[i],
      wordX,
      wordY
    );
  }
  endGameDraw();
  }

  void drawCharacter(PImage img, float centerX) {

    float targetH = 520;

    float scale = targetH / img.height;

    float targetW = img.width * scale;

    image(
      img,
      centerX,
      GAME_HEIGHT/2 + 20,
      targetW,
      targetH
    );
  }

  // =====================================================
  // 過關畫面
  // =====================================================

  void showWinScreen() {

    imageMode(CORNER);
    image(back, 0, 0, GAME_WIDTH, GAME_HEIGHT);

    imageMode(CENTER);

    drawCharacter(player, 240);

    noStroke();

    fill(0, 190);

    rect(
      40,
      GAME_HEIGHT - 220,
      GAME_WIDTH - 80,
      180,
      20
    );

    fill(255);

    textAlign(LEFT, TOP);

    textSize(30);

    text(
      "玩家：\n英文的記憶似乎恢復了。",
      80,
      GAME_HEIGHT - 190
    );

    // ===== 自動結束 =====
    if (millis() - clearTime > 3000) {
      Exit();
    }
  }

  // =====================================================
  // 滑鼠
  // =====================================================

  void mousePressed() {
    int gmx = gameMouseX();
    int gmy = gameMouseY();

    // ===== 劇情 =====
    if (inDialogue) {
      dialogue.advance();
      if (dialogue.isFinished()) inDialogue = false;

      return;
    }

    if (gameClear) return;

    int x = (gmx - boardX) / cellSize;
    int y = (gmy - boardY) / cellSize;

    if (x < 0 || x >= gridSize ||
        y < 0 || y >= gridSize) {
      return;
    }

    if (start == null) {

    // ===== 第一點 =====
    start = new PVector(x, y);

    selecting = true;

  } else {

    // ===== 第二點 =====
    end = new PVector(x, y);

    checkSelection();

    // ===== 清除選取 =====
    start = null;
    end = null;

    selecting = false;
  }
  }

  // =====================================================
  // 判斷選字
  // =====================================================

  void checkSelection() {

    int dx = (int)end.x - (int)start.x;
    int dy = (int)end.y - (int)start.y;

    int stepX = (int)Math.signum(dx);
    int stepY = (int)Math.signum(dy);

    int len = max(abs(dx), abs(dy)) + 1;

    String selected = "";

    int x = (int)start.x;
    int y = (int)start.y;

    for (int i = 0; i < len; i++) {

      selected += grid[y][x];

      x += stepX;
      y += stepY;
    }

    String reversed =
      new StringBuilder(selected)
      .reverse()
      .toString();

    boolean correct = false;

    for (int i = 0; i < words.length; i++) {

      if (!wordFound[i] &&
        (selected.equals(words[i]) ||
        reversed.equals(words[i]))) {

        x = (int)start.x;
        y = (int)start.y;

        for (int j = 0; j < len; j++) {

          found[y][x] = true;

          x += stepX;
          y += stepY;
        }

        wordFound[i] = true;
        correct = true;
      }
    }
    if (!correct) {

    // 錯誤就不保留任何顏色
  }
    checkGameClear();
  }

  // =====================================================
  // 過關檢查
  // =====================================================

  void checkGameClear() {

    for (boolean b : wordFound) {

      if (!b) return;
    }

    gameClear = true;

    clearTime = millis();
  }

  // =====================================================
  // 產生題目
  // =====================================================

  void generateGrid() {

    // ===== 清空 =====
    for (int i = 0; i < gridSize; i++) {

      for (int j = 0; j < gridSize; j++) {

        grid[i][j] = 0;
        found[i][j] = false;
      }
    }

    // ===== 放單字 =====
    for (String word : words) {
      placeWord(word);
    }

    // ===== 補隨機字 =====
    for (int i = 0; i < gridSize; i++) {

      for (int j = 0; j < gridSize; j++) {

        if (grid[i][j] == 0) {

          grid[i][j] =
            (char)('A' + int(random(26)));
        }
      }
    }
  }

  // =====================================================
  // 放單字
  // =====================================================

  void placeWord(String word) {

    boolean placed = false;

    int attempts = 0;

    while (!placed && attempts < 1000) {

      attempts++;

      int dir = int(random(4));

      int x = int(random(gridSize));
      int y = int(random(gridSize));

      int dx = 0;
      int dy = 0;

      if (dir == 0) dx = 1;
      if (dir == 1) dx = -1;
      if (dir == 2) dy = 1;
      if (dir == 3) dy = -1;

      int nx = x;
      int ny = y;

      boolean ok = true;

      // ===== 檢查 =====
      for (int i = 0; i < word.length(); i++) {

        if (nx < 0 || nx >= gridSize ||
            ny < 0 || ny >= gridSize) {

          ok = false;
          break;
        }

        // ===== 只能覆蓋相同字 =====
        if (grid[ny][nx] != 0 &&
            grid[ny][nx] != word.charAt(i)) {

          ok = false;
          break;
        }

        nx += dx;
        ny += dy;
      }

      if (!ok) continue;

      // ===== 寫入 =====
      nx = x;
      ny = y;

      for (int i = 0; i < word.length(); i++) {

        grid[ny][nx] = word.charAt(i);

        nx += dx;
        ny += dy;
      }

      placed = true;
    }

    if (!placed) {
      println("放不下單字: " + word);
    }
  }
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

  int gameMouseX() {
    return (int)((mouseX - gameOffsetX) / gameScale);
  }

  int gameMouseY() {
    return (int)((mouseY - gameOffsetY) / gameScale);
  }
}