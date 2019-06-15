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
		add(new FlxText(0, 348 * Main.scale, FlxG.width, Main.version).setFormat(null, 8  * Main.scale));

		FlxG.mouse.visible = !FlxG.onMobile;

      	add(new FlxText(0, 60 * Main.scale, FlxG.width, "Buddha Breath").setFormat(null, 64 * Main.scale, FlxColor.RED, FlxTextAlign.CENTER));

 		add(new FlxScaleButton(280 * Main.scale, 180 * Main.scale, "New game", play));
		add(new FlxScaleButton(280 * Main.scale, 200 * Main.scale, "Settings", settings));
		add(new FlxScaleButton(280 * Main.scale, 220 * Main.scale, "Quit", quit));

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

		var button:FlxButton = new FlxButton(570 * Main.scale, 290 * Main.scale, "", function() FlxG.fullscreen = !FlxG.fullscreen);
		button.loadGraphic("assets/images/" + Main.scale + "/fullscreen.png");
		add(button);
		#end

		#if mobile
		platforms += "mobile ";
		#end

		platforms += " (" + openfl.system.Capabilities.screenResolutionX + "x" + openfl.system.Capabilities.screenResolutionY + ")";
		platforms += " (" + FlxG.stage.stageWidth + "x" + FlxG.stage.stageHeight + ")";

		add(new FlxText(0, 338 * Main.scale, FlxG.width, platforms).setFormat(null, 8 * Main.scale));

		super.create();

		FlxG.sound.music.stop();
		FlxG.sound.playMusic("assets/music/temple-nometadata.ogg", 1, true);
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
