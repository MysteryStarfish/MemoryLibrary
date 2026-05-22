class NPCHandler {
    ArrayList<NPC> npcs;

    public NPCHandler() {
        npcs = new ArrayList<NPC>();
    }

    public void AddNPC(NPC npc) {
        npcs.add(npc);
    }

    public void InteractWithNPC(int id) {
        print("Interacting with NPC ID: " + id);
        for (NPC npc : npcs) {
            print("Finding with NPC ID: " + npc.id);
            if (npc.id == id) {
                print("Found NPC ID: " + npc.id);
                npc.Interact();
                break;
            }
        }
    }
}