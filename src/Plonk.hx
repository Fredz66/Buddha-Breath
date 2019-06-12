package;

import flixel.FlxSprite;

class Plonk extends FlxSprite
{
	private var speed = 2 * Main.scale;
	public var direction:Int = 1;

	public function new() 
	{
		super();

		allowCollisions = 0;

		loadGraphic("assets/images/" + Main.scale + "/plonk.png", true, 64 * Main.scale, 64 * Main.scale);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}