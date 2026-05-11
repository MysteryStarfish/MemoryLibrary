class CollisionHandler {

    CollisionHandler instance = null;

    ArrayList<BoxCollider> collisions = new ArrayList<BoxCollider>();

    CollisionHandler() {

    }

    static CollisionHandler getInstance() {
        if (!instance) {
            instance = new CollisionHandler();
        }
        return instance;
    }

    public void update() {

    }

    boolean isCollision(BoxCollider _from, BoxCollider _to) { 
        float fromTop = _from.gameObject.getComponent(Transform.class).y + _from.offsetY - _from.height/2;
        float fromBottom = _from.gameObject.getComponent(Transform.class).y + _from.offsetY + _from.height/2;
        float fromRight = _from.gameObject.getComponent(Transform.class).x + _from.offsetX + _from.width/2;
        float fromLeft = _from.gameObject.getComponent(Transform.class).x + _from.offsetX - _from.width/2;
        
        float toTop = _to.gameObject.getComponent(Transform.class).y + _to.offsetY - _to.height/2;
        float toBottom = _to.gameObject.getComponent(Transform.class).y + _to.offsetY + _to.height/2;
        float toRight = _to.gameObject.getComponent(Transform.class).x + _to.offsetX + _to.width/2;
        float toLeft = _to.gameObject.getComponent(Transform.class).x + _to.offsetX - _to.width/2;
        
        boolean yInRange = fromBottom > toTop && fromTop < toBottom;
        boolean xInRange = fromRight > toLeft && fromLeft < toRight;

        if (xInRange && yInRange) return true;
        return false;
    }

    void checkCollision() {
        for (BoxCollision from : collisions) {
            for (BoxCollision to : collisions) {
                if (from == to) continue;
                if (isCollision(from, to)) {
                    from.onCollision();
                }
            }
        }
    }
}
