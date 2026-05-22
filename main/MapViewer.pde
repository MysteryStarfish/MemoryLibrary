class MapVisualizer {
    JsonReader jsonReader;

    public MapVisualizer(JsonReader jsonReader) {
        this.jsonReader = jsonReader;
    }
  
    public void drawMap(String mapName) {
        int[][] map = jsonReader.ReadMapJson(mapName);
        int gridSize = jsonReader.ReadGridSize();
        for (int i = 0; i < map.length; i++) {
            for (int j = 0; j < map[i].length; j++) {
                var val = map[i][j];
                PImage gridImage = getGrid(val);
                if (gridImage != null) {
                    image(gridImage, j * gridSize, i * gridSize, gridSize, gridSize);
                }
            }
        }
    }

    private PImage getGrid(int val) {
        return loadImage("assets/TileSets/" + String.valueOf(val) + ".png");
    }
}
