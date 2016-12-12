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
import openfl.events.*;

class Sidebar extends Sprite {
  public function new () {
    super ();
    addEventListener(GameStateEvent.DRAW_STATE, onDrawState);
  }

  private function onDrawState(event:Event):Void {
    while (numChildren > 0) removeChildAt(0);
    addBackground();
  }

  private function addBackground():Void {
    graphics.clear();
    graphics.beginFill(GameColors.UI_BACKGROUND_COLOR);
    graphics.drawRect(0, 0, stage.stageWidth / 4, stage.stageHeight);
    graphics.endFill();
    graphics.beginFill(GameColors.UI_EDGE_COLOR);
    graphics.drawRect(stage.stageWidth / 4, 0, 2, stage.stageHeight);
    graphics.endFill();
    dispatchEvent(new SidebarEvent(SidebarEvent.DRAW_SIDEBAR));
  }
}
