package;

//import flixel.ui.FlxVirtualPad;
import flixel.addons.effects.FlxTrail;
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
	var foreground:FlxBackdrop;
	var map:FlxTilemap;
	var mobile:Mobile;
	var spikies:Array<Spiky> = [];
	var player:Player;

	var tiles:Array<String> = [
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                                       ',
		'                                                  |     |     |     |     |                                    [=]                ',
		'                                                  |     |     |     |     |                                     |                 ',
		'=                                                 |     |     |     |     |                        [=]    [=]   |                 ',
		'|                                                                                        [==]       |      |    |     [=]         ',
		'|                                                                                         ||   ==   |      |    |      |          ',
		'|                =                     [_=                                         [=]    ||   ||   |      |    |      |          ',
		'|             =  |    =        [--]      |                                          |     ||   ||   |      |    |      |          ',
		'---------------  |    |         ||       ----------------------------------------------   ||   ||   |      |    |      |       ---',
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
					default:  mapData.push(0);
				}
			}
		}

		return mapData;
	}

	override public function create():Void
	{
		super.create();

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

		// Load player.
		player = new Player();
		add(player);

		// Load mobile.
		mobile = new Mobile();
		add(mobile);

		// Load spikies.
		addSpiky(1593, 157, 0, 150);
		addSpiky(1785, 157, 33.5, 120);
		addSpiky(1977, 157, 50, 102);
		addSpiky(2169, 157, 0, 150);
		addSpiky(2361, 157, 50, 102);

		// Load foreground.
		foreground = new FlxBackdrop("assets/images/water-beige-640.png");
		foreground.scrollFactor.x = 1.25;
		foreground.scrollFactor.y = 1.25;
		foreground.offset.y = 10;
		add(foreground);

		// Camera follows the player, map follows the camera.
		FlxG.camera.follow(player, LOCKON, 1);
		map.follow();

		// Hide mouse cursor.
		FlxG.mouse.visible = false;

		//var virtualPad = new FlxVirtualPad(FULL, A_B);
		//add(virtualPad);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//trace(spiky1.direction, spiky1.angle, spiky1.angularVelocity);

		// Toggle map visibility with H key.
		if (FlxG.keys.justPressed.H) {
			map.visible = !map.visible;
		}

		if (player.alive) {
			// Collision detection between the player and the map.
			FlxG.collide(player, mobile);
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
		}

		// Detects fall and death.
		if (player.y + player.height > FlxG.height + player.starty) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, death);
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

	function addSpiky(x, y, angle, velocity) {
		var spiky = new Spiky();
		add(new FlxTrail(spiky, null, 3, 0, 0.2));
		add(spiky);
		spiky.x = x;
		spiky.y = y;
		spiky.angle = angle;
		spiky.angularVelocity = velocity;
		spikies.push(spiky);
	}

	function hit():Void
	{
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