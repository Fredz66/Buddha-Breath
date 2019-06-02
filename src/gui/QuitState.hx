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
      	add(new FlxText(0, 180, FlxG.width, "Are you sure ?").setFormat(null, 96, FlxColor.RED, FlxTextAlign.CENTER));

		// Show main menu button.
 		add(new FlxScaleButton(840, 540, "Main Menu", menu));

		// Show start button.
 		add(new FlxScaleButton(840, 630, "Quit", quit));
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
