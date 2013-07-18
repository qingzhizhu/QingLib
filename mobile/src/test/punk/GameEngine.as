package test.punk 
{
	import com.saia.starlingPunk.SP;
	import com.saia.starlingPunk.SPEngine;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class GameEngine extends SPEngine
	{
		
		public function GameEngine() 
		{
			super();
			SP.world = new MyWord();
		}
		
		//-------------------
		//  event handlers
		//-------------------
		
		override public function init():void 
		{
			super.init();
			//SP.world = LevelController.getCurrentLevel();
			trace("FlashPunk has started successfully!");
		}
		
	}

}