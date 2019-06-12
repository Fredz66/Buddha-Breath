package;

import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;

class VirtualPad extends FlxSpriteGroup
{
	public var offsetLeftRight:Int = 30;

	public var buttonLeft:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonAction:FlxButton;

	// Move the virtual floating pad at the position of each initial touch if it's in the left half of the screen.
	// Uses an offset between the left/right buttons.
	/*if (FlxG.onMobile) {
		if (FlxG.mouse.justPressed) {
			if (FlxG.mouse.x - camera.scroll.x < FlxG.camera.width / 2) {
				var position:FlxPoint = new FlxPoint(FlxG.mouse.x - camera.scroll.x, FlxG.mouse.y - camera.scroll.y);
				buttonLeft.setPosition(position.x - buttonLeft.width - virtualPadOffset, position.y - (buttonLeft.height / 2) - 1);
				buttonRight.setPosition(position.x + virtualPadOffset, position.y - (buttonRight.height / 2) - 1);
			}
		}
	}*/

	public function new()
	{
		super();
		scrollFactor.set();

		var spriteRight:FlxSprite = new FlxSprite().loadGraphic("assets/images/" + Main.scale + "/buttonRight.png");
		var spriteUp:FlxSprite = new FlxSprite().loadGraphic("assets/images/" + Main.scale + "/buttonUp.png");
		var spriteAction:FlxSprite = new FlxSprite().loadGraphic("assets/images/" + Main.scale + "/buttonAction.png");

		buttonLeft = new FlxButton(0, FlxG.height - spriteRight.height, "");
		buttonLeft.loadGraphicFromSprite(spriteRight);
		buttonLeft.solid = false;
		buttonLeft.immovable = true;
		buttonLeft.scrollFactor.set();
		add(buttonLeft);
		buttonLeft.flipX = true;

		buttonRight = new FlxButton(spriteRight.width + offsetLeftRight, FlxG.height - spriteRight.height, "");
		buttonRight.loadGraphicFromSprite(spriteRight);
		buttonRight.solid = false;
		buttonRight.immovable = true;
		buttonRight.scrollFactor.set();
		add(buttonRight);

		buttonAction = new FlxButton(FlxG.width - spriteAction.width, spriteAction.height, "");
		buttonAction.loadGraphicFromSprite(spriteAction);
		buttonAction.solid = false;
		buttonAction.immovable = true;
		buttonAction.scrollFactor.set();
		add(buttonAction);

		buttonUp = new FlxButton(FlxG.width - spriteUp.width, FlxG.height - 2 *spriteUp.height - offsetLeftRight, "");
		buttonUp.loadGraphicFromSprite(spriteUp);
		buttonUp.solid = false;
		buttonUp.immovable = true;
		buttonUp.scrollFactor.set();
		add(buttonUp);

		buttonDown = new FlxButton(FlxG.width - spriteUp.width, FlxG.height - spriteUp.height, "");
		buttonDown.loadGraphicFromSprite(spriteUp);
		buttonDown.solid = false;
		buttonDown.immovable = true;
		buttonDown.scrollFactor.set();
		add(buttonDown);
		buttonDown.flipY = true;
	}

	override public function destroy():Void
	{
		super.destroy();
		
		buttonLeft = null;
		buttonRight = null;
		buttonUp = null;
		buttonDown = null;
		buttonAction = null;
	}
}