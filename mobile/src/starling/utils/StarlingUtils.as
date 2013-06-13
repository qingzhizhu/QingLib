package starling.utils 
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	import starling.animation.Transitions;
	import starling.display.Image;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class StarlingUtils 
	{
		
		public function StarlingUtils() 
		{
			
		}
		/**
		 * 注册过渡
		 */
		public static function registerTransitions():void {
			Transitions.register("shakyLinear",
			function(ratio:Number):Number
			{
			   if (ratio == 0.0 || ratio == 1.0) return ratio;
			   else return ratio + Math.sin(getTimer() / 100) * 0.1 - 0.05;
			});
			
			Transitions.register("easeInCubic",
			function(ratio:Number):Number
			{
				return ratio * ratio * ratio * ratio;
			});	
			 
			Transitions.register("easeInQuadratic",
				function(ratio:Number):Number
				{
					return ratio * ratio * ratio * ratio  * ratio;
			});			
			 
			Transitions.register("easeOutCubic",
				function(ratio:Number):Number
				{
					var invRatio:Number = ratio - 1.0;
					return invRatio * invRatio * invRatio * invRatio  * invRatio * invRatio  * invRatio + 1;
			});	
			
		}
		
		/**
		 * 平铺图片
		 * //Tiles texture, give number of horizontal and vertical tiles
		 * @param	img
		 * @param	horizontally 水平
		 * @param	vertically 垂直
		 */
		public static function tileImg(img:Image, horizontally:int, vertically:int):void {
			img.texture.repeat = true;
			img.setTexCoords(1, new Point(horizontally, 0));
			img.setTexCoords(2, new Point(0, vertically));
			img.setTexCoords(3, new Point(horizontally, vertically));
			img.width *= horizontally;
			img.height *= vertically;
		}
		
		
		
		
		
	}

}