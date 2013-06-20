package test.tool 
{
	import com.qing.utils.DisplayObjectUtil;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.richardlord.collisions.HitTest;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class HitDemoTest extends Sprite
	{
		private var _shape : Shape = null;
		private var _shape2 : Shape = null;
		public function HitDemoTest() 
		{
			var shape : Shape = new Shape();
			DisplayObjectUtil.drawLayerByGraphics(shape.graphics, int(Math.random()*5+20), int(Math.random()*5+20));
			addChild(shape);
			shape.x = 100;
			shape.y = 150;
			_shape2 = shape;
			
			shape = new Shape();
			DisplayObjectUtil.drawLayerByGraphics(shape.graphics, 100, 100);
			addChild(shape); 
			_shape = shape;
			
			
			//addEventListener(Event.ENTER_FRAME, onLoop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onLoop);

		}
		
		private function onLoop(e:Event):void 
		{
			_shape.x = this.mouseX;
			_shape.y = this.mouseY;
			
			var b : Boolean = HitTest.hitTestRect(_shape.getRect(this), _shape2.getRect(this));
			if (b) {
				DisplayObjectUtil.drawLayerByGraphics(_shape.graphics, 100, 100, true, 0xFF);
			}else {
				DisplayObjectUtil.drawLayerByGraphics(_shape.graphics, 100, 100);
			}
			
			
			 
			trace("HitTest.hitTestObject 好像有问题！", _shape.hitTestObject(_shape2), HitTest.hitTestObject(_shape, _shape2));
		}
		
	}

}