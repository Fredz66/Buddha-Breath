package gui;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class WinState extends FlxState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		// Show message.
      	add(new FlxText(0, 180, FlxG.width, "Level " + Main.level + " completed !").setFormat(null, 96, FlxColor.RED, FlxTextAlign.CENTER));

		// Show start button.
 		add(new FlxScaleButton(840, 540, "Continue", play));

		// Show main menu button.
 		add(new FlxScaleButton(840, 630, "Main Menu", reset));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.anyPressed([W,X,C,SPACE])) {
			play();
		}
	}

	function play():Void
	{
		Main.level += 1;

		switch (Main.level) {
			case 1 : FlxG.switchState(new Level1State());
			case 2 : FlxG.switchState(new Level2State());
			default: 
				Main.level = 1;
				FlxG.switchState(new MenuState());
		}
 	}

	function reset():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
