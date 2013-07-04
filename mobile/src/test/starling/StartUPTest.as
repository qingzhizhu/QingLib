package test.starling 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	import starling.extensions.krecha.PixelImageTouch;
	import test.starling.better.QuadBatchTest;
	import test.starling.customDisplayobject.CustomDisObjTest;
	import test.starling.displayobject.SpriteTest;
	import test.starling.feathers.HelloWorld;
	import test.starling.image.ImageTest;
	import test.starling.PixelPerfectTouch.PixelPerfectTouchDemo;
	import test.starling.startup.Game;
	import test.starling.text.TextTest;
	import test.starling.third.GaugeTest;
	import test.starling.third.ParticleTest;
	import test.starling.third.JoyStickTest;
	import test.starling.touch.MultitouchTest;
	import test.starling.tween.TweenTest;
	
	/**
	 * 单个文件测试
	 * @author gengkun123@gmail.com
	 */
	[SWF(width="800", height="480", backgroundColor="0xCCCCCC", frameRate="60")]
	public class StartUPTest extends Sprite 
	{
		private var mStarling:Starling;
		public function StartUPTest() 
		{
			// These settings are recommended to avoid problems with touch handling
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
 
            // Create a Starling instance that will run the "Game" class
            //mStarling = new Starling(Game, stage);
			//----------image test----------
			//mStarling = new Starling(ImageTest, stage);
			
			//----------multitouch test----------
			//Starling.multitouchEnabled = true;
			//mStarling = new Starling(MultitouchTest, stage);
			
			//----------quadbatch test----------
			//mStarling = new Starling(QuadBatchTest, stage);
			
			//----------custom displayobject test----------
			//mStarling = new Starling(CustomDisObjTest, stage);
			
			//----------custom displayobject test----------
			//mStarling = new Starling(CustomDisObjTest, stage);
			
			//---------- 文本  test----------
			//mStarling = new Starling(TextTest, stage);
			
			//---------- 粒子系统 test----------
			//mStarling = new Starling(ParticleTest, stage);
			
			//---------- 操作杆 test----------
			//mStarling = new Starling(JoyStickTest, stage);
			
			//---------- feather ui test----------
			//mStarling = new Starling(HelloWorld, stage);
			
			//---------- 遮罩 sprite test----------
			//mStarling = new Starling(SpriteTest, stage);
			
			//---------- 进度条 test----------
			//mStarling = new Starling(GaugeTest, stage);
			
			//---------- 进度条 test----------
			mStarling = new Starling(PixelPerfectTouchDemo, stage);
			
			
            mStarling.start();
			
			
		}
		
	}

}