class DialogueSpeaker {
  String tag;
  String name;
  PImage image;
  float centerX;

  DialogueSpeaker(String tag, String name, PImage image, float centerX) {
    this.tag = tag;
    this.name = name;
    this.image = image;
    this.centerX = centerX;
  }
}

class DialogueScene {
  private int gameWidth;
  private int gameHeight;
  private PImage background;
  private DialogueSpeaker[] speakers;
  private String[] lines;
  private int index = 0;

  private float boxX = 40;
  private float boxHeight = 180;
  private float boxRadius = 20;
  private float textX = 80;
  private float textTopOffset = 190;
  private float hintXOffset = 220;
  private float hintYOffset = 70;
  private float characterTargetH = 520;

  DialogueScene(int gameWidth, int gameHeight, PImage background, DialogueSpeaker[] speakers, String[] lines) {
    this.gameWidth = gameWidth;
    this.gameHeight = gameHeight;
    this.background = background;
    this.speakers = speakers;
    this.lines = lines;
  }

  public void draw() {
    pushStyle();
    pushMatrix();
    if (background != null) {
      imageMode(CORNER);
      image(background, 0, 0, gameWidth, gameHeight);
    }

    if (lines == null || lines.length == 0) return;
    if (index >= lines.length) return;

    String line = lines[index];
    String tag = parseTag(line);
    String content = stripTag(line);
    DialogueSpeaker speaker = findSpeaker(tag);

    imageMode(CENTER);
    if (speaker != null && speaker.image != null) {
      drawCharacter(speaker.image, speaker.centerX);
    }

    noStroke();
    fill(0, 190);
    rect(
      boxX,
      gameHeight - 220,
      gameWidth - 80,
      boxHeight,
      boxRadius
    );

    fill(255);
    textAlign(LEFT, TOP);
    textSize(30);

    String label = (speaker != null && speaker.name != null && speaker.name.length() > 0)
      ? speaker.name + "\n"
      : "";

    text(
      label + content,
      textX,
      gameHeight - textTopOffset
    );

    textSize(18);
    text(
      "\u9ede\u64ca\u6ed1\u9f20\u7e7c\u7e8c",
      gameWidth - hintXOffset,
      gameHeight - hintYOffset
    );
    popMatrix();
    popStyle();
  }

  public void setBackground(PImage background) {
    this.background = background;
    // println("DialogueScene setBackground: " + background);
  }

  public String getCurrentLine() {
    if (lines == null || index < 0 || index >= lines.length) return null;
    return lines[index];
  }

  public void advance() {
    if (lines == null || lines.length == 0) return;
    index++;
  }

  public boolean isFinished() {
    return lines == null || index >= lines.length;
  }

  public void reset() {
    index = 0;
  }

  private DialogueSpeaker findSpeaker(String tag) {
    if (tag == null) return null;
    if (speakers == null) return null;
    for (int i = 0; i < speakers.length; i++) {
      if (tag.equals(speakers[i].tag)) return speakers[i];
    }
    return null;
  }

  private String parseTag(String line) {
    if (line == null) return null;
    if (!line.startsWith("[")) return null;
    int end = line.indexOf(']');
    if (end <= 0) return null;
    return line.substring(1, end);
  }

  private String stripTag(String line) {
    if (line == null) return "";
    if (!line.startsWith("[")) return line;
    int end = line.indexOf(']');
    if (end <= 0 || end + 1 >= line.length()) return "";
    return line.substring(end + 1);
  }

  private void drawCharacter(PImage img, float centerX) {
    float scale = characterTargetH / img.height;
    float targetW = img.width * scale;
    image(
      img,
      centerX,
      gameHeight / 2.0f + 20,
      targetW,
      characterTargetH
    );
  }
}
