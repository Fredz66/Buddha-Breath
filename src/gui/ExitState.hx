package gui;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxG;

class ExitState extends FlxSubState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		var background = new FlxSprite();
		background.loadGraphic("assets/images/" + Main.scale + "/popup.png");
		background.scale.set(Main.scale, Main.scale);
		background.setPosition(
			FlxG.camera.scroll.x + (FlxG.camera.width - background.width) / 2,
			FlxG.camera.scroll.y + (FlxG.camera.height - background.height) / 2);
		add (background);

		// Show main menu button.
 		add(new FlxScaleButton(280 * Main.scale, 160 * Main.scale, "Back", back));

		// Show start button.
 		add(new FlxScaleButton(280 * Main.scale, 200 * Main.scale, "Main menu", menu));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.mouse.visible = false;
			FlxG.sound.resume();
			close();
		}
	}

	function back():Void
	{
		FlxG.mouse.visible = false;
		FlxG.sound.resume();
		close();
 	}

	function menu():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
