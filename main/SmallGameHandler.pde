class SmallGamehandler extends Script {
    MathSolve mathSolve;

    SmallGame currentGame;

    public SmallGamehandler() {
        var e = new Event();
        e.Register(this::Origin);
        mathSolve = new MathSolve(e);
    }

    public void Math() {
        currentGame = mathSolve;
        currentGame.setup();
    }

    public void Origin() {
        currentGame = null;
    }

    public void setup() {
        if (currentGame != null)
        currentGame.setup();
    }

    public void update() {
        if (currentGame != null)
            currentGame.update();
    }

    public void mousePressed() {
        if (currentGame != null)
            currentGame.mousePressed();
    }
}
