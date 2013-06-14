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
			init();
			
			setTimeout(test, 2000);
		}
		
		private function test():void
		{
			_mirror = MirrorBitmapUtil.create(_sprite, new Rectangle(0, 0, _sprite.width, 400), true, false, 0xFF);
			_target = _mirror.bitmap;
			trace("mirror dis");
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
				g.drawRect(0, i * gap, wid, gap);
				g.endFill();
				txt = new TextField();
				txt.text = i + "";
				txt.y = i * gap;
				txt.height = 30;
				_sprite.addChild(txt);
			}
			g.lineStyle(0, 0);
			g.drawRect(0, 0, wid, hei);
			addChild(_sprite);
			_sprite.x = (500 - wid) >> 1;
			_sprite.y = 50;
			_target = _sprite;
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWhell);
			trace(_sprite.width, _sprite.height);
		}
		
		private function onWhell(e:MouseEvent):void
		{
			var num : int = e.delta > 0 ? 20 : -20;
			_sprite.y += num;
			//num += _target.y;
			if (_mirror) {
				_mirror.update(x, num);
			}
			//else {
				
			//}
		}
	
	}

}