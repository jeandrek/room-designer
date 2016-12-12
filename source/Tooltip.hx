package;

import openfl.display.*;
import openfl.text.*;
import openfl.events.*;

class Tooltip extends Sprite {
  private var text:String;
  private var textField:TextField;

  public function new (text2:String) {
    super ();
    text = text2;
    makeTextField();
    addEventListener(Event.ENTER_FRAME, onEnterFrame);
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

  private function onEnterFrame(event:Event):Void {
    if (stage != null) {
      x = stage.mouseX;
      y = stage.mouseY;
      if (numChildren > 0) removeChild(textField);
      addBackground();
      addChild(textField);
    }
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
