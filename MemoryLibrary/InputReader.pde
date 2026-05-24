class InputReader {
    public Event OnMoveUp;
    public Event OnMoveDown;
    public Event OnMoveLeft;
    public Event OnMoveRight;
    public Event OnInteract;

    public Boolean enable = true;

    private boolean isUpPressed = false;
    private boolean isDownPressed = false;
    private boolean isLeftPressed = false;
    private boolean isRightPressed = false;
    private boolean isInteractPressed = false;

    public InputReader() { 
        OnMoveUp = new Event();
        OnMoveDown = new Event();
        OnMoveLeft = new Event();
        OnMoveRight = new Event();
        OnInteract = new Event();
    }

    public void Disable() { enable = false; println("Input Disabled"); }
    public void Enable() { enable = true; println("Input Enabled"); }
    
    public void update() {
        if (!enable) return;
        if (isUpPressed) { OnMoveUp.Invoke(); isUpPressed = false; }
        else if (isDownPressed) { OnMoveDown.Invoke(); isDownPressed = false; }
        else if (isLeftPressed) { OnMoveLeft.Invoke(); isLeftPressed = false; }
        else if (isRightPressed) { OnMoveRight.Invoke(); isRightPressed = false; }
        else if (isInteractPressed) { OnInteract.Invoke(); isInteractPressed = false; }
    }

    private void directDetected() {
        if (!enable) return;
        if (InputMoveUp() && keyPressed) { OnMoveUp.Invoke(); }
        else if (InputMoveDown() && keyPressed) { OnMoveDown.Invoke(); }
        else if (InputMoveLeft() && keyPressed) { OnMoveLeft.Invoke(); }
        else if (InputMoveRight() && keyPressed) { OnMoveRight.Invoke(); }
        else if (InputInteract() && keyPressed) { OnInteract.Invoke(); }
    }
    
    public void keyPressed() {
        if (InputMoveUp()) isUpPressed = true;
        if (InputMoveDown()) isDownPressed = true;
        if (InputMoveLeft()) isLeftPressed = true;
        if (InputMoveRight()) isRightPressed = true;
        if (InputInteract()) isInteractPressed = true;
    }
    
    public void keyReleased() {
        if (InputMoveUp()) isUpPressed = false;
        if (InputMoveDown()) isDownPressed = false;
        if (InputMoveLeft()) isLeftPressed = false;
        if (InputMoveRight()) isRightPressed = false;
        if (InputInteract()) isInteractPressed = false;
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
    private Boolean InputInteract() {
        if (key == 'E' || key == 'e') return true;
        return false;
    }
}
