class MathSolve extends SmallGame {
  // --- 全域變數 ---
  String[] dialogue = {
    "館長：你回來了。", 
    "女孩：村子裡確實有問題，數字……變得不一致",
    "館長：……果然。但還不能確定，是哪一部分被動過。",
    "女孩：也就是說——從錯誤裡，找出正確。",
    "館長：沒錯。如果數字出現問題，那就代表——相關的知識被改動了。",
    "女孩：這裡的書……內容被改過了：「7+6=20」、「10-3=2」、「4×5=15」、「12÷3=6」",
    "女孩：果然……不是世界亂掉，是『答案』被改掉了。",
    "館長：只要把它們修正回正確的結果——這部分的異常，應該就會消失。",
    "女孩：……試試看吧。",
    "女孩：數學的記憶似乎恢復了。" // 結尾
  };

  int[] dialogueOwners = {1, 0, 1, 0, 1, 0, 0, 1, 0, 0};

  // 解謎數據
  String[] equations = {"7 + 6 = ?", "10 - 3 = ?", "4 × 5 = ?", "12 ÷ 3 = ?"};
  int[][] options = {{11, 13, 20}, {7, 2, 8}, {15, 20, 25}, {4, 6, 3}};
  int[] correctAnswers = {13, 7, 20, 4};

  int currentPhase = 0;      // 目前在哪一題 (0~3)
  int selectedOption = -1;   // 當前選中的選項索引
  int gameState = 0;         // 0: 對話, 1: 解謎中, 2: 答錯警告
  boolean puzzleSolved = false;

  PImage bg;
  ActorSprite[] portraits = new ActorSprite[2]; 
  int currentLine = 0; 

  MathSolve(Event onExit) {
    super(onExit);
  }

  @Override
  public void setup() {
    size(800, 600);
    textFont(createFont("Microsoft JhengHei", 24));
    bg = loadImage("library_bg.png");
    println(bg);
    portraits[0] = new ActorSprite("girl.png", 280, 400); 
    portraits[1] = new ActorSprite("old.png", 300, 450);  
  }

  @Override
  public void update() {
    image(bg, 0, 0, width, height); 
    
    if (gameState == 0) {
      drawDialogueBox();
    } else if (gameState == 1) {
      drawSingleChoiceScreen();
    } else if (gameState == 2) {
      drawErrorScene();
    }
  }

// 1. 對話介面
void drawDialogueBox() {
  int speakerIndex = dialogueOwners[currentLine];
  if (speakerIndex == 0) portraits[0].display(50, 100); 
  else portraits[1].display(450, 60); 
  
  drawUIBox();
  fill(255);
  textAlign(LEFT, TOP);
  text(dialogue[currentLine], 80, 430, 640, 110);
  drawClickHint();
}

// 2. 逐題解謎介面
void drawSingleChoiceScreen() {
  fill(0, 0, 0, 180);
  rect(0, 0, width, height);
  
  fill(255);
  textAlign(CENTER);
  textSize(28);
  text("—— 正在修復第 " + (currentPhase + 1) + " 處知識殘片 ——", width/2, 100);
  
  // 顯示題目
  textSize(48);
  text(equations[currentPhase], width/2, 220);
  
  // 顯示三個選項按鈕
  for (int i = 0; i < 3; i++) {
    float y = 320 + i * 80;
    stroke(255);
    fill(selectedOption == i ? #4CAF50 : 50, 200);
    rect(width/2 - 100, y - 35, 200, 60, 10);
    fill(255);
    textSize(32);
    text(options[currentPhase][i], width/2, y + 5);
  }
  
  drawButton(620, 520, "確認回答", #2196F3);
}

// 3. 錯誤劇情介面
void drawErrorScene() {
  fill(150, 0, 0, 200); // 紅色警告色調
  rect(0, 0, width, height);
  
  portraits[1].display(450, 60); // 館長出現警告
  
  drawUIBox();
  fill(255);
  textAlign(LEFT, TOP);
  text("館長：不對！知識的流向變得混亂了... 如果填入錯誤的答案，這部分的記憶會永久消失！", 80, 430, 640, 110);
  
  drawButton(450, 520, "重新嘗試", #FF9800);
  drawButton(620, 520, "放棄離開", #9E9E9E);
}

// --- 通用 UI 組件 ---
void drawUIBox() {
  stroke(255); 
  strokeWeight(3);
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
    textSize(24);
  }
}

@Override
// --- 滑鼠點擊邏輯 ---
public void mousePressed() {
  if (gameState == 0) {
    handleDialogueClick();
  } else if (gameState == 1) {
    handlePuzzleClick();
  } else if (gameState == 2) {
    handleErrorClick();
  }
}

void handleDialogueClick() {
  if (currentLine == 9) Exit(); // 結尾點擊離開
  else {
    currentLine++;
    if (currentLine == 9 && !puzzleSolved) {
      gameState = 1; // 進入解謎
      currentLine = 8;
    }
  }
}

void handlePuzzleClick() {
  // 選項點擊
  for (int i = 0; i < 3; i++) {
    float y = 320 + i * 80;
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > y - 35 && mouseY < y + 25) {
      selectedOption = i;
    }
  }
  
  // 確認按鈕
  if (selectedOption != -1 && mouseX > 620 && mouseX < 770 && mouseY > 520 && mouseY < 570) {
    if (options[currentPhase][selectedOption] == correctAnswers[currentPhase]) {
      // 答對了
      currentPhase++;
      selectedOption = -1;
      if (currentPhase >= 4) {
        puzzleSolved = true;
        gameState = 0;
        currentLine = 9; // 回到最後一句對話
      }
    } else {
      // 答錯了，進入錯誤劇情
      gameState = 2;
    }
  }
}

void handleErrorClick() {
  // 重新嘗試
  if (mouseX > 450 && mouseX < 600 && mouseY > 520 && mouseY < 570) {
    selectedOption = -1;
    gameState = 1; 
  }
  // 放棄離開
  if (mouseX > 620 && mouseX < 770 && mouseY > 520 && mouseY < 570) {
    Exit();
  }
}

class ActorSprite {
  PImage img; float w, h;
  ActorSprite(String p, float tw, float th) { img = loadImage(p); w = tw; h = th; }
  void display(float x, float y) { if (img != null) image(img, x, y, w, h); }
}

}
