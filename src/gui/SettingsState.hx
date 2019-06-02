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
      	add(new FlxText(0, 180, FlxG.width, "Settings").setFormat(null, 96, FlxColor.RED, FlxTextAlign.CENTER));

 		add(new FlxScaleButton(660, 540, "Graphics", keyboard));
 		add(new FlxScaleButton(660, 600, "Keyboard", keyboard));
 		add(new FlxScaleButton(660, 660, "Joypad", keyboard));
 		add(new FlxScaleButton(660, 720, "Volume", keyboard));

 		add(new FlxScaleButton(660, 810, "Back", back));
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
