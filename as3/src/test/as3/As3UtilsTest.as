package test.as3 
{
	import com.qing.utils.ArrayUtil;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class As3UtilsTest extends Sprite 
	{
		
		public function As3UtilsTest() 
		{
			
			//test_every();
			//test_forEach();
			//
			//Array_some();
			//
			//return;
			
			var arr : Array = [];
			arr[5] = 1;
			arr[10] = 2;
			arr[30] = 4;
			
			trace(ArrayUtil.getNearbyValue(1, arr));
			trace(ArrayUtil.getNearbyValue(5, arr));
			trace(ArrayUtil.getNearbyValue(20, arr));
			trace(ArrayUtil.getNearbyValue(30, arr));
			trace(ArrayUtil.getNearbyValue(100, arr));
			
			//trace(arr.length);
			
			trace(arr.indexOf(4));
		}
		
		public function test_every():void {
            var arr1:Array = new Array(1, 2, 4);
            var res1:Boolean = arr1.every(isNumeric);
            trace("isNumeric:", res1); // true
 
            var arr2:Array = new Array(1, 2, "ham");
            var res2:Boolean = arr2.every(isNumeric);
            trace("isNumeric:", res2); // false
        }
        private function isNumeric(element:*, index:int, arr:Array):Boolean {
            return (element is Number);
        }
		
		public function test_forEach():void {
            var employees:Array = new Array();
            employees.push({name:"Employee 1", manager:false});
            employees.push({name:"Employee 2", manager:true});
            employees.push({name:"Employee 3", manager:false});
            trace(employees);
            employees.forEach(traceEmployee);
        }
        private function traceEmployee(element:*, index:int, arr:Array):void {
            trace(element.name + " (" + element.manager + ")");
			return;
        }
		
		public function Array_some():void {
            var arr:Array = new Array();
            arr[0] = "one";
            arr[1] = "two";
            arr[3] = "four";
			//arr.sort(Array.NUMERIC);
            var isUndef:Boolean = arr.some(isUndefined);
            if (isUndef) {
                trace("array contains undefined values: " + arr);
            } else {
                trace("array contains no undefined values.");
            }
        }
        private function isUndefined(element:*, index:int, arr:Array):Boolean {
            return (element == undefined);
        }
		
	}

}