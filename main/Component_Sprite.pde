class Sprite extends Component {
    PImage image;
    float w, h;

    public Sprite(String filename, float scale) {
        image = loadImage(filename);
        w = image.width * scale;
        h = image.height * scale;
    }

    public Sprite(String filename) {
        this(filename, 1.0);
    }

    @Override
    void update() {
        display();
    }
    
    void display() {
        Transform transform = gameObject.getComponent(Transform.class);
        float s = transform.scale;
        float width = w * s;
        float height = h * s;
        float x = transform.position.x - width/2;
        float y = transform.position.y - height/2;
        image(image, x, y, width, height);
    }
}
