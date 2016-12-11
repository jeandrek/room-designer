package;

import openfl.display.*;
import openfl.events.*;

class GameState extends Sprite {
  private var game:Game;

  public function new (game2:Game) {
    super ();
    game = game2;
  }

  public function drawState():Void {
    while (numChildren > 0) removeChildAt(0);
    addBackground();
    dispatchEvent(new GameStateEvent(GameStateEvent.DRAW_STATE));
  }

  private function addBackground():Void {
    graphics.clear();
    graphics.beginFill(GameColors.GAME_BACKGROUND_COLOR);
    graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
    graphics.endFill();
  }
}
