class Dialogue1 extends SmallGame {
  Dialogue dialogue = new Dialogue();

  String[] dialogues = {
      "[BG:shop]",
      "[BOSS]喔，你醒了啊。",
      "[PLAYER]嗯，剛剛才起來。",
      "[PLAYER]最近村子是不是發生了什麼事？",
      "[BOSS]……你也有這種感覺？", // 書店老闆（停頓一下）
      "[BOSS]我這幾天在整理帳本的時候，發現一件怪事。",
      "[SYSTEM]（書店老闆翻開了帳本）",
      "[BOSS]有些數字對不上。",
      "[PLAYER]對不上？",
      "[BOSS]像是貨物數量，明明記得是這樣——",
      "[SYSTEM]（書店老闆指著帳本的某一頁）",
      "[BOSS]但現在看起來，好像哪裡怪怪的。",
      "[PLAYER]是記錯了嗎？",
      "[BOSS]我一開始也這麼想。",
      "[BOSS]可是——",
      "[BOSS]同一筆紀錄，我重新算了好幾次，每次結果都不一樣。", // 書店老闆（皺眉）
      "[PLAYER]……結果會變？",
      "[BOSS]對。",
      "[BOSS]就好像……",
      "[BOSS]連算出來的結果都會亂掉。",
      "[PLAYER_THINK]不是單純記錯……",
      "[PLAYER_THINK]是規則出了問題。",
      "[PLAYER_THINK]如果連數字都會變……",
      "[PLAYER]妳有跟館長說過這件事嗎？",
      "[BOSS]沒有。",
      "[BOSS]不過……這種事情，應該只有圖書館能解釋吧。",
      "[SYSTEM]（書店老闆闔上了帳本）",
      "[BOSS]畢竟那裡，記錄著所有東西的『原本樣子』。",
      "[PLAYER]……我知道了。",
      "[SYSTEM]（玩家轉身準備離開）",
      "[PLAYER]我去看看。"
  };

  Dialogue1(Event onExit) {
      super(onExit);
      dialogue.OnExit.Register(this::Exit);
  }  

  void setup() {
    dialogue.setup();
    dialogue.SetDiaLogues(dialogues);
  }

  void update() {
    dialogue.update();
  }

  void mousePressed() {
    dialogue.mousePressed();
  }
}
