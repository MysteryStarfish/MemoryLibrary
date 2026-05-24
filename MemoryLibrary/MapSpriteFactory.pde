class MapSpriteFactory {
    PImage playerImage;

    public MapSpriteFactory() {
        playerImage = loadImage("Raphtalia.png");
    }

    public PImage getPlayer() {
        return playerImage;
    }

    public PImage getCharacter(int type) {
        if (type == 1) return playerImage;
        return null;
    }
}
