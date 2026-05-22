abstract class SmallGame {
    Event OnExit;

    SmallGame(Event onExit) {
        OnExit = onExit;
    }

    public void setup() {
        ;
    }

    public void update() {
        ;
    }

    public void mousePressed() {
        ;
    }

    public void Exit() {
        OnExit.Invoke();
    }
}
