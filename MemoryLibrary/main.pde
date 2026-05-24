Scene currentScene;
JsonReader jsonReader;
InputReader inputReader;
MathSolve mathSolve;
final int BASE_WIDTH = 1152;
final int BASE_HEIGHT = 768;
LibraryScene libraryScene;
VillageScene villageScene;
int storyStep = 1;
Event OnNextStoryStep = new Event();
Dialogue0 dialogue0;
boolean inDialogue0 = true;
int gamePhase = 1; // 1: intro, 2: gameplay, 3: end
AudioManager bgmManager;
AudioManager soundEffectManager;

SimpleDialogueBox talkBox;

void audio_setup() {
    bgmManager = new AudioManager(this);
    bgmManager.LoadAudio("bgm_village", "assets/audio/bgm_village.wav");
    bgmManager.LoadAudio("bgm_library", "assets/audio/bgm_library.wav");
    bgmManager.LoadAudio("bgm_game", "assets/audio/bgm_game.wav");
    bgmManager.LoadAudio("bgm_start", "assets/audio/bgm_start.wav");

    soundEffectManager = new AudioManager(this);
    soundEffectManager.LoadAudio("sfx_walk", "assets/audio/sfx_walk.wav");
    soundEffectManager.LoadAudio("sfx_start_button", "assets/audio/sfx_start_button.wav");
    soundEffectManager.LoadAudio("sfx_interacte", "assets/audio/sfx_interacte.wav");
}

void talkBox_setup() {
    talkBox = new SimpleDialogueBox(BASE_WIDTH, BASE_HEIGHT);
    talkBox.RegisterSpeaker("NPC", "村民", "assets/2Dlive/npc1.png");
    talkBox.RegisterSpeaker("GYM", "館長", "assets/2Dlive/gym.png");
    talkBox.RegisterSpeaker("BOSS", "書店老闆", "assets/2Dlive/boss.png");
    talkBox.RegisterSpeaker("LEADER", "村長", "assets/2Dlive/leader.png");
    talkBox.RegisterSpeaker("FARMER", "農夫", "assets/2Dlive/farmer.png");
    talkBox.RegisterSpeaker("NPC2", "村民2", "assets/2Dlive/npc2.png");
}

void talkBox_update() {
    if (talkBox.IsVisible()) {
        talkBox.Update();
    }
}

void talkBox_mousePressed() {
    if (talkBox.IsVisible()) {
        talkBox.MousePressed();
        return;
    }
}

ClickRegion region;

void setup() {
    pixelDensity(1);
    size(1536, 1024, P2D);
    noSmooth();
    surface.setLocation(100, 100);
    changeAppIcon();
    audio_setup();
    bgmManager.Loop("bgm_start");

    region = new ClickRegion(1536/2 - 275, 1024/2 - 100, 550, 180, () -> {
        soundEffectManager.PlaySound("sfx_start_button");
        gamePhase = 2;
        game_setup();
    });
}

void draw() {
  if (gamePhase == 1) {
    image(loadImage("assets/background/start.png"), 0, 0, width, height);
  } else if (gamePhase == 2) {
    game_draw();
  } else if (gamePhase == 3) {
    image(loadImage("assets/background/end.png"), 0, 0, width, height);
  }
}

void game_setup() {
    init();

    libraryScene = new LibraryScene(jsonReader, inputReader);
    libraryScene.Register(this::switchToVillage);
    villageScene = new VillageScene(jsonReader, inputReader);
    villageScene.Register(this::switchToLibrary);
    currentScene = villageScene.CreatScene();

    Event introExit = new Event();
    introExit.Register(this::exitDialogue0);
    introExit.Register(() -> bgmManager.Loop("bgm_village"));
    dialogue0 = new Dialogue0(introExit);
    dialogue0.setup();

    talkBox = new SimpleDialogueBox(BASE_WIDTH, BASE_HEIGHT);
    talkBox_setup();

    JsonReader reader = new JsonReader();
    reader.ReadMapJson("map1");
}

void init() {
    jsonReader = new JsonReader();
    inputReader = new InputReader();
}

void game_draw() {
    background(10, 10, 10);
    pushMatrix();
    float scaleX = (float)width / (float)BASE_WIDTH;
    float scaleY = (float)height / (float)BASE_HEIGHT;
    float viewScale = min(scaleX, scaleY);
    float offsetX = (width - BASE_WIDTH * viewScale) / 2.0f;
    float offsetY = (height - BASE_HEIGHT * viewScale) / 2.0f;
    translate(offsetX, offsetY);
    scale(viewScale);
    if (inDialogue0) {
        dialogue0.update();
    } else {
        currentScene.update();
        talkBox_update();
    }
    popMatrix();
    if (!inDialogue0) {
        inputReader.update();
    }
}

void keyPressed() {
    if (!inDialogue0) {
        inputReader.keyPressed();
    }
}

void keyReleased() {
    if (!inDialogue0) {
        inputReader.keyReleased();
    }
}

void mousePressed() {
    if (gamePhase == 1) {
        region.HandleClick(mouseX, mouseY);
        return;
    }
    if (inDialogue0) {
        dialogue0.mousePressed();
    } else {
        currentScene.mousePressed();
        talkBox_mousePressed();
    }
}

void mouseReleased() {
    if (!inDialogue0) {
        currentScene.mouseReleased();
    }
}

void exitDialogue0() {
    inDialogue0 = false;
}

void switchToLibrary() {
    libraryScene.SetSpawn(10, 15);
    currentScene = libraryScene.CreatScene();
    bgmManager.Loop("bgm_library");
}

void switchToVillage() {
    villageScene.SetSpawn(12, 2);
    currentScene = villageScene.CreatScene();
    bgmManager.Loop("bgm_village");
}

void changeAppIcon() {
  try {
    PImage img = loadImage("icon.png"); // 請確保 data 資料夾內有此 PNG
    if (img != null) {
      surface.setIcon(img);
    }
  } catch (Exception e) {
    println("無法載入視窗圖示: " + e.getMessage());
  }
}