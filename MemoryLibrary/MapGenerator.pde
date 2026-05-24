import java.util.HashMap;

public class MapGenerator {
    final int COLS = 24;
    final int ROWS = 16;
    final int TILE_SIZE = 48;
    String basePath = "assets/TileSets/";

    ArrayList<String>[][] mapLayers = new ArrayList[ROWS][COLS];
    HashMap<String, PImage> tileCache = new HashMap<String, PImage>();

    void setup() {
        // 初始化所有網格，並直接預設底層為 "00.png"
        for (int r = 0; r < ROWS; r++) {
            for (int c = 0; c < COLS; c++) {
            mapLayers[r][c] = new ArrayList<String>();
            mapLayers[r][c].add(basePath + "00.png"); // 自動鋪滿背景
            }
        }
        
        // 載入各區塊陣列
        loadFarm();
        loadGlobalMap();               
        loadBookstore();      
        loadLibDoor();        
        loadVillageHead();    
        loadProtagonist();    
        
        preloadImages();
    }

    void draw() {
        background(0);
        for (int r = 0; r < ROWS; r++) {
            for (int c = 0; c < COLS; c++) {
            int posX = c * TILE_SIZE;
            int posY = r * TILE_SIZE;
            
            ArrayList<String> layers = mapLayers[r][c];
            for (int i = 0; i < layers.size(); i++) {
                String filename = layers.get(i);
                PImage img = tileCache.get(filename);
                
                if (img != null) {
                    image(img, posX, posY, TILE_SIZE, TILE_SIZE);
                } 
                else {
                    noFill(); stroke(80); rect(posX, posY, TILE_SIZE, TILE_SIZE);
                    fill(255, 100, 100); textSize(8); textAlign(CENTER, CENTER);
                    text(filename.replace(".png", ""), posX + TILE_SIZE/2, posY + (TILE_SIZE/2) + (i*10));
                }
            }
        }
    }
    
    if (mousePressed) drawDebugGrid();
    }

    // ==========================================
    // 1. 全局地圖 - (0,0) 到 (23,15)
    // ==========================================
    void loadGlobalMap() {
    // Col:   0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19    20    21    22    23
    String[][] globalGrid = {
        {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 0
        {"  ", "44", "45", "45", "45", "45", "46", "  ", "  ", "47", "01", "02", "02", "03", "47", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 1
        {"  ", "59", "  ", "  ", "  ", "  ", "59", "  ", "  ", "59", "04", "05", "05", "06", "59", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 2
        {"  ", "59", "  ", "  ", "  ", "  ", "59", "  ", "  ", "59", "04", "05", "05", "06", "59", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 3
        {"  ", "59", "  ", "  ", "  ", "  ", "59", "  ", "  ", "59", "04", "05", "05", "06", "59", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 4
        {"  ", "59", "  ", "  ", "  ", "  ", "59", "  ", "  ", "59", "04", "05", "05", "06", "59", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 5
        {"  ", "59", "  ", "  ", "  ", "  ", "59", "80", "45", "70", "07", "08", "08", "09", "68", "45", "82", "  ", "  ", "  ", "  ", "  ", "99", "  "}, // Row 6
        {"47", "01", "02", "02", "02", "02", "02", "02", "03", "10", "10", "10", "10", "10", "10", "01", "02", "02", "02", "02", "02", "02", "03", "47"}, // Row 7
        {"59", "04", "05", "05", "05", "05", "05", "05", "06", "10", "10", "10", "10", "10", "10", "04", "05", "05", "05", "05", "05", "05", "06", "59"}, // Row 8
        {"59", "07", "08", "08", "08", "08", "08", "08", "09", "10", "10", "10", "10", "10", "10", "07", "08", "08", "08", "08", "08", "08", "09", "59"}, // Row 9
        {"68", "82", "  ", "  ", "  ", "  ", "  ", "80", "45", "45", "45", "45", "45", "45", "45", "45", "82", "  ", "  ", "  ", "  ", "  ", "80", "70"}, // Row 10
        {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 11
        {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 12
        {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 13
        {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}, // Row 14
        {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "}  // Row 15
    };
    processGrid(globalGrid, 0, 0, "");
    }

    // ==========================================
    // 2. 農場區 - (1,1) 起點，6x6 正方形
    // ==========================================
    void loadFarm() {
    // Col:   0     1     2     3     4     5
    String[][] grid = {
        {"01", "02", "02", "02", "02", "03"}, // Row 0 (實際 Y = 1)
        {"04", "05,11", "05,10", "05,10", "05,10", "06"}, // Row 1 (實際 Y = 2)
        {"04", "05,12", "05,13", "05,13", "05", "06"}, // Row 2 (實際 Y = 3)
        {"04", "05,14", "05,14", "05,14", "05", "06"}, // Row 3 (實際 Y = 4)
        {"04", "05,14", "05,14", "05,14", "05,15", "06"}, // Row 4 (實際 Y = 5)
        {"07", "08,14", "08,14", "08,14", "08,15", "09"}  // Row 5 (實際 Y = 6)
    };
    processGrid(grid, 1, 1, "farm");
    }

    // ==========================================
    // 3. 書店區 - (2,10) 起點，4列x5行 長方形
    // ==========================================
    void loadBookstore() {
    // Col:   0     1     2     3     4
    String[][] grid = {
        {"01", "05", "05", "05", "03"}, // Row 0 (實際 Y = 10)
        {"04", "05", "05", "05", "06"}, // Row 1 (實際 Y = 11)
        {"04", "05", "05", "05", "06"}, // Row 2 (實際 Y = 12)
        {"07", "08", "08", "08", "09"}  // Row 3 (實際 Y = 13)
    };
    processGrid(grid, 2, 10, "book_");
    }

    // ==========================================
    // 4. 圖書館門口 - (10,0) 起點，1列x4行 長方形
    // ==========================================
    void loadLibDoor() {
    // 範例：同一格疊加 "03" 和 "10"，可以寫作 "03,10"
    // Col:   0          1     2     3
    String[][] grid = {
        {"03", "01", "02", "04"}  // Row 0 (實際 Y = 0)
    };
    processGrid(grid, 10, 0, "libdoor_");
    }

    // ==========================================
    // 5. 村長家 - (17,1) 起點，6列x5行 長方形
    // ==========================================
    void loadVillageHead() {
    // Col:   0     1     2     3     4
    String[][] grid = {
        {"01", "02", "02", "02", "03"}, // Row 0 (實際 Y = 1)
        {"04", "05", "05", "05", "06"}, // Row 1 (實際 Y = 2)
        {"04", "05", "05", "05", "06"}, // Row 2 (實際 Y = 3)
        {"04", "05", "05", "05", "06"}, // Row 3 (實際 Y = 4)
        {"04", "05", "05", "05", "06"}, // Row 4 (實際 Y = 5)
        {"07", "05", "05", "05", "09"}  // Row 5 (實際 Y = 6)
    };
    processGrid(grid, 17, 1, "vh_");
    }

    // ==========================================
    // 6. 主角家 - (17,10) 起點，5x5 正方形
    // ==========================================
    void loadProtagonist() {
    // Col:   0     1     2     3     4
    String[][] grid = {
        {"01", "05", "05", "05", "03"}, // Row 0 (實際 Y = 10)
        {"04", "05", "05", "05", "06"}, // Row 1 (實際 Y = 11)
        {"04", "05", "05", "05", "06"}, // Row 2 (實際 Y = 12)
        {"04", "05", "05", "05", "06"}, // Row 3 (實際 Y = 13)
        {"07", "08", "08", "08", "09"}  // Row 4 (實際 Y = 14)
    };
    processGrid(grid, 17, 10, "protagonist_");
    }

    // ==========================================
    // 升級版處理引擎：支援逗號分割多層疊加
    // ==========================================
    void processGrid(String[][] grid, int startX, int startY, String prefix) {
    for (int r = 0; r < grid.length; r++) {
        for (int c = 0; c < grid[r].length; c++) {
        String rawVal = grid[r][c];
        if (rawVal == null) continue;
        
        // 以逗號分割字串，處理同一格有多張圖片的狀況
        String[] values = rawVal.split(",");
        
        for (String val : values) {
            val = val.trim(); // 清除可能的空格，例如 "03, 10" 或是 "  " 都會被清乾淨
            
            if (val.equals("")) continue; // 略過空值
            
            int targetX = startX + c;
            int targetY = startY + r;
            String filename = basePath + prefix + val + ".png";
            
            if (targetX >= 0 && targetX < COLS && targetY >= 0 && targetY < ROWS) {
                mapLayers[targetY][targetX].add(filename);
            }
        }
        }
    }
    }

    // ==========================================
    // 工具函式
    // ==========================================
    void preloadImages() {
        for (int r = 0; r < ROWS; r++) {
            for (int c = 0; c < COLS; c++) {
                for (String filename : mapLayers[r][c]) {
                    if (!tileCache.containsKey(filename)) {
                    PImage img = loadImage(filename);
                    if (img != null) tileCache.put(filename, img);
                    }
                }
            }
        }
    }

    void drawDebugGrid() {
        stroke(255, 0, 0, 100); strokeWeight(1);
        for (int i = 0; i <= COLS; i++) line(i * TILE_SIZE, 0, i * TILE_SIZE, height);
            for (int j = 0; j <= ROWS; j++) line(0, j * TILE_SIZE, width, j * TILE_SIZE);
        
        int gridX = mouseX / TILE_SIZE;
        int gridY = mouseY / TILE_SIZE;
        if (gridX >= 0 && gridX < COLS && gridY >= 0 && gridY < ROWS) {
            noFill(); stroke(255, 255, 0, 200); strokeWeight(2);
            rect(gridX * TILE_SIZE, gridY * TILE_SIZE, TILE_SIZE, TILE_SIZE);
        }
    }
}