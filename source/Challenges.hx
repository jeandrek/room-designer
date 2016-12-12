package;

import haxe.*;
import openfl.*;
import openfl.display.*;
import openfl.text.*;
import openfl.events.*;

typedef Challenge = {
  var description:String;
  var requirements:DynamicAccess<Int>;
  var reward:Int;
}

class Challenges extends Sidebar {
  private var allChallenges:Array<Challenge>;
  private var currentChallenge:Challenge;
  private var completedChallenges:Int;
  private var room:Room;

  public function new (room2:Room) {
    super ();
    room = room2;
    room.addEventListener(RoomEvent.PURCHASE, onPurchase);
    makeChallenges();
    addEventListener(SidebarEvent.DRAW_SIDEBAR, onDrawSidebar);
  }

  private function makeChallenges():Void {
    allChallenges = Json.parse(Assets.getText("assets/data/challenges.json"));
    completedChallenges = 0;
    startChallenge();
  }

  private function startChallenge():Void {
    currentChallenge = allChallenges[completedChallenges];
  }

  private function onPurchase(event:Event):Void {
    if (completedChallenges + 1 < allChallenges.length &&
        room.meetsRequirements(currentChallenge.requirements)) {
      room.claimReward(currentChallenge.reward);
      room.showCompletion(currentChallenge.reward);
      completedChallenges++;
      startChallenge();
    }
  }

  private function onDrawSidebar(event:Event):Void {
    addText();
  }

  private function addText():Void {
    var textField:TextField = new TextField();
    textField.htmlText =
      '<font face="_typewriter" size="16"><b>Completed challenges:</b> $completedChallenges' +
      '<br><br><b>Current challenge:</b><br>${currentChallenge.description}<br><br>Reward: ' +
      '$$${currentChallenge.reward}</font>';
    textField.wordWrap = true;
    textField.multiline = true;
    textField.selectable = false;
    textField.width = width - 4;
    textField.height = height - 4;
    textField.x = 2;
    textField.y = 2;
    addChild(textField);
  }
}
