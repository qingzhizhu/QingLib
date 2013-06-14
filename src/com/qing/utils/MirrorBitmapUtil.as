package com.qing.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * 静态化一个对象
	 * @author kevin geng
	 */
	public class MirrorBitmapUtil
	{
		
		public static function create(dis:DisplayObject, drawRect:Rectangle, autoAdd:Boolean=true, transparent:Boolean=false, fillColor:uint=0, pixelSnapping:String="never", smoothing:Boolean=false):MirrorBitmapUtil{
			var mirror : MirrorBitmapUtil = new MirrorBitmapUtil(dis, drawRect, transparent, fillColor, pixelSnapping, smoothing);
			if (autoAdd) {
				var parent : DisplayObjectContainer = dis.parent, index:int = parent.getChildIndex(dis);
				parent.removeChild(dis);
				parent.addChildAt(mirror.bitmap, index);
				mirror.moveto(dis.x, dis.y);
				parent = null;
			}
			return mirror;
		}
		
		private static var _matrix : Matrix = new Matrix();
		private static var _boundsRect : Rectangle = null;
		
		private var _target : DisplayObject = null;
		private var _bitmap : Bitmap = null;
		private var _bitmapData : BitmapData = null;
		/**定义bitmap的宽高，和需要静态Dis的左上角*/
		private var _drawRect : Rectangle = null;
		
		//private var _targetParent : DisplayObjectContainer = null;
		
		public function MirrorBitmapUtil(dis:DisplayObject, drawRect:Rectangle, transparent:Boolean=false, fillColor:uint=0, pixelSnapping:String="never", smoothing:Boolean=false)
		{
			_target = dis;
			//_targetParent = dis.parent;
			_drawRect = drawRect ? drawRect : new Rectangle(0, 0, dis.width, dis.height);
			_bitmapData = new BitmapData(drawRect.width, drawRect.height, transparent, fillColor);
			_bitmap = new Bitmap(_bitmapData, pixelSnapping, smoothing);
			update(0,0);
		}
		
		public function update(targetX:int, targetY:int, drawRect:Rectangle=null):void{
			if (drawRect) _drawRect = drawRect;
			var left : int = _drawRect.left - targetX;
			left = left > 0 ? left : 0;
			var top : int = _drawRect.top - targetY;
			top = top > 0 ? top : 0;
			top = top >= _drawRect.height ? _drawRect.height : top;
			
			//var left : int = 0, top : int = 0;
			//if (_drawRect.top - targetY >= 0 && _drawRect.top - targetY <= _drawRect.height - _drawRect.top) {
				//top = _drawRect.top - targetY ;
			//}else {
				//return;
			//}
			
			//top = top > _target.height - _drawRect.height
			//_drawRect.offset(left, top);
			_drawRect.setTo(left, top, _drawRect.width, _drawRect.height);
			_matrix.identity();
			//_boundsRect.setTo(
			_matrix.translate( -_drawRect.left, -_drawRect.top);
			//scale?
			_bitmapData.lock();
			_bitmapData.fillRect(_bitmapData.rect, 0);
			_bitmapData.draw(_target,_matrix);//, _target.transform.colorTransform); 
			
			_bitmapData.unlock();
		}
		
		public function moveto(tx:int, ty:int):void{
			this._bitmap.x = tx + _drawRect.x;
			this._bitmap.y = ty + _drawRect.y;
		}
		
		public function dispose(addTarget:Boolean = true):void {
			if (addTarget) {
				var parent : DisplayObjectContainer = _bitmap.parent, index : int = parent.getChildIndex(_bitmap);
				parent.addChildAt(target, index);
				_target.x = this._bitmap.x - _drawRect.x;
				_target.y = this._bitmap.y - _drawRect.y;
			}
			_bitmap.parent && _bitmap.parent.removeChild(_bitmap);
			_bitmapData.dispose();
			_bitmap.bitmapData = null;
			_bitmapData = null;
			_bitmap = null;
			_target = null;
			_drawRect = null;
			//_targetParent = null;
		}
		
		public function get bitmap():Bitmap
		{
			return _bitmap;
		}
		
		public function get target():DisplayObject{
			return _target;
		}
		
		public function get drawRect():Rectangle{
			return this._drawRect;
		}
		
	}
}