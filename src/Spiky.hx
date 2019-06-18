package;

import flixel.addons.display.FlxNestedSprite;
import flixel.math.FlxAngle;

class Spiky extends FlxNestedSprite
{
	private var speed = 2;
	public var direction:Int = 1;

	public var myAngularVelocity:Float;
	public var myAngle:Float;

	public var xcenter:Int;
	public var ycenter:Int;

	public var myLength:Float = 72 * Main.scale;

	var chain:FlxNestedSprite;

	public function new(X,Y,Angle, Velocity) 
	{
		super();
		chain = new FlxNestedSprite();
		chain.loadGraphic("assets/images/" + Main.scale + "/chain.png");
		chain.allowCollisions = 0;
		add(chain);

		loadGraphic("assets/images/" + Main.scale + "/ball.png");

		myAngle = Angle;
		myAngularVelocity = Velocity;
		xcenter = X;
		ycenter = Y;
	}

	override public function update(elapsed:Float):Void
	{
		myAngle += (myAngularVelocity * elapsed);

		if (direction == 1) {
			if (myAngle >= 0) {
				myAngularVelocity -= speed;
			} else {
				myAngularVelocity += speed;
			}
			if (myAngularVelocity <= 0) {
				direction = -1;
				myAngularVelocity = -1;
			}
		} else {
			if (myAngle >= 0) {
				myAngularVelocity -= speed;
			} else {
				myAngularVelocity += speed;
			}
			if (myAngularVelocity >= 0) {
				direction = 1;
				myAngularVelocity = 1;
			}
		}

		var xrelative = myLength * Math.cos(FlxAngle.asRadians(myAngle - 90));
		var yrelative = myLength * Math.sin(FlxAngle.asRadians(myAngle - 90));

		x = xcenter + xrelative;
		y = ycenter - yrelative;

		chain.relativeX = -(xrelative / 2) * 1.14 + 13 * Main.scale;
		chain.relativeY = (yrelative / 2) * 1.14 - height / 2;
		chain.relativeAngle = -myAngle;

		super.update(elapsed);
	}
}