package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxMath;

class Player extends FlxSprite
{
	private var ACCELERATION:Int;
	private var JUMP_FORCE:Int;
	private var WALK_SPEED:Int;
	private var RUN_SPEED:Int;
	private var CROUCH_SPEED:Int;
	private var FALLING_SPEED:Int;

	public var direction:Int = 1;
	public var crouch:Bool = false;
	public var drown:Bool = false;

	// Initial position.
	public var startx:Int;
	public var starty:Int;

	public function new(X:Int, Y:Int) 
	{
		super();

		startx = X;
		starty = Y;

		ACCELERATION = 333 * Main.scale;
		JUMP_FORCE = -280 * Main.scale;
		WALK_SPEED = 100 * Main.scale;
		RUN_SPEED = 167 * Main.scale;
		CROUCH_SPEED = 50 * Main.scale;
		FALLING_SPEED = 300 * Main.scale;

		loadGraphic("assets/images/" + Main.scale + "/litang.png", true, 68 * Main.scale, 80 * Main.scale);

		animation.add("idle", [0, 1], 6);
		animation.add("walk", [2, 3, 4, 5, 6], 12);
		animation.add("crouch", [8, 9], 6);
		animation.add("crouch-walk", [8, 9], 12);
		animation.add("skid", [0, 1], 6);
		animation.add("jump", [17]);
		animation.add("fall", [17]);
		animation.add("hit", [16]);
		//animation.add("attack", [26,27,28,29],8);

		setSize(30 * Main.scale, 50 * Main.scale);
		offset.set(24 * Main.scale, 30 * Main.scale);
		
		drag.x = 800 * Main.scale;
		acceleration.y = 600 * Main.scale;
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
		
		if (FlxG.keys.pressed.LEFT || (FlxG.onMobile && Main.pad.buttonLeft.pressed))
		{
			flipX = true;
			setSize(30 * Main.scale, 50 * Main.scale);
			offset.set(14 * Main.scale, 30 * Main.scale);
			direction = -1;
			acceleration.x -= ACCELERATION;

		} 
		else if (FlxG.keys.pressed.RIGHT || (FlxG.onMobile && Main.pad.buttonRight.pressed))
		{
			flipX = false;
			setSize(30 * Main.scale, 50 * Main.scale);
			offset.set(24 * Main.scale, 30 * Main.scale);
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0)
		{
			if ((FlxG.keys.justPressed.UP || (FlxG.onMobile && Main.pad.buttonUp.pressed)) && isTouching(FlxObject.FLOOR)) {
				FlxG.sound.play("assets/sounds/jump.ogg", 1);
				velocity.y = JUMP_FORCE;
			}

			if ((FlxG.keys.pressed.DOWN || (FlxG.onMobile && Main.pad.buttonDown.pressed)) && isTouching(FlxObject.FLOOR)) {
				crouch = true;
				maxVelocity.x = CROUCH_SPEED;
			} else {
				crouch = false;
				maxVelocity.x = RUN_SPEED;
			}
		} else {
			if ((FlxG.keys.justPressed.UP || (FlxG.onMobile && Main.pad.buttonUp.justPressed)) && isTouching(FlxObject.FLOOR)) {
				FlxG.sound.play("assets/sounds/jump.ogg", 1);
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