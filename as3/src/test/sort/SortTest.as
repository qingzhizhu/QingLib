package test.sort 
{
	import com.qing.utils.Logger;
	import com.qing.utils.SortUtils;
	import flash.display.Sprite;
	import flash.geom.Point;
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
			
			var asc : Boolean = false;
			
			//----------------------------------------------
			if(asc){
			arr = radomArr();
			funStart();
			arr.sort();
			funEnd("sortAdobe 官方sort 不加参数 排序：");
			}
			//trace(arr);
			//----------------------------------------------
			
			//----------------------------------------------
			arr = radomArr();
			funStart();
			SortUtils.adobeSort(arr, asc);
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
			if(asc){
			arr = radomArr();
			funStart();
			SortUtils.getQuickSortArr(arr);
			funEnd("快速排序：");
			}
			//----------------------------------------------
			//trace(arr);
			
			//----------------------------------------------
			arr = radomArr();
			funStart();
			SortUtils.sort(arr, asc);
			funEnd("flash punk sort 快速排序：");
			//----------------------------------------------
			
			
			///---------------sortby-----------------------
			asc = true;
			arr = radomPoint();
			funStart();
			arr.sortOn("x");// , asc ? Array.NUMERIC : Array.DESCENDING);
			funEnd("sortAdobe 官方sorton 排序：");
			//trace(arr);
			
			arr = radomPoint();
			funStart();
			SortUtils.sortBy(arr, "x", asc);
			funEnd("flash punk sortby 快速排序：");
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
		
		private function radomPoint(len:int=100000):Array 
		{
			var /*len : int = 100000, */i:int = 0;
			var arr:Array = [];
			for(i=0;i<len;i++){
				arr.push(new Point(int(Math.random()*len), int(Math.random()*len)));
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