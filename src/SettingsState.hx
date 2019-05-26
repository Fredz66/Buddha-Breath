package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class SettingsState extends FlxState
{
	override public function create():Void
	{
		super.create();

		// Show mouse cursor.
		FlxG.mouse.visible = true;

		// Show message.
      	add(new FlxText(0, 60, FlxG.width, "Settings").setFormat(null, 32, FlxColor.RED, FlxTextAlign.CENTER));

		// Show main menu button.
 		add(new FlxButton(280, 210, "Main Menu", reset));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function reset():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
