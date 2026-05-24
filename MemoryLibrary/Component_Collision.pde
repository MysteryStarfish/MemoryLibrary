import java.util.function.Consumer;

class BoxCollider extends Component {
    float offsetX;
    float offsetY;

    float width;
    float height;

    boolean isTrigger;

    ArrayList<Consumer<BoxCollider>> onCollisionEvents;

    public BoxCollider(float offsetX, float offsetY, float w, float h, boolean isTrigger) {
        this.offsetX = offsetX;
        this.offsetY = offsetY;
        this.width = w;
        this.height = h;
        this.isTrigger = isTrigger;
        onCollisionEvents = new ArrayList<Consumer<BoxCollider>>();
    }

    void onCollision(BoxCollider target) {
        for (Consumer<BoxCollider> event : onCollisionEvents) {
            event.accept(target); 
        }
    }

    void addOnCollisionEvents(Consumer<BoxCollider> event) {
        onCollisionEvents.add(event);
    }

    @Override
    void start() {;}

    @Override
    void update() {;}
}
