class NPC extends Script {
    int id;
    PVector mapPosition;
    boolean isInteracting = false;
    ArrayList<Runnable> interactions;
    int interactionIndex = 0;

    public NPC(int id, int x, int y, NPCHandler npcHandler) {
        this.id = id;
        mapPosition = new PVector(x, y);

        interactions = new ArrayList<Runnable>();
        npcHandler.AddNPC(this);
    }

    public int getId() {
        return id;
    }

    public void AddInteraction(Runnable interaction) {
        interactions.add(interaction);
    }

    public void ClearInteraction() {
        interactions.clear();
    }

    public void ResetInteractions() {
        interactions.clear();
        interactionIndex = 0;
        isInteracting = false;
    }

    public void Interact() {
        if (isInteracting) return;
        if (interactions.size() == 0) return;
        soundEffectManager.PlaySound("sfx_interacte");
        inputReader.Disable();
        interactions.get(interactionIndex).run();
    }

    public void CompleteInteraction() {
        if (interactionIndex < interactions.size() - 1) {
            interactionIndex++;
        }
        isInteracting = false;
        inputReader.Enable();
    }

    public void CancelInteraction() {
        isInteracting = false;
        inputReader.Enable();
    }

    public PVector MapPosition() {
        return mapPosition;
    }

    public void Move(PVector targetPosition) {
        gameObject.getComponent(Transform.class).position = targetPosition;
    }
}
