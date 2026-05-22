// class AudioManager {
//     // 建立一個字典，用來儲存 "音效名稱" 對應的 "音效實體"
//     private HashMap<String, SoundFile> soundDict;
//     private PApplet app; // Processing 讀取檔案需要用到核心的 applet

//     public AudioManager(PApplet app) {
//         this.app = app;
//         soundDict = new HashMap<String, SoundFile>();
//     }

//     // 🌟 1. 載入音效 (放在 setup 中執行)
//     // 傳入你想要叫它的名字 (name)，以及檔案路徑 (path)
//     public void LoadSound(String name, String path) {
//         if (!soundDict.containsKey(name)) {
//             SoundFile file = new SoundFile(app, path);
//             soundDict.put(name, file);
//             println("音效載入成功: " + name);
//         }
//     }

//     // 🌟 2. 播放音效 (在遊戲碰撞或任何地方執行)
//     public void Play(String name) {
//         SoundFile file = soundDict.get(name);
//         if (file != null) {
//             file.play(); // 播放！
//         } else {
//             println("錯誤：找不到名為 [" + name + "] 的音效，你忘記載入了嗎？");
//         }
//     }
    
//     // (可選) 調整特定音效的音量 0.0 ~ 1.0
//     public void SetVolume(String name, float volume) {
//         SoundFile file = soundDict.get(name);
//         if (file != null) file.amp(volume);
//     }
// }