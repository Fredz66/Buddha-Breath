package;

import flixel.FlxSprite;

class Fish extends FlxSprite
{
	public var ACCELERATION:Int;
	public var direction:Int = 1;

	private var maxHeight:Int = 0;
	private var accelerationY:Float = 0;

	public function new(x, y, accelerationY, velocity, maxHeight)
	{
		super();

		loadGraphic("assets/images/" + Main.scale + "/fish.png");

		animation.add("idle", [0]);

		allowCollisions = 0;

		ACCELERATION = 500 * Main.scale;
		drag.x = 320 * Main.scale;
		this.accelerationY = accelerationY;
		this.acceleration.y = this.accelerationY;
		maxVelocity.set(150 * Main.scale, 300 * Main.scale);

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