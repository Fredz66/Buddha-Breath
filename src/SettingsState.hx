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

 		add(new FlxButton(220, 180, "Graphics", keyboard));
 		add(new FlxButton(220, 200, "Keyboard", keyboard));
 		add(new FlxButton(220, 220, "Joypad", keyboard));
 		add(new FlxButton(220, 240, "Volume", keyboard));

 		add(new FlxButton(220, 270, "Back", back));
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
