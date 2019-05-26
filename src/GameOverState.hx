package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class GameOverState extends FlxState
{
	override public function create():Void
	{
		super.create();

		// Show mouse cursor.
		FlxG.mouse.visible = true;

		// Show message.
      	add(new FlxText(0, 60, FlxG.width, "Game Over").setFormat(null, 32, FlxColor.RED, FlxTextAlign.CENTER));

		// Show start button.
 		add(new FlxButton(280, 180, "Retry", play));

		// Show main menu button.
 		add(new FlxButton(280, 210, "Main Menu", reset));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.anyPressed([W,X,C,SPACE])) {
			play();
		}
	}

	function play():Void
	{
		FlxG.switchState(new PlayState());
 	}

	function reset():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
