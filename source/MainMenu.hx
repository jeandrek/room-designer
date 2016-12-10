package;

import openfl.*;
import openfl.display.*;
import openfl.geom.*;
import openfl.events.*;

class MainMenu extends GameState {
  public function new () {
    super ();
    drawMenu();
    Lib.current.stage.addEventListener(Event.RESIZE, onStageResize);
  }

  private function onStageResize(event:Event):Void {
    // Remove everything on the menu.
    while (numChildren > 0) removeChildAt(0);
    // Redraw the menu.
    drawMenu();
  }

  private var verticalIndex:Float;
  
  private function drawMenu():Void {
    verticalIndex = 0;
    addLogo();
    addButtons();
  }

  private function addLogo():Void {
    // Scale the logo to fit on the stage.
    var logo:BitmapData = Assets.getBitmapData("assets/logo.png");
    var scale:Float = Lib.current.stage.stageWidth / logo.width;
    var matrix:Matrix = new Matrix();
    var scaledLogo:BitmapData =
        new BitmapData(Math.floor(logo.width * scale),
                       Math.floor(logo.height * scale),
                       true, 0x000000);
    matrix.scale(scale, scale);
    scaledLogo.draw(logo, matrix, null, null, null, true);
    // Show the scaled logo.
    addChild(new Bitmap(scaledLogo));
    verticalIndex += logo.height * scale;
  }

  private function addButtons():Void {
    var playButton:Button = new Button("Play!");
    playButton.x = (Lib.current.stage.stageWidth - playButton.width) / 2;
    playButton.y = verticalIndex;
    addChild(playButton);
    verticalIndex += playButton.height + 2;
  }
}
