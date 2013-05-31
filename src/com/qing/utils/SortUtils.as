package com.qing.utils 
{
	/**
	 * 几个排序算法，主要用于数值排序.<br/>
	 * 1万条数据：<br/>
	 * [Logger-trace] sortAdobe 官方sort 排序：,4
[Logger-trace] 冒泡排序 ：,7570
[Logger-trace] 鸡尾酒-定向冒泡排序：,5820
[Logger-trace] 插入排序：,2752
[Logger-trace] 快速排序：,20

	 * @author gengkun123@gmail.com
	 */
	public class SortUtils 
	{
		
		/**
		 * 原始的排序
		 * @param	arr
		 * @param	asc 升序
		 */
		public static function adobeSort(arr:Array, asc:Boolean=true):Array {
			return asc ? arr.sort(Array.NUMERIC) : arr.sort(Array.DESCENDING);
		}
		
		/**         
        冒泡排序         
           1. 首先将所有待排序的数字放入工作列表中。 
           2. 从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换。 
           3. 重复2号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换。 
        冒泡排序的平均时间复杂度与插入排序相同，也是平方级的，但也是非常容易实现的算法 		
		*/
		public static function bubbleSort(arr:Array, asc:Boolean=true):Array {
            //var arr2:Array = arr.concat();
            var i:int = 1;  
            var j:int = 0;  
            var n:int = arr.length;
			var temp : * = null;
			var change : Boolean = false;
            for(i=1;i<n;i++) {
                for (j = 0; j < n - i; j++) {
					change = asc ? (arr[j] > arr[j + 1]) : (arr[j + 1] > arr[j]);
                    if(change) {
                        temp = arr[j];
                        arr[j] = arr[j+1];
                        arr[j+1] = temp;
                    }
                }
            }
            return arr;  
        }
		
		
		/**         
        一般来说，插入排序都采用in-place在数组上实现。具体算法描述如下： 
       1. 从第一个元素开始，该元素可以认为已经被排序 
       2. 取出下一个元素，在已经排序的元素序列中从后向前扫描 
       3. 如果该元素（已排序）大于新元素，将该元素移到下一位置 
       4. 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置 
       5. 将新元素插入到该位置中 
       6. 重复步骤2 
*/  
        public static function getInsertionSortArr(arr:Array):Array { 
            var i:int = 1;  
            var n:int = arr.length;  
              
            for(i=1;i<n;i++) {  
                var temp:Number = arr[i];  
                var j:int = i - 1;  
                  
                while((j>=0) && (arr[j] > temp)) {  
					arr[j+1] = arr[j];          
					j--;  
				}  
				   
				arr[j+1] = temp;  
            }
            return arr;  
        }
		
		/**         
快速排序使用分治法（Divide and conquer）策略来把一个序列（list）分为两个子序列（sub-lists）。 
   1. 从数列中挑出一个元素，称为 "基准"（pivot）， 
   2. 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分割之后，该基准是它的最后位置。这个称为分割（partition）操作。 
   3. 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。 
 
递回的最底部情形，是数列的大小是零或一，也就是永远都已经被排序好了。虽然一直递回下去，但是这个演算法总会结束，因为在每次的迭代（iteration）中，它至少会把一个元素摆到它最后的位置去。 
*/  
          
        public static function getQuickSortArr(arr:Array):Array {  
            var n:int = arr.length;  
            quickSort(arr,0,n-1);  
            return arr;  
        }  
          
        private static function quickSort(arr:Array,low:int,high:int):void {  
            var i:int;  
            var j:int;  
            var x:int;  
              
            if (low < high) { //这个条件用来结束递归  
                  
                i = low;  
                j = high;  
                x = arr[i];  
              
                while (i < j) {  
                    while (i < j && arr[j] > x) {  
                       j--; //从右向左找第一个小于x的数  
                    }  
                    if (i < j) {  
                       arr[i] = arr[j];  
                       i++;  
                    }  
                  
                    while (i < j && arr[i] < x) {  
                       i++; //从左向右找第一个大于x的数  
                    }  
                  
                    if (i < j) {  
                       arr[j] = arr[i];  
                       j--;  
                    }  
                 }  
  
                arr[i] = x;  
                quickSort(arr, low, i - 1);  
                quickSort(arr, i + 1, high);  
            }  
        }
		
		
		
		/* 
    选择排序是这样实现的： 
        1.首先在未排序序列中找到最小元素，存放到排序序列的起始位置 
        2.然后，再从剩余未排序元素中继续寻找最小元素，然后放到排序序列末尾。 
        3.以此类推，直到所有元素均排序完毕。 
*/  
        public static function getSelectionSort(arr:Array):Array { 
            var i:int = 0;  
            var j:int = 0;  
            var n:int = arr.length;  
              
            for (i = 0; i < n - 1; i++) {  
                var min:int = i;  
                for (j = i+1; j < n; j++) {  
                    if (arr[j] < arr[min]) {  
                        min = j;  
                    }  
                }  
                /* swap data[i] and data[min] */  
                var temp:Number = arr[i];  
                arr[i] = arr[min];  
                arr[min] = temp;  
            } 
            return arr;  
        }  
		
		/**         
        鸡尾酒排序，也就是定向冒泡排序, 鸡尾酒搅拌排序, 搅拌排序 (也可以视作选择排序的一种变形), 涟漪排序, 来回排序 or 快乐小时排序,  
        是冒泡排序的一种变形。此算法与冒泡排序的不同处在于排序时是以双向在序列中进行排序。 
*/          
        public static function getCocktailSortArr(arr:Array):Array { 
            var i:int = 0;  
            var n:int = arr.length;  
            var top:int = n - 1;  
            var bottom:int = 0;  
            var swapped:Boolean = true;   
              
            while(swapped) { // if no elements have been swapped, then the list is sorted  
                swapped = false;   
                var temp:Number;  
                for(i = bottom; i < top;i++) {  
                    if(arr[i] > arr[i + 1]) {  // test whether the two elements are in the correct order  
                        temp = arr[i];// let the two elements change places  
                        arr[i] = arr[i + 1];  
                        arr[i + 1] = temp;  
                        swapped = true;  
                    }  
                }  
                // decreases top the because the element with the largest value in the unsorted  
                // part of the list is now on the position top   
                top = top - 1;   
                for(i = top; i > bottom;i--) {  
                    if(arr[i] < arr[i - 1]) {  
                        temp = arr[i];  
                        arr[i] = arr[i - 1];  
                        arr[i - 1] = temp;  
                        swapped = true;  
                    }  
                }  
                // increases bottom because the element with the smallest value in the unsorted   
                // part of the list is now on the position bottom   
                bottom = bottom + 1;    
            }
            return arr;  
        } 
		
		
	}

}