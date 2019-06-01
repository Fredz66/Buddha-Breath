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
	private static inline var WALK_SPEED:Int = 100;
	private static inline var RUN_SPEED:Int = 150;
	private static inline var CROUCH_SPEED:Int = 50;
	private static inline var FALLING_SPEED:Int = 300;

	public var direction:Int = 1;
	public var crouch:Bool = false;

	// First position.
	public var startx:Int = 60;
	public var starty:Int = 150;

	// Second position.
	//public var startx:Int = 1400;
	//public var starty:Int = 310;

	// Third position.
	//public var startx:Int = 2500;
	//public var starty:Int = 310;

	// End position.
	//public var startx:Int = 4100;
	//public var starty:Int = 310;

	public function new() 
	{
		super();
		loadGraphic(AssetPaths.litang__png, true, 68, 80);

		animation.add("idle", [0, 1], 6);
		animation.add("walk", [2, 3, 4, 5, 6], 12);
		animation.add("crouch", [8, 9], 6);
		animation.add("crouch-walk", [8, 9], 12);
		animation.add("skid", [0, 1], 6);
		animation.add("jump", [17]);
		animation.add("fall", [17]);
		animation.add("hit", [16]);
		//animation.add("attack", [26,27,28,29],8);

		setSize(30, 76);
		offset.set(24, 4);
		
		drag.x = DRAG;
		acceleration.y = GRAVITY;
		maxVelocity.set(RUN_SPEED, FALLING_SPEED);

		x = startx;
		y = starty;
	}

	override public function update(elapsed:Float):Void
	{
		if (alive) {
			move();
			animate();
		}

		super.update(elapsed);
	}

	private function move() 
	{
		acceleration.x = 0;
		
		if (FlxG.keys.pressed.LEFT || PlayState.buttonLeft.pressed)
		{
			flipX = true;
			setSize(30, 76);
			offset.set(14, 4);
			direction = -1;
			acceleration.x -= ACCELERATION;

		} 
		else if (FlxG.keys.pressed.RIGHT || PlayState.buttonRight.pressed)
		{
			flipX = false;
			setSize(30, 76);
			offset.set(24, 4);
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0)
		{
			if ((FlxG.keys.justPressed.UP || PlayState.buttonJump.pressed) && isTouching(FlxObject.FLOOR)) {
				FlxG.sound.play(AssetPaths.jump__ogg, 1);
				velocity.y = JUMP_FORCE;
			}

			if ((FlxG.keys.pressed.DOWN || PlayState.buttonCrouch.pressed) && isTouching(FlxObject.FLOOR)) {
				crouch = true;
				maxVelocity.x = CROUCH_SPEED;
			} else {
				crouch = false;
				maxVelocity.x = RUN_SPEED;
			}

			/*if (FlxG.keys.pressed.W)
				maxVelocity.x = WALK_SPEED;
			else
				maxVelocity.x = RUN_SPEED;*/
		} else {
			if ((FlxG.keys.justPressed.UP || PlayState.buttonJump.justPressed) && isTouching(FlxObject.FLOOR)) {
				FlxG.sound.play(AssetPaths.jump__ogg, 1);
				velocity.y = JUMP_FORCE;
			}
		}
	}
		
	private function animate() 
	{
		if ((velocity.y <= 0) && (!isTouching(FlxObject.FLOOR))) {
			animation.play("jump");
		} else if (velocity.y > 0) {
			animation.play("fall");
		} else if (velocity.x == 0) {
			if (crouch) {
				animation.play("crouch");
			} else {
				animation.play("idle");
			}
		} else {
			if (crouch) {
				animation.play("crouch-walk");
			} else {
				if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction)) {
					animation.play("skid");
				} else {
					animation.play("walk");
				}
			}
		}
	}
}