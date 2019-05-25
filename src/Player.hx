package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

import flixel.math.FlxMath;

class Player extends FlxSprite
{
	private static inline var ACCELERATION:Int = 320;
	private static inline var DRAG:Int = 320;
	private static inline var GRAVITY:Int = 600;
	private static inline var JUMP_FORCE:Int = -280;
	private static inline var WALK_SPEED:Int = 120;
	private static inline var RUN_SPEED:Int = 200;
	private static inline var FALLING_SPEED:Int = 300;

	public var direction:Int = 1;

	public function new() 
	{
		super();
		loadGraphic(AssetPaths.spritesProto__png, true, 68, 80);

		animation.add("idle", [0] );
		animation.add("walk", [0, 1, 2, 3, 4, 5, 6 ], 14);
		animation.add("skid", [0]);
		animation.add("jump", [0]);
		animation.add("fall", [0]);
		//animation.add("attack", [26,27,28,29],8);

		setSize(40, 76);
		offset.set(24, 4);
		
		drag.x = DRAG;
		acceleration.y = GRAVITY;
		maxVelocity.set(WALK_SPEED, FALLING_SPEED);
	}

	override public function update(elapsed:Float):Void
	{
		move();		
		animate();	

		super.update(elapsed);
	}

	private function move() 
	{
		acceleration.x = 0;
		
		if (FlxG.keys.pressed.LEFT) 
		{
			flipX = true;
			setSize(40, 76);
			offset.set(4, 4);
			direction = -1;
			acceleration.x -= ACCELERATION;

		} 
		else if (FlxG.keys.pressed.RIGHT)
		{
			flipX = false;
			setSize(40, 76);
			offset.set(24, 4);
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0)
		{
			if (FlxG.keys.justPressed.SPACE && isTouching(FlxObject.FLOOR))
				velocity.y = JUMP_FORCE;

			if (FlxG.keys.pressed.W)
				maxVelocity.x = RUN_SPEED;
			else
				maxVelocity.x = WALK_SPEED;
		}

		if ((velocity.y < 0) && (FlxG.keys.justReleased.SPACE))
			velocity.y = velocity.y * 0.5;
	}
		
	private function animate() 
	{
		if ((velocity.y <= 0) && (!isTouching(FlxObject.FLOOR)))
			animation.play("jump");
		else if (velocity.y > 0) 
			animation.play("fall");
		else if (velocity.x == 0) 
			animation.play("idle");
		else 
		{
			if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction)) 
				animation.play("skid");
			else 
				animation.play("walk");
		}
	}
}