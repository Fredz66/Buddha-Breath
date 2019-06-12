package;

import flixel.FlxG;
import flixel.ui.FlxButton;

class FlxScaleButton extends FlxButton
{
	public function new(X:Float = 0, Y:Float = 0, ?Text:String, ?OnClick:Void->Void)
	{
		super(X, Y, OnClick);

		scale.set(Main.scale, Main.scale);
		updateHitbox();

		for (point in labelOffsets)
		if (Main.scale == 3) {
			point.set(point.x - Main.scale, point.y + 3 * Main.scale);
		}

		initLabel(Text);

		label.size = Std.int(label.size * Main.scale);
		label.fieldWidth *= Main.scale;
		label.width *= Main.scale;
		label.height *= Main.scale;
	}	
}
