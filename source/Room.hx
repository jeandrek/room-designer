package;

import openfl.display.*;
import openfl.events.*;

class Room extends GameState {
  private var storeButton:Button;
  private var exitButton:Button;
  private var store:Store;
  private var storeShowing:Bool;

  public function new (game:Game) {
    super (game);
    storeShowing = false;
    makeChildren();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
    addEventListener(MouseEvent.CLICK, onClick);
  }

  private function makeChildren():Void {
    store = new Store();
    storeButton = new Button("Store", onStorePressed);
    exitButton = new Button("Exit", onExitPressed);
  }

  private function onDrawState(event:Event):Void {
    store.dispatchEvent(event);
    if (storeShowing)
      addChild(store);
    else
      addChild(storeButton);
    exitButton.x = stage.stageWidth - exitButton.width;
    addChild(exitButton);
  }

  private function onStorePressed(event:Event):Void {
    removeChild(storeButton);
    addChild(store);
    storeShowing = true;
  }

  private function onClick(event:Event):Void {
    var target:DisplayObject = cast (event.target, DisplayObject);
    if (!storeButton.contains(target)
        && !store.contains(target)
        && storeShowing) {
      removeChild(store);
      storeShowing = false;
      addChild(storeButton);
    }
  }

  private function onExitPressed(event:Event):Void {
    game.useState(new MainMenu(game));
  }
}
