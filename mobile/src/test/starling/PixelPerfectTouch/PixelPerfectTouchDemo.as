package test.starling.PixelPerfectTouch 
{
	import flash.display.Bitmap;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.krecha.PixelHitArea;
	import starling.extensions.krecha.PixelImageTouch;
	import starling.textures.Texture;
	
	/**
	 * This extension class allow to create an Image display object, that is touchable only in place where alpha is 0 (or higher - by use threshold).
	 * 应该是过滤图片透明区域的点击事件，但是有问题。。。。
	 * @author gengkun123@gmail.com
	 */
	public class PixelPerfectTouchDemo extends Sprite 
	{
		
		public function PixelPerfectTouchDemo() 
		{
			
			//First we must create hitArea for a bitmapaData used in Image.
			var myBitmap:Bitmap = new Assets.BIRD();
			var hit_1:PixelHitArea = new PixelHitArea ( myBitmap, .2); // second arg is sampling for bitmapData
			//or
			var hit_2:PixelHitArea = new PixelHitArea ( myBitmap, 1, 'area_name');
			//then
			trace ( PixelHitArea.getHitArea ('area_name') == hit_2 ) // true
			 
			//Now we can create a PixelImageTouch.
			var img_1:PixelImageTouch = new PixelImageTouch ( Texture.fromBitmap (myBitmap), hit_1, 150 ); //last arg is a treshold for alpha channel;
			var img_2:PixelImageTouch = new PixelImageTouch ( Texture.fromBitmap (myBitmap), PixelHitArea.getHitArea('area_name'));
			 
			//Additional usage.
			img_1.hitArea = null;// otherHitArea; //or null, then PixelImageTouch works just like Image, still is touchable but without alpha test
			 
			//dispose, after that PixelImageTouch works just like an Image
			hit_1.dispose ();
			PixelHitArea.disposeHitArea ( PixelHitArea.getHitArea('area_name') );
			PixelHitArea.dispose (); //dispose all ares
			 
			trace (PixelHitArea.getDebugInfo ()) //get size and time needed to create for all hitAreas, size is valid only in debug mode, in normal it equals 0;
					
			//img_2.addEventListener(TouchEvent.TOUCH, onTouch);  //这个会报错的...
			addChild(img_2);
			this.img_2 = img_2;
		}
		private var img_2 : PixelImageTouch = null;
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch : Touch = e.getTouch(img_2);
			if(touch && touch.phase == TouchPhase.ENDED){
			trace(e, e.target);
			}
		}
		
	}

}