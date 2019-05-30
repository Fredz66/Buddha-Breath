package;

import flixel.FlxSprite;

class Plonk extends FlxSprite
{
	private var speed = 2;
	public var direction:Int = 1;

	public function new() 
	{
		super();

		loadGraphic(AssetPaths.plonk__png, true, 64, 64);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}