package test.starling.third 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.Gauge;
	import starling.textures.Texture;
	
	/**
	 * 进度条，主要设置scaleX，在更新纹理坐标。<br/>
	 * 其实不用更新纹理的坐标，只用scaleX就可以
	 * @author gengkun123@gmail.com
	 */
	public class GaugeTest extends Sprite 
	{
		private var _gauge : Gauge = null;
		public function GaugeTest() 
		{
			var shape : Shape = new Shape();
			shape.graphics.beginFill(0xFF, 0.5);
			shape.graphics.drawRect(0, 0, 200, 30);
			shape.graphics.endFill();
			var btd : BitmapData = new BitmapData(shape.width, shape.height);
			
			btd.draw(shape);
			//var texture : Texture = Texture.fromColor(200, 30, 0xFFFF);
			var texture : Texture = Texture.fromBitmapData(btd);
			
			var gauge:Gauge = new Gauge(texture);
			gauge.ratio = 0;
			addChild(gauge);
			
			_gauge = gauge;
			
			gauge.x = 100;
			gauge.y = 200;
			
			addEventListener(Event.ENTER_FRAME, onLoop);
		}
		
		private function onLoop(e:Event):void 
		{
			_gauge.ratio += 0.01;
		}
		
	}

}