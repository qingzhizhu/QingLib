package test.starling.customDisplayobject 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class CustomDisObjTest extends Sprite 
	{
		
		public function CustomDisObjTest() 
		{
			var sprite : Sprite = new Sprite();
			var i :int = 0, len:int = 1;
			for (; i < len; i++) {
				var edge : int =  int(Math.random() * 20 + 3);
				var polygon : Polygon = new Polygon(30, edge, Math.random() * uint.MAX_VALUE);
				sprite.addChild(polygon);
				polygon.x = i % 5 * 60 + 60;
				polygon.y = int((i / 5)) * 60 + 60;
			}
			//sprite.flatten(); 报错
			addChild(sprite);
			
			var bottomColor:uint = 0x1c1191; // blue
			var topColor:uint    = 0xea0b0b; // red
			 
			var quad:Quad = new Quad(250, 150);
			quad.setVertexColor(0, topColor);
			quad.setVertexColor(1, topColor);
			quad.setVertexColor(2, bottomColor);
			quad.setVertexColor(3, bottomColor);
			quad.setVertexAlpha(3, 0.1);
			addChild(quad);
		}
		
	}

}