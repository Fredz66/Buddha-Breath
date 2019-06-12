package gui;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class SettingsState extends FlxState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		// Show message.
      	add(new FlxText(0, 60 * Main.scale, FlxG.width, "Settings").setFormat(null, 32 * Main.scale, FlxColor.RED, FlxTextAlign.CENTER));

 		add(new FlxScaleButton(220 * Main.scale, 180 * Main.scale, "Graphics", keyboard));
 		add(new FlxScaleButton(220 * Main.scale, 200 * Main.scale, "Keyboard", keyboard));
 		add(new FlxScaleButton(220 * Main.scale, 220 * Main.scale, "Joypad", keyboard));
 		add(new FlxScaleButton(220 * Main.scale, 240 * Main.scale, "Volume", keyboard));

 		add(new FlxScaleButton(220 * Main.scale, 270 * Main.scale, "Back", back));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function keyboard():Void
	{
		FlxG.switchState(new KeyboardState());
 	}

	function back():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
