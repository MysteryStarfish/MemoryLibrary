class MapVisualizer {
    JsonReader jsonReader;
    // MapGenerator mapGen;

    private static final int BASE_WIDTH = 1152;
    private static final int BASE_HEIGHT = 768;
    private PImage cachedMapImage;
    private PImage cachedScaledMapImage;
    private int cachedScaledWidth = -1;
    private int cachedScaledHeight = -1;
    private int cachedMapNum = -1;

    public MapVisualizer(JsonReader jsonReader) {
        this.jsonReader = jsonReader;

        cachedMapImage = null;
        cachedScaledMapImage = null;
        cachedScaledWidth = -1;
        cachedScaledHeight = -1;
        cachedMapNum = -1;
        // mapGen = new MapGenerator();
        // mapGen.setup();
    }
  
    public void drawMap(String mapName) {
        // int[][] map = jsonReader.ReadMapJson(mapName);
        // int gridSize = jsonReader.ReadGridSize();
        // for (int i = 0; i < map.length; i++) {
        //     for (int j = 0; j < map[i].length; j++) {
        //         var val = map[i][j];
        //         // rect(j * gridSize, i * gridSize, gridSize, gridSize);
        //         PImage gridImage = getGrid(val);
        //         if (gridImage != null) {
        //             image(gridImage, j * gridSize, i * gridSize, gridSize, gridSize);
        //         }
        //     }
        // }
        // mapGen.draw();
        int mapNum = mapNumFromName(mapName);
        ensureScaledMapImage(mapNum);
        if (cachedScaledMapImage != null) {
            image(cachedScaledMapImage, 0, 0);
        } else if (cachedMapImage != null) {
            image(cachedMapImage, 0, 0, width, height);
        }
    }

    private void ensureScaledMapImage(int mapNum) {
        if (cachedMapNum != mapNum) {
            cachedMapImage = getMap(mapNum);
            cachedScaledMapImage = null;
            cachedScaledWidth = -1;
            cachedScaledHeight = -1;
            cachedMapNum = mapNum;
        }
        if (cachedMapImage != null && cachedMapImage.width == BASE_WIDTH && cachedMapImage.height == BASE_HEIGHT) {
            cachedScaledMapImage = cachedMapImage;
            cachedScaledWidth = BASE_WIDTH;
            cachedScaledHeight = BASE_HEIGHT;
            return;
        }
        if (cachedScaledMapImage == null || cachedScaledWidth != BASE_WIDTH || cachedScaledHeight != BASE_HEIGHT) {
            cachedScaledMapImage = cachedMapImage.copy();
            cachedScaledMapImage.resize(BASE_WIDTH, BASE_HEIGHT);
            cachedScaledWidth = BASE_WIDTH;
            cachedScaledHeight = BASE_HEIGHT;
        }
    }

    private PImage getGrid(int val) {
        // return 
        return loadImage("assets/TileSets/" + String.valueOf(val) + ".png");
    }

    private PImage getMap(int val) {
        // return 
        return loadImage("assets/map0" + String.valueOf(val) + ".png");
    }

    private int mapNumFromName(String mapName) {
        if (mapName == null) return 1;
        String digits = "";
        for (int i = 0; i < mapName.length(); i++) {
            char c = mapName.charAt(i);
            if (c >= '0' && c <= '9') {
                digits += c;
            }
        }
        if (digits.length() == 0) return 1;
        return int(digits);
    }
}
