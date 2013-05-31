package test 
{
	import com.qing.utils.Logger;
	import com.qing.utils.MySystem;
	import flash.display.Sprite;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class MySystemTest extends Sprite 
	{
		
		public function MySystemTest() 
		{
			addChild(new Stats());
			Logger.debug("this" , "is", "a test ");
			
		}
		
	}

}