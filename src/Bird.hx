package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxMath;

class Bird extends FlxSprite
{
	private static inline var ACCELERATION:Int = 500;
	private static inline var DRAG:Int = 320;
	private static inline var GRAVITY:Int = 600;
	private static inline var JUMP_FORCE:Int = -280;
	private static inline var WALK_SPEED:Int = 100;
	private static inline var RUN_SPEED:Int = 150;
	private static inline var CROUCH_SPEED:Int = 50;
	private static inline var FALLING_SPEED:Int = 300;

	public var direction:Int = 1;

	public function new() 
	{
		super();

		loadGraphic(AssetPaths.bird__png, true, 20, 20);

		animation.add("idle", [2]);
		animation.add("fly", [0, 1, 2, 3, 4, 5], 12);

		drag.x = DRAG;
		acceleration.y = 20;
		maxVelocity.set(RUN_SPEED, FALLING_SPEED);

		x = 0;
		y = 0;
		velocity.x = 300;
	}

	override public function update(elapsed:Float):Void
	{
		move();
		animate();

		super.update(elapsed);
	}

	private function move() 
	{
		//trace(x, y, acceleration.x, acceleration.y, velocity.x, velocity.y);
		acceleration.x += ACCELERATION;
		if (y > 100)
			acceleration.y = -20;
	}
		
	private function animate() 
	{
		animation.play("fly");
	}
}