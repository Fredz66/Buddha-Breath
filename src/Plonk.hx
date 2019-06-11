package;

import flixel.FlxSprite;

class Plonk extends FlxSprite
{
	private var speed = 6;
	public var direction:Int = 1;

	public function new() 
	{
		super();

		allowCollisions = 0;

		loadGraphic(AssetPaths.plonk__png, true, 192, 192);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}