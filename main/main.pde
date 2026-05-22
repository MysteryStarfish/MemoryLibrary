Scene currentScene;
JsonReader jsonReader;
InputReader inputReader;
MathSolve mathSolve;


void setup() {
    size(1152, 768);

    init();

    var testScene = new TestScene(jsonReader, inputReader);
    currentScene = testScene.CreatScene();

    JsonReader reader = new JsonReader();
    reader.ReadMapJson("map1");
}

void init() {
    jsonReader = new JsonReader();
    inputReader = new InputReader();
}

void draw() {
    background(10, 10, 10);
    currentScene.update();
}

void keyPressed() {
    inputReader.keyPressed();
    inputReader.update();
}

void keyReleased() {
    inputReader.keyReleased();
}

void mousePressed() {
    currentScene.mousePressed();
}
