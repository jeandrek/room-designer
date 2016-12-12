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

import openfl.*;
import openfl.display.*;
import openfl.text.*;
import openfl.geom.*;
import openfl.events.*;

class Button extends Sprite {
  private var upState:Sprite;
  private var downState:Sprite;

  public function new (text:String, ?onPress:Event -> Void) {
    super ();
    buttonMode = true;
    upState = makeState(Assets.getBitmapData("assets/images/button-up.png"), text);
    downState = makeState(Assets.getBitmapData("assets/images/button-down.png"), text);
    addChild(upState);
    addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
    addEventListener(MouseEvent.CLICK, onClick);
    if (onPress != null)
      addEventListener(ButtonEvent.BUTTON_PRESS, onPress);
  }

  private function makeState(image:BitmapData, text:String):Sprite {
    var state:Sprite = new Sprite();
    // Make the background
    var background:BitmapData = new BitmapData(20 + text.length * 10, 30);
    var horizontalIndex:Int = 0;
    background.copyPixels(image, new Rectangle(0, 0, 10, 30), new Point(horizontalIndex, 0));
    horizontalIndex += 10;
    for (charIndex in 0...text.length) {
      background.copyPixels(image, new Rectangle(10, 0, 10, 30), new Point(horizontalIndex, 0));
      horizontalIndex += 10;
    }
    background.copyPixels(image, new Rectangle(20, 0, 10, 30), new Point(horizontalIndex, 0));
    // Make the text field
    var textField:TextField = new TextField();
    textField.text = text;
    textField.defaultTextFormat =
      new TextFormat("_typewriter", 18, null, null, null, null, null, null, TextFormatAlign.CENTER);
    textField.selectable = false;
    textField.width = text.length * 12;
    textField.height = 32;
    textField.x = 0;
    textField.y = 2;
    // Add everything to the state
    state.addChild(new Bitmap(background));
    state.addChild(textField);
    return state;
  }

  private function onMouseOver(event:Event):Void {
    removeChild(upState);
    addChild(downState);
  }

  private function onMouseOut(event:Event):Void {
    removeChild(downState);
    addChild(upState);
  }

  private function onClick(event:Event):Void {
    dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_PRESS));
  }
}
