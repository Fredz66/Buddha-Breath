package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class KeyboardState extends FlxState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		// Show message.
      	add(new FlxText(0, 60, FlxG.width, "Keyboard").setFormat(null, 32, FlxColor.RED, FlxTextAlign.CENTER));

		// Show controls.
		add(new FlxText(180, 120, FlxG.width, "Up").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100, 120, FlxG.width, "up").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180, 140, FlxG.width, "Down").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100, 140, FlxG.width, "down").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180, 160, FlxG.width, "Left").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100, 160, FlxG.width, "left").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180, 180, FlxG.width, "Right").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100, 180, FlxG.width, "right").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180, 200, FlxG.width, "Jump").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100, 200, FlxG.width, "up").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180, 220, FlxG.width, "Action").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100, 220, FlxG.width, "Left-Ctrl").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180, 240, FlxG.width, "Reset to default").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.LEFT));

 		add(new FlxButton(220, 270, "Back", reset));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	function reset():Void
	{
		FlxG.switchState(new SettingsState());
 	}
}
