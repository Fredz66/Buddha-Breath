package;

import flixel.FlxSprite;

class Fish extends FlxSprite
{
	private static inline var ACCELERATION:Int = 500 * 3;
	private static inline var DRAG:Int = 320 * 3;
	private static inline var GRAVITY:Int = 600 * 3;
	private static inline var JUMP_FORCE:Int = -280 * 3;
	private static inline var WALK_SPEED:Int = 100 * 3;
	private static inline var RUN_SPEED:Int = 150 * 3;
	private static inline var CROUCH_SPEED:Int = 50 * 3;
	private static inline var FALLING_SPEED:Int = 300 * 3;

	public var direction:Int = 1;

	private var maxHeight:Int = 0;
	private var accelerationY:Float = 0;

	public function new(x, y, accelerationY, velocity, maxHeight)
	{
		super();

		loadGraphic(AssetPaths.fish__png);

		animation.add("idle", [0]);

		drag.x = DRAG;
		this.accelerationY = accelerationY;
		this.acceleration.y = this.accelerationY;
		maxVelocity.set(RUN_SPEED, FALLING_SPEED);

		this.x = x;
		this.y = y;
		this.velocity.x = velocity;
		this.maxHeight = maxHeight;
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
		
		if (y > maxHeight)
			acceleration.y = -accelerationY;
	}
		
	private function animate() 
	{
		animation.play("idle");
	}
}