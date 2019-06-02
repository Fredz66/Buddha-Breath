package gui;

#if html5
import flixel.ui.FlxButton;
#end
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	override public function create():Void
	{
		// Display version number.
		add(new FlxText(0, 1044, FlxG.width, "v0.8-alpha").setFormat(null, 24));

		FlxG.mouse.visible = !FlxG.onMobile;

      	add(new FlxText(0, 180, FlxG.width, "Buddha Breath").setFormat(null, 192, FlxColor.RED, FlxTextAlign.CENTER));

 		add(new FlxScaleButton(840, 540, "New game", play));
		add(new FlxScaleButton(840, 600, "Settings", settings));
		add(new FlxScaleButton(840, 660, "Quit", quit));

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

		var button:FlxButton = new FlxButton(1710, 870, "", function() FlxG.fullscreen = !FlxG.fullscreen);
		button.loadGraphic("assets/images/fullscreen.png");
		add(button);
		#end

		#if mobile
		platforms += "mobile ";
		#end

		add(new FlxText(0, 1014, FlxG.width, platforms).setFormat(null, 24));

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
