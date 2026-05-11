class GameObject {
    String name;
    HashMap<Class<? extends Component>, Component> components;
    HashMap<String, GameObject> children;

    public GameObject(String name) {
        this.name = name;
        components = new HashMap<Class<? extends Component>, Component>();
        children = new HashMap<String, GameObject>();
    }

    public void update() {
        for (Component component : components.values()) {
            component.update();
        }
        for (GameObject child : children.values()) {
            child.update();
        }
    }

    public <T extends Component> void addComponent(T component) {
        components.put(component.getClass(), component);
        component.setGameObject(this);
        component.start();
    }

    public <T extends Component> T getComponent(Class<T> type) {
        Component c = components.get(type);

        if (c == null) return null;
        return type.cast(c);
    }

    public void addChild(GameObject gameObject) {
        children.put(gameObject.name, gameObject);
    }

    public GameObject getChild(String name) {
        return children.get(name);
    }
    public Transform transform() {
        return this.getComponent(Transform.class);
    }
}
