GameObject player;

void setup() {
    size(800, 600);

    player = new GameObject("Player");
    Transform t = new Transform(width/2, height/2);
    Sprite s = new Sprite("Raphtalia.png");
    player.addComponent(t);
    player.addComponent(s);
}

void draw() {
    player.update();
}
