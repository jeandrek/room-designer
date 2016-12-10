package;

import openfl.*;
import openfl.display.*;
import openfl.text.*;
import openfl.geom.*;
import openfl.events.*;

class Button extends Sprite {
  private var upState:Sprite;
  private var downState:Sprite;

  public function new (text:String) {
    super ();
    buttonMode = true;
    upState = makeState(Assets.getBitmapData("assets/button-up.png"), text);
    downState = makeState(Assets.getBitmapData("assets/button-down.png"), text);
    addChild(upState);
    addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
  }

  private function makeState(image:BitmapData, text:String):Sprite {
    var state:Sprite = new Sprite();
    // Make the background
    var background:BitmapData = new BitmapData(20 + text.length * 10, 30);
    var x:Int = 0;
    background.copyPixels(image, new Rectangle(0, 0, 10, 30), new Point(x, 0));
    x += 10;
    for (charIndex in 0...text.length) {
      background.copyPixels(image, new Rectangle(10, 0, 10, 30), new Point(x, 0));
      x += 10;
    }
    background.copyPixels(image, new Rectangle(20, 0, 10, 30), new Point(x, 0));
    // Make the text field
    var textField:TextField = new TextField();
    textField.text = text;
    textField.defaultTextFormat = new TextFormat("_typewriter", 20);
    textField.selectable = false;
    textField.width = text.length * 12;
    textField.height = 32;
    textField.x = 4;
    textField.y = 2;
    // Finish the state
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
}
