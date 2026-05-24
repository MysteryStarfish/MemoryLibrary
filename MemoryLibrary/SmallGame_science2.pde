class Science2Solve extends SmallGame {
  final int GAME_WIDTH = 800;
  final int GAME_HEIGHT = 600;
  float gameScale = 1.0f;
  float gameOffsetX = 0.0f;
  float gameOffsetY = 0.0f;

  // --- 全域變數 ---
  String[] dialogue = {
    "館長：這次是什麼？", 
    "女孩：自然現象變得不一致，順序亂了。",
    "館長：那就是『因果與順序』的問題。自然本來就依照規律運作。",
    "館長：一旦順序錯亂，就會出現這種現象。",
    "女孩：書頁內容寫著：「開花 → 發芽 → 成長」、「下雨 → 雲形成 → 蒸發」...",
    "女孩：順序被顛倒了……這些原本應該是連續的過程。",
    "館長：只要把順序恢復，自然就會回到原本的狀態。",
    "女孩：……開始吧。",
    "女孩：自然的記憶似乎恢復了。" 
  };
  int[] dialogueOwners = {1, 0, 1, 1, 0, 0, 1, 0, 0};

  // 謎題數據
  String[][] allOptions = {
    {"開花", "發芽", "成長"}, 
    {"下雨", "雲形成", "蒸發"}
  };
  String[][] allCorrect = {
    {"發芽", "成長", "開花"}, 
    {"蒸發", "雲形成", "下雨"}
  };

  // 拖拽與位置控制
  float[] blockX = new float[3];
  float[] blockY = new float[3];
  float[] startX = {200, 400, 600}; // 下方初始 X
  float startY = 450;               // 下方初始 Y
  float[] slotX = {200, 400, 600};  // 上方目標 X
  float slotY = 250;                // 上方目標 Y

  int draggingIdx = -1;
  int currentPhase = 0; 
  int gameState = 0;    // 0: 對話, 1: 解謎, 2: 錯誤劇情
  int currentLine = 0;
  boolean puzzleSolved = false;

  PImage bg;
  ActorSprite[] portraits = new ActorSprite[2];

  Science2Solve(Event onExit) {
    super(onExit);
  }

  @Override
  public void setup() {
    bgmManager.Loop("bgm_game");
    textFont(createFont("Microsoft JhengHei", 24));
    String path = "assets/2Dlive/";
    bg = loadImage("assets/background/library.jpg"); 
    portraits[0] = new ActorSprite(path + "player.png", 0.5f); 
    portraits[1] = new ActorSprite(path + "gym.png", 0.5f);
    resetBlocks();
  }

  @Override
  public void update() {
    beginGameDraw();
    background(0);
    image(bg, 0, 0, GAME_WIDTH, GAME_HEIGHT);
    
    if (gameState == 0) {
      drawDialogueBox();
    } else if (gameState == 1) {
      drawDragToSlotPuzzle();
    } else if (gameState == 2) {
      drawErrorScene();
    }
    endGameDraw();
  }

// 繪製「從下往上填空」介面
  void drawDragToSlotPuzzle() {
  fill(0, 0, 0, 200);
  rect(0, 0, GAME_WIDTH, GAME_HEIGHT);
  
  fill(255);
  textAlign(CENTER, TOP);
  textSize(26);
  text("—— 請將正確的順序拖移至上方框中 ——", GAME_WIDTH/2, 50);
  text("第 " + (currentPhase+1) + " 題", GAME_WIDTH/2, 90);
  
  // 1. 繪製上方答案槽 (目標區)
  for (int i = 0; i < 3; i++) {
    stroke(255, 150);
    strokeWeight(2);
    fill(255, 20); // 槽的底色
    rect(slotX[i] - 85, slotY - 35, 170, 70, 5);
    
    fill(255, 100);
    textSize(16);
    text("步驟 " + (i+1), slotX[i], slotY + 45);
    
    // 箭頭
    if (i < 2) {
      textSize(30);
      text("→", slotX[i] + 100, slotY - 5);
    }
  }

  // 2. 繪製下方答案區 (提示文字)
  fill(255, 150);
  textSize(18);
  text("候選答案區", GAME_WIDTH/2, startY + 80);

  // 3. 繪製可拖拽的方塊
  for (int i = 0; i < 3; i++) {
    if (i == draggingIdx) {
      blockX[i] = gameMouseX();
      blockY[i] = gameMouseY();
      fill(#FFD700); 
    } else {
      fill(255);
    }
    
    stroke(255);
    rect(blockX[i] - 80, blockY[i] - 30, 160, 60, 10);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(24);
    text(allOptions[currentPhase][i], blockX[i], blockY[i] - 5);
  }
  
  drawButton(620, 520, "確認修復", #2196F3);
}

  void drawErrorScene() {
  fill(100, 0, 0, 220);
  rect(0, 0, GAME_WIDTH, GAME_HEIGHT);
  portraits[1].display(450, 60); 
  drawUIBox();
  fill(255);
  textAlign(LEFT, TOP);
  text("館長：時空的因果被扭曲了！這不是正確的規律，快點修正，否則這個現象會固化！", 80, 430, 640, 110);
  drawButton(450, 520, "重新嘗試", #FF9800);
  drawButton(620, 520, "放棄離開", #9E9E9E);
}

  void drawDialogueBox() {
  int speakerIdx = dialogueOwners[currentLine];
  if (speakerIdx == 0) portraits[0].display(-100, -50); 
  else portraits[1].display(300, -50); 
  drawUIBox();
  fill(255);
  textAlign(LEFT, TOP);
  text(dialogue[currentLine], 80, 430, 640, 110);
  drawClickHint();
}

  void drawUIBox() {
  stroke(255);
  fill(0, 0, 0, 220); 
  rect(50, 400, 700, 150, 15); 
}

  void drawButton(float x, float y, String label, color c) {
  stroke(255);
  fill(c, 220);
  rect(x, y, 150, 50, 10);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(label, x + 75, y + 25);
}

  void drawClickHint() {
  if (frameCount % 60 < 30) {
    textAlign(RIGHT);
    textSize(16);
    text("▼ 點擊繼續", 720, 520);
  }
}

  public void mousePressed() {
  int gmx = gameMouseX();
  int gmy = gameMouseY();
  if (gameState == 0) {
    handleDialogueClick();
  } else if (gameState == 1) {
    for (int i = 0; i < 3; i++) {
      if (dist(gmx, gmy, blockX[i], blockY[i]) < 60) {
        draggingIdx = i;
        break;
      }
    }
    if (gmx > 620 && gmx < 770 && gmy > 520 && gmy < 570) checkResult();
  } else if (gameState == 2) {
    handleErrorClick();
  }
}

  public void mouseReleased() {
  if (draggingIdx != -1) {
    boolean snapped = false;
    // 檢查是否靠近任何一個槽位 (上方)
    for (int i = 0; i < 3; i++) {
      if (dist(blockX[draggingIdx], blockY[draggingIdx], slotX[i], slotY) < 80) {
        blockX[draggingIdx] = slotX[i];
        blockY[draggingIdx] = slotY;
        snapped = true;
        break;
      }
    }
    // 如果沒吸附到槽位，彈回下方初始位置
    if (!snapped) {
      blockX[draggingIdx] = startX[draggingIdx];
      blockY[draggingIdx] = startY;
    }
    draggingIdx = -1;
  }
}

  void checkResult() {
  String[] playerOrder = {"", "", ""};
  // 判定哪些塊進了哪些槽
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (blockX[i] == slotX[j] && blockY[i] == slotY) {
        playerOrder[j] = allOptions[currentPhase][i];
      }
    }
  }
  
  boolean correct = true;
  for (int i = 0; i < 3; i++) {
    if (!playerOrder[i].equals(allCorrect[currentPhase][i])) correct = false;
  }
  
  if (correct) {
    currentPhase++;
    if (currentPhase >= 2) {
      puzzleSolved = true;
      gameState = 0;
      currentLine = 8;
    } else {
      resetBlocks(); // 進入下一題
    }
  } else {
    gameState = 2;
  }
}

  void resetBlocks() {
  for (int i = 0; i < 3; i++) {
    blockX[i] = startX[i];
    blockY[i] = startY;
  }
}

  void handleDialogueClick() {
  if (currentLine == 8) Exit();
  else {
    currentLine++;
    if (currentLine == 8 && !puzzleSolved) {
      gameState = 1;
      currentLine = 7;
      resetBlocks();
    }
  }
}

  void handleErrorClick() {
  int gmx = gameMouseX();
  int gmy = gameMouseY();
  if (gmx > 450 && gmx < 600 && gmy > 520 && gmy < 570) {
    resetBlocks();
    gameState = 1;
  }
  if (gmx > 620 && gmx < 770 && gmy > 520 && gmy < 570) Exit();
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

  class ActorSprite {
    PImage img; float w, h;
    ActorSprite(String p, float tw, float th) { img = loadImage(p); w = tw; h = th; }
    ActorSprite(String p, float scale) { 
      img = loadImage(p); 
      w = img.width * scale; 
      h = img.height * scale; 
    }
    void display(float x, float y) { if (img != null) image(img, x, y, w, h); }
  }
}
