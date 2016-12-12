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

import openfl.display.*;
import openfl.text.*;
import openfl.events.*;

class Tooltip extends Sprite {
  private var text:String;
  private var textField:TextField;

  public function new (text2:String, object:DisplayObject) {
    super ();
    text = text2;
    makeTextField();
#if mobile
    x = object.x + object.width / 2;
    y = object.y + object.height / 2;
    drawTooltip();
#else
    addEventListener(Event.ENTER_FRAME, onEnterFrame);
#end
  }

  private function makeTextField():Void {
    textField = new TextField();
    textField.text = text;
    textField.defaultTextFormat = new TextFormat("_typewriter", 18);
    textField.selectable = false;
    textField.width = text.length * 14;
    textField.x = 2;
    textField.y = 0;
  }

#if (!mobile)
  private function onEnterFrame(event:Event):Void {
    if (stage != null) {
      x = stage.mouseX;
      y = stage.mouseY;
      if (numChildren > 0) removeChild(textField);
      drawTooltip();
    }
  }
#end

  private function drawTooltip():Void {
    addBackground();
    addChild(textField);
  }

  private function addBackground():Void {
    graphics.beginFill(GameColors.UI_EDGE_COLOR);
    graphics.drawRect(0, 0, text.length * 12 + 4, 26);
    graphics.endFill();
    graphics.beginFill(GameColors.TOOLTIP_BACKGROUND_COLOR);
    graphics.drawRect(2, 2, text.length * 12, 22);
    graphics.endFill();
  }
}
