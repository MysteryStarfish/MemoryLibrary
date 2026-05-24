class CollisionHandler {
    public ArrayList<BoxCollider> collisions = new ArrayList<BoxCollider>();

    public void update() {
        checkCollision();
    }

    boolean isCollision(BoxCollider _from, BoxCollider _to) { 
        float fromTop = _from.gameObject.getComponent(Transform.class).position.y + _from.offsetY - _from.height/2;
        float fromBottom = _from.gameObject.getComponent(Transform.class).position.y + _from.offsetY + _from.height/2;
        float fromRight = _from.gameObject.getComponent(Transform.class).position.x + _from.offsetX + _from.width/2;
        float fromLeft = _from.gameObject.getComponent(Transform.class).position.x + _from.offsetX - _from.width/2;
        
        float toTop = _to.gameObject.getComponent(Transform.class).position.y + _to.offsetY - _to.height/2;
        float toBottom = _to.gameObject.getComponent(Transform.class).position.y + _to.offsetY + _to.height/2;
        float toRight = _to.gameObject.getComponent(Transform.class).position.x + _to.offsetX + _to.width/2;
        float toLeft = _to.gameObject.getComponent(Transform.class).position.x + _to.offsetX - _to.width/2;
        
        boolean yInRange = fromBottom > toTop && fromTop < toBottom;
        boolean xInRange = fromRight > toLeft && fromLeft < toRight;

        if (xInRange && yInRange) return true;
        return false;
    }

    void checkCollision() {
        for (BoxCollider from : collisions) {
            for (BoxCollider target : collisions) {
                if (from == target) continue;
                if (isCollision(from, target)) {
                    from.onCollision(target);
                }
            }
        }
    }
}
