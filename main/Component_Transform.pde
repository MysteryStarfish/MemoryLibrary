class Transform extends Component {
    public PVector position = new PVector(0, 0);
    public float scale = 1;

    Transform(float x, float y) {
        this.position.set(x, y);
    }

    Transform(float x, float y, float scale) {
        this.position.set(x, y);
        this.scale = scale;
    }
}