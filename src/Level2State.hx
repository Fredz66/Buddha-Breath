package;

import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

import gui.ExitState;
import gui.GameOverState;
import gui.WinState;

class Level2State extends FlxState
{
	// Player first position.
	public var startx:Int = 180;
	public var starty:Int = -1100;

	// Player second position.
	//public var startx:Int = 4200;
	//public var starty:Int = 927;

	// Player third position.
	//public var startx:Int = 7500;
	//public var starty:Int = 927;

	// Player final position.
	//public var startx:Int = 12300;
	//public var starty:Int = 927;

	var background:FlxBackdrop;

	var island1:FlxBackdrop;
	var island2:FlxBackdrop;

	var boat1:FlxBackdrop;
	var boat2:FlxBackdrop;

	var foreground1:FlxBackdrop;
	var foreground2:FlxBackdrop;
	var foreground3:FlxBackdrop;
	var foreground4:FlxBackdrop;

	var map:FlxTilemap;

	var plonk:Plonk;
	var flagStart:Flag;
	var flagEnd:Flag;

	var player:Player;

	var frames:Int = 0;

	var tiles:Array<String> = [
		'                                                               ',
		'                                                               ',
		'                                                               ',
		'                                                               ',
		'                                                               ',
		'                   [------]                                    ',
	    '                                                               ',
		'           [---]                                               ',
		'                               [---]                           ',
		')                  [--]                                       (',
		'|                                                             |',
		'|                         [---]                     [---]     L',
		'|                                          [---]               ',
		'|                 [---]                                        ',
		'|                                                              ',
		'--------------)                                             (--',
		'|||||||||||||||                                             |||',
		'|||||||||||||||                                             |||',
		'|||||||||||||||                                             |||',
	];

	/*
	 * Convert an array of strings to an array of ints suitable for tilemaps.
	 */
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

		var yshift = -250;

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

		// Load map.
		map = new FlxTilemap();
		map.loadMapFromArray(StringsToMapData(tiles), tiles[0].length, tiles.length, AssetPaths.tiles__png, 96, 96);
		add(map);

		// Load flags.
		flagStart = new Flag(66, map.height - 966, false);
		add(flagStart);

		flagEnd = new Flag(5680, map.height - 966, true);
		add(flagEnd);

		// Load player.
		player = new Player(startx, Std.int(map.height + starty));
		add(player);

		// Camera follows the player, map follows the camera.
		FlxG.camera.follow(player, LOCKON, 1);
		map.follow();

		// Load foreground.
		foreground1 = new FlxBackdrop("assets/images/water3.png", 1.25, 1.25, true, false);
		foreground1.y = map.height * 1.25 - (FlxG.height + foreground1.height) / 2 + 250;

		foreground2 = new FlxBackdrop("assets/images/water2.png", 1.30, 1.25, true, false);
		foreground2.offset.x = 60;
		foreground2.y = map.height * 1.25 - (FlxG.height + foreground2.height) / 2 + 322;

		foreground3 = new FlxBackdrop("assets/images/water1.png", 1.50, 1.25, true, false);
		foreground3.offset.x = 180;
		foreground3.y = map.height * 1.25 - (FlxG.height + foreground3.height) / 2 + 430;

		foreground4 = new FlxBackdrop("assets/images/reed.png", 1.75, 1.25, true, false);
		foreground4.y = map.height * 1.25 - (FlxG.height + foreground4.height) / 2 + 200;

		// Load plonk.
		plonk = new Plonk();
		plonk.visible = false;

		add(plonk);
		add(foreground1);
		add(foreground2);
		add(foreground3);
		add(foreground4);

		// Hide the mouse cursor.
		FlxG.mouse.visible = false;

		if (FlxG.onMobile) {
			Main.pad = new VirtualPad();
			add(Main.pad);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frames++;

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
			FlxG.collide(player, map);
		}

		if (player.alive || !player.drown) {
			// Detect if the player falls out of the screen and kill him.
			if (player.y + player.height > map.height) {
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

	function drown():Void {
		FlxG.sound.play(AssetPaths.watersplash__ogg, 1);
		plonk.x = player.x;
		plonk.y = player.y;
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