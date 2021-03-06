package;

import flixel.FlxSprite;

class Pole extends FlxSprite
{
	public function new(X:Int, Y:Int) 
	{
		super();

		loadGraphic("assets/images/" + Main.scale + "/pole.png");
		
		x = X * Main.scale;
		y = Y * Main.scale;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}