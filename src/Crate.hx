package;

import flixel.addons.nape.FlxNapeSprite;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.phys.Material;

class Crate extends FlxNapeSprite
{
	public var drown:Bool = false;
	public var pushed:Bool = false;

	public var player:Player;

	public function new(X:Int, Y:Int) 
	{
		super(X * Main.scale, Y * Main.scale);

		loadGraphic("assets/images/" + Main.scale + "/crate.png");

		if (body != null)
			destroyPhysObjects();

		centerOffsets(false);
		setBody(new Body(BodyType.DYNAMIC, Vec2.weak(x, y)));

		var box = new Polygon(Polygon.box(85 * Main.scale, 85 * Main.scale));
		body.shapes.add(box);
		body.setShapeMaterials(new Material(0, 0.001, 0.005, 1));
		body.allowRotation = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (player != null && player.pushing) {
			if (Main.scale == 1) {
				body.applyImpulse(Vec2.weak(20, 0));
			} else {
				body.applyImpulse(Vec2.weak(200, 0));
			}
		}
	}
}