class MapScene extends Scene {
    MapHandler mapHandler;
    public MapScene(MapHandler mapHandler) {
        this.mapHandler = mapHandler;
    }
    
    @Override
    void update() {
        background(0);
        super.update();
        mapHandler.update();
    }
}
