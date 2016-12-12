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

class Game extends Sprite {
  private var state:GameState = null;

  public function new () {
    super ();
    Item.addItemTypes();
    useState(new MainMenu(this));
  }

  public function useState(newState:GameState):Void {
    if (state != null) removeChild(state);
    state = newState;
    addChild(state);
    state.drawState();
    stage.addEventListener(Event.RESIZE, onStageResize);
  }

  private function onStageResize(event:Event):Void {
    state.drawState();
  }
}
