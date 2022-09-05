package android;

import android.flixel.FlxHitbox;
import android.flixel.FlxVirtualPad;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;

/**
 * @author Mihai Alexandru (M.A. Jigsaw)
 */
class AndroidControls extends FlxSpriteGroup
{
	public var virtualPad:FlxVirtualPad;
	public var hitbox:FlxHitbox;

	public function new()
	{
		super();

		switch (AndroidControls.getMode())
		{
			case 'Pad-Right':
				virtualPad = new FlxVirtualPad(RIGHT_FULL, NONE);
				add(virtualPad);
			case 'Pad-Left':
				virtualPad = new FlxVirtualPad(LEFT_FULL, NONE);
				add(virtualPad);
			case 'Pad-Custom':
				virtualPad = AndroidControls.getCustomMode(new FlxVirtualPad(RIGHT_FULL, NONE));
				add(virtualPad);
			case 'Pad-Duo':
				virtualPad = new FlxVirtualPad(BOTH_FULL, NONE);
				add(virtualPad);
			case 'Hitbox':
				hitbox = new FlxHitbox();
				add(hitbox);
			case 'Keyboard': // do nothing
		}
	}

	override public function destroy():Void
	{
		super.destroy();

		if (virtualPad != null)
		{
			virtualPad = FlxDestroyUtil.destroy(virtualPad);
			virtualPad = null;
		}

		if (hitbox != null)
		{
			hitbox = FlxDestroyUtil.destroy(hitbox);
			hitbox = null;
		}
	}

	public static function setOpacity(opacity:Float, isHitbox:Bool = false):Void
	{
		if (!isHitbox)
		{
			FlxG.save.data.virtualPadOpacity = opacity;
			FlxG.save.flush();
		}
		else
		{
			FlxG.save.data.hitboxOpacity = opacity;
			FlxG.save.flush();
		}
	}

	public static function getOpacity(isHitbox:Bool = false):Float
	{
		if (!isHitbox)
		{
			if (FlxG.save.data.virtualPadOpacity == null)
			{
				FlxG.save.data.virtualPadOpacity = 0.6;
				FlxG.save.flush();
			}

			return FlxG.save.data.virtualPadOpacity;
		}
		else
		{
			if (FlxG.save.data.hitboxOpacity == null)
			{
				FlxG.save.data.hitboxOpacity = 0.3;
				FlxG.save.flush();
			}

			return FlxG.save.data.hitboxOpacity;
		}
	}

	public static function setMode(mode:String = 'Pad-Right'):Void
	{
		FlxG.save.data.controlsMode = mode;
		FlxG.save.flush();
	}

	public static function getMode():String
	{
		if (FlxG.save.data.controlsMode == null)
		{
			FlxG.save.data.controlsMode = 'Pad-Right';
			FlxG.save.flush();
		}

		return FlxG.save.data.controlsMode;
	}

	public static function setCustomMode(virtualPad:FlxVirtualPad):Void
	{
		if (FlxG.save.data.buttons == null)
		{
			FlxG.save.data.buttons = new Array();
			for (buttons in virtualPad)
				FlxG.save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
		}
		else
		{
			var tempCount:Int = 0;
			for (buttons in virtualPad)
			{
				FlxG.save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}

		FlxG.save.flush();
	}

	public static function getCustomMode(virtualPad:FlxVirtualPad):FlxVirtualPad
	{
		if (FlxG.save.data.buttons == null)
			return virtualPad;

		var tempCount:Int = 0;
		for (buttons in virtualPad)
		{
			buttons.x = FlxG.save.data.buttons[tempCount].x;
			buttons.y = FlxG.save.data.buttons[tempCount].y;
			tempCount++;
		}

		return virtualPad;
	}
}
