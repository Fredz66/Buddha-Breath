package;

import flixel.system.FlxSound;
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
	public var canJump:Bool = true;
	public var pushing:Bool = false;

	var soundCrate:FlxSound;

	public function new(X:Int, Y:Int) 
	{
		super(X, Y);

		ACCELERATION = 333 * Main.scale;
		JUMP_FORCE = -280 * Main.scale;
		WALK_SPEED = 100 * Main.scale;
		//RUN_SPEED = 167 * Main.scale;
		RUN_SPEED = 200 * Main.scale;
		CROUCH_SPEED = 50 * Main.scale;
		FALLING_SPEED = 300 * Main.scale;

		soundCrate = FlxG.sound.load("assets/sounds/scrape.ogg", 1, true);

		loadGraphic("assets/images/" + Main.scale + "/litang.png", true, 116 * Main.scale, 80 * Main.scale);
		
		animation.add("idle", [10, 11, 12, 13, 12, 11, 10], 12);
		animation.add("run", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 12);
		animation.add("crouching", [11, 14, 15, 16], 10, false);
		animation.add("standing", [16, 15, 14, 11], 12, false);
		animation.add("crouch", [16], 12);
		animation.add("crouch-walk", [15, 16], 6);
		animation.add("skid", [0, 1], 6);
		animation.add("jump", [2]);
		animation.add("fall", [6]);
		animation.add("hit", [20, 21, 22, 23], 12, false);
		animation.add("push", [30, 31, 32, 33, 34, 35, 36], 12, false);

		setSize(40 * Main.scale, 50 * Main.scale);
		offset.set(54 * Main.scale, 30 * Main.scale);
		
		drag.x = 1000 * Main.scale;
		acceleration.y = 600 * Main.scale;
		maxVelocity.set(RUN_SPEED, FALLING_SPEED);
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
			offset.set(14 * Main.scale, 30 * Main.scale);
			direction = -1;
			acceleration.x -= ACCELERATION;

		} 
		else if (FlxG.keys.pressed.RIGHT || (FlxG.onMobile && Main.pad.buttonRight.pressed))
		{
			flipX = false;
			offset.set(54 * Main.scale, 30 * Main.scale);
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (FlxG.onMobile) {
			if (!Main.pad.buttonUp.pressed) {
				canJump = true;
			}
		} else {
			if (!FlxG.keys.pressed.UP) {
				canJump = true;
			}
		}

		if (velocity.y == 0)
		{
			if ((FlxG.keys.pressed.UP || (FlxG.onMobile && Main.pad.buttonUp.pressed)) && isTouching(FlxObject.FLOOR) && canJump) {
				canJump = false;
				FlxG.sound.play("assets/sounds/jump.ogg", 1);
				velocity.y = JUMP_FORCE;
			}

			if ((FlxG.keys.pressed.DOWN || (FlxG.onMobile && Main.pad.buttonDown.pressed)) && isTouching(FlxObject.FLOOR)) {
				if (!crouch)
					animation.play("crouching");
				crouch = true;
				maxVelocity.x = CROUCH_SPEED;
			} else {
				if (crouch)
					animation.play("standing");
				crouch = false;
				maxVelocity.x = RUN_SPEED;
			}
		} else {
			if ((FlxG.keys.pressed.UP || (FlxG.onMobile && Main.pad.buttonUp.justPressed)) && isTouching(FlxObject.FLOOR) && canJump) {
				canJump = false;
				FlxG.sound.play("assets/sounds/jump.ogg", 1);
				velocity.y = JUMP_FORCE;
			}
		}
	}
		
	private function animate() 
	{
		pushing = false;

		if ((velocity.y <= 0) && (!isTouching(FlxObject.FLOOR))) {
			animation.play("jump");
		} else if (velocity.y > 0) {
			animation.play("fall");
		} else if (velocity.x == 0) {
			if (crouch) {
				if (animation.curAnim.name == "crouch-walk" || (animation.curAnim.name == "crouching" && animation.finished)) {
					animation.play("crouch");
				}
			} else {
				if (animation.curAnim.name != "standing" || animation.finished) {
					animation.play("idle");
				}
			}
		} else {
			if (crouch) {
				animation.play("crouch-walk");
			} else {
				if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction)) {
					animation.play("skid");
				} else {
					if ((isTouching(FlxObject.LEFT) || isTouching(FlxObject.RIGHT)) &&
						(FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.LEFT || (FlxG.onMobile && Main.pad.buttonLeft.pressed) || (FlxG.onMobile && Main.pad.buttonRight.pressed))) {
						offset.set(74 * Main.scale, 30 * Main.scale);
						animation.play("push");
						pushing = true;
						if (!soundCrate.playing) {
							soundCrate.play();
						}
					} else {
						soundCrate.stop();
						animation.play("run");
					}
				}
			}
		}
	}
}