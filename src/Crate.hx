package;

import flixel.FlxSprite;

class Crate extends FlxSprite
{
	public var drown:Bool = false;

	public function new(X:Int, Y:Int) 
	{
		super();

		loadGraphic("assets/images/" + Main.scale + "/crate.png");
		
		x = X * Main.scale;
		y = Y * Main.scale;

		acceleration.y = 600 * Main.scale;
		drag.x = 400 * Main.scale;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}