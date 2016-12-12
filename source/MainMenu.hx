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
import openfl.system.*;
import openfl.display.*;
import openfl.geom.*;
import openfl.events.*;

class MainMenu extends GameState {
  private var verticalIndex:Float;
  private var buttons:Array<Button>;

  public function new (game:Game) {
    super (game);
    makeButtons();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
  }

  private function onDrawState(event:Event):Void {
    verticalIndex = 0;
    addLogo();
    addButtons();
  }

  private function addLogo():Void {
    // Scale the logo to fit on the stage.
    var logo:BitmapData = Assets.getBitmapData("assets/images/logo.png");
    var scale:Float = stage.stageWidth / logo.width;
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

  private function makeButtons():Void {
    buttons =
      [new Button("Play!", onPlayPressed),
#if !(html5 || flash)
       new Button("Quit", onQuitPressed)
#end];
  }

  private function addButtons():Void {
    for (button in buttons) {
      button.x = (stage.stageWidth - button.width) / 2;
      button.y = verticalIndex;
      addChild(button);
      verticalIndex += button.height + 4;
    }
  }

  private function onPlayPressed(event:Event):Void {
    game.useState(new Room(game));
  }

  private function onQuitPressed(event:Event):Void {
    System.exit(0);
  }
}
