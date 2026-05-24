class SmallGamehandler extends Script {
    MathSolve mathSolve;
    EnglishSolve englishSolve;
    ScienceSolve scienceSolve;
    Science2Solve science2Solve;
    Dialogue0 dialogue0;
    Dialogue1 dialogue1;
    Dialogue3 dialogue3;
    Dialogue4 dialogue4;
    Dialogue6 dialogue6;
    Dialogue8 dialogue8;

    SmallGame currentGame;
    private Runnable pendingOnExit;

    public SmallGamehandler() {
        var e = new Event();
        e.Register(this::Origin);
        dialogue0 = new Dialogue0(e);
        dialogue1 = new Dialogue1(e);
        dialogue3 = new Dialogue3(e);
        dialogue4 = new Dialogue4(e);
        dialogue6 = new Dialogue6(e);
        dialogue8 = new Dialogue8(e);
        mathSolve = new MathSolve(e);
        englishSolve = new EnglishSolve(e);
        scienceSolve = new ScienceSolve(e);
        science2Solve = new Science2Solve(e);
    }

    public void Math() {
        currentGame = mathSolve;
        currentGame.setup();
    }

    public void Dialogue0() {
        currentGame = dialogue0;
        currentGame.setup();
    }

    public void Dialogue1() {
        currentGame = dialogue1;
        currentGame.setup();
    }

    public void Dialogue3() {
        currentGame = dialogue3;
        currentGame.setup();
    }

    public void Dialogue4() {
        currentGame = dialogue4;
        currentGame.setup();
    }

    public void Dialogue6() {
        currentGame = dialogue6;
        currentGame.setup();
    }

    public void Dialogue8() {
        currentGame = dialogue8;
        currentGame.setup();
    }

    public void English() {
        currentGame = englishSolve;
        currentGame.setup();
    }

    public void Science() {
        currentGame = scienceSolve;
        currentGame.setup();
    }

    public void Science2() {
        currentGame = science2Solve;
        currentGame.setup();
    }

    public void RunWithOnExit(Runnable startGame, Runnable onExit) {
        pendingOnExit = onExit;
        startGame.run();
    }

    public void Origin() {
        currentGame = null;
        if (pendingOnExit != null) {
            pendingOnExit.run();
            pendingOnExit = null;
        }
    }

    public void setup() {
        if (currentGame != null) {
            currentGame.setup();
        }
    }

    public void update() {
        if (currentGame != null)
            currentGame.update();
    }

    public void mousePressed() {
        if (currentGame != null)
            currentGame.mousePressed();
    }

    public void mouseReleased() {
        if (currentGame != null)
            currentGame.mouseReleased();
    }
}
