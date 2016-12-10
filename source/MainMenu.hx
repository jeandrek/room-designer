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
    addBackground();
    addLogo();
    addButtons();
  }

  private function addBackground():Void {
    graphics.beginFill(0xfff8ea);
    graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
    graphics.endFill();
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
    // Display the scaled logo.
    addChild(new Bitmap(scaledLogo));
    verticalIndex += logo.height * scale;
  }

  private function addButtons():Void {
    // Make all the buttons.
    var buttons:Array<Button> =
        [new Button("Play!", onPlayPressed),
         new Button("Leaderboard", onLeaderboardPressed)];
    // Display them all.
    for (button in buttons) {
      button.x = (Lib.current.stage.stageWidth - button.width) / 2;
      button.y = verticalIndex;
      addChild(button);
      verticalIndex += button.height + 4;
    }
  }

  private function onPlayPressed(event:Event):Void {
    trace("Play button pressed!");
  }

  private function onLeaderboardPressed(event:Event):Void {
    trace("Leaderboard button pressed!");
  }
}
