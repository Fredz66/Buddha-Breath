package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxMath;

class Flag extends FlxSprite
{
	public function new(x, y, invert)
	{
		super();

		loadGraphic(AssetPaths.flag__png, true, 100, 75);

		animation.add("float", [0, 1, 2, 3, 4, 5], 12);

		this.x = x;
		this.y = y;
		flipX = invert;
	}

	override public function update(elapsed:Float):Void
	{
		animate();

		super.update(elapsed);
	}
	
	private function animate() 
	{
		animation.play("float");
	}
}