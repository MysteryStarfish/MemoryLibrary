class ScienceSolve extends SmallGame {
  final int GAME_WIDTH = 1024;
  final int GAME_HEIGHT = 768;
  float gameScale = 1.0f;
  float gameOffsetX = 0.0f;
  float gameOffsetY = 0.0f;

  PFont font;

  // =====================================================
  // 背景與角色
  // =====================================================

  PImage back;

  PImage playerimg;
  PImage npc;
  PImage npc4;
  PImage npc5;

  // =====================================================
  // 水循環圖片
  // =====================================================

  PImage water1, water2, water3, water4;

  // water1 = 逕流
  // water2 = 蒸發
  // water3 = 凝結
  // water4 = 降水

  // =====================================================
  // 昆蟲圖片
  // =====================================================

  PImage bug1, bug2, bug3, bug4;

  // =====================================================
  // 花朵圖片
  // =====================================================

  PImage flower1, flower2, flower3, flower4;

  // =====================================================
  // 場景
  // =====================================================

  int scene = 0;

  // 1 = 水循環
  // 3 = 昆蟲
  // 5 = 花朵
  // 6 = 結局

  // =====================================================
  // 劇情
  // =====================================================

  boolean inDialogue = true;

  int dialogueIndex = 0;

  String[] dialogues = {
    
  "[NPC]這次是什麼？",

  "[PLAYER]自然現象變得不一致。",
  "[PLAYER]順序亂了。",

  "[NPC]那就是『因果與順序』的問題。",
  "[NPC]自然本來就依照規律運作。",

  "[NPC]開花 → 發芽 → 成長",
  "[NPC]下雨 → 雲形成 → 蒸發",

  "[PLAYER]順序被顛倒了……",

  "[NPC]只要把順序恢復。",
  "[NPC]自然就會回到原本的狀態。",

  "[PLAYER]……開始吧。"
  };

  // =====================================================
  // 共用變數
  // =====================================================

  int[] player = new int[4];

  boolean[] selected = new boolean[5];

  int step = 0;

  boolean success = false;

  boolean fail = false;

  // =====================================================
  // 隨機排列
  // =====================================================

  int[] waterOrder = {1, 2, 3, 4};

  int[] bugOrder = {1, 2, 3, 4};

  int[] flowerOrder = {1, 2, 3, 4};

  // =====================================================
  // 座標
  // =====================================================

  int[] posX = {300, 700, 300, 700};

  int[] posY = {170, 170, 550, 550};

  int[] flowerPosX = {175, 395, 615, 835};

  ScienceSolve(Event onExit) {
    super(onExit);
  }

  // =====================================================
  // setup
  // =====================================================

  @Override
  void setup() {
    bgmManager.Loop("bgm_game");
    font = createFont("NotoSansTC-VariableFont_wght.ttf", 28);

    textFont(font);

    // =====================================================
    // 載入背景與角色
    // =====================================================
    String path = "assets/2Dlive/";

    back = loadImage("assets/background/library.jpg");

    playerimg = loadImage(path + "player.png");

    npc = loadImage(path + "gym.png");

    npc4 = loadImage(path + "farmer.png");

    npc5 = loadImage(path + "npc1.png");

    // =====================================================
    // 載入水循環圖片
    // =====================================================

    water1 = loadImage("water1.png");
    water2 = loadImage("water2.png");
    water3 = loadImage("water3.png");
    water4 = loadImage("water4.png");

    // =====================================================
    // 載入昆蟲圖片
    // =====================================================

    bug1 = loadImage("bug1.png");
    bug2 = loadImage("bug2.png");
    bug3 = loadImage("bug3.png");
    bug4 = loadImage("bug4.png");

    // =====================================================
    // 載入花朵圖片
    // =====================================================

    flower1 = loadImage("flower1.jpg");
    flower2 = loadImage("flower2.jpg");
    flower3 = loadImage("flower3.jpg");
    flower4 = loadImage("flower4.jpg");

    // =====================================================
    // 隨機排列
    // =====================================================

    shuffleArray(waterOrder);

    shuffleArray(bugOrder);

    shuffleArray(flowerOrder);
  }

  // =====================================================
  // draw
  // =====================================================

  @Override
  void update() {

    background(255);
    beginGameDraw();

    imageMode(CORNER);

    image(back, 0, 0, GAME_WIDTH, GAME_HEIGHT);

    // =====================================================
    // 劇情
    // =====================================================

    if (inDialogue) {

      drawDialogue();
      endGameDraw();
      return;
    }

    // =====================================================
    // 水循環
    // =====================================================

    if (scene == 1) {

      drawWaterPuzzle();
    }

    // =====================================================
    // 昆蟲
    // =====================================================

    else if (scene == 3) {

      drawBugPuzzle();
    }

    // =====================================================
    // 花朵
    // =====================================================

    else if (scene == 5) {

      drawFlowerPuzzle();
    }

    // =====================================================
    // 結局
    // =====================================================

    else if (scene == 6) {

      showEnding();
    }
    endGameDraw();

    if (scene == 7) {
      Exit();
    }
  }

// =====================================================
// 劇情畫面
// =====================================================

void drawDialogue() {

  imageMode(CORNER);

  background(0);
  image(back, 0, 0, GAME_WIDTH, GAME_HEIGHT);

  String line = dialogues[dialogueIndex];

  imageMode(CENTER);

  if (
    line.startsWith("[PLAYER]") ||
    line.startsWith("[PLAYER_THINK]")
  ) {

    drawCharacter(playerimg, 240);
  }

  else if (line.startsWith("[NPC]")) {

    drawCharacter(npc, GAME_WIDTH - 240);
  }

  else if (line.startsWith("[NPC4]")) {

    drawCharacter(npc4, GAME_WIDTH - 240);
  }

  else if (line.startsWith("[NPC5]")) {

    drawCharacter(npc5, GAME_WIDTH - 240);
  }

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

  String textLine = line;

  textLine = textLine.replace(
    "[PLAYER]",
    "玩家：\n"
  );

  textLine = textLine.replace(
    "[PLAYER_THINK]",
    "玩家（心想）：\n"
  );

  textLine = textLine.replace(
    "[NPC]",
    "館長：\n"
  );

  textLine = textLine.replace(
    "[NPC4]",
    "農夫：\n"
  );

  textLine = textLine.replace(
    "[NPC5]",
    "村民：\n"
  );

  textLine = textLine.replace(
    "[SYSTEM]",
    ""
  );

  text(
    textLine,
    80,
    GAME_HEIGHT - 190
  );

  textSize(18);

  text(
    "點擊滑鼠繼續",
    GAME_WIDTH - 220,
    GAME_HEIGHT - 70
  );
}

// =====================================================
// 人物
// =====================================================

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
// 水循環
// =====================================================

void drawWaterPuzzle() {

  drawPuzzleMessage();

  drawBigBox(120, 20, selected[1]);
  drawBigBox(520, 20, selected[2]);
  drawBigBox(120, 400, selected[3]);
  drawBigBox(520, 400, selected[4]);

  imageMode(CENTER);

  for (int i = 0; i < 4; i++) {

    int id = waterOrder[i];

    PImage img = null;

    String label = "";

    if (id == 1) {

      img = water1;
      label = "逕流";
    }

    if (id == 2) {

      img = water2;
      label = "蒸發";
    }

    if (id == 3) {

      img = water3;
      label = "凝結";
    }

    if (id == 4) {

      img = water4;
      label = "降水";
    }

    image(
      img,
      posX[i],
      posY[i],
      220,
      220
    );
    
    textSize(40);
    fill(255);
    textAlign(CENTER);
    text("水", 40,50);
    text("循", 40,100);
    text("環", 40,150);
    text(
      label,
      posX[i],
      posY[i] + 170
    );
  }
}

// =====================================================
// 昆蟲
// =====================================================

void drawBugPuzzle() {

  drawPuzzleMessage();

  drawBigBox(120, 20, selected[1]);
  drawBigBox(520, 20, selected[2]);
  drawBigBox(120, 400, selected[3]);
  drawBigBox(520, 400, selected[4]);

  imageMode(CENTER);

  for (int i = 0; i < 4; i++) {

    int id = bugOrder[i];

    PImage img = null;

    if (id == 1) img = bug1;
    if (id == 2) img = bug2;
    if (id == 3) img = bug3;
    if (id == 4) img = bug4;

    image(
      img,
      posX[i],
      posY[i] + 30,
      260,
      260
    );
    textSize(40);
    fill(255);
    textAlign(CENTER);
    text("完", 40,50);
    text("全", 40,100);
    text("變", 40,150);
    text("態", 40,200);
  }
}

// =====================================================
// 花朵
// =====================================================

void drawFlowerPuzzle() {

  drawPuzzleMessage();

  drawFlowerBox(80, 150, selected[1]);
  drawFlowerBox(300, 150, selected[2]);
  drawFlowerBox(520, 150, selected[3]);
  drawFlowerBox(740, 150, selected[4]);

  imageMode(CENTER);

  for (int i = 0; i < 4; i++) {

    int id = flowerOrder[i];

    PImage img = null;

    if (id == 1) img = flower1;
    if (id == 2) img = flower2;
    if (id == 3) img = flower3;
    if (id == 4) img = flower4;

    image(
      img,
      flowerPosX[i],
      375,
      150,
      410
    );
    textSize(40);
    fill(255);
    textAlign(CENTER);
    text("花的生長週期", 130,50);
  }
}

// =====================================================
// 訊息
// =====================================================

void drawPuzzleMessage() {

  if (fail) {

    fill(255);

    textSize(50);

    textAlign(CENTER, CENTER);

    text("答錯了！再試一次！", width/2, 40);
  }
}

// =====================================================
// 大框
// =====================================================

void drawBigBox(int x, int y, boolean state) {

  strokeWeight(5);

  if (state) {

    stroke(0, 255, 0);

  } else {

    stroke(255);
  }

  fill(255, 180);

  rect(x, y, 360, 360, 28);
}

// =====================================================
// 花框
// =====================================================

void drawFlowerBox(int x, int y, boolean state) {

  strokeWeight(5);

  if (state) {

    stroke(0, 255, 0);

  } else {

    stroke(255);
  }

  fill(255, 180);

  rect(x, y, 190, 450, 28);
}

// =====================================================
// 結局
// =====================================================

void showEnding() {

  imageMode(CORNER);

  image(back, 0, 0, GAME_WIDTH, GAME_HEIGHT);

  imageMode(CENTER);

  drawCharacter(playerimg, 240);

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
    "玩家：\n自然的記憶似乎恢復了。",
    80,
    GAME_HEIGHT - 190
  );
}

// =====================================================
// 滑鼠
// =====================================================

void mousePressed() {
  int gmx = gameMouseX();
  int gmy = gameMouseY();

  // =====================================================
  // 劇情
  // =====================================================

  if (inDialogue) {

    dialogueIndex++;

    if (dialogueIndex >= dialogues.length) {

      inDialogue = false;

      scene = 1;

      resetPuzzle();
    }

    return;
  }

  // =====================================================
  // 水循環完成
  // =====================================================

  if (scene == 1 && success) {

    scene = 3;

    success = false;

    resetPuzzle();

    return;
  }

  // =====================================================
  // 昆蟲完成
  // =====================================================

  if (scene == 3 && success) {

    scene = 5;

    success = false;

    resetPuzzle();

    return;
  }

  // =====================================================
  // 花朵完成
  // =====================================================

  if (scene == 5 && success) {

    scene = 6;

    return;
  }

  if (scene == 6) {
    scene = 7;
    return;
  }

  checkPuzzle(gmx, gmy);
}

// =====================================================
// 判定
// =====================================================

void checkPuzzle(int gmx, int gmy) {

  int number = 0;

  // =====================================================
  // 水循環與昆蟲
  // =====================================================

  if (scene == 1 || scene == 3) {

    if (
      gmx > 120 && gmx < 480 &&
      gmy > 20 && gmy < 380
    ) {

      number = 1;
    }

    else if (
      gmx > 520 && gmx < 880 &&
      gmy > 20 && gmy < 380
    ) {

      number = 2;
    }

    else if (
      gmx > 120 && gmx < 480 &&
      gmy > 400 && gmy < 760
    ) {

      number = 3;
    }

    else if (
      gmx > 520 && gmx < 880 &&
      gmy > 400 && gmy < 760
    ) {

      number = 4;
    }
  }

  // =====================================================
  // 花朵
  // =====================================================

  if (scene == 5) {

    if (
      gmx > 80 && gmx < 270 &&
      gmy > 150 && gmy < 600
    ) {

      number = 1;
    }

    else if (
      gmx > 300 && gmx < 490 &&
      gmy > 150 && gmy < 600
    ) {

      number = 2;
    }

    else if (
      gmx > 520 && gmx < 710 &&
      gmy > 150 && gmy < 600
    ) {

      number = 3;
    }

    else if (
      gmx > 740 && gmx < 930 &&
      gmy > 150 && gmy < 600
    ) {

      number = 4;
    }
  }

  if (number == 0) return;

  if (selected[number]) return;

  selected[number] = true;

  player[step] = number;

  int correct = 0;

  if (scene == 1) {

    correct = waterOrder[number - 1];
  }

  if (scene == 3) {

    correct = bugOrder[number - 1];
  }

  if (scene == 5) {

    correct = flowerOrder[number - 1];
  }

  int expected = 0;

// =====================================================
// 水循環（可從任意位置開始）
// =====================================================

if (scene == 1) {

  // 正確循環順序
  int[] cycle = {2, 3, 4, 1};

  // 第一次點擊
  if (step == 0) {

    expected = correct;
  }

  // 第二次之後
  else {

    int prevCorrect = 0;

    int prevNumber = player[step - 1];

    prevCorrect = waterOrder[prevNumber - 1];

    // 找上一個在 cycle 的位置
    int index = 0;

    for (int i = 0; i < 4; i++) {

      if (cycle[i] == prevCorrect) {

        index = i;
      }
    }

    // 下一個
    expected = cycle[(index + 1) % 4];
  }
}

  // 昆蟲
  if (scene == 3) {

    expected = step + 1;
  }

  // 花朵
  if (scene == 5) {

    expected = step + 1;
  }

  if (correct != expected) {

    fail = true;

    resetPuzzle();

    return;
  }

  fail = false;

  step++;

  if (step == 4) {

    success = true;
  }
}

// =====================================================
// 重設
// =====================================================

void resetPuzzle() {

  for (int i = 0; i < 4; i++) {

    player[i] = 0;
  }

  for (int i = 1; i <= 4; i++) {

    selected[i] = false;
  }

  step = 0;
}

// =====================================================
// 洗牌
// =====================================================

void shuffleArray(int[] arr) {

  for (int i = arr.length - 1; i > 0; i--) {

    int j = int(random(i + 1));

    int temp = arr[i];

    arr[i] = arr[j];

    arr[j] = temp;
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
