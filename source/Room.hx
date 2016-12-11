package;

import openfl.events.*;

class Room extends GameState {
  public function new (game:Game) {
    super (game);
    addEventListener(GameStateEvent.DRAW_STATE, onDrawRoom);
  }

  private function onDrawRoom(event:Event):Void {
    addButtons();
  }

  private function addButtons():Void {
    addStoreButton();
    addExitButton();
  }

  private function addStoreButton():Void {
    addChild(new Button("Store", onStorePressed));
  }

  private function addExitButton():Void {
    var exitButton:Button = new Button("Exit", onExitPressed);
    exitButton.x = stage.stageWidth - exitButton.width;
    addChild(exitButton);
  }

  private function onStorePressed(event:Event):Void {
  }

  private function onExitPressed(event:Event):Void {
    game.useState(new MainMenu(game));
  }
}
