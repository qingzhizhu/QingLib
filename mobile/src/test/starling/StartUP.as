package test.starling 
{
	import com.qing.utils.MySystem;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	import test.starling.image.ImageTest;
	import test.starling.startup.Game;
	import test.starling.touch.MultitouchTest;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	//[SWF(width="400", height="300", backgroundColor="0xCCCCCC", frameRate="60")]
	public class StartUP extends Sprite 
	{
		private var mStarling:Starling;
		public function StartUP() 
		{
			// These settings are recommended to avoid problems with touch handling
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
 
            // Create a Starling instance that will run the "Game" class
            //mStarling = new Starling(Game, stage);
			//----------image test----------
			//mStarling = new Starling(ImageTest, stage);
			
			//----------multitouch test----------
			Starling.multitouchEnabled = true;
			mStarling = new Starling(MultitouchTest, stage);
			
            mStarling.start();
			
			trace("android:", MySystem.isAndroid, "iso:", MySystem.isIOS);
		}
		
	}

}