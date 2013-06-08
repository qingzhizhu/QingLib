package test.starling 
{
	import com.qing.utils.MySystem;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class StartUP extends Sprite 
	{
		// Startup image for SD screens
        [Embed(source="../../../../system/startup.jpg")]
        private static var Background:Class;
        
        // Startup image for HD screens
        [Embed(source="../../../../system/startupHD.jpg")]
        private static var BackgroundHD:Class;
		
		private var mStarling:Starling;
		
		private var _stageWidth : int = 320;
		private var _stageHeight : int = 480;
		
		public function StartUP() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = "TL";
			stage.scaleMode = "noScale";
			
			var stageWidth:int  = _stageWidth;
            var stageHeight:int = _stageHeight;
			
			var iOS:Boolean = MySystem.isIOS;
			
			Starling.multitouchEnabled = true; // for Multitouch Scene
            Starling.handleLostContext = !iOS; // required on Windows, needs more memory
            
			
			// create a suitable viewport for the screen size
            // 
            // we develop the game in a *fixed* coordinate system of 320x480; the game might 
            // then run on a device with a different resolution; for that case, we zoom the 
            // viewPort to the optimal size for any display and load the optimal textures.
            
			CONFIG::MOBILE{
            var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, stageWidth, stageHeight), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL, iOS);
			}
			CONFIG::WEB{
			var viewPort:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			}
			var scaleFactor:int = viewPort.width < stageHeight ? 1 : 2; // midway between 320 and 640
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
            // we display a startup image now and remove it below, when Starling is ready to go.
            // This is especially useful on iOS, where "Default.png" (or a variant) is displayed
            // during Startup. You can create an absolute seamless startup that way.
            // 
            // These are the only embedded graphics in this app. We can't load them from disk,
            // because that can only be done asynchronously - i.e. flickering would return.
            // 
            // Note that we cannot embed "Default.png" (or its siblings), because any embedded
            // files will vanish from the application package, and those are picked up by the OS!
            
            var background:Bitmap = scaleFactor == 1 ? new Background() : new BackgroundHD();
            Background = BackgroundHD = null; // no longer needed!
            
            background.x = viewPort.x;
            background.y = viewPort.y;
            background.width  = viewPort.width;
            background.height = viewPort.height;
            background.smoothing = true;
            addChild(background);
            
            // launch Starling
				
			
            mStarling = new Starling(Game, stage, viewPort);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            mStarling.addEventListener(Event.ROOT_CREATED, function():void
            {
				// set framerate to 30 in software mode
				if (mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
					mStarling.nativeStage.frameRate = 30;
				
				 // create the AssetManager, which handles all required assets for this resolution
				
				var scaleFactor:int = mStarling.viewPort.width < _stageHeight ? 1 : 2; // midway between 320 and 640
				
				var assets:AssetManager = new AssetManager(scaleFactor);            
				assets.verbose = Capabilities.isDebugger;
				
				//air, android, iso..
				CONFIG::MOBILE {
				import flash.filesystem.File;
				
				var appDir:File = File.applicationDirectory;
				assets.enqueue(
					appDir.resolvePath("audio"),
					appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
					appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
				);
				}
				
				//web 
				CONFIG::WEB{
				assets.enqueue(EmbeddedAssets);
				}
			
                removeChild(background);
                
                var game:Game = mStarling.root as Game;
                var bgTexture:Texture = Texture.fromBitmap(background, false, false, scaleFactor);
                
                game.start(bgTexture, assets);
                mStarling.start();
            });
			
			
			
		}
		
		
		
	}

}