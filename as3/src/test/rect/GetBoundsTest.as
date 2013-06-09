package test.rect 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class GetBoundsTest extends Sprite 
	{
		
		public function GetBoundsTest() 
		{
			var container:Sprite = new Sprite();
			 container.x = 100;
			 container.y = 100;
			 this.addChild(container);
			 var contents:Shape = new Shape();
			 contents.graphics.drawCircle(0,0,100);
			 container.addChild(contents);
			 trace(contents.getBounds(container));
			  // (x=-100, y=-100, w=200, h=200)
			 trace(contents.getBounds(this));
			  // (x=0, y=0, w=200, h=200)
			  
			 trace(container.getBounds(contents));
			 //(x=-100, y=-100, w=200, h=200)

		}
		
	}

}