package;

import openfl.display.*;
import openfl.text.*;
import openfl.events.*;
import openfl.system.*;

class Store extends Sidebar {
  private var moneyField:TextField;
  private var items:Array<Item>;
  private var room:Room;

  public function new (room2:Room) {
    super ();
    room = room2;
    room.addEventListener(RoomEvent.PURCHASE, onMoneyUpdated);
    room.addEventListener(RoomEvent.REWARD, onMoneyUpdated);
    makeMoneyField();
    makeItems();
    addEventListener(SidebarEvent.DRAW_SIDEBAR, onDrawSidebar);
  }

  private function makeMoneyField():Void {
    moneyField = new TextField();
    moneyField.text = 'Money: $$${room.money}';
    moneyField.defaultTextFormat = new TextFormat("_typewriter", 16);
    moneyField.wordWrap = true;
    moneyField.selectable = false;
    moneyField.x = 2;
    moneyField.y = 2;
  }

  private function makeItems():Void {
    var index:Int = 0;
    var horizontalIndex:Float = 0;
    var verticalIndex:Float = 30;
    items = [];
    for (itemType in Item.ITEM_TYPES) {
      var item:Item = new Item(itemType.name, itemType.price, true, room);
      item.x = horizontalIndex;
      item.y = verticalIndex;
      items.push(item);
      if (index % 2 == 1) {
        horizontalIndex = 0;
        verticalIndex += item.height;
      } else horizontalIndex += item.width;
      index++;
    }
  }

  private function onDrawSidebar(event:Event):Void {
    if (moneyField == null) makeMoneyField();
    moneyField.width = width - 4;
    addChild(moneyField);
    for (item in items) addChild(item);
  }

  private function onMoneyUpdated(event:Event):Void {
    moneyField.text = 'Money: $$${room.money}';
  }
}
