package;

//import flixel.ui.FlxVirtualPad;
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
	var spiky1:Spiky;
	var spiky2:Spiky;
	var spiky3:Spiky;
	var player:Player;

	var tiles:Array<String> = [
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                    |      |      |                                                               ',
		'                                                    |      |      |                                                               ',
		'                                                    |      |      |                                            [=]                ',
		'                                                    |      |      |                                             |                 ',
		'=                                                   |      |      |                                [=]    [=]   |                 ',
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
		spiky1 = new Spiky();
		add(spiky1);
		spiky1.x = 1657;
		spiky1.y = 157;
		//spiky1.angle = 0;
		spiky1.angularVelocity = 150;

		spiky2= new Spiky();
		add(spiky2);
		spiky2.x = 1881;
		spiky2.y = 157;
		spiky2.angle = 33.5;
		spiky2.angularVelocity = 120;

		spiky3 = new Spiky();
		add(spiky3);
		spiky3.x = 2105;
		spiky3.y = 157;
		spiky3.angle = 50;
		spiky3.angularVelocity = 102;

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

		// Collision detection between the player and the map.
		FlxG.collide(player, mobile);
		FlxG.collide(player, map);

		// Collision detection between the player and the spikies.
		if (player.alive && (FlxCollision.pixelPerfectCheck(player, spiky1) || FlxCollision.pixelPerfectCheck(player, spiky2) || FlxCollision.pixelPerfectCheck(player, spiky3))) {
			player.alive = false;
			hit();
		}

		// Detects fall and death.
		if (player.y + player.height > FlxG.height + player.starty) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, death);
		}

		// Detects end of level.
		if (player.x > map.width) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, win);
		}

		//FlxG.debugger.visible = true;
		//FlxG.debugger.drawDebug = true;
	}

	function hit():Void
	{
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