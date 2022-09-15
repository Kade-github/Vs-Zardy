package;

import flixel.FlxG;
import flixel.FlxState;
import openfl.events.Event;
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;
import vlc.VlcBitmap;
import flixel.FlxSprite;

// THIS IS FOR TESTING
// DONT STEAL MY CODE >:(
class MP4Handler
{
	public static var video:Video;
	public static var netStream:NetStream;
	public static var finishCallback:FlxState;
	public var sprite:FlxSprite;
	public static var VlcBitmap:VlcBitmap;

	public function new()
	{
		FlxG.autoPause = false;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}
	}

	public function playMP4(path:String, callback:FlxState, ?outputTo:FlxSprite = null, ?repeat:Bool = false, ?isWindow:Bool = false, ?isFullscreen:Bool = false):Void
	{
		#if html5
		FlxG.autoPause = false;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}

		finishCallback = callback;

		video = new Video();
		video.x = 0;
		video.y = 0;

		FlxG.addChildBelowMouse(video);

		var nc = new NetConnection();
		nc.connect(null);

		netStream = new NetStream(nc);
		netStream.client = {onMetaData: client_onMetaData};

		nc.addEventListener("netStatus", netConnection_onNetStatus);

		netStream.play(path);
		#else
		finishCallback = callback;

		VlcBitmap = new VlcBitmap();

		VlcBitmap.set_height(FlxG.stage.stageHeight);
		VlcBitmap.set_width(FlxG.stage.stageHeight * (16 / 9));

		trace("Setting width to " + FlxG.stage.stageHeight * (16 / 9));
		trace("Setting height to " + FlxG.stage.stageHeight);

		VlcBitmap.onVideoReady = onVLCVideoReady;
		VlcBitmap.onComplete = onVLCComplete;
		VlcBitmap.onError = onVLCError;

		FlxG.stage.addEventListener(Event.ENTER_FRAME, update);

		if (repeat)
			VlcBitmap.repeat = -1;
		else
			VlcBitmap.repeat = 0;

		VlcBitmap.inWindow = isWindow;
		VlcBitmap.fullscreen = isFullscreen;

		FlxG.addChildBelowMouse(VlcBitmap);
		VlcBitmap.play(checkFile(path));
		if (outputTo != null)
		{
			// lol this is bad kek
			
			VlcBitmap.x = -20000; // defn off screen

			sprite = outputTo;
			trace("gosh darn rabitygs");
		}
		#end
	}

	function checkFile(fileName:String):String
	{
		var pDir = "";
		var appDir = "file:///" + Sys.getCwd() + "/";

		if (fileName.indexOf(":") == -1) // Not a path
			pDir = appDir;
		else if (fileName.indexOf("file://") == -1 || fileName.indexOf("http") == -1) // C:, D: etc? ..missing "file:///" ?
			pDir = "file:///";

		return pDir + fileName;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function onVLCVideoReady()
	{
		trace("video loaded!");
		if (sprite != null)
		{
			sprite.loadGraphic(VlcBitmap.bitmapData);	
			trace("loaded da graphics " + VlcBitmap.bitmapData);
		}
	}

	public function onVLCComplete()
	{
		if (sprite != null)
		{
			VlcBitmap.pause();
			return;
		}
		VlcBitmap.stop();

		// Clean player, just in case!
		VlcBitmap.dispose();

		if (FlxG.game.contains(VlcBitmap))
		{
			FlxG.game.removeChild(VlcBitmap);
		}

		trace("Big, Big Chungus, Big Chungus!");

		if (finishCallback != null)
		{
			LoadingState.loadAndSwitchState(finishCallback);
		}
	}

	function onVLCError()
	{
		if (finishCallback != null)
		{
			LoadingState.loadAndSwitchState(finishCallback);
		}
	}

	function update(e:Event)
	{
		VlcBitmap.volume = FlxG.sound.volume; // shitty volume fix
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function client_onMetaData(path)
	{
		video.attachNetStream(netStream);

		video.width = FlxG.width;
		video.height = FlxG.height;
	}

	function netConnection_onNetStatus(path)
	{
		if (path.info.code == "NetStream.Play.Complete")
		{
			finishVideo();
		}
	}

	function finishVideo()
	{
		netStream.dispose();

		if (FlxG.game.contains(video))
		{
			FlxG.game.removeChild(video);
		}

		if (finishCallback != null)
		{
			LoadingState.loadAndSwitchState(finishCallback);
		}
		else
			LoadingState.loadAndSwitchState(new MainMenuState());
	}

	// old html5 player
	/*
		var nc:NetConnection = new NetConnection();
		nc.connect(null);
		var ns:NetStream = new NetStream(nc);
		var myVideo:Video = new Video();
		myVideo.width = FlxG.width;
		myVideo.height = FlxG.height;
		myVideo.attachNetStream(ns);
		ns.play(path);
		return myVideo;
		ns.close();
	 */
}
