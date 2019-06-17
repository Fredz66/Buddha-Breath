package;

import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

import gui.ExitState;
import gui.GameOverState;
import gui.WinState;

class Level1State extends FlxState
{
	// Player first position.
	public var startx:Int = 60 * Main.scale;
	public var starty:Int = -367 * Main.scale;

	// Player second position.
	//public var startx:Int = 4200;
	//public var starty:Int = 927;

	// Player third position.
	//public var startx:Int = 7500;
	//public var starty:Int = 927;

	// Player fourth position.
	//public var startx:Int = 12300;
	//public var starty:Int = 927;

	// Player final position.
	//public var startx:Int = 4700 * Main.scale;
	//public var starty:Int = -177 * Main.scale;

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
	var crate:Crate;
	var plonk:Plonk;
	var plonkCrate:Plonk;
	var spikies:Array<Spiky> = [];
	var flagStart:Flag;
	var flagEnd:Flag;
	var bird:Bird;
	var fish:Fish;

	var player:Player;

	var frames:Int = 0;
	var poleFalling:Bool = false;
	var crateFalling:Bool = false;
	var birdsReleased:Bool = false;

	var tiles:Array<String> = [
		'                                                                                                                                                                            ',
		'                                                                                                                                                                            ',
		'                                                  |     |     |     |     |                                                                                                 ',
		'                                                  |     |     |     |     |                                                                                                 ',
		'                                                  |     |     |     |     |                                     v                                                           ',
		'                                                  |     |     |     |     |                                    [-]                                                          ',
		')                                                 |     |     |     |     |                                     |                                                          (',
		'|>                                                |     |     |     |     |                        [-]    [-]   |                                                         <|',
		'|                                                                                        [--]       |      |    |     [-]                                                  L',
		'|                                                                                         ||   ()   |      |    |      |                                                    ',
		'|                =                     [_)                                        [-]     ||   ||   |      |    |      |                                                    ',
		'|  v    ~     =  |    =        [--]      |           ~                         ~   |      ||   ||   |      |    |      |                                                    ',
		'-_-_-_-_-_-_-_)  |    |         ||       (_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_)    ||   ||   |      |    |      |       (_-_-_-_)      (_-_-_-_-_)      (_-_-_-_-_-_-',
		'| | | | | | | |  |    |         ||       | | | | | | | | | | | | | | | | | | | | | | |    ||   ||   |      |    |      |       | | | | |      | | | | | |      | | | | | | |',
		'| | | | | | | |  |    |         ||       | | | | | | | | | | | | | | | | | | | | | | |    ||   ||   |      |    |      |       | | | | |      | | | | | |      | | | | | | |',
		'| | | | | | | |  |    |         ||       | | | | | | | | | | | | | | | | | | | | | | |    ||   ||   |      |    |      |       | | | | |      | | | | | |      | | | | | | |',
	];

	/*
	 * Convert an array of strings to an array of ints suitable for tilemaps.
	 */
	public function StringsToMapData(strings:Array<String>):Array<Int> {
		var mapData:Array<Int> = [];

		var j = 0;
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
					case '>':
						// Load start flag.
						mapData.push(0);
						//flagStart = new Flag(22 * Main.scale, map.height - 322 * Main.scale, false);
						flagStart = new Flag((i * 32 - 10) * Main.scale, ((j - 1) * 32) * Main.scale, false);
					case '<':
						// Load end flag.
						mapData.push(0);
						//flagEnd = new Flag(4037 * Main.scale, map.height - 322 * Main.scale, true);
						flagEnd = new Flag(((i - 2) * 32 + 5) * Main.scale, ((j - 1) * 32) * Main.scale, true);
					default:  mapData.push(0);
				}
			}
			j++;
		}

		return mapData;
	}

	override public function create():Void
	{
		super.create();

		FlxG.sound.playMusic("assets/music/asian-mystery-nometadata.ogg", 1, true);

		var yshift = 0;

		background = new FlxBackdrop("assets/images/" + Main.scale + "/background3.png");
		background.scrollFactor.x = 0.5;
		background.scrollFactor.y = 0.5;
		background.offset.y = 83 * Main.scale;
		add(background);

		// Load island 1.
		island1 = new FlxBackdrop("assets/images/" + Main.scale + "/island2.png",0.55, 0.55, false, false);
		island1.offset.x = -200 * Main.scale;
		island1.offset.y = -83 * Main.scale;
		add(island1);

		// Load island 2.
		island2 = new FlxBackdrop("assets/images/" + Main.scale + "/island2.png",0.55, 0.55, false, false);
		island2.offset.x = -200 * Main.scale - 700 * Main.scale;
		island2.offset.y = -83 * Main.scale;
		add(island2);

		// Load island 3.
		island3 = new FlxBackdrop("assets/images/" + Main.scale + "/island2.png",0.55, 0.55, false, false);
		island3.offset.x = -200 * Main.scale - 700*2 * Main.scale;
		island3.offset.y = -83 * Main.scale;
		add(island3);

		// Load island 4.
		island4 = new FlxBackdrop("assets/images/" + Main.scale + "/island2.png",0.55, 0.55, false, false);
		island4.offset.x = -200 * Main.scale - 700*3 * Main.scale;
		island4.offset.y = -83 * Main.scale;
		add(island4);

		// Load boat 1.
		boat1 = new FlxBackdrop("assets/images/" + Main.scale + "/boat2.png",0.58, 0.58, false, false);
		boat1.offset.x = -423 * Main.scale;
		boat1.offset.y = -233 * Main.scale;
		add(boat1);

		// Load boat 2.
		boat2 = new FlxBackdrop("assets/images/" + Main.scale + "/boat2.png",0.58, 0.58, false, false);
		boat2.offset.x = -423 * Main.scale - 700 * Main.scale;
		boat2.offset.y = -233 * Main.scale;
		add(boat2);

		// Load island 3.
		boat3 = new FlxBackdrop("assets/images/" + Main.scale + "/boat2.png",0.58, 0.58, false, false);
		boat3.offset.x = -423 * Main.scale - 700*2 * Main.scale;
		boat3.offset.y = -233 * Main.scale;
		add(boat3);

		// Load island 4.
		boat4 = new FlxBackdrop("assets/images/" + Main.scale + "/boat2.png",0.58, 0.58, false, false);
		boat4.offset.x = -423 * Main.scale - 700*3 * Main.scale;
		boat4.offset.y = -233 * Main.scale;
		add(boat4);

		// Load map.
		map = new FlxTilemap();
		map.loadMapFromArray(StringsToMapData(tiles), tiles[0].length, tiles.length, "assets/images/" + Main.scale + "/tiles.png", 32 * Main.scale, 32 * Main.scale);
		add(map);

		add(flagStart);
		add(flagEnd);

		releaseBirds(11, 0, 0, 300 * Main.scale, 100 * Main.scale);

		// Load crate.
		crate = new Crate(4800, 300);
		add(crate);

		// Load player.
		player = new Player(startx, Std.int(map.height + starty));
		add(player);

		// Load pole.
		pole = new Pole(840, 320);
		add(pole);

		// Load spikies.
		addSpiky(50 * 32 * Main.scale - 7 * Main.scale, 240 * Main.scale, 33.5, 120);
		addSpiky(56 * 32 * Main.scale - 7 * Main.scale, 240 * Main.scale, 0, 150);
		addSpiky(62 * 32 * Main.scale - 7 * Main.scale, 240 * Main.scale, 50, 102);
		addSpiky(68 * 32 * Main.scale - 7 * Main.scale, 240 * Main.scale, 0, 150);
		addSpiky(74 * 32 * Main.scale - 7 * Main.scale, 240 * Main.scale, 50, 102);

		// Load foreground.
		foreground1 = new FlxBackdrop("assets/images/" + Main.scale + "/water3.png", 1.25, 1.25, true, false);
		foreground1.y = map.height * 1.25 - (FlxG.height + foreground1.height) / 2 + 83 * Main.scale;

		foreground2 = new FlxBackdrop("assets/images/" + Main.scale + "/water2.png", 1.30, 1.25, true, false);
		foreground2.offset.x = 20 * Main.scale;
		foreground2.y = map.height * 1.25 - (FlxG.height + foreground2.height) / 2 + 108 * Main.scale;

		foreground3 = new FlxBackdrop("assets/images/" + Main.scale + "/water1.png", 1.50, 1.25, true, false);
		foreground3.offset.x = 60 * Main.scale;
		foreground3.y = map.height * 1.25 - (FlxG.height + foreground3.height) / 2 + 143 * Main.scale;

		foreground4 = new FlxBackdrop("assets/images/" + Main.scale + "/reed.png", 1.75, 1.25, true, false);
		foreground4.y = map.height * 1.25 - (FlxG.height + foreground4.height) / 2 + 67 * Main.scale;

		// Load plonk.
		plonk = new Plonk("assets/images/" + Main.scale + "/plonk.png");
		plonk.visible = false;

		// Load plonk crate.
		plonkCrate = new Plonk("assets/images/" + Main.scale + "/plonk-crate.png");
		plonkCrate.visible = false;

		fish = new Fish(500 * Main.scale, 370 * Main.scale, -300 * Main.scale, -50 * Main.scale, 340 * Main.scale);

		add(plonk);
		add(plonkCrate);
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
			Main.pad = new VirtualPad();
			add(Main.pad);
		}
	}

	public function releaseBirds(count, x, y, speed, height) {
		for (i in 0...count) {
			bird = new Bird(FlxG.random.int(0, 25 * Main.scale) * 2 + x, FlxG.random.int(0, 15 * Main.scale) * 2 + y, 20 * Main.scale, speed, height);
			add(bird);
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frames++;

		// Release the second flock of birds.
		if (!birdsReleased && player.x > 3500 * Main.scale) {
			birdsReleased = true;
			releaseBirds(15, Std.int(map.width), 0, -300 * Main.scale, 100 * Main.scale);
		}

		// Move the water with a sinusoidal wave.
		foreground1.x += 2 * Main.scale;
		foreground1.y += (FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) * Main.scale) / 3;

		foreground2.x += 2.333 * Main.scale;
		foreground2.y += (FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) * Main.scale) / 3;

		foreground3.x += 3 * Main.scale;
		foreground3.y += (FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) * Main.scale) / 3;

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
			FlxG.collide(player, crate);
			FlxG.collide(player, map);
			FlxG.collide(crate, map);

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

		// Player drown.
		if (player.alive || !player.drown) {
			// Detect if the player falls out of the screen and kill him.
			if (player.y + player.height > map.height) {
				player.alive = false;
				player.drown = true;
				player.acceleration.x = 0;
				drown(player.x, player.y);
			}			
		}

		// Crate drown.
		if (!crate.drown) {
			// Detect if the crate falls out of the screen.
			if (crate.y + crate.height > map.height) {
				crate.drown = true;
				crate.acceleration.x = 0;
				drownCrate(crate.x, crate.y);
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

	function hitPole(Object1:FlxObject, Object2:FlxObject):Void {
		FlxObject.separate(Object1, Object2);
		if (!poleFalling) {
			poleFalling = true;
			FlxG.sound.play("assets/sounds/tree.ogg", 1);
		}
	}

	function addSpiky(x, y, angle, velocity) {
		var spiky = new Spiky(x, y, angle, velocity);
		add(spiky);
		spikies.push(spiky);
	}

	function drown(x, y):Void {
		FlxG.sound.play("assets/sounds/watersplash.ogg", 1);
		plonk.x = x;
		plonk.y = y;
		plonk.visible = true;
		plonk.velocity.y = -300 * Main.scale;
		plonk.acceleration.y = 400 * Main.scale;
		new FlxTimer().start(2, hitdeath);
	}

	function drownCrate(x, y):Void {
		FlxG.sound.play("assets/sounds/watersplash.ogg", 1);
		plonkCrate.x = x;
		plonkCrate.y = y;
		plonkCrate.visible = true;
		plonkCrate.velocity.y = -300 * Main.scale;
		plonkCrate.acceleration.y = 400 * Main.scale;
	}

	function hit():Void
	{
		FlxG.sound.play("assets/sounds/death.ogg", 1);
		FlxG.camera.shake(0.01, 0.2);
		player.animation.play("hit");
		player.maxVelocity.set(500 * Main.scale, 300 * Main.scale);
		player.velocity.set(-450 * Main.scale, -200 * Main.scale);
		player.acceleration.x = 0;
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