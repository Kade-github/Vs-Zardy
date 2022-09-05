package;

import flixel.math.FlxMath;
import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['freeplay', 'options', 'plush', 'foolhardy','bushwhack'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.7" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;
	
	public var fool:FlxSprite;
	public var vush:FlxSprite;


	public var scoreText:FlxText;
	public var scoreBG:FlxSprite;
	public var rateText:FlxText;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.04;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		if(FlxG.save.data.antialiasing)
			{
				bg.antialiasing = true;
			}
		add(bg);

		PlayState.poggin = false;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.04;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		if(FlxG.save.data.antialiasing)
			{
				magenta.antialiasing = true;
			}
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		var tex2 = Paths.getSparrowAtlas('foolhardy_menu_text',"ChallengeWeek");
		var tex3 = Paths.getSparrowAtlas('bushvvhack',"ChallengeWeek");
		var tex4 = Paths.getSparrowAtlas('plishue',"ChallengeWeek");

		for (i in 0...optionShit.length - 3)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.ID = i;
			menuItem.animation.play('idle');

			trace(optionShit[i] + " - " + i);
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			if(FlxG.save.data.antialiasing)
				{
					menuItem.antialiasing = true;
				}
			if (firstStart)
				FlxTween.tween(menuItem,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
			else
				menuItem.y = 60 + (i * 160);
		}

		var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
		menuItem.frames = tex4;
		menuItem.animation.addByPrefix('idle', "plushieSmall", 24);
		menuItem.animation.addByPrefix('selected', "plushieBig", 24);
		menuItem.ID = 2;
		menuItem.animation.play('idle');
		menuItem.screenCenter(X);
		menuItems.add(menuItem);
		menuItem.scrollFactor.set();
		if(FlxG.save.data.antialiasing)
			{
				menuItem.antialiasing = true;
			}
		if (firstStart)
			FlxTween.tween(menuItem,{y: 60 + (2 * 160)},1 + (2 * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
				{ 
					finishedFunnyMove = true; 
					changeItem();
				}});
		else
			menuItem.y = 60 + (2 * 160);

		fool = new FlxSprite(0, FlxG.height * 1.6);
		fool.frames = tex2;
		fool.animation.addByPrefix('idle', "foolhardy basic", 24);
		fool.animation.addByPrefix('selected', "foolhardy white", 24);
		fool.animation.play('idle');
		fool.ID = menuItems.length;
		fool.screenCenter(X);
		fool.x -= 100;
		fool.scrollFactor.set();

		vush = new FlxSprite(0, FlxG.height * 1.6);
		vush.frames = tex3;
		vush.animation.addByPrefix('idle', "BushwhackSmall", 24);
		vush.animation.addByPrefix('selected', "BushwhackBig", 24);
		vush.animation.play('idle');
		vush.ID = menuItems.length + 1;
		vush.screenCenter(X);
		vush.x += 125 ;
		vush.scrollFactor.set();

		add(vush);
		add(fool);

		
		scoreText = new FlxText(FlxG.width * 0.7, -15, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		rateText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		rateText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		rateText.text = "1x";

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 80, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		add(scoreText);
		add(rateText);

		scoreText.scrollFactor.set();
		scoreBG.scrollFactor.set();
		rateText.scrollFactor.set();

		scoreText.y = -200;
		rateText.y = -200;
		scoreBG.y = -200;

		trace(fool.ID + " " + vush.ID);

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		#if android
		addVirtualPad(UP_DOWN, A_B);
		#end

		super.create();
	}

	var selectedSomethin:Bool = false;

	var lerpScore:Float = 0;
	var intendedScore:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		rateText.text = "Rate: " + HelperFunctions.truncateFloat(rate,2) + "x";

		
		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				if (type)
				{
					curSelected = 0;
					goToState();
				}
				else
					FlxG.switchState(new TitleState());
			}

			if (FlxG.keys.pressed.SHIFT)
			{
				if (FlxG.keys.justPressed.LEFT)
					rate -= 0.05;
				if (FlxG.keys.justPressed.RIGHT)
					rate += 0.05;
		
				if (rate > 3)
					rate = 3;
				else if (rate < 0.5)
					rate = 0.5;
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'plush')
				{
					fancyOpenURL("https://www.makeship.com/products/zardy-plush");
				}
				else
				{
					selectedSomethin = true;
					if (curSelected < menuItems.length)
						FlxG.sound.play(Paths.sound('confirmMenu'));
					else
						FlxG.sound.play(Paths.sound('game_start',"ChallengeWeek"));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, true, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
					
					if (fool.ID == curSelected || vush.ID == curSelected)
					{
						if (FlxG.save.data.flashing)
						{
							FlxFlicker.flicker(fool.ID == curSelected ? fool : vush, 1, 0.06, true, false, function(flick:FlxFlicker)
							{
								goToState();
							});
						}
						else
						{
							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
						}
					}
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}
	
	public var type = false;

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			default:
				selectedSomethin = false;
				if (!type)
				{
					for(i in 0...menuItems.members.length)
					{
						var menu = menuItems.members[i];
						FlxTween.tween(menu,{y: FlxG.height * 1.6},1 + (i * 0.25) ,{ease: FlxEase.expoInOut});
					}

					FlxTween.tween(fool,{y: 60 },1  ,{ease: FlxEase.expoInOut});
					FlxTween.tween(vush,{y: 60 + 160},1 + 0.25 ,{ease: FlxEase.expoInOut});
					curSelected = menuItems.length;
					intendedScore = Highscore.getScore("Foolhardy", 1);
					FlxTween.tween(scoreBG,{y: 0},1,{ease: FlxEase.expoInOut});
					FlxTween.tween(scoreText,{y: 5},1,{ease: FlxEase.expoInOut});
					FlxTween.tween(rateText,{y: 40},1,{ease: FlxEase.expoInOut});

					trace(curSelected);
				}
				else
				{
					for(i in 0...menuItems.members.length)
					{
						var menu = menuItems.members[i];
						FlxTween.tween(menu,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut});
					}

					FlxTween.tween(fool,{y: FlxG.height * 1.6 },1  ,{ease: FlxEase.expoInOut});
					FlxTween.tween(vush,{y: FlxG.height * 1.6},1 + 0.25 ,{ease: FlxEase.expoInOut});
					FlxTween.tween(scoreBG,{y: -200},1,{ease: FlxEase.expoInOut});
					FlxTween.tween(scoreText,{y: -200},1,{ease: FlxEase.expoInOut});
					FlxTween.tween(rateText,{y: -200},1,{ease: FlxEase.expoInOut});
					curSelected = 0;
				}

				type = !type;

				menuItems.forEach(function(spr:FlxSprite)
					{
						spr.animation.play('idle');
			
						if (curSelected == 1)
						{
							if (spr.ID == 9)
							{
								spr.animation.play('selected');
								camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
							}
						}
						else if (spr.ID == curSelected && finishedFunnyMove)
						{
							trace("selected " + spr.ID);
							spr.animation.play('selected');
							camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
						}
			
						spr.updateHitbox();
					});

				if (fool.ID == curSelected)
				{
					fool.animation.play('selected');
					camFollow.setPosition(fool.getGraphicMidpoint().x, fool.getGraphicMidpoint().y);
		
					fool.updateHitbox();
				}

				if (vush.ID == curSelected)
				{
					vush.animation.play('selected');
					camFollow.setPosition(vush.getGraphicMidpoint().x, vush.getGraphicMidpoint().y);
		
					vush.updateHitbox();
				}
			case 'options':
				FlxG.switchState(new OptionsMenu());

			case "foolhardy" | "bushwhack":
				trace("loading " + daChoice);
				var poop:String = Highscore.formatSong(daChoice, 1);

				PlayState.SONG = Song.conversionChecks(Song.loadFromJson(poop, daChoice));
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 1;

				PlayState.storyWeek = 0;
				PlayState.songMultiplier = rate;
				PlayState.loadRep = false;
				LoadingState.loadAndSwitchState(new PlayState());
		}
	}

	public var rate:Float = 1;

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			if (!type)
			{
				curSelected += huh;

				if (curSelected > menuItems.length - 1)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = menuItems.length - 1;
			}
			else
			{
				curSelected += huh;

				if (curSelected > menuItems.length + 1)
					curSelected = menuItems.length;
				if (curSelected < menuItems.length)
					curSelected = menuItems.length + 1;
				trace(curSelected);
			}
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				trace("selected " + spr.ID);
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.animation.curAnim.frameRate = 24 * (60 / FlxG.save.data.fpsCap);

			spr.updateHitbox();
		});

		if (fool.ID == curSelected)
		{
			intendedScore = Highscore.getScore("Foolhardy", 1);
			fool.animation.play('selected');
			camFollow.setPosition(fool.getGraphicMidpoint().x, fool.getGraphicMidpoint().y);
			fool.offset.x = 0;
			fool.updateHitbox();
		}
		else
		{
			fool.offset.x = -100;
			fool.animation.play('idle');
		}

		if (vush.ID == curSelected)
		{
			intendedScore = Highscore.getScore("Bushwhack", 1);
			vush.animation.play('selected');
			trace("offset");
			camFollow.setPosition(vush.getGraphicMidpoint().x, vush.getGraphicMidpoint().y);

			vush.updateHitbox();
			vush.offset.x = 100;
		}
		else
		{
			vush.animation.play('idle');
			vush.offset.x = 0;
		}
	}
}
