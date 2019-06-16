package;

import flixel.FlxSprite;

class Plonk extends FlxSprite
{
	private var speed = 2 * Main.scale;
	public var direction:Int = 1;

	public function new(graphic) 
	{
		super();

		allowCollisions = 0;

		loadGraphic(graphic);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}