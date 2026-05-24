class Dialogue0 extends SmallGame {
  Dialogue dialogue = new Dialogue();

  String[] dialogues = {
    "[BG:default]",
    "[SYSTEM]這個世界的記憶，曾經是完整的。",
    "[SYSTEM]直到某一天——",
    "[SYSTEM]有人開始改寫它。",
    "[SYSTEM]而有些人，選擇踏上旅途，將它修復。",
    "[BG:village]",
    "[PLAYER]……嗯……",
    "[PLAYER]頭……好痛……",
    "[SYSTEM]（玩家慢慢坐起來）",
    "[PLAYER]我剛剛……是在路上嗎？",
    "[PLAYER]……不對，我明明準備離開村子了……", // 玩家（停頓）
    "[SYSTEM]（玩家環顧四周）",
    "[PLAYER]這裡是……村裡？",
    "[PLAYER]奇怪……",
    "[PLAYER]總覺得哪裡不太對……",
    "[SYSTEM]（遠處傳來模糊的聲音）",
    "[PLAYER]……剛剛那是誰在說話？",
    "[PLAYER]……不對……剛剛明明有人……", // 玩家（停頓）
    "[SYSTEM]（門被敲響）",
    "[GYM]醒了嗎？",
    "[PLAYER]……這聲音？",
    "[SYSTEM]（玩家打開門）",
    "[PLAYER]館長？",
    "[GYM]看來你還記得我。",
    "[PLAYER]你怎麼會來？你不是很少離開圖書館嗎？",
    "[GYM]確實如此。", // 館長（輕笑）
    "[GYM]但這次的情況，有點不一樣。",
    "[SYSTEM]（館長看向周圍）",
    "[GYM]你應該也感覺到了吧？",
    "[PLAYER]……你是說，剛剛那種奇怪的感覺？",
    "[GYM]不只是感覺。",
    "[GYM]這個村子，已經開始『偏離原本的樣子』了。",
    "[PLAYER]偏離？",
    "[GYM]有些東西，被改掉了。",
    "[GYM]你應該知道，這個世界的記憶，並不是絕對穩定的。",
    "[PLAYER]……我知道。",
    "[PLAYER]有人，會去動它。",
    "[GYM]沒沒錯。", // 館長（點頭）
    "[GYM]而這一次——",
    "[GYM]他們來過這裡了。",
    "[PLAYER]……所以我才會昏倒？",
    "[GYM]很有可能。",
    "[GYM]你運氣不錯，只是被波及。",
    "[GYM]……有些人，甚至不會察覺自己失去了什麼。", // 館長（停頓）
    "[GYM]我這幾天觀察到——",
    "[GYM]村民的記憶開始出現偏差。",
    "[GYM]有人記錯事情，有人忘記過去。",
    "[GYM]甚至……同一件事，會有兩種不同說法。",
    "[PLAYER]……所以，你來找我，是要我幫忙？",
    "[GYM]我不會替你決定。",
    "[SYSTEM]（館長看著玩家）",
    "[GYM]但你是冒險者。",
    "[GYM]這種事情，你應該很清楚該怎麼做。",
    "[GYM]如果你想弄清楚發生了什麼——",
    "[GYM]去和村民談談吧。",
    "[GYM]他們的話，可能彼此矛盾。",
    "[GYM]但正因如此，才更接近真相。",
    "[PLAYER]……我明白了。",
    "[SYSTEM]（玩家轉身準備離開）",
    "[PLAYER_THINK]既然事情發生在這裡，我也不可能當作沒看到。",
    "[PLAYER_THINK]……就從村子開始吧。", // 玩家（停頓）
    "[GYM]記住——", // 館長（在後方）
    "[GYM]不要只相信第一個答案。",
    "[BG:village2]",
    "[PLAYER]……這裡明明是我待了一陣子的地方。",
    "[PLAYER]卻有種說不上來的違和感。",
    "[SYSTEM]（看向四周）",
    "[PLAYER]館長說的沒錯……",
    "[PLAYER]先找人問問看。"
  };

  Dialogue0(Event onExit) {
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
