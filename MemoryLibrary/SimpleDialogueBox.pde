class SimpleDialogueBox {
  private int gameWidth;
  private int gameHeight;
  private boolean visible = false;
  private DialogueScene dialogue;
  private HashMap<String, DialogueSpeaker> speakerMap = new HashMap<String, DialogueSpeaker>();
  private Event onClose;

  SimpleDialogueBox(int gameWidth, int gameHeight) {
    this.gameWidth = gameWidth;
    this.gameHeight = gameHeight;
  }

  public void SetSize(int gameWidth, int gameHeight) {
    this.gameWidth = gameWidth;
    this.gameHeight = gameHeight;
    float centerX = gameWidth - 240;
    for (DialogueSpeaker speaker : speakerMap.values()) {
      speaker.centerX = centerX;
    }
  }

  public void RegisterSpeaker(String key, String name, String imagePath) {
    PImage img = loadImage(imagePath);
    float centerX = gameWidth - 240;
    DialogueSpeaker speaker = new DialogueSpeaker(key, name + ":", img, centerX);
    speakerMap.put(key, speaker);
  }

  public void ShowText(String text, String personKey) {
    String line = "[" + personKey + "]" + text;
    DialogueSpeaker speaker = speakerMap.get(personKey);
    DialogueSpeaker[] speakers = (speaker != null)
      ? new DialogueSpeaker[] { speaker }
      : new DialogueSpeaker[] { new DialogueSpeaker(personKey, "", null, gameWidth - 240) };

    dialogue = new DialogueScene(gameWidth, gameHeight, null, speakers, new String[] { line });
    visible = true;
  }

  public void ShowText(String text, String personKey, Runnable onClose) {
    this.onClose = new Event();
    this.onClose.Register(onClose);
    ShowText(text, personKey);
  }

  public void Update() {
    if (!visible || dialogue == null) return;
    dialogue.draw();
  }

  public void MousePressed() {
    if (!visible || dialogue == null) return;
    dialogue.advance();
    if (dialogue.isFinished()) {
      visible = false;
      if (onClose != null) {
        onClose.Invoke();
        onClose = null;
      }
    }
  }

  public boolean IsVisible() {
    return visible;
  }
}
