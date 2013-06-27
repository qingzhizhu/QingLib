package test.as3 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import net.richardlord.utils.FunctionUtils;
	
	/**
	 * 测试arguments, 类。
	 * @author gengkun123@gmail.com
	 */
	public class FunctionTest extends Sprite 
	{
		
		
		private var count:int = 1;
        
        public function FunctionTest() {
			//trace("arguments ");
            //firstFunction(true);
			
			//try{
				//trace("aa", FunctionUtils)
				//trace(FunctionUtils.adaptFunction);
			//}catch (err:Error) {
				//trace(err);
			//}
			
			//没搞懂其意思。
			/*trace("functionUtils test");
			var fun : Function = FunctionUtils.adaptFunction(test, FunctionUtils.PARAM_1, FunctionUtils.PARAM_2);
			trace(fun);
			fun();
			
			var fun2 : Function = FunctionUtils.adaptFunction(test, FunctionUtils.PARAM_1, FunctionUtils.PARAM_2);
			trace(fun2);
			fun2();*/
			
			
			test.call(null, 100);
			
			var point : Point = new Point();
			test.call(point, 200);
			
			function testThis():void {
				trace("testThis:", this);
			};
			
			testThis(point);
			
        }

		
		
		private function test(a:int):void {
			trace("test fun:", arguments, arguments.length);
			trace("thisobject", this );
		}
		
		//---------------------------arguments---------
        public function firstFunction(callSecond:Boolean):void {
            trace(count + " : firstFunction");
            if(callSecond) {
                secondFunction(arguments.callee);
            }
            else {
                trace("CALLS STOPPED");
            }
        }

        public function secondFunction(caller:Function):void {
            trace(count + " : secondFunction\n", "caller, is firtfun?", caller==firstFunction, "callee: is secondFun?", arguments.callee == secondFunction );
            count++;
            caller(false);
        }        

	}

}