package gui;

import flixel.FlxGame;
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
		add(new FlxText(0, 1044 / FlxG.initialZoom, FlxG.width, "v0.9.1-alpha").setFormat(null, Std.int(24 / FlxG.initialZoom)));

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

		platforms += " (" + openfl.system.Capabilities.screenResolutionX + "x" + openfl.system.Capabilities.screenResolutionY + ")";
		platforms += " (" + FlxG.stage.stageWidth + "x" + FlxG.stage.stageHeight + ")";

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
		switch (Main.level) {
			case 1 : FlxG.switchState(new Level1State());
			case 2 : FlxG.switchState(new Level2State());
		}
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
