package;

import haxe.*;
import openfl.*;
import openfl.display.*;
import openfl.events.*;

class Room extends GameState {
  public var money:Int;
  private var items:Array<Item>;
  private var storeButton:Button;
  private var challengesButton:Button;
  private var exitButton:Button;
  private var store:Store;
  private var challenges:Challenges;
  private var storeShowing:Bool;
  private var challengesShowing:Bool;
  private var dialog:Dialog;

  public function new (game:Game) {
    super (game);
    money = 1000;
    items = [];
    storeShowing = false;
    challengesShowing = false;
    dialog = null;
    makeChildren();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
    addEventListener(MouseEvent.CLICK, onClick);
  }

  private function makeChildren():Void {
    store = new Store(this);
    challenges = new Challenges(this);
    storeButton = new Button("Store", onStorePressed);
    challengesButton = new Button("Challenges", onChallengesPressed);
    exitButton = new Button("Exit", onExitPressed);
    showHelp();
  }

  private function showHelp():Void {
    showDialog(new Dialog("Welcome to Room Designer!\n\n" +
                          "Press CHALLENGES to see your current objective.\n\n" +
                          "Press STORE to purchase items to decorate your room.\n\n"));
  }

  private function onDrawState(event:Event):Void {
    if (storeShowing) {
      addChild(store);
      store.dispatchEvent(event);
    } else if (challengesShowing) {
      addChild(challenges);
      challenges.dispatchEvent(event);
    } else {
      challengesButton.y = Lib.current.stage.stageHeight - challengesButton.height;
      addChild(storeButton);
      addChild(challengesButton);
    }
    exitButton.x = Lib.current.stage.stageWidth - exitButton.width;
    addChild(exitButton);
    addItems();
    if (dialog != null) {
      addChild(dialog);
      dialog.dispatchEvent(event);
    }
  }

  private function addItems():Void {
    for (item in items) addChild(item);
  }

  private function onStorePressed(event:Event):Void {
    storeShowing = true;
    drawState();
  }

  private function onChallengesPressed(event:Event):Void {
    challengesShowing = true;
    drawState();
  }

  private function onClick(event:Event):Void {
    var target:DisplayObject = cast (event.target, DisplayObject);
    if (!storeButton.contains(target) && !store.contains(target) &&
        !challengesButton.contains(target) && !challenges.contains(target)) {
      storeShowing = false;
      challengesShowing = false;
      drawState();
    }
  }

  private function onExitPressed(event:Event):Void {
    game.useState(new MainMenu(game));
  }

  public function canAfford(item:Item):Bool {
    return money >= item.price;
  }

  public function purchase(item:Item):Void {
    money -= item.price;
    items.push(item);
    addChild(item);
    dispatchEvent(new RoomEvent(RoomEvent.PURCHASE));
  }

  public function meetsRequirements(requirements:DynamicAccess<Int>):Bool {
    var itemCounts:Map<String, Int> = new Map();
    for (item in items) {
      var itemName:String = item.itemName;
      if (itemCounts.exists(itemName)) itemCounts[itemName] += 1;
      else itemCounts[itemName] = 1;
    }
    for (itemName in requirements.keys()) {
      if (!itemCounts.exists(itemName)) return false;
      if (itemCounts[itemName] < requirements[itemName]) return false;
    }
    return true;
  }

  public function claimReward(reward:Int):Void {
    money += reward;
    dispatchEvent(new RoomEvent(RoomEvent.REWARD));
  }

  public function showCompletion(reward:Int):Void {
    showDialog(new Dialog('You have completed a challenge!\n\n' +
                          'You have been rewarded with $$$reward.\n\n' +
                          'Press CHALLENGES to see your new objective.'));
    drawState();
  }

  private function showDialog(dialog2:Dialog):Void {
    storeShowing = false;
    challengesShowing = false;
    dialog = dialog2;
    dialog.addEventListener(DialogEvent.OKAY_PRESSED, function (event:Event):Void {
      dialog = null;
      drawState();
    });
  }
}
