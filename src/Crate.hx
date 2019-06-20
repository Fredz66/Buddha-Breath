package;

import flixel.addons.nape.FlxNapeSprite;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.phys.Material;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxObject;

class Crate extends FlxNapeSprite
{
	public var drown:Bool = false;
	public var pushed:Bool = false;

	public var player:Player;
	var soundSliding:FlxSound;
	var soundDroping:FlxSound;

	public function new(X:Int, Y:Int) 
	{
		super(X * Main.scale, Y * Main.scale);

		soundSliding = FlxG.sound.load("assets/sounds/scrape.ogg", 1, true);

		loadGraphic("assets/images/" + Main.scale + "/crate.png");

		if (body != null)
			destroyPhysObjects();

		centerOffsets(false);
		setBody(new Body(BodyType.DYNAMIC, Vec2.weak(x, y)));

		var box = new Polygon(Polygon.box(width, height));
		body.shapes.add(box);
		body.setShapeMaterials(new Material(0, 0.001, 0.005, 1));
		body.allowRotation = true;
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxMath.equal(velocity.x, 0)) {
			soundSliding.stop();
		} else {
			if (!soundSliding.playing) {
				soundSliding.play();
			}			
		}

		super.update(elapsed);
	}
}