class Dialogue8 extends SmallGame {
  Dialogue dialogue = new Dialogue();

  String[] dialogues = {
    "[BG:library]",
    "[PLAYER_THINK]……結束了嗎？",
    "[GYM]暫時而已。",
    "[PLAYER]暫時？",
    "[GYM]這裡的異常，已經被修正。",
    "[GYM]但這種事情，不會只發生在一個地方。",
    "[SYSTEM]（館長看向書架）",
    "[GYM]世界很大，而被改動的地方……遠比你想的多。",
    "[PLAYER]所以，這只是其中一個例子？",
    "[GYM]沒錯。",
    "[GYM]有人，在各地改寫這個世界。",
    "[GYM]他們不會留下名字，也不會留下痕跡。",
    "[GYM]你能看到的——",
    "[GYM]只有被扭曲的結果。",
    "[PLAYER]所以我們只能一個地方一個地方修正。",
    "[SYSTEM]（館長點頭）",
    "[GYM]目前是這樣。",
    "[PLAYER]……雖然不知道對方是誰。",
    "[PLAYER]但至少，這裡已經恢復正常了。",
    "[GYM]記住。",
    "[GYM]你修正的，不只是錯誤。",
    "[GYM]而是讓世界回到『應該存在的樣子』。",
    "[PLAYER]我原本就打算離開這裡。",
    "[PLAYER]……現在看來，不能停下來了。", // 玩家（停頓）
    "[GYM]旅途不會輕鬆。",
    "[PLAYER]我知道。",
    "[PLAYER]但如果沒有人去做，事情只會越來越糟。",
    "[BG:default]",
    "[SYSTEM]（主角回頭看了一眼）",
    "[PLAYER_THINK]這裡已經沒問題了。",
    "[PLAYER_THINK]接下來——",
    "[PLAYER]去下一個地方吧。",
    "[SYSTEM]當世界的記憶被改寫——",
    "[SYSTEM]總會有人，將它找回。"
};

  Dialogue8(Event onExit) {
      super(new Event());
      dialogue.OnExit.Register(() -> {gamePhase = 3; bgmManager.Loop("bgm_game"); });
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
