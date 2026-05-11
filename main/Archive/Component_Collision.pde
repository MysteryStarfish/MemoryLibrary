class BoxCollider extends Component {
    float offsetX;
    float offsetY;

    float width;
    float height;

    boolean isTrigger;

    ArrayList<Runable> onCollisionEvents;

    void onCollision() {
        for (Runable event : onCollisionEvents) {
            event.run();
        }
    }

    void addOnCollisionEvents(Runable event) {
        onCollisionEvents.add(event);
    }

    @Override
    void start() {;}

    @Override
    void update() {;}
}
