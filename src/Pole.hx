package;

import flixel.FlxSprite;

class Pole extends FlxSprite
{
	public var startx:Int = 840 * Main.scale;
	public var starty:Int = 320 * Main.scale;

	public function new() 
	{
		super();

		loadGraphic("assets/images/" + Main.scale + "/pole.png", true, 32 * Main.scale, 160 * Main.scale);
		
		x = startx;
		y = starty;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}