package test.as3 
{
	import com.qing.utils.FunctionUtils;
	import com.qing.utils.ObjectUtil;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class FunctionCallTest extends Sprite 
	{
		
		public function FunctionCallTest() {
			
			// ...(rest) parameter 测试， 若想将...(rest) 二次传输，需要新定义一个方法，在掉那个方法的.apply传过去。
			//test(1, 2, 3);
			//test.apply(this, [1, 2, 3]);
			//testTwo.apply(this, ["kevin", 1, 2, 3]);
			//callTestTwo("kevin8", 1, 2, 3);
			//return;
			
			callTest(1, 2, 3);
			//output
			//1,2,3 object Array 1
			//1,2,3 object Array 3
			FunctionUtils.sendParams(test, 1, 2, 3);
			
			FunctionUtils.sendParams(testTwo, "kevin", 1, 2, 3);
			
			//----------------  ...(rest) parameter 测试 end -------------------------
			
			return;
			var test1=new TestA();
			var test2=new TestB();
			//不管传入对象X的function的call的参数指向任何对象，
			//function中的this永远都指向原对象X。
			//test1.callA.call(this);
			
			//如果给callB传入的参数是一个对象X中已定义的方法，
			//那么这个方法中的this永远都指向此对象X。
			//test2.callB(test1.callA);
			
			//当给CallB传入的参数是一个不知所属的function的时候，
			//此时这个function中的this才会由call中指向的对象来确定。
			test2.callB(function(){trace(this, "aa")});
		}
		
		public function callTest(...params):void {
			this.test(params);
			//this.test.call(null, params);
			test.apply(null, params);
		}
		
		public function callTestTwo(...params):void {
			//this.testTwo(params);
			//this.test.call(null, params);
			testTwo.apply(null, params);
		}
		
		
		public function test(...params):void {
			trace(params, typeof(params), ObjectUtil.getObjType(params), params.length );
		}
		
		public function testTwo(name:String, ...params):void {
			trace("name", name, params, typeof(params), ObjectUtil.getObjType(params), params.length );
		}
		
	}
	

}



internal class TestA {
public function callA() {
trace(this);
}
}
internal class TestB {
public function callB(fn:Function) {
fn.call(this);
fn.call(TestA);
}
}