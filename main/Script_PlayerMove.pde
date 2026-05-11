class PlayerMove extends Script {
    @Override
    void start() {;}
    
    @Override
    void update() {;}

    public void Move(PVector position) {
        gameObject.transform().SetPosition(position);
    }
}