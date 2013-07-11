package starling.utils 
{
	import com.qing.utils.construct;
	import com.qing.utils.singleton;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import starling.filters.BlurFilter;
	/**
	 * starling 滤镜
	 * @author gengkun123@gmail.com
	 */
	public class FilterUtils 
	{
		private static var _dic : Dictionary = new Dictionary();
		
		/**
		 * 模糊滤镜
		 * @param	isNew 是否重新创建
		 * @param	...params 需对应 (blurX:Number=1, blurY:Number=1, resolution:Number=1)
		 */
		public static function blur(isNew:Boolean = false, ...params):void {
			isNew ? construct(BlurFilter, params) : singleton(BlurFilter, params);
		}
		
		// the blur filter handles also drop shadow and glow
		private static var _dropShadow : BlurFilter = null;
		public static function dropShadow(isNew:Boolean = false, ...params):void {
			isNew ? BlurFilter.createDropShadow.call(null, params) : (_dropShadow ? _dropShadow : _dropShadow = BlurFilter.createDropShadow.call(null, params));
		}
		
		// the blur filter handles also drop shadow and glow
		private static var _glow : BlurFilter = null;
		public static function glow(isNew:Boolean = false, ...params):void {
			isNew ? BlurFilter.createGlow.call(null, params) : (_glow ? _glow : _glow = BlurFilter.createGlow.call(null, params));
		}
		
		
		
		/*
		// the blur filter handles also drop shadow and glow
		var blur:BlurFilter = new BlurFilter();
		var dropShadow:BlurFilter = BlurFilter.createDropShadow();
		var glow:BlurFilter = BlurFilter.createGlow();

		// the ColorMatrixFilter contains some handy helper methods
		var colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter();
		colorMatrixFilter.invert();                // invert image
		colorMatrixFilter.adjustSaturation(-1);    // make image Grayscale
		colorMatrixFilter.adjustContrast(0.75);    // raise contrast
		colorMatrixFilter.adjustHue(1);            // change hue
		colorMatrixFilter.adjustBrightness(-0.25); // darken image

		// to use a filter, just set it to the "filter" property
		sprite.filter = anyFilter;
		*/
	}

}