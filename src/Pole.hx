package;

import flixel.FlxSprite;

class Pole extends FlxSprite
{
	public var startx:Int = 840 * 3;
	public var starty:Int = 320 * 3;

	public function new() 
	{
		super();

		loadGraphic(AssetPaths.pole__png, true, 32 * 3, 160 * 3);
		
		x = startx;
		y = starty;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}