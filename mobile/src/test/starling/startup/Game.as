package test.starling.startup 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			var quad:Quad = new Quad(200, 200, Color.RED);
            quad.x = 100;
            quad.y = 50;
            addChild(quad);
		}
		
	}

}