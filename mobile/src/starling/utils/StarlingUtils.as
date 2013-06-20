package starling.utils 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import starling.animation.Transitions;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Stage;
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
		
		
		/**
		 * 截屏。Screenshot to BitmapData
		 * @param	scl
		 * @return
		 */
		public static function takeScreenshot(scl:Number=1.0):BitmapData
		{
			var stage:Stage= Starling.current.stage;
			var width:Number = stage.stageWidth;
			var height:Number = stage.stageHeight;
		 
			var rs:RenderSupport = new RenderSupport();
		 
			rs.clear(stage.color, 1.0);
			rs.scaleMatrix(scl, scl);
			rs.setOrthographicProjection(0, 0, width, height);
		 
			stage.render(rs, 1.0);
			rs.finishQuadBatch();
		 
			var outBmp:BitmapData = new BitmapData(width*scl, height*scl, true);
			Starling.context.drawToBitmapData(outBmp);
		 
			return outBmp;
		}
		
		/**
		 * Any display object to BitmapData<br/>
		 * note: 1.暂时不能渲染透明的图片，RencderSupport.clear(0,0) 没有效果.<br/>
		 * 2. 在手机上不能用。
		 * @param	disp
		 * @param	scl
		 * @return
		 */
		public static function copyToBitmap(disp:DisplayObject, scl:Number=1.0):BitmapData
		{
			var rc:Rectangle = new Rectangle();
			disp.getBounds(disp, rc);
		 
			var stage:Stage= Starling.current.stage;
			var rs:RenderSupport = new RenderSupport();
		 
			rs.clear();
			rs.scaleMatrix(scl, scl);
			rs.setOrthographicProjection(0, 0, stage.stageWidth, stage.stageHeight);
			rs.translateMatrix(-rc.x, -rc.y); // move to 0,0
			disp.render(rs, 1.0);
			rs.finishQuadBatch();
		 
			var outBmp:BitmapData = new BitmapData(rc.width*scl, rc.height*scl, true);
			Starling.context.drawToBitmapData(outBmp);
		 
			return outBmp;
		}
		
		
	}

}