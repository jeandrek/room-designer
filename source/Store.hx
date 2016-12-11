package;

import openfl.*;
import openfl.display.*;
import openfl.events.*;

class Store extends Sprite {
  public function new () {
    super ();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
  }

  private function onDrawState(event:Event):Void {
    graphics.clear();
    graphics.beginFill(GameColors.SHOP_BACKGROUND_COLOR);
    graphics.drawRect(0, 0, 120, Lib.current.stage.stageHeight);
    graphics.endFill();
  }
}
