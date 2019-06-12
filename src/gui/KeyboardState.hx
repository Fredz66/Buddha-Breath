package gui;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class KeyboardState extends FlxState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		// Show message.
      	add(new FlxText(0, 60 * Main.scale, FlxG.width, "Keyboard").setFormat(null, 32 * Main.scale, FlxColor.RED, FlxTextAlign.CENTER));

		// Show controls.
		add(new FlxText(180 * Main.scale, 120 * Main.scale, FlxG.width, "Up").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100 * Main.scale, 120 * Main.scale, FlxG.width, "up").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180 * Main.scale, 140 * Main.scale, FlxG.width, "Down").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100 * Main.scale, 140 * Main.scale, FlxG.width, "down").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180 * Main.scale, 160 * Main.scale, FlxG.width, "Left").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100 * Main.scale, 160 * Main.scale, FlxG.width, "left").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180 * Main.scale, 180 * Main.scale, FlxG.width, "Right").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100 * Main.scale, 180 * Main.scale, FlxG.width, "right").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180 * Main.scale, 200 * Main.scale, FlxG.width, "Jump").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100 * Main.scale, 200 * Main.scale, FlxG.width, "up").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180 * Main.scale, 220 * Main.scale, FlxG.width, "Action").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(100 * Main.scale, 220 * Main.scale, FlxG.width, "Left-Ctrl").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(180 * Main.scale, 240 * Main.scale, FlxG.width, "Reset to default").setFormat(null, 16 * Main.scale, FlxColor.WHITE, FlxTextAlign.LEFT));

 		add(new FlxScaleButton(220 * Main.scale, 270 * Main.scale, "Back", reset));
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
