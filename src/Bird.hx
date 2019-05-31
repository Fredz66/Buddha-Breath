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

	private var minHeight:Int = 0;
	private var accelerationY:Float = 0;

	public function new(x, y, accelerationY, velocity, minHeight)
	{
		super();

		loadGraphic(AssetPaths.bird__png, true, 20, 20);

		animation.add("idle", [2]);
		animation.add("fly", [0, 1, 2, 3, 4, 5], 12);

		drag.x = DRAG;
		this.accelerationY = accelerationY;
		this.acceleration.y = this.accelerationY;
		maxVelocity.set(RUN_SPEED, FALLING_SPEED);

		this.x = x;
		this.y = y;
		this.velocity.x = velocity;
		this.minHeight = minHeight;
	}

	override public function update(elapsed:Float):Void
	{
		move();
		animate();

		super.update(elapsed);
	}

	private function move() 
	{
		if (velocity.x < 0) {
			acceleration.x -= ACCELERATION;
		} else {
			acceleration.x += ACCELERATION;
		}
		
		if (y > minHeight)
			acceleration.y = -accelerationY;
	}
		
	private function animate() 
	{
		animation.play("fly");
	}
}