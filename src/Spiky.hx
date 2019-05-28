package;

import flixel.FlxSprite;

class Spiky extends FlxSprite
{
	private var speed = 2;
	public var direction:Int = 1;

	public function new() 
	{
		super();

		loadGraphic(AssetPaths.spiky__png, true, 47, 186);

		angularVelocity = 150;
	}

	override public function update(elapsed:Float):Void
	{
		if (direction == 1) {
			if (angle >= 0) {
				angularVelocity -= speed;
			} else {
				angularVelocity += speed;
			}
			if (angularVelocity <= 0) {
				direction = -1;
				angularVelocity = -1;
			}
		} else {
			if (angle >= 0) {
				angularVelocity -= speed;
			} else {
				angularVelocity += speed;
			}
			if (angularVelocity >= 0) {
				direction = 1;
				angularVelocity = 1;
			}
		}
		super.update(elapsed);
	}
}