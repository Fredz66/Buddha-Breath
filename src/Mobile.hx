package;

import flixel.FlxSprite;

class Mobile extends FlxSprite
{
	public var startx:Int = 840;
	public var starty:Int = 320;

	public function new() 
	{
		super();

		loadGraphic(AssetPaths.mobile__png, true, 32, 160);
		
		x = startx;
		y = starty;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}