package test.starling 
{
	import com.qing.utils.MySystem;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.formatString;
	
	/**
	 * 全屏 starling
	 * @author gengkun123@gmail.com
	 */
	[SWF(width="480", height="320", backgroundColor="0xCCCCCC")]
	public class FullScreen extends Sprite 
	{
		private var mStarling:Starling;
		public function FullScreen() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = "TL";
			stage.scaleMode = "noScale";
			
			//横屏时, 不在使用
			//stage.setAspectRatio("landscape");
			//var isLandscapeNow:Boolean = (stageWidth > stageHeight); Constants.isLandscape;
			//var screenWidth:int  = Math.max(stage.fullScreenWidth, stage.fullScreenHeight) ;
			//var screenHeight:int = Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			
			//set full screen view port.
			var screenWidth:int = Constants.GameWidth;
			var screenHeight:int = Constants.GameHeight;
			var viewPort : Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);
			var scaleFactor:int = 1;
			
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
            
            var background:Bitmap = null;
			//测试没有loading图片，用shape代替了。。。
			//background = scaleFactor == 1 ? new Background() : new BackgroundHD();
            //Background = BackgroundHD = null; // no longer needed!
            
			if (true) {
				var shape : Shape = new Shape();
				shape.graphics.lineStyle(1);
				shape.graphics.beginFill(0xFFFF, 0.5);
				shape.graphics.drawRect(0, 0, screenWidth, screenHeight);
				shape.graphics.endFill();
				var btd : BitmapData = new BitmapData(screenWidth, screenHeight);
				btd.draw(shape);
				shape = null;
				background = new Bitmap(btd);
			}
			
            background.x = viewPort.x;
            background.y = viewPort.y;
            background.width  = viewPort.width;
            background.height = viewPort.height;
            background.smoothing = true;
            addChild(background);
			
			
			
			
			var iOS:Boolean = MySystem.isIOS;
			
			Starling.multitouchEnabled = true; // for Multitouch Scene
            Starling.handleLostContext = !iOS; // required on Windows, needs more memory
			
			
			
			// launch Starling
				
			
            mStarling = new Starling(Game, stage, viewPort);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Constants.isDebugger;
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            mStarling.addEventListener(Event.ROOT_CREATED, function():void
            {
				// set framerate to 30 in software mode
				if (mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
					mStarling.nativeStage.frameRate = 30;
				
				 // create the AssetManager, which handles all required assets for this resolution
				
				var scaleFactor:int = 1;// mStarling.viewPort.width < _stageHeight ? 1 : 2; // midway between 320 and 640
				
				var assets:AssetManager = new AssetManager(scaleFactor);            
				assets.verbose = Constants.isDebugger;
				
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
			
                //removeChild(background);
                
                var game:Game = mStarling.root as Game;
                var bgTexture:Texture = Texture.fromBitmap(background, false, false, scaleFactor);
                
                game.start(bgTexture, assets);
                mStarling.start();
            });
			
			
		}
		
	}

}