package;

import openfl.display.*;
import openfl.text.*;
import openfl.events.*;

class Dialog extends Sprite {
  public static var WIDTH:Int = 360;
  public static var HEIGHT:Int = 180;

  private var textField:TextField;
  private var okayButton:Button;

  public function new (text:String) {
    super ();
    makeTextField(text);
    makeOkayButton();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
  }

  private function makeTextField(text:String):Void {
    textField = new TextField();
    textField.text = text;
    textField.defaultTextFormat = new TextFormat("_typewriter", 16);
    textField.multiline = true;
    textField.wordWrap = true;
    textField.selectable = false;
  }

  private function makeOkayButton():Void {
    okayButton = new Button("Okay!", function (event:Event):Void {
      dispatchEvent(new DialogEvent(DialogEvent.OKAY_PRESSED));
    });
  }

  private function onDrawState(event:Event):Void {
    var startX = (stage.stageWidth - WIDTH) / 2;
    var startY = (stage.stageHeight - HEIGHT) / 2;
    // Remove the children
    while (numChildren > 0) removeChildAt(0);
    // Draw the shade
    graphics.clear();
    graphics.beginFill(GameColors.UI_SHADE_COLOR, GameColors.UI_SHADE_ALPHA);
    graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
    graphics.endFill();
    // Draw the border
    graphics.beginFill(GameColors.UI_EDGE_COLOR);
    graphics.drawRect(startX - 3, startY - 3, WIDTH + 6, HEIGHT + 6);
    graphics.endFill();
    // Draw the inside
    graphics.beginFill(GameColors.UI_BACKGROUND_COLOR);
    graphics.drawRect(startX, startY, WIDTH, HEIGHT);
    graphics.endFill();
    // Position the children
    textField.width = WIDTH - 8;
    textField.height = HEIGHT - 8;
    textField.x = startX + 4;
    textField.y = startY + 4;
    okayButton.x = (stage.stageWidth - okayButton.width) / 2;
    okayButton.y = startY + HEIGHT - okayButton.height;
    // Add the children
    addChild(textField);
    addChild(okayButton);
  }
}
