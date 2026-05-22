class NPC extends Script {
    int id;
    PVector mapPosition;
    boolean isInteracting = false;

    Event interactions;

    public NPC(int id, int x, int y, NPCHandler npcHandler) {
        this.id = id;
        mapPosition = new PVector(x, y);

        interactions = new Event();
        npcHandler.AddNPC(this);
    }

    public int getId() {
        return id;
    }

    public void AddInteraction(Runnable interaction) {
        interactions.Register(interaction);
    }

    public void Interact() {
        if (isInteracting) return;
        isInteracting = true;
        interactions.Invoke();
    }

    public PVector MapPosition() {
        return mapPosition;
    }

    public void Move(PVector targetPosition) {
        gameObject.getComponent(Transform.class).position = targetPosition;
    }
}
