package;

import openfl.display.*;
import openfl.events.*;

class Sidebar extends Sprite {
  public function new () {
    super ();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
  }

  private function onDrawState(event:Event):Void {
    while (numChildren > 0) removeChildAt(0);
    addBackground();
  }

  private function addBackground():Void {
    graphics.clear();
    graphics.beginFill(GameColors.UI_BACKGROUND_COLOR);
    graphics.drawRect(0, 0, stage.stageWidth / 4, stage.stageHeight);
    graphics.endFill();
    graphics.beginFill(GameColors.UI_EDGE_COLOR);
    graphics.drawRect(stage.stageWidth / 4, 0, 2, stage.stageHeight);
    graphics.endFill();
    dispatchEvent(new SidebarEvent(SidebarEvent.DRAW_SIDEBAR));
  }
}
