class Dialogue3 extends SmallGame {
  Dialogue dialogue = new Dialogue();

  String[] dialogues = {
    "[BG:shop]",
    "[PLAYER_THINK]剛剛的異常消失了……",
    "[PLAYER_THINK]代表館長說的是對的。",
    "[PLAYER_THINK]被改動的，不只一種東西。",

    "[BOSS]剛剛那些數字……恢復正常了。",

    "[PLAYER]嗯，應該只是其中一部分。",

    "[BOSS]那你要小心一點。",
    "[BOSS]最近不只數字，連書裡的文字也怪怪的。",

    "[PLAYER]文字？",

    "[BOSS]有些單字拼起來很奇怪。",
    "[BOSS]看得懂意思，但又不太對。",
  };

  Dialogue3(Event onExit) {
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
