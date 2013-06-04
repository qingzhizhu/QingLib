package test.starling.touch 
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class MultitouchTest extends Sprite 
	{
		
		public function MultitouchTest() 
		{
			//multitouch
			Starling.current.simulateMultitouch = true;
			
			var texture : Texture = Texture.fromBitmap(new Assets.BIRD());
			var img : Image = new Image(texture);
			
			var touchSheet : TouchSheet = new TouchSheet(img);
			addChild(touchSheet);
			touchSheet.x = 200;
			touchSheet.y = 100;
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			
		}
		
	}

}