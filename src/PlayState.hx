package;

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

class PlayState extends FlxState
{
	var background:FlxBackdrop;
	var foreground1:FlxBackdrop;
	var foreground2:FlxBackdrop;
	var foreground3:FlxBackdrop;
	var foreground4:FlxBackdrop;
	var map:FlxTilemap;
	var mobile:Mobile;
	var plonk:Plonk;
	var spikies:Array<Spiky> = [];
	var player:Player;
	var flagStart:Flag;
	var flagEnd:Flag;
	var bird:Bird;
	var fish:Fish;
	var frames:Int = 0;

	public var virtualPadOffset:Int = 10;
	public static var buttonLeft:FlxButton;
	public static var buttonRight:FlxButton;
	public static var buttonJump:FlxButton;
	public static var buttonCrouch:FlxButton;

	var mobileFalling:Bool = false;
	var birdsReleased:Bool = false;

	var tiles:Array<String> = [
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                    [-]                ',
		')                                                 |     |     |     |     |                                     |                (',
		'|                                                 |     |     |     |     |                        [-]    [-]   |                |',
		'|                                                                                        [--]       |      |    |     [-]        L',
		'|                                                                                         ||   ()   |      |    |      |          ',
		'|                =                     [_)                                         [-]    ||   ||   |      |    |      |          ',
		'|             =  |    =        [--]      |                                          |     ||   ||   |      |    |      |          ',
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
					case '_': mapData.push(6);
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

		// Load background.
		background = new FlxBackdrop("assets/images/640.png");
		background.scrollFactor.x = 0.5;
		background.scrollFactor.y = 0.5;
		add(background);

		// Load map but don't show it.
		map = new FlxTilemap();
		map.loadMapFromArray(StringsToMapData(tiles), 130, 16, AssetPaths.tiles__png, 32, 32);
		add(map);

		// Load flags.
		flagStart = new Flag(22, 190, false);
		add(flagStart);

		flagEnd = new Flag(4037, 190, true);
		add(flagEnd);

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

		foreground4 = new FlxBackdrop("assets/images/reed.png", 1.75, 1.25, true, false);
		foreground4.offset.y = -490;

		// Load plonk.
		plonk = new Plonk();
		plonk.visible = false;

		fish = new Fish(500, 370, -300, -50, 340);

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

		// Create the buttons for the virtual floating pad.
		buttonLeft = new FlxButton(0, 360 - 128, "");
		buttonLeft.loadGraphic("assets/images/btn-128x128.png");
		add(buttonLeft);

		buttonRight = new FlxButton(128, 360 - 128, "");
		buttonRight.loadGraphic("assets/images/btn-128x128.png");
		add(buttonRight);

		buttonJump = new FlxButton(640 - 128, 360 - 256, "");
		buttonJump.loadGraphic("assets/images/btn-128x128.png");
		add(buttonJump);

		buttonCrouch = new FlxButton(640 - 128, 360 - 128, "");
		buttonCrouch.loadGraphic("assets/images/btn-128x128.png");
		add(buttonCrouch);

		// Hide the virtual floating pad when not on mobile.		
		if (!FlxG.onMobile) {
			buttonLeft.visible = false;
			buttonRight.visible = false;
			buttonJump.visible = false;
			buttonCrouch.visible = false;
		}
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

		// Move the virtual floating pad at the position of each initial touch if it's in the left half of the screen.
		// Uses an offset between the left/right buttons.
		if (FlxG.onMobile) {
			if (FlxG.mouse.justPressed) {
				if (FlxG.mouse.x - camera.scroll.x < FlxG.camera.width / 2) {
					var position:FlxPoint = new FlxPoint(FlxG.mouse.x - camera.scroll.x, FlxG.mouse.y - camera.scroll.y);
					buttonLeft.setPosition(position.x - buttonLeft.width - virtualPadOffset, position.y - (buttonLeft.height / 2) - 1);
					buttonRight.setPosition(position.x + virtualPadOffset, position.y - (buttonRight.height / 2) - 1);
				}
			}
		}

		// Release the second flock of birds.
		if (!birdsReleased && player.x > 3500) {
			birdsReleased = true;
			releaseBirds(15, Std.int(map.width), 0, -300, 100);
		}

		// Move the water with a sinusoidal wave.
		foreground1.x += 2;
		foreground1.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) / 3;

		foreground2.x += 2.3;
		foreground2.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) / 3;

		foreground3.x += 2.8;
		foreground3.y += FlxMath.fastSin(((frames / (700 + FlxG.random.int(0, 300))) % 360) * FlxAngle.TO_DEG) / 3;

		// Toggle map visibility with the H key.
		if (FlxG.keys.justPressed.H) {
			map.visible = !map.visible;
		}

		// Show an exit popup if the ESCAPE key is pressed.
		if (FlxG.keys.justPressed.ESCAPE) {
			openSubState(new ExitState());
		}

		if (player.alive) {
			// Detect collision between the player and the map.
			FlxG.overlap(player, mobile, hitMobile);
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
			if (player.y + player.height > FlxG.height + player.starty) {
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