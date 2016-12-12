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
import openfl.geom.*;
import openfl.events.*;

class Item extends Sprite {
  public static var ITEM_TYPES:Array<{name:String, price:Int}>;

  public static function addItemTypes():Void {
    ITEM_TYPES = Json.parse(Assets.getText("assets/data/items.json"));
  }

  public var itemName:String;
  public var price:Int;
  private var image:BitmapData;
  public var template:Bool;
  private var room:Room;
  private var dragging:Bool;
  private var startX:Float;
  private var startY:Float;

  public function new (itemName2:String, price2:Int, template2:Bool, room2:Room) {
    super ();
    itemName = itemName2;
    price = price2;
    template = template2;
    room = room2;
    image = Assets.getBitmapData('assets/images/$itemName.png');
    addChild(new Bitmap(scaleBitmap(image, template)));
    if (template) {
      buttonMode = true;
      dragging = false;
#if mobile
      addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
#else
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
#end
      addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }
  }

  private function scaleBitmap(image:BitmapData, template:Bool):BitmapData {
    var scale:Float = Lib.current.stage.stageWidth / 8 / image.width;
    var matrix:Matrix = new Matrix();
    var scaledImage:BitmapData =
      new BitmapData(Math.floor(image.width * scale),
                     Math.floor(image.height * scale),
                     true, 0x000000);
    matrix.scale(scale, scale);
    scaledImage.draw(image, matrix, null, null, null, true);
    return scaledImage;
  }

#if mobile
  private function onAddedToStage(event:Event):Void {
    stage.addEventListener(MouseEvent.CLICK, onStageTapped);
  }

  private function onStageTapped(event:Event):Void {
    if (!Std.is(event.target, Item)) hidePrice();
  }
#else
  private function onMouseOver(event:Event):Void {
    if (!dragging) showPrice();
  }

  private function onMouseOut(event:Event):Void {
    hidePrice();
  }
#end

  private function onMouseDown(event:Event):Void {
    if (room.canAfford(this)) {
      hidePrice();
      startX = x;
      startY = y;
      dragging = true;
      startDrag();
    }
  }

  private function onMouseUp(event:Event):Void {
    if (dragging) {
      stopDrag();
      dragging = false;
      if (startX == x && startY == y) {
#if mobile
        showPrice();
#end
        return;
      }
      var newItem:Item = new Item(itemName, price, false, room);
      newItem.x = x;
      newItem.y = y;
      x = startX;
      y = startY;
      room.purchase(newItem);
    }
  }

  private function showPrice():Void {
    room.addTooltip(new Tooltip('Price $$$price', this));
  }

  private function hidePrice():Void {
    room.removeTooltip();
  }
}
