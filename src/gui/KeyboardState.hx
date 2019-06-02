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
      	add(new FlxText(0, 180, FlxG.width, "Keyboard").setFormat(null, 96, FlxColor.RED, FlxTextAlign.CENTER));

		// Show controls.
		add(new FlxText(540, 360, FlxG.width, "Up").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(300, 360, FlxG.width, "up").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(540, 420, FlxG.width, "Down").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(300, 420, FlxG.width, "down").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(540, 480, FlxG.width, "Left").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(300, 480, FlxG.width, "left").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(540, 540, FlxG.width, "Right").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(300, 540, FlxG.width, "right").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(540, 600, FlxG.width, "Jump").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(300, 600, FlxG.width, "up").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(540, 660, FlxG.width, "Action").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));
		add(new FlxText(300, 660, FlxG.width, "Left-Ctrl").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.CENTER));

		add(new FlxText(540, 720, FlxG.width, "Reset to default").setFormat(null, 48, FlxColor.WHITE, FlxTextAlign.LEFT));

 		add(new FlxScaleButton(660, 810, "Back", reset));
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
