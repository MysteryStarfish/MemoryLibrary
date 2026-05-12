class MapHandler {
    private MapVisualizer mapVisualizer;
    private PlayerMove playerMove;
    private int mapSizeX, mapSizeY;
    private int gridSize;
    private int[][] map;
    private int[][] characterMap;
    private JsonReader jsonReader;

    public MapHandler(int x, int y, int playerX, int playerY, 
        JsonReader jsonReader, 
        PlayerMove playerMove,
        InputReader inputReader
    ) {
        mapSizeX = x;
        mapSizeY = y;
        map = new int[mapSizeY][mapSizeX];
        characterMap = new int[mapSizeY][mapSizeX];
        PutPlayer(playerX, playerY);
        InfoInit(jsonReader, playerMove);
        
        inputReader.OnMoveUp.Register(this::MoveUpPlayer);
        inputReader.OnMoveDown.Register(this::MoveDownPlayer);
        inputReader.OnMoveLeft.Register(this::MoveLeftPlayer);
        inputReader.OnMoveRight.Register(this::MoveRightPlayer);
    } 
    
    public MapHandler(int playerX, int playerY, 
        JsonReader jsonReader, 
        PlayerMove playerMove,
        InputReader inputReader
    ) {
        InfoInit(jsonReader, playerMove);
        mapSizeX = width/gridSize;
        mapSizeY = height/gridSize;
        map = new int[mapSizeY][mapSizeX];
        characterMap = new int[mapSizeY][mapSizeX];
        PutPlayer(playerX, playerY);
        
        inputReader.OnMoveUp.Register(this::MoveUpPlayer);
        inputReader.OnMoveDown.Register(this::MoveDownPlayer);
        inputReader.OnMoveLeft.Register(this::MoveLeftPlayer);
        inputReader.OnMoveRight.Register(this::MoveRightPlayer);
    } 
    public void InfoInit(JsonReader jsonReader, PlayerMove playerMove) {
        this.jsonReader = jsonReader;
        this.playerMove = playerMove;
        // var data = jsonReader.ReadMapJson();
        gridSize = 10;
        // gridSize = data.gridSize;
    }
    
    public void update() {
        playerMove.Move(MapToPosition(FindPlayer()));
    }
    public PVector getGridPosition(int x, int y) {
        var xPos = x * gridSize; // TODO: xPos = x * gridSize;
        var yPos = y * gridSize; // TODO: xPos = x * gridSize;
        return new PVector(xPos, yPos);
    }
    public int[][] getMap() {
        int[][] copy = new int[map.length][map[0].length];
        for (int i = 0; i < map.length; i++) {
            System.arraycopy(map[i], 0, copy[i], 0, map[i].length);
        }
        return copy;
    }
    public void PutPlayer(int x, int y) {
        characterMap[y][x] = 1;
    }
    public void MovePlayer(int x, int y) {
        PVector playerPosition = FindPlayer();
        int oldPositionX = (int)playerPosition.x;
        int oldPositionY = (int)playerPosition.y;
        playerPosition.add(new PVector(x, y));
        if (playerPosition.x <= 0 || playerPosition.x >= mapSizeX || playerPosition.y <= 0 || playerPosition.y >= mapSizeY) return;
        characterMap[oldPositionY][oldPositionX] = 0;
        characterMap[(int)playerPosition.y][(int)playerPosition.x] = 1;
    }
    public void MoveLeftPlayer() {
        MovePlayer(-1, 0);
    }
    public void MoveRightPlayer() {
        MovePlayer(1, 0);
    }
    public void MoveUpPlayer() {
        MovePlayer(0, -1);
    }
    public void MoveDownPlayer() {
        MovePlayer(0, 1);
    }
    private PVector FindPlayer() {
        PVector res;
        for (int y = 0; y < mapSizeY; y++) {
            for (int x = 0; x < mapSizeX; x++) {
                if (characterMap[y][x] == 1) {
                    res = new PVector(x, y);
                    return res;
                }
            }
        }
        return new PVector(0, 0);
        // TODO: throw error 
    }

    private PVector MapToPosition(PVector place) {
        return new PVector(place.x * gridSize, place.y * gridSize);
    }
}
