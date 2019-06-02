package;

import flixel.FlxG;
import flixel.ui.FlxButton;

class FlxScaleButton extends FlxButton
{
	var gameScale:Float = FlxG.width / 640;

	public function new(X:Float = 0, Y:Float = 0, ?Text:String, ?OnClick:Void->Void)
	{
		super(X, Y, OnClick);

		scale.set(gameScale, gameScale);
		updateHitbox();

		for (point in labelOffsets)
			point.set(point.x - gameScale, point.y + 3 * gameScale);

		initLabel(Text);

		label.size = Std.int(label.size * gameScale);
		label.fieldWidth *= gameScale;
		label.width *= gameScale;
		label.height *= gameScale;
	}	
}
