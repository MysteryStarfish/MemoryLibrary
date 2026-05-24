class MapHandler {
    private MapVisualizer mapVisualizer;
    private PlayerMove playerMove;
    private int mapSizeX, mapSizeY;
    private int gridSize;
    private int[][] map;
    private int[][] characterMap;
    private JsonReader jsonReader;
    private NPCHandler npcHandler;
    private PVector playerPosition;
    private boolean debugPrintMap = false;
    private String mapName = "map2";
    public Event SwitchToVillageAction;
    public Event SwitchToLibraryAction;

    private void SwitchToVillage() {
        SwitchToVillageAction.Invoke();
    }
    private void SwitchToLibrary() {
        SwitchToLibraryAction.Invoke();
    }
    public MapHandler(int x, int y, int playerX, int playerY, 
        String mapName,
        JsonReader jsonReader, 
        PlayerMove playerMove,
        InputReader inputReader,
        NPCHandler npcHandler
    ) {
        this.mapName = mapName;
        mapSizeX = x;
        mapSizeY = y;
        map = new int[mapSizeY][mapSizeX];
        characterMap = new int[mapSizeY][mapSizeX];
        this.npcHandler = npcHandler;
        PutPlayer(playerX, playerY);
        playerPosition = new PVector(playerX, playerY);
        InfoInit(jsonReader, playerMove);

        SwitchToVillageAction = new Event();
        SwitchToLibraryAction = new Event();
        
        inputReader.OnMoveUp.Register(this::MoveUpPlayer);
        inputReader.OnMoveDown.Register(this::MoveDownPlayer);
        inputReader.OnMoveLeft.Register(this::MoveLeftPlayer);
        inputReader.OnMoveRight.Register(this::MoveRightPlayer);
        inputReader.OnInteract.Register(this::DetectdAroundNPC);
    } 
    
    public MapHandler(int playerX, int playerY, 
        String mapName,
        JsonReader jsonReader, 
        PlayerMove playerMove,
        InputReader inputReader,
        NPCHandler npcHandler
    ) {
        this(
            jsonReader.ReadMapSizeWidth(mapName) + 1,
            jsonReader.ReadMapSizeHeight(mapName) + 1,
            playerX,
            playerY,
            mapName,
            jsonReader,
            playerMove,
            inputReader,
            npcHandler
        );
    } 
    public void InfoInit(JsonReader jsonReader, PlayerMove playerMove) {
        this.jsonReader = jsonReader;
        this.playerMove = playerMove;
        gridSize = jsonReader.ReadGridSize();

        mapVisualizer = new MapVisualizer(jsonReader);
    }
    
    public void update() {
        mapVisualizer.drawMap(mapName);
        if (playerPosition.x <= 16 && playerPosition.x >= 9 && playerPosition.y == 16) {
            SwitchToVillage();
        }
        if (playerPosition.x <= 13 && playerPosition.x >= 12 && playerPosition.y == 1) {
            SwitchToLibrary();
        }
        playerMove.Move(MapToPosition(playerPosition));
        MoveNPC();
    }
    public PVector GetGridPosition(int x, int y) {
        var xPos = x * gridSize; 
        var yPos = y * gridSize; 
        return new PVector(xPos, yPos);
    }
    public int[][] GetMap() {
        int[][] copy = new int[map.length][map[0].length];
        for (int i = 0; i < map.length; i++) {
            System.arraycopy(map[i], 0, copy[i], 0, map[i].length);
        }
        return copy;
    }
    public void PutPlayer(int x, int y) {
        characterMap[y][x] = 1;
    }
    public void PutNPC() {
        for (int i = 0; i < npcHandler.npcs.size(); i++) {
            PVector npcPosition = npcHandler.npcs.get(i).MapPosition();
            characterMap[(int)npcPosition.y][(int)npcPosition.x] = npcHandler.npcs.get(i).getId();
        }
    }
    public void MoveNPC() {
        PutNPC();
        for (int i = 0; i < npcHandler.npcs.size(); i++) {
            NPC npc = npcHandler.npcs.get(i);
            npc.Move(MapToPosition(npc.MapPosition()));
        }
    }
    public void DetectdAroundNPC() {
        // print("Detecting NPC...");
        // PrintMap();
        PVector playerPosition = this.playerPosition;

        for (int y = (int)playerPosition.y - 1; y <= (int)playerPosition.y + 1; y++) {
            for (int x = (int)playerPosition.x - 1; x <= (int)playerPosition.x + 1; x++) {
                if (x == (int)playerPosition.x && y == (int)playerPosition.y) continue;
                if (x <= 0 || x >= mapSizeX || y <= 0 || y >= mapSizeY) continue;
                if (characterMap[y][x] != 0) {
                    // print("NPC Detected! ID: " + characterMap[y][x]);
                    npcHandler.InteractWithNPC(characterMap[y][x]);
                }
            }
        }
    }
    void PrintMap() {
        for (int y = 0; y < mapSizeY; y++) {
            for (int x = 0; x < mapSizeX; x++) {
                print(characterMap[y][x] + " ");
            }
            println();
        }
    }
    public void MovePlayer(int x, int y) {
        int oldPositionX = (int)playerPosition.x;
        int oldPositionY = (int)playerPosition.y;
        int newPositionX = oldPositionX + x;
        int newPositionY = oldPositionY + y;
        if (debugPrintMap) PrintMap();
        if (newPositionX <= 0 || newPositionX >= mapSizeX || newPositionY <= 0 || newPositionY >= mapSizeY) return;
        if (characterMap[newPositionY][newPositionX] != 0) return;
        // println(playerPosition.x + " " + playerPosition.y);
        characterMap[oldPositionY][oldPositionX] = 0;
        characterMap[newPositionY][newPositionX] = 1;
        playerPosition.set(newPositionX, newPositionY);
    }

    public void ChangePlayerDirection(String direction) {
        playerMove.GoDirection(direction);
    }

    public void SetPlayerPosition(int x, int y) {
        characterMap[(int)playerPosition.y][(int)playerPosition.x] = 0;
        characterMap[y][x] = 1;
        playerPosition.set(x, y);
    }
    public void MoveLeftPlayer() {
        MovePlayer(-1, 0);
        ChangePlayerDirection("LEFT");
    }
    public void MoveRightPlayer() {
        MovePlayer(1, 0);
        ChangePlayerDirection("RIGHT");
    }
    public void MoveUpPlayer() {
        MovePlayer(0, -1);
        ChangePlayerDirection("UP");
    }
    public void MoveDownPlayer() {
        MovePlayer(0, 1);
        ChangePlayerDirection("DOWN");
    }
    private PVector FindPlayer() {
        PVector res;
        for (int y = 0; y < mapSizeY; y++) {
            for (int x = 0; x < mapSizeX; x++) {
                if (characterMap[y][x] == 1) {
                    // println(x + " " + y);
                    res = new PVector(x, y);
                    return res;
                }
            }
        }
        return new PVector(0, 0);
        // TODO: throw error 
    }

    private PVector MapToPosition(PVector place) {
        return new PVector(place.x * gridSize - gridSize/2, place.y * gridSize - gridSize/2);
    }
}
