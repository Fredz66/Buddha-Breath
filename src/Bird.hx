package;

import flixel.FlxSprite;

class Bird extends FlxSprite
{
	public var direction:Int = 1;
	public var ACCELERATION:Int;

	private var minHeight:Int = 0;
	private var accelerationY:Float = 0;

	public function new(x, y, accelerationY, velocity, minHeight)
	{
		super();

		loadGraphic("assets/images/" + Main.scale + "/bird.png", true, 20 * Main.scale, 20 * Main.scale);

		animation.add("idle", [2]);
		animation.add("fly", [0, 1, 2, 3, 4, 5], 12);

		allowCollisions = 0;

		ACCELERATION = 500 * Main.scale;
		drag.x = 320 * Main.scale;
		this.accelerationY = accelerationY;
		this.acceleration.y = this.accelerationY;
		maxVelocity.set(150 * Main.scale, 300 * Main.scale);

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