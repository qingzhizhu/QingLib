package com.qing._3rd.greensock 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	/**
	 * 窗口的显示和退出特效
	 * @author gengkun123@gmail.com
	 */
	public class PopupEffectUtils 
	{
		
		/**
		 * 根据缩放显示特效
		 * @param	source
		 * @param	duration
		 * @param	callBack
		 * @param	originalX 表示原始的x
		 * @param	originalY 表示原始的y
		 * @param	delay 延迟
		 * @param	sX	缩放达到的scaleX
		 * @param	sY	缩放达到的scaleY
		 */
		public static function showByScale(source:DisplayObject, duration:Number = 1, callBack:Function = null, originalX:int = 0, originalY:int = 0, delay:Number = 0, sX:Number = 1, sY:Number = 1):void {
			TweenLite.killTweensOf(source, true);
			var tscale : Number = 0.4;	//(1-0.2) /2
			//trace("show1", source.x, source.y, source.width, source.height);
			source.x = originalX + source.width / source.scaleX * tscale;
			source.y = originalY + source.height / source.scaleY * tscale;
			//trace("show2", source.x, source.y, source.width, source.height);
			
			if (source.scaleX == sX || source.scaleY == sY) {
				source.scaleX = tscale;
				source.scaleY = tscale;
			}
			
			TweenLite.to(source, duration, {ease:Back.easeOut, scaleX:sX,scaleY:sY, onComplete:callBack, delay:delay, x:originalX, y:originalY} );
		}
		
		/**
		 * 根据缩隐藏特效
		 * @param	source
		 * @param	duration
		 * @param	callBack
		 * @param	dealy 延迟
		 * @param	sX	缩放达到的scaleX
		 * @param	sY	缩放达到的scaleY
		 */
		public static function hideByScale(source:DisplayObject, duration:Number = 1, callBack:Function = null, delay:Number = 0, sX:Number = .2, sY:Number = .2):void {
			TweenLite.killTweensOf(source, true);
			var tscale : Number = 0.4;
			if (source.scaleX == sX || source.scaleY == sY) {
				source.scaleX = 1;
				source.scaleY = 1;
			}
			//trace("hide1", source.x, source.y, source.width, source.height);
			var tx : int = (source.width * tscale) + source.x;
			var ty : int = (source.height * tscale) + source.y;
			//trace("hide2", source.x, source.y, source.width, source.height, tx, ty);
			TweenLite.to(source, duration, {ease:Back.easeIn, scaleX:sX,scaleY:sY, onComplete:callBack, delay:delay, x:tx, y:ty} );
		}
		
	}

}