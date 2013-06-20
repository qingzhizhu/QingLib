package test.tool 
{
	import com.qing.utils.MirrorBitmapUtil;
	import com.qing.utils.singleton;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import net.richardlord.utils.FunctionUtils;
	
	/**
	 * 单利测试, 利用全局方法, singleton
	 * @author gengkun123@gmail.com
	 */
	public class SingletonTest extends Sprite 
	{
		
		public function SingletonTest() 
		{
			//第一次实例化，需要传入一些参数
			var mirror : MirrorBitmapUtil = singleton(MirrorBitmapUtil, this, new Rectangle(10, 4, 30,40));
			trace(mirror.drawRect);
			
			var m2 : MirrorBitmapUtil = singleton(MirrorBitmapUtil);
			trace(mirror.drawRect);		//the same instance.
			
			//FunctionUtils.adaptFunction
			test("aabb", 1, true);
		}
		
		public function test(a:String, b:int, c:Boolean):void {
			var t : * = arguments;
			trace(t.callee, t.length, t);
		}
		
	}

}