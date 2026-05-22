class Sprite extends Component {
    PImage image;
    float w, h;

    public Sprite(String filename, float scale) {
        image = loadImage(filename);
        w = image.width * scale;
        h = image.height * scale;
    }

    public Sprite(String filename, float size_x, float size_y) {
        image = loadImage(filename);
        w = size_x;
        h = size_y;
    }

    public Sprite(String filename) {
        this(filename, 1.0f);
    }

    public PImage getImage() {
        return image;
    }

    @Override
    void update() {
        display();
    }
    
    void display() {
        Transform transform = gameObject.getComponent(Transform.class);
        float s = transform.scale;
        float _w = w * s;
        float _h = h * s;
        float x = transform.position.x - _w/2;
        float y = transform.position.y - _h/2;
        image(image, x, y, _w, _h);
    }
}
