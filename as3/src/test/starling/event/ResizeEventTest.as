package test.starling.event 
{
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	
	/**
	 * 屏幕尺寸改变
	 * @author gengkun123@gmail.com
	 */
	public class ResizeEventTest extends Sprite 
	{
		private var _quad : Quad = null;
		
		
		public function ResizeEventTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			_quad = new Quad(100, 200, 0xFFFF);
			_quad.x = (stage.stageWidth - _quad.width) >> 1;
			_quad.y = (stage.stageHeight - _quad.height) >> 1;
			addChild(_quad);
			stage.addEventListener(ResizeEvent.RESIZE, onResize);
		}
		private var rect : Rectangle = new Rectangle();
		private function onResize(event:ResizeEvent):void 
		{
			// set rect dimmensions 
			rect.width = event.width, rect.height = event.height; 
			// resize the viewport 
			Starling.current.viewPort = rect; 
			// assign the new stage width and height 
			stage.stageWidth = event.width; 
			stage.stageHeight = event.height; 
			trace(rect);
			// repositions our quad 
			_quad.x = (stage.stageWidth - _quad.width) >> 1; 
			_quad.y = (stage.stageHeight - _quad.height) >> 1; 
		}
		
	}

}