package;

import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
//import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

#if mobile
import flixel.ui.FlxVirtualPad;
#end

class PlayState extends FlxState
{
	var background:FlxBackdrop;
	var foreground1:FlxBackdrop;
	var foreground2:FlxBackdrop;
	var foreground3:FlxBackdrop;
	var map:FlxTilemap;
	var mobile:Mobile;
	var plonk:Plonk;
	var spikies:Array<Spiky> = [];
	var player:Player;
	var bird:Bird;
	var frames:Int = 0;

	#if mobile
 	public static var virtualPad:FlxVirtualPad;
 	#end

	var mobileFalling:Bool = false;
	var birdsReleased:Bool = false;

	var tiles:Array<String> = [
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                    [-]                ',
		')                                                 |     |     |     |     |                                     |                 ',
		'|                                                 |     |     |     |     |                        [-]    [-]   |                 ',
		'|                                                                                        [--]       |      |    |     [-]         ',
		'|                                                                                         ||   ()   |      |    |      |          ',
		'|                =                     [_)                                         [-]    ||   ||   |      |    |      |          ',
		'|             =  |    =        [--]      |                                          |     ||   ||   |      |    |      |          ',
		'--------------)  |    |         ||       (--------------------------------------------)   ||   ||   |      |    |      |       (--',
		'|||||||||||||||  |    |         ||       ||||||||||||||||||||||||||||||||||||||||||||||   ||   ||   |      |    |      |       |||',
		'|||||||||||||||  |    |         ||       ||||||||||||||||||||||||||||||||||||||||||||||   ||   ||   |      |    |      |       |||',
		'|||||||||||||||  |    |         ||       ||||||||||||||||||||||||||||||||||||||||||||||   ||   ||   |      |    |      |       |||',
	];

	/*
	 * Convert array of string to array of int for tilemaps.
	**/
	public function StringsToMapData(strings:Array<String>):Array<Int> {
		var mapData:Array<Int> = [];

		for (row in strings) {
			for (i in 0...row.length) {
				switch row.charAt(i) {
					case ' ': mapData.push(0);
					case '-': mapData.push(1);
					case '=': mapData.push(2);
					case ']': mapData.push(3);
					case '[': mapData.push(4);
					case '|': mapData.push(5);
					case '_': mapData.push(6);
					case ')': mapData.push(7);
					case '(': mapData.push(8);
					default:  mapData.push(0);
				}
			}
		}

		return mapData;
	}

	override public function create():Void
	{
		super.create();

		FlxG.sound.playMusic(AssetPaths.asian_mystery_nometadata__ogg, 1, true);

		// Load background.
		background = new FlxBackdrop("assets/images/640.png");
		background.scrollFactor.x = 0.5;
		background.scrollFactor.y = 0.5;
		//background.offset.y = -24;
		add(background);

		// Load map but don't show it.
		map = new FlxTilemap();
		map.loadMapFromArray(StringsToMapData(tiles), 130, 16, AssetPaths.tiles__png, 32, 32);
		add(map);
		//FlxG.camera.setScrollBounds(0, 0, map.width, map.height);
		//map.visible = false;

		releaseBirds(11, 0, 0, 300, 100);

		// Load player.
		player = new Player();
		add(player);

		// Load mobile.
		mobile = new Mobile();
		add(mobile);

		// Load spikies.
		addSpiky(50 * 32 - 7, 157, 33.5, 120);
		addSpiky(56 * 32 - 7, 157, 0, 150);
		addSpiky(62 * 32 - 7, 157, 50, 102);
		addSpiky(68 * 32 - 7, 157, 0, 150);
		addSpiky(74 * 32 - 7, 157, 50, 102);

		// Load foreground.
		foreground1 = new FlxBackdrop("assets/images/water3.png", 1.25, 1.25, true, false);
		foreground1.offset.y = -450;
		foreground2 = new FlxBackdrop("assets/images/water2.png", 1.30, 1.25, true, false);
		foreground2.offset.x = 20;
		foreground2.offset.y = -474;
		foreground3 = new FlxBackdrop("assets/images/water1.png", 1.50, 1.25, true, false);
		foreground3.offset.x = 60;
		foreground3.offset.y = -510;

		// Load plonk.
		plonk = new Plonk();
		plonk.visible = false;

		add(plonk);
		add(foreground1);
		add(foreground2);
		add(foreground3);

		// Camera follows the player, map follows the camera.
		FlxG.camera.follow(player, LOCKON, 1);
		map.follow();

		// Hide mouse cursor.
		FlxG.mouse.visible = false;

		#if mobile
		virtualPad = new FlxVirtualPad(FULL, A_B);
		virtualPad.visible = true;
		add(virtualPad);
		#end
	}

	public function releaseBirds(count, x, y, speed, height) {
		for (i in 0...count) {
			bird = new Bird(FlxG.random.int(0, 25) * 2 + x, FlxG.random.int(0, 15) * 2 + y, 20, speed, height);
			add(bird);
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frames++;

		if (!birdsReleased && player.x > 3500) {
			birdsReleased = true;
			releaseBirds(15, Std.int(map.width), 0, -300, 100);
		}

		foreground1.x += 2;
		foreground1.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) / 3;

		foreground2.x += 2.3;
		foreground2.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) / 3;

		foreground3.x += 2.8;
		foreground3.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) / 3;

		// Toggle map visibility with H key.
		if (FlxG.keys.justPressed.H) {
			map.visible = !map.visible;
		}

		if (player.alive) {
			// Collision detection between the player and the map.
			FlxG.overlap(player, mobile, hitMobile);
			FlxG.collide(player, map);

			// Collision detection between the player and the spikies.
			if (player.alive) {
				for (spiky in spikies) {
					if (FlxCollision.pixelPerfectCheck(player, spiky)) {
						player.alive = false;
						hit();
					}
				}
			}

			// Detects fall and death.
			if (player.y + player.height > FlxG.height + player.starty) {
				player.alive = false;
				drown();
			}
		}

		// Detects end of level.
		if (player.x > map.width) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, win);
		}

		#if debug
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		#end
	}

	function hitMobile(Object1:flixel.FlxObject, Object2:flixel.FlxObject):Void {
		FlxObject.separate(Object1, Object2);
		if (!mobileFalling) {
			mobileFalling = true;
			FlxG.sound.play(AssetPaths.tree__ogg, 1);
		}
	}

	function addSpiky(x, y, angle, velocity) {
		var spiky = new Spiky();
		//add(new FlxTrail(spiky, null, 3, 0, 0.2));
		add(spiky);
		spiky.x = x;
		spiky.y = y;
		spiky.angle = angle;
		spiky.angularVelocity = velocity;
		spikies.push(spiky);
	}

	function drown():Void {
		FlxG.sound.play(AssetPaths.watersplash__ogg, 1);
		plonk.x = player.x;
		plonk.y = FlxG.height + player.height;
		plonk.visible = true;
		plonk.velocity.y = -300;
		plonk.acceleration.y = 400;
		new FlxTimer().start(2, hitdeath);
	}
	function hit():Void
	{
		FlxG.sound.play(AssetPaths.death__ogg, 1);
		FlxG.camera.shake(0.01, 0.2);
		player.animation.play("hit");
		player.maxVelocity.set(500, 300);
		player.velocity.set(-300,-200);
		new FlxTimer().start(1, hitdeath);
	}

	function hitdeath(Timer:FlxTimer):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, death);
	}

	function death():Void
	{
		FlxG.switchState(new GameOverState());
	}

	function win():Void
	{
		FlxG.switchState(new WinState());
	}
}