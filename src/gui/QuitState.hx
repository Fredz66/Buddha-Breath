package gui;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class QuitState extends FlxState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		// Show message.
      	add(new FlxText(0, 60 * Main.scale, FlxG.width, "Are you sure ?").setFormat(null, 32 * Main.scale, FlxColor.RED, FlxTextAlign.CENTER));

		// Show main menu button.
 		add(new FlxScaleButton(280 * Main.scale, 180 * Main.scale, "Main Menu", menu));

		// Show start button.
 		add(new FlxScaleButton(280 * Main.scale, 210 * Main.scale, "Quit", quit));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function quit():Void
	{
		FlxG.sound.music.stop();
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() { openfl.system.System.exit(0); });
 	}

	function menu():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
