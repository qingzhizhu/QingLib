package test.sort 
{
	import com.qing.utils.Logger;
	import com.qing.utils.SortUtils;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	/**
	 * 算法比较
	 * @author gengkun123@gmail.com
	 */
	public class SortTest extends Sprite 
	{
		private var _arr : Array = null;
		public function SortTest() 
		{
			var arr : Array = null;
			
			//----------------------------------------------
			arr = radomArr();
			funStart();
			SortUtils.adobeSort(arr);
			funEnd("sortAdobe 官方sort 排序：");
			//trace(arr);
			//----------------------------------------------
			
			//----------------------------------------------
			/*arr = radomArr();
			funStart();
			SortUtils.bubbleSort(arr);
			funEnd("冒泡排序 ：");*/
			//----------------------------------------------
			
			//----------------------------------------------
			/*arr = radomArr();
			funStart();
			SortUtils.getCocktailSortArr(arr);
			funEnd("鸡尾酒-定向冒泡排序：");*/
			//----------------------------------------------
			
			//----------------------------------------------
			/*arr = radomArr();
			funStart();
			SortUtils.getInsertionSortArr(arr);
			funEnd("插入排序：");*/
			//----------------------------------------------
			
			
			
			//----------------------------------------------
			arr = radomArr();
			funStart();
			SortUtils.getQuickSortArr(arr);
			funEnd("快速排序：");
			//----------------------------------------------
			//trace(arr);
		}
		
		private function radomArr():Array 
		{
			var len : int = 100000, i:int = 0;
			var arr:Array = [];
			for(i=0;i<len;i++){
				arr.push(int(Math.random()*len));
			}
			return arr;
			//_arr = arr;
		}
		
		/*private function sortAdobe(arr:Array):void {
			arr.sort(Array.NUMERIC);
		}*/
		
		private var t:int;  
        private function funStart():void {  
            t = getTimer();  
        }  
          
        private function funEnd(str:String=""):void {  
			Logger.debug(str, getTimer() - t);
        }  
		
	}

}