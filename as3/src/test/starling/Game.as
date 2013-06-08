package test.starling 
{
	import starling.utils.AssetManager;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			
		}
		
		public function start(bgTexture:Texture, assets:AssetManager):void 
		{
			trace("start!");
		}
		
	}

}