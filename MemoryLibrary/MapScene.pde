class MapScene extends Scene {
    MapHandler mapHandler;
    public MapScene(MapHandler mapHandler) {
        this.mapHandler = mapHandler;
    }
    
    @Override
    void update() {
        mapHandler.update();
        super.update();
    }
}
