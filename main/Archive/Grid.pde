class Grid extends GameObject {
    float size_x;
    float size_y;

    Sprite sprite;
    Transform transform;

    public Grid(String imagePath) {
        size_x = GlobalData.getInstance().gridSizeX;
        size_y = GlobalData.getInstance().gridSizeY;

        sprite = new Sprite(imagePath, size_x, size_y);
        transform = new Transform(0, 0);
        this.addComponent(sprite);
    }
    public void SetPosition(float x, float y) {
        transform.SetPosition(x, y);
    }
}