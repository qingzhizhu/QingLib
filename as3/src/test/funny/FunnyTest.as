package test.funny 
{
	import com.qing.utils.Logger;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class FunnyTest extends Sprite 
	{
		
		public function FunnyTest() 
		{
				Logger.debug( func(9999) );
		}
		/**
		 * 1.求下面函数的返回值（微软） 
		 * 假定x = 9999. 答案：8
		 * 思路：将x转化为2进制，看含有的1的个数。
		 * @param	x
		 * @return
		 */
		private function func(x:int):int
		{
			var countx : int = 0;
			while(x)
			{
				trace("",x.toString(2) ,"\n", (x-1).toString(2),"\n-------",x);
				  countx ++;
				  x = x & (x - 1);
				  
			 }
			return countx;
		}
		
	}

}