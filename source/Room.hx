/*
 * This file is part of Room Designer.
 *
 * Room Designer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Room Designer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Room Designer.  If not, see <http://www.gnu.org/licenses/>.
 */

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
  private var tooltip:Tooltip;

  public function new (game:Game) {
    super (game);
    money = 1000;
    items = [];
    storeShowing = false;
    challengesShowing = false;
    dialog = null;
    tooltip = null;
    makeChildren();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
    addEventListener(MouseEvent.CLICK, onClick);
  }

  private function makeChildren():Void {
    store = new Store(this);
    storeButton = new Button("Store", onStorePressed);
    storeButton.x = 4;
    storeButton.y = 4;
    challenges = new Challenges(this);
    challengesButton = new Button("Challenges", onChallengesPressed);
    challengesButton.x = 4;
    exitButton = new Button("Exit", onExitPressed);
    exitButton.y = 4;
    addHelp();
  }

  private function addHelp():Void {
    addDialog(new Dialog("Welcome to Room Designer!\n\n" +
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
      challengesButton.y = Lib.current.stage.stageHeight - challengesButton.height - 2;
      addChild(storeButton);
      addChild(challengesButton);
    }
    exitButton.x = Lib.current.stage.stageWidth - exitButton.width - 4;
    addChild(exitButton);
    addItems();
    if (dialog != null) {
      addChild(dialog);
      dialog.dispatchEvent(event);
    } else if (tooltip != null) addChild(tooltip);
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
    addDialog(new Dialog('You have completed a challenge!\n\n' +
                         'You have been rewarded with $$$reward.\n\n' +
                         'Press CHALLENGES to see your new objective.'));
    drawState();
  }

  private function addDialog(dialog2:Dialog):Void {
    dialog = dialog2;
    dialog.addEventListener(DialogEvent.OKAY_PRESSED, function (event:Event):Void {
      dialog = null;
      drawState();
    });
  }

  public function addTooltip(tooltip2:Tooltip):Void {
    tooltip = tooltip2;
    drawState();
  }

  public function removeTooltip():Void {
    tooltip = null;
    drawState();
  }
}
