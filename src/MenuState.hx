package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	override public function create():Void
	{
		super.create();

		// Show title.
      	add(new FlxText(0, 60, FlxG.width, "Buddha Breath").setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER));

		// Show controls.
		add(new FlxText(0, 270, FlxG.width, "Run : <- ->").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));
		add(new FlxText(0, 290, FlxG.width, "Walk : W").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));
		add(new FlxText(0, 310, FlxG.width, "Jump : SPACE").setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER));

		// Show start button.
 		add(new FlxButton(280, 180, "New game", play));

		// Show start button.
		add(new FlxButton(280, 200, "Settings", settings));

		// Show quit button.
		add(new FlxButton(280, 220, "Quit", quit));
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
		FlxG.switchState(new PlayState());
 	}

	function settings():Void
	{
		FlxG.switchState(new SettingsState());
 	}

	function quit():Void
	{
		FlxG.switchState(new QuitState());
 	}
}
