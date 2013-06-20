package test.tool 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import net.richardlord.utils.WeakRef;
	/**
	 * 若引用
	 * @author gengkun123@gmail.com
	 */
	public class WeakRefTest extends Sprite
	{
		// Create a weak reference
		private var weak:WeakRef = null;
		public function WeakRefTest() 
		{
			
			//fun1();
			fun2();
		}
		
		
		
		private var _obj : Object = null;
		private function fun2():void {
			var obj : Object = { "name":"KKK" };
			weak = new WeakRef(obj);
			test();
			_obj = obj;
			setTimeout(
			function():void {
				test();
				obj = null; //closefun ref.
				_obj = null;
				setTimeout(test, 1000);
				trace("因为有全局的引用，所以当_obj=null;时才被GC");
			}
			, 2000);
		}
		
		
		//point 用完就被释放了
		private function fun1():void {
			var obj : Point = new Point(10, 1);
			weak = new WeakRef(obj);
			test();
			
			setTimeout(test, 2000);
		}
		
		private function test():void 
		{
			

			// Later use the referenced object
			var strong : * = weak.get();
			if( strong != null )
			{
				trace("// use strong here");
			}
			else
			{
				trace("// garbage collector has disposed of the object");
			}
			
			
		}
	}

}