package test.tool 
{
	import com.qing.utils.ObjectPool;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class ObjectPoolTest extends Sprite
	{
		
		public function ObjectPoolTest() 
		{
			ObjectPool.initialize(Sprite, 5);
			var t : * = ObjectPool.getObject(Sprite);
			trace(t);
			ObjectPool.disposeObject(t);
			
			var mc : MovieClip = ObjectPool.getObject(MovieClip);
			trace(mc);
			ObjectPool.disposeObject(mc, MovieClip);
			
			ObjectPool.initialize(Test, 3, 100);
			//id 不能重置
			var t2 : Test = ObjectPool.getObject(Test, 300);
			trace(t2.id);
			ObjectPool.disposeObject(t2, Test);
		}
		
	}

}

class Test {
	public var id:int = 0;
	public function Test(id:int):void {
		this.id = id;
	}
}