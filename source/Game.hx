package;

import openfl.display.*;
import openfl.text.*;
import openfl.events.*;

class Game extends Sprite {
  private var state:GameState = null;

  public function new () {
    super ();
    useState(new MainMenu(this));
  }

  public function useState(newState:GameState):Void {
    if (state != null) removeChild(state);
    state = newState;
    addChild(state);
    state.drawState();
    stage.addEventListener(Event.RESIZE, onStageResize);
  }

  private function onStageResize(event:Event):Void {
    state.drawState();
  }
}
