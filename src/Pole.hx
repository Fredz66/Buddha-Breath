package;

import flixel.FlxSprite;

class Pole extends FlxSprite
{
	public var startx:Int = 2520;
	public var starty:Int = 960;

	public function new() 
	{
		super();

		loadGraphic(AssetPaths.pole__png, true, 96, 480);
		
		x = startx;
		y = starty;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}