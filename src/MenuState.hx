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
		FlxG.mouse.visible = !FlxG.onMobile;

      	add(new FlxText(0, 60, FlxG.width, "Buddha Breath").setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER));

 		add(new FlxButton(280, 180, "New game", play));
		add(new FlxButton(280, 200, "Settings", settings));
		add(new FlxButton(280, 220, "Quit", quit));

		var platforms:String = "";

		#if desktop
		platforms += "desktop ";
		#end

		#if html5
		platforms += "html5 ";

		if (FlxG.onMobile) {
			platforms += "(mobile) ";
		} else {
			platforms += "(desktop) ";
		}

		var button = new FlxButton(570, 290, "", function() FlxG.fullscreen = !FlxG.fullscreen);
		button.loadGraphic("assets/images/fullscreen.png");
		add(button);
		#end

		#if mobile
		platforms += "mobile ";
		#end

		add(new FlxText(0, 338, FlxG.width, platforms).setFormat(null, 8));
		add(new FlxText(0, 348, FlxG.width, "v0.5").setFormat(null, 8));

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
