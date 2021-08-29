package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		if(FlxG.save.data.antialiasing)
			{
				antialiasing = true;
			}

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets','shared',true);
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND','shared',true);
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;

			case 'bf-zar':
				var tex = Paths.getSparrowAtlas('five-minute-song/ZardyWeek2_BoyFriend','ChallengeWeek');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance instance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP instance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT instance', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT instance', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN instance', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS instance', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS instance', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS instance', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS instance', 24, false);
				animation.addByPrefix('fall', 'bf pre attack instance', 24, false);
				animation.addByPrefix('axe', 'Holding Axe instance', Math.floor(24 * PlayState.songMultiplier), false);
				animation.addByIndices('dead', 'BF hit instance 1',[19,20,21,22,23,24],"", 24, false);
				animation.addByIndices('heldByVine', 'BF hit instance 1',[4,5,6,7,8,9,10,12,13,14,15,16,17,18],"", 24, true);
				animation.addByIndices('deadInVine', 'BF hit instance 1',[18,19,20,21,22,23,24],"", 24, false);
				animation.addByPrefix('dodge', 'boyfriend dodge instance 1', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies instance", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop instance", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm instance", 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
			case 'zardyMyBeloved':
				tex = Paths.getSparrowAtlas('Zardy','ChallengeWeek');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 14);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", -80, -10);
				addOffset("singRIGHT", -65, 5);
				addOffset("singLEFT", 130, 5);
				addOffset("singDOWN", -2, -26);

				playAnim('idle');
			case 'zardyButDARK':
				tex = Paths.getSparrowAtlas('five-minute-song/ZardyDark','ChallengeWeek');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 14);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", -80, -10);
				addOffset("singRIGHT", -65, 5);
				addOffset("singLEFT", 130, 5);
				addOffset("singDOWN", -2, -26);

				playAnim('idle');
			case 'cableCrowPog':
				tex = Paths.getSparrowAtlas('five-minute-song/Cablecrow','ChallengeWeek');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 14);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				loadOffsetFile(curCharacter);
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function loadOffsetFile(character:String)
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/characters/' + character + "Offsets", 'shared'));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (this != PlayState.boyfriend)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	 public function dance(forced:Bool = false, altAnim:Bool = false)
		{
			if (!debugMode)
			{
				switch (curCharacter)
				{
					case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel':
						if (!animation.curAnim.name.startsWith('hair') && !animation.curAnim.name.startsWith('sing'))
						{
							danced = !danced;
	
							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}
					case 'spooky':
						danced = !danced;
	
						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					default:
						if (altAnim && animation.getByName('idle-alt') != null)
							playAnim('idle-alt', forced);
						else
							playAnim('idle', forced);
				}
			}
		}

		
	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
