package;

import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.math.FlxPoint;
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

import flixel.addons.editors.tiled.TiledMap;

import gui.ExitState;
import gui.GameOverState;
import gui.WinState;

class PlayState extends FlxState
{
	//var level:TiledLevel;

	var background:FlxBackdrop;

	var island1:FlxBackdrop;
	var island2:FlxBackdrop;
	var island3:FlxBackdrop;
	var island4:FlxBackdrop;

	var boat1:FlxBackdrop;
	var boat2:FlxBackdrop;
	var boat3:FlxBackdrop;
	var boat4:FlxBackdrop;

	var foreground1:FlxBackdrop;
	var foreground2:FlxBackdrop;
	var foreground3:FlxBackdrop;
	var foreground4:FlxBackdrop;

	var map:FlxTilemap;

	var pole:Pole;
	var plonk:Plonk;
	var spikies:Array<Spiky> = [];
	var flagStart:Flag;
	var flagEnd:Flag;
	var bird:Bird;
	var fish:Fish;

	var player:Player;

	public static var pad:VirtualPad;

	var frames:Int = 0;
	var poleFalling:Bool = false;
	var birdsReleased:Bool = false;

	var tiles:Array<String> = [
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                     v                 ',
		'                                                  |     |     |     |     |                                    [-]                ',
		')                                                 |     |     |     |     |                                     |                (',
		'|                                                 |     |     |     |     |                        [-]    [-]   |                |',
		'|                                                                                        [--]       |      |    |     [-]        L',
		'|                                                                                         ||   ()   |      |    |      |          ',
		'|                =                     [_)                                         [-]    ||   ||   |      |    |      |          ',
		'|  v    ~     =  |    =        [--]      |           ~                         ~    |     ||   ||   |      |    |      |          ',
		'--------------)  |    |         ||       (--------------------------------------------)   ||   ||   |      |    |      |       (--',
		'|||||||||||||||  |    |         ||       ||||||||||||||||||||||||||||||||||||||||||||||   ||   ||   |      |    |      |       |||',
		'|||||||||||||||  |    |         ||       ||||||||||||||||||||||||||||||||||||||||||||||   ||   ||   |      |    |      |       |||',
		'|||||||||||||||  |    |         ||       ||||||||||||||||||||||||||||||||||||||||||||||   ||   ||   |      |    |      |       |||',
	];

	/*
	 * Convert an array of strings to an array of ints suitable for tilemaps.
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
					case '_': mapData.push(10);
					case ')': mapData.push(7);
					case '(': mapData.push(8);
					case 'L': mapData.push(9);
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

		var yshift = 0;

		//background = new FlxBackdrop("assets/images/640.png");
		background = new FlxBackdrop("assets/images/background3.png");
		background.scrollFactor.x = 0.5;
		background.scrollFactor.y = 0.5;
		background.offset.y = yshift + 250;
		add(background);

		// Load island 1.
		island1 = new FlxBackdrop("assets/images/island2.png",0.55, 0.55, false, false);
		island1.offset.x = -600;
		island1.offset.y = yshift - 250;
		add(island1);

		// Load island 2.
		island2 = new FlxBackdrop("assets/images/island2.png",0.55, 0.55, false, false);
		island2.offset.x = -600 - 2100;
		island2.offset.y = yshift - 250;
		add(island2);

		// Load island 3.
		island3 = new FlxBackdrop("assets/images/island2.png",0.55, 0.55, false, false);
		island3.offset.x = -600 - 2100*2;
		island3.offset.y = yshift - 250;
		add(island3);

		// Load island 4.
		island4 = new FlxBackdrop("assets/images/island2.png",0.55, 0.55, false, false);
		island4.offset.x = -600 - 2100*3;
		island4.offset.y = yshift - 250;
		add(island4);

		// Load boat 1.
		boat1 = new FlxBackdrop("assets/images/boat2.png",0.58, 0.58, false, false);
		boat1.offset.x = -1270;
		boat1.offset.y = yshift - 700;
		add(boat1);

		// Load boat 2.
		boat2 = new FlxBackdrop("assets/images/boat2.png",0.58, 0.58, false, false);
		boat2.offset.x = -1270 - 2100;
		boat2.offset.y = yshift - 700;
		add(boat2);

		// Load island 3.
		boat3 = new FlxBackdrop("assets/images/boat2.png",0.58, 0.58, false, false);
		boat3.offset.x = -1270 - 2100*2;
		boat3.offset.y = yshift - 700;
		add(boat3);

		// Load island 4.
		boat4 = new FlxBackdrop("assets/images/boat2.png",0.58, 0.58, false, false);
		boat4.offset.x = -1270 - 2100*3;
		boat4.offset.y = yshift - 700;
		add(boat4);

		// Load map but don't show it.
		map = new FlxTilemap();
		map.loadMapFromArray(StringsToMapData(tiles), 130, 16, AssetPaths.tiles__png, 96, 96);
		add(map);

		// Load flags.
		flagStart = new Flag(66, 570, false);
		add(flagStart);

		flagEnd = new Flag(12111, 570, true);
		add(flagEnd);

		releaseBirds(11, 0, 0, 900, 300);

		// Load player.
		player = new Player();
		add(player);

		// Load pole.
		pole = new Pole();
		add(pole);

		// Load spikies.
		addSpiky(50 * 96 - 21, 750 - 30, 33.5, 120);
		addSpiky(56 * 96 - 21, 750 - 30, 0, 150);
		addSpiky(62 * 96 - 21, 750 - 30, 50, 102);
		addSpiky(68 * 96 - 21, 750 - 30, 0, 150);
		addSpiky(74 * 96 - 21, 750 - 30, 50, 102);

		// Load foreground.
		foreground1 = new FlxBackdrop("assets/images/water3.png", 1.25, 1.25, true, false);
		foreground1.offset.y = -1350;

		foreground2 = new FlxBackdrop("assets/images/water2.png", 1.30, 1.25, true, false);
		foreground2.offset.x = 60;
		foreground2.offset.y = -1422;

		foreground3 = new FlxBackdrop("assets/images/water1.png", 1.50, 1.25, true, false);
		foreground3.offset.x = 180;
		foreground3.offset.y = -1530;

		foreground4 = new FlxBackdrop("assets/images/reed.png", 1.75, 1.25, true, false);
		foreground4.offset.y = -1470;

		// Load plonk.
		plonk = new Plonk();
		plonk.visible = false;

		fish = new Fish(1500, 1110, -900, -150, 1020);

		add(plonk);
		add(foreground1);
		add(fish);
		add(foreground2);
		add(foreground3);
		add(foreground4);

		// Camera follows the player, map follows the camera.
		FlxG.camera.follow(player, LOCKON, 1);
		map.follow();

		// Hide the mouse cursor.
		FlxG.mouse.visible = false;

		if (FlxG.onMobile) {
			pad = new VirtualPad();
			add(pad);
		}
	}

	public function releaseBirds(count, x, y, speed, height) {
		for (i in 0...count) {
			bird = new Bird(FlxG.random.int(0, 75) * 2 + x, FlxG.random.int(0, 45) * 2 + y, 60, speed, height);
			add(bird);
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frames++;

		// Release the second flock of birds.
		if (!birdsReleased && player.x > 10500) {
			birdsReleased = true;
			releaseBirds(15, Std.int(map.width), 0, -900, 300);
		}

		// Move the water with a sinusoidal wave.
		foreground1.x += 6;
		foreground1.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG);

		foreground2.x += 7;
		foreground2.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG);

		foreground3.x += 9;
		foreground3.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG);

		// Toggle map visibility with the H key.
		if (FlxG.keys.justPressed.H) {
			map.visible = !map.visible;
		}

		// Show an exit popup if the ESCAPE key is pressed.
		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.sound.pause();
			openSubState(new ExitState());
		}

		if (player.alive) {
			// Detect collision between the player and the map.
			FlxG.overlap(player, pole, hitPole);
			FlxG.collide(player, map);

			// Detect collision between the player and the spikies.
			if (player.alive) {
				for (spiky in spikies) {
					if (FlxCollision.pixelPerfectCheck(player, spiky)) {
						player.alive = false;
						hit();
					}
				}
			}
		}

		if (player.alive || !player.drown) {
			// Detect if the player falls out of the screen and kill him.
			if (player.y - player.height > FlxG.height) {
				player.alive = false;
				player.drown = true;
				player.acceleration.x = 0;
				drown();
			}			
		}

		// Detect the end of the level.
		if (player.x > map.width) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, win);
		}

		#if debug
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		#end
	}

	function hitPole(Object1:flixel.FlxObject, Object2:flixel.FlxObject):Void {
		FlxObject.separate(Object1, Object2);
		if (!poleFalling) {
			poleFalling = true;
			FlxG.sound.play(AssetPaths.tree__ogg, 1);
		}
	}

	function addSpiky(x, y, angle, velocity) {
		var spiky = new Spiky(x, y, angle, velocity);
		//add(new FlxTrail(spiky, null, 3, 0, 0.2));
		add(spiky);
		spikies.push(spiky);
	}

	function drown():Void {
		FlxG.sound.play(AssetPaths.watersplash__ogg, 1);
		plonk.x = player.x;
		plonk.y = FlxG.height + player.height;
		plonk.visible = true;
		plonk.velocity.y = -900;
		plonk.acceleration.y = 1200;
		new FlxTimer().start(2, hitdeath);
	}
	function hit():Void
	{
		FlxG.sound.play(AssetPaths.death__ogg, 1);
		FlxG.camera.shake(0.01, 0.2);
		player.animation.play("hit");
		player.maxVelocity.set(1500, 900);
		player.velocity.set(-1350, -600);
		player.acceleration.x = 0;
		//new FlxTimer().start(1, hitdeath);
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