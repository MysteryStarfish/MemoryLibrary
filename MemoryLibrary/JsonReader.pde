class JsonReader {
    private int[][] ReadMapJson(String filePath) {
        // TODO: Json Read, return Data
        var json = loadJSONObject("map.json");

        int[][] map;
        var test = json.getJSONObject("maps").getJSONArray(filePath);
        map = new int[test.size()][];
        for (int i = 0; i < test.size(); i++) {
            var temp = test.getJSONArray(i);
            map[i] = new int[temp.size()];
            for (int j = 0; j < temp.size(); j++) {
                var val = temp.getInt(j);
                map[i][j] = val;
            }
        }
        return map;
    }

    private int ReadMapSizeWidth(String filePath) {
        // TODO: Json Read, return Data
        var json = loadJSONObject("map.json");

        // var res = json.getJSONObject("maps").getJSONArray(filePath).getJSONArray(0).size();
        var res = json.getJSONObject("mapSize").getJSONArray(filePath).getInt(0);
 
        return res;
    }

    private int ReadMapSizeHeight(String filePath) {
        var json = loadJSONObject("map.json");

        // var res = json.getJSONObject("maps").getJSONArray(filePath).size();
        var res = json.getJSONObject("mapSize").getJSONArray(filePath).getInt(1);
        
        return res;
    }

    private int ReadGridSize() {
        // TODO: Json Read, return Data
        var json = loadJSONObject("map.json");

        int gridSize = json.getInt("gridSize");
        
        return gridSize;
    }
}
