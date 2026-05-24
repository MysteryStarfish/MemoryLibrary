class Dialogue4 extends SmallGame {
  Dialogue dialogue = new Dialogue();

  String[] dialogues = {
    "[BG:village2]",
    "[LEADER]你來得正好。",

    "[PLAYER]怎麼了？",

    "[LEADER]村口的告示牌，被人改過了。",
    "[LEADER]內容還在，但字有點不對。",

    "[PLAYER]不對是指？",

    "[LEADER]像是拼錯，但又不是完全錯。",
    "[LEADER]看得懂……卻讓人不舒服。",

    "[PLAYER_THINK]數字之後，是文字……",
    "[PLAYER_THINK]不是消失，而是被『改過』。",
    "[PLAYER_THINK]讓人看得懂，但不完全正確。",

    "[PLAYER]如果是這樣——",
    "[PLAYER]問題應該出在『語言本身』。",
  };

  Dialogue4(Event onExit) {
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
