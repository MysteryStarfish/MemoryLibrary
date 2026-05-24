class PlayerMove extends Script {
    PImage[] downSprites;
    PImage[] upSprites;
    PImage[] leftSprites;
    PImage[] rightSprites;
    int currentSpriteIndex = 0;

    @Override
    void start() {
        downSprites = new PImage[2];
        downSprites[0] = loadImage("assets/Character/main_character_down_1.png");
        downSprites[1] = loadImage("assets/Character/main_character_down_2.png");
        upSprites = new PImage[2];
        upSprites[0] = loadImage("assets/Character/main_character_up_1.png");
        upSprites[1] = loadImage("assets/Character/main_character_up_2.png");
        leftSprites = new PImage[2];
        leftSprites[0] = loadImage("assets/Character/main_character_left_1.png");
        leftSprites[1] = loadImage("assets/Character/main_character_left_2.png");
        rightSprites = new PImage[2];
        rightSprites[0] = loadImage("assets/Character/main_character_right_1.png");
        rightSprites[1] = loadImage("assets/Character/main_character_right_2.png");
    }
    
    @Override
    void update() {;}

    public void Move(PVector position) {
        gameObject.transform().SetPosition(position);
    }

    public void GoDirection(String direction) {
        currentSpriteIndex++;
        soundEffectManager.PlaySound("sfx_walk");
        switch (direction) {
            case "UP":
                gameObject.getComponent(Sprite.class).setImage(upSprites[currentSpriteIndex % upSprites.length]);
                break;
            case "DOWN":
                gameObject.getComponent(Sprite.class).setImage(downSprites[currentSpriteIndex % downSprites.length]);
                break;
            case "LEFT":
                gameObject.getComponent(Sprite.class).setImage(leftSprites[currentSpriteIndex % leftSprites.length]);
                break;
            case "RIGHT":
                gameObject.getComponent(Sprite.class).setImage(rightSprites[currentSpriteIndex % rightSprites.length]);
                break;
        }
    }
}