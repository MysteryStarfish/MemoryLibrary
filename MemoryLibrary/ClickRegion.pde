class ClickRegion {
  float x;
  float y;
  float w;
  float h;
  private Runnable onClick;
  boolean enabled = true;

  ClickRegion(float x, float y, float w, float h, Runnable onClick) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.onClick = onClick;
  }

  public void SetOnClick(Runnable onClick) {
    this.onClick = onClick;
  }

  public void SetEnabled(boolean enabled) {
    this.enabled = enabled;
  }

  public boolean Contains(float px, float py) {
    return px >= x && px <= x + w && py >= y && py <= y + h;
  }

  public void HandleClick(float px, float py) {
    if (!enabled) return;
    if (onClick == null) return;
    if (Contains(px, py)) {
      onClick.run();
    }
  }
}
