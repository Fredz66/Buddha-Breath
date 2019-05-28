package;

import flixel.FlxSprite;

class Spiky extends FlxSprite
{
	public function new() 
	{
		super();

		loadGraphic(AssetPaths.spiky__png, true, 47, 93);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}