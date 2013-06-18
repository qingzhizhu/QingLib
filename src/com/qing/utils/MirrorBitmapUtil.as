package com.qing.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * <ul>
	 * <li>
	 * MirrorBitmapUtil.create(_sprite, null); 静态化一个对象.<br/> </li>
	 * <li>
	 * MirrorBitmapUtil.create(_sprite, new Rectangle(0, 10, 100, 100), true, MirrorBitmapUtil.HORIZONTAL, false, 0xFF);<br/>
	 * 可以做类似遮罩的位图，需要传入可画的区域，滚动时调用update,传入偏移量.<br/>
	 * bitmapdata.draw 的效率不高，根据实际情况使用滚动方法。
	 * </li>
	 * </ul>
	 * @author kevin geng
	 */
	public class MirrorBitmapUtil
	{
		public static const HORIZONTAL:int = 2;
		public static const VERTICAL:int = 1;
		
		
		public static function create(dis:DisplayObject, drawRect:Rectangle, autoAdd:Boolean=true, dir:int=MirrorBitmapUtil.VERTICAL, transparent:Boolean=false, fillColor:uint=0, pixelSnapping:String="never", smoothing:Boolean=false):MirrorBitmapUtil{
			var mirror : MirrorBitmapUtil = new MirrorBitmapUtil(dis, drawRect, dir, transparent, fillColor, pixelSnapping, smoothing);
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
		/**定义bitmap的宽高，和需要静态Dis的左上角,global 坐标*/
		private var _drawRect : Rectangle = null;
		/**滚动的方向*/
		private var _dir : int = 0;
		
		private var _max_wid : int = 0;
		private var _max_hei : int = 0;
		
		//private var _targetParent : DisplayObjectContainer = null;
		
		public function MirrorBitmapUtil(dis:DisplayObject, drawRect:Rectangle, dir:int=MirrorBitmapUtil.VERTICAL, transparent:Boolean=false, fillColor:uint=0, pixelSnapping:String="never", smoothing:Boolean=false)
		{
			_target = dis;
			//_targetParent = dis.parent;
			setDrawRect(drawRect);
			_dir = dir;
			_bitmapData = new BitmapData(_drawRect.width+1, _drawRect.height+1, transparent, fillColor);
			_bitmap = new Bitmap(_bitmapData, pixelSnapping, smoothing);
			dir == MirrorBitmapUtil.VERTICAL ? update(0, -1) : update(-1, 0);
		}
		/**
		 * 滚动
		 * @param	targetX 增量
		 * @param	targetY 增量
		 * @param	drawRect
		 */
		public function update(targetX:Number, targetY:Number, check:Boolean=false, drawRect:Rectangle = null):void {
			//_boundsRect = _target.getBounds(_target);
			//trace(_boundsRect, _drawRect);
			if (drawRect) setDrawRect(drawRect);
			var left : Number = _drawRect.left;
			var top : Number = _drawRect.top;
			if (_dir == MirrorBitmapUtil.VERTICAL) {
				top -= targetY;
				if(check){
					top = top > 0 ? top : 0;
					top = top > _max_hei ? _max_hei : top;
				}
			}else { //horizontal
				left -= targetX;
				if(check){
					left = left > 0 ? left : 0;
					left = left > _max_wid ? _max_wid : left;
				}
			}
			if (_drawRect.left == left && _drawRect.top == top) {
				return;
			}
			_drawRect.setTo(left, top, _drawRect.width, _drawRect.height);
			
			_matrix.identity();
			_matrix.scale(_target.scaleX, _target.scaleY);
			_matrix.translate( -_drawRect.left, -_drawRect.top);
			
			_bitmapData.lock();
			_bitmapData.fillRect(_bitmapData.rect, 0);
			_bitmapData.draw(_target,_matrix);//, _target.transform.colorTransform); 
			
			_bitmapData.unlock();
		}
		
		public function moveto(tx:int, ty:int):void{
			this._bitmap.x = tx;// + _drawRect.x;
			this._bitmap.y = ty;// + _drawRect.y;
		}
		
		public function dispose(addTarget:Boolean = true):void {
			if (addTarget) {
				var parent : DisplayObjectContainer = _bitmap.parent, index : int = parent.getChildIndex(_bitmap);
				parent.addChildAt(target, index);
				_target.x = this._bitmap.x;// - _drawRect.x;
				_target.y = this._bitmap.y;// - _drawRect.y;
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
		/**
		 * 
		 * @param	drawRect
		 */
		private function setDrawRect(drawRect:Rectangle):void {
			drawRect = drawRect ? drawRect : new Rectangle(0, 0, _target.width, _target.height);
			var wid : int = _target.width - drawRect.width;
			var hei : int = _target.height - drawRect.height;
			_max_wid = wid > 0 ? wid : 1;
			_max_hei = hei > 0 ? hei : 1;
			_drawRect = drawRect;
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
		
		public function get dir():int 
		{
			return _dir;
		}
		
	}
}