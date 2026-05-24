class Dialogue6 extends SmallGame {
  Dialogue dialogue = new Dialogue();

  String[] dialogues = {
      "[BG:farm]",
      "[PLAYER_THINK]語言也恢復了……",
      "[PLAYER_THINK]代表館長說的是對的。",
      "[PLAYER_THINK]被改動的，不只一種東西。",

      "[FARMER]你來得正好，我正覺得奇怪。",

      "[PLAYER]發生什麼事？",

      "[FARMER]我種的作物長得不對。",

      "[PLAYER]不對是指？",

      "[FARMER]明明昨天才剛發芽，今天卻像長了好幾天。",
      "[FARMER]但有些又完全沒變。",

      "[PLAYER]生長速度不一致？",

      "[FARMER]對。",
      "[FARMER]照理說應該有順序，但現在完全亂了。",
      "[FARMER]像是……時間被打亂一樣。",

      "[NPC]最近的天氣也怪怪的。",

      "[PLAYER]怎麼說？",

      "[NPC]剛剛明明下過雨，地卻是乾的。",
      "[NPC]但有些地方反而是濕的。",

      "[PLAYER]……不符合情況。",

      "[PLAYER_THINK]作物的生長、天氣的變化……",
      "[PLAYER_THINK]原本應該都有固定順序。",
      "[PLAYER_THINK]現在卻變得混亂。",

      "[PLAYER]不是記憶，也不是文字。",
      "[PLAYER]是自然的規律……被改動了。",
  };

  Dialogue6(Event onExit) {
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
