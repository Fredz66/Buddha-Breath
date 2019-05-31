package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

enum Menu
{
	PLAY;
	LOAD;
	SETTINGS;
	QUIT;
}

class MenuState extends FlxState
{
	override public function create():Void
	{
		FlxG.mouse.visible = true;

      	add(new FlxText(0, 60, FlxG.width, "Buddha Breath").setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER));

 		add(new FlxButton(280, 180, "New game", play));
		add(new FlxButton(280, 200, "Settings", settings));
		add(new FlxButton(280, 220, "Quit", quit));

		#if html5
		var button = new FlxButton(10, 10, "Fullscreen", function() FlxG.fullscreen = !FlxG.fullscreen);
		add(button);
		#end

		super.create();

		FlxG.sound.playMusic(AssetPaths.temple_nometadata__ogg, 1, true);
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
