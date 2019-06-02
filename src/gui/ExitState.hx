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
		background.loadGraphic("assets/images/popup.png");
		background.scale.set(3, 3);
		background.setPosition(
			FlxG.camera.scroll.x + (FlxG.camera.width - background.width) / 2,
			FlxG.camera.scroll.y + (FlxG.camera.height - background.height) / 2);
		add (background);

		// Show main menu button.
 		add(new FlxScaleButton(840, 480, "Back", back));

		// Show start button.
 		add(new FlxScaleButton(840, 600, "Main menu", menu));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
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
