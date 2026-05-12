class InputReader {
    public Event OnMoveUp;
    public Event OnMoveDown;
    public Event OnMoveLeft;
    public Event OnMoveRight;

    public Boolean enable = true;

    private boolean isUpPressed = false;
    private boolean isDownPressed = false;
    private boolean isLeftPressed = false;
    private boolean isRightPressed = false;

    public InputReader() { 
        OnMoveUp = new Event();
        OnMoveDown = new Event();
        OnMoveLeft = new Event();
        OnMoveRight = new Event();
    }

    public void Disable() { enable = false; }
    public void Enable() { enable = true; }
    
    public void update() {
        if (!enable) return;
        if (isUpPressed) { OnMoveUp.Invoke(); }
        else if (isDownPressed) { OnMoveDown.Invoke(); }
        else if (isLeftPressed) { OnMoveLeft.Invoke(); }
        else if (isRightPressed) { OnMoveRight.Invoke(); }
    }
    
    public void keyPressed() {
        if (InputMoveUp()) isUpPressed = true;
        if (InputMoveDown()) isDownPressed = true;
        if (InputMoveLeft()) isLeftPressed = true;
        if (InputMoveRight()) isRightPressed = true;
    }
    
    public void keyReleased() {
        if (InputMoveUp()) isUpPressed = false;
        if (InputMoveDown()) isDownPressed = false;
        if (InputMoveLeft()) isLeftPressed = false;
        if (InputMoveRight()) isRightPressed = false;
    }
    
    private Boolean InputMoveUp() {
        if (key == 'W' || key == 'w') return true;
        return false;
    }
    private Boolean InputMoveDown() {
        if (key == 'S' || key == 's') return true;
        return false;
    }
    private Boolean InputMoveLeft() {
        if (key == 'A' || key == 'a') return true;
        return false;
    }
    private Boolean InputMoveRight() {
        if (key == 'D' || key == 'd') return true;
        return false;
    }
}
