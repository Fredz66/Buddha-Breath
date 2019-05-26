package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class QuitState extends FlxState
{
	override public function create():Void
	{
		super.create();

		// Show mouse cursor.
		FlxG.mouse.visible = true;

		// Show message.
      	add(new FlxText(0, 60, FlxG.width, "Are you sure ?").setFormat(null, 32, FlxColor.RED, FlxTextAlign.CENTER));

		// Show start button.
 		add(new FlxButton(280, 180, "Quit", quit));

		// Show main menu button.
 		add(new FlxButton(280, 210, "Main Menu", menu));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function quit():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() { openfl.system.System.exit(0); });
 	}

	function menu():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
