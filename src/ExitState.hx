package;

import flixel.FlxSprite;
import openfl.display.Sprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ExitState extends FlxSubState
{
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = !FlxG.onMobile;

		var background = new FlxSprite();
		background.loadGraphic("assets/images/popup.png");
		background.setPosition(
			FlxG.camera.scroll.x + (FlxG.camera.width - background.width) / 2,
			FlxG.camera.scroll.y + (FlxG.camera.height - background.height) / 2);
		add (background);

		// Show main menu button.
 		add(new FlxButton(280, 160, "Back", back));

		// Show start button.
 		add(new FlxButton(280, 200, "Main menu", menu));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
			close();
		}
	}

	function back():Void
	{
		FlxG.mouse.visible = false;
		close();
 	}

	function menu():Void
	{
		FlxG.switchState(new MenuState());
 	}
}
