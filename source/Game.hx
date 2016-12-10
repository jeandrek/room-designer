package;

import openfl.display.*;
import openfl.text.*;

class Game extends Sprite {
  private var state:GameState = null;

  public function new () {
    super ();
    useState(new MainMenu());
  }

  public function useState(newState:GameState):Void {
    if (state != null) removeChild(state);
    state = newState;
    addChild(state);
  }
}
