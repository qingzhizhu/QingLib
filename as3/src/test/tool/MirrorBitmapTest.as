package test.tool
{
	import com.qing.utils.MirrorBitmapUtil;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	/**
	 * 测试mirrorbitmap。
	 * @author gengkun123@gmail.com
	 */
	[SWF(width="500",height="800")]
	
	public class MirrorBitmapTest extends Sprite
	{
		private var _sprite:Sprite = null;
		private var _target:DisplayObject = null;
		
		private var _mirror : MirrorBitmapUtil = null;
		
		public function MirrorBitmapTest()
		{
			//画一个长方形代表很长的底图
			
			
			//纵向的
			//init();
			//横向的
			init2();
			
		}
		
		private function test():void
		{
			//_mirror = MirrorBitmapUtil.create(_sprite, new Rectangle(0, 0, _sprite.width, 400), true, false, 0xFF);
			_mirror = MirrorBitmapUtil.create(_sprite, new Rectangle(15, 0, 50, 100), true, MirrorBitmapUtil.VERTICAL, false, 0xFF);
			_target = _mirror.bitmap;
			trace("mirror dis");
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWhell);
		}
		
		private function init():void
		{
			_sprite = new Sprite();
			var gap:int = 50;
			var wid:int = 200;
			var len:int = 15;
			var hei:int = gap * len;
			var g:Graphics = _sprite.graphics;
			var txt : TextField = null;
			for (var i:int = 0; i < len; i++)
			{
				//g.moveTo(0, i * gap);
				g.beginFill(uint(Math.random() * uint.MAX_VALUE));
				g.drawRect(10, i * gap, wid, gap);
				g.endFill();
				txt = new TextField();
				txt.text = i + "";
				txt.x = 30;
				txt.y = i * gap;
				txt.height = 30;
				_sprite.addChild(txt);
			}
			g.lineStyle(0, 0);
			g.drawRect(0, 0, wid, hei);
			addChild(_sprite);
			_sprite.x = (500 - wid) >> 1;
			_sprite.y = 80;
			_target = _sprite;
			trace(_sprite.width, _sprite.height);
			_sprite.scaleY = .5;
			setTimeout(test, 2000);
			//setTimeout(function():void {
				//_mirror.dispose(true);
			//}, 4000);
		}
		
		
		private function test2():void
		{
			//_mirror = MirrorBitmapUtil.create(_sprite, new Rectangle(0, 0, _sprite.width, 400), true, false, 0xFF);
			_mirror = MirrorBitmapUtil.create(_sprite, new Rectangle(0, 10, 100, 100), true, MirrorBitmapUtil.HORIZONTAL, false, 0xFF);
			//_mirror = MirrorBitmapUtil.create(_sprite, null);
			_target = _mirror.bitmap;
			trace("mirror dis");
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWhell2);
		}
		
		private function init2():void
		{
			_sprite = new Sprite();
			var gap:int = 50;
			var hei:int = 200;
			var len:int = 15;
			var wid:int = gap * len;
			var g:Graphics = _sprite.graphics;
			var txt : TextField = null;
			for (var i:int = 0; i < len; i++)
			{
				//g.moveTo(0, i * gap);
				g.beginFill(uint(Math.random() * uint.MAX_VALUE));
				g.drawRect(i * gap, 0, gap, hei);
				g.endFill();
				txt = new TextField();
				txt.text = i + "";
				txt.y = 30;
				txt.x = i * gap;
				txt.width = txt.height = 30;
				_sprite.addChild(txt);
			}
			g.lineStyle(0, 0);
			g.drawRect(0, 0, wid, hei);
			addChild(_sprite);
			_sprite.x = 50;// (500 - wid) >> 1;
			_sprite.y = 80;
			_target = _sprite;
			trace(_sprite.width, _sprite.height);
			_sprite.scaleX = .5;
			setTimeout(test2, 2000);
			//setTimeout(function():void {
				//_mirror.dispose(true);
			//}, 4000);
		}
		
		
		private function onWhell(e:MouseEvent):void
		{
			var num : int = e.delta > 0 ? 20 : -20;
			_sprite.y += num;
			//num += _target.y;
			if (_mirror) {
				_mirror.update(0, num, true);
			}
			//else {
				
			//}
		}
		
		private function onWhell2(e:MouseEvent):void
		{
			var num : int = e.delta > 0 ? 20 : -20;
			_sprite.y += num;
			//num += _target.y;
			if (_mirror) {
				_mirror.update(num, 0, true);
			}
			//else {
				
			//}
		}
	
	}

}