package com.qing.utils 
{
	/**
	 * 数组的帮助类
	 * @author gengkun123@gmail.com
	 */
	public class ArrayUtil 
	{
		
		/**
		 * src是否包含value, src，value均可以是Vector
		 * 1
		 * var arr:Array = [20, 21, 22, 39, 40, 41];
			var src:Array = [1, 20, 90];
			trace ( ArrayUtil.isContainValue(src, arr) );//true
		 * 2
		 * var arr:Array = [21, 22, 39, 40, 41];
			var src : Vector.<int> = new <int>[1,20,90, 100, 200, 300, 400, 500, 600];
			trace ( ArrayUtil.isContainValue(src, arr) );	// false
		 * 3
		 * var vo : MapVO = new MapVO();
			vo.name = "arr con";
			var arr:Array = [20, 21, 22, 39, 40, 41, vo];
			var src:Array = [1,90, vo];
			trace ( ArrayUtil.isContainValue(src, arr) );	//true
		 * 4
		 * var arr : Vector.<int> = new <int>[20, 21, 22, 39, 40, 41];
			var src : Vector.<int> = new <int>[1,20,90, 100, 200, 300, 400, 500, 600];
			trace ( ArrayUtil.isContainValue(src, arr) );	//true
		 * 
			
		 * @param	src Array | Vector 
		 * @param	value is also can a Array | Vector...
		 * @return
		 */
		public static function isContainValue(src:*, value:*):Boolean {
			if(src && src.length && value){
				if (ObjectUtil.getObjType(value) == ObjectUtil.TYPE_ARRAY) {
					var temp : * = null;
					if (value.length > src.length) {	//value is less
						temp = src;
						src = value;
						value = temp;
						temp = null;
					}
					for each(temp in value) {
						if (src.indexOf(temp) > -1) {
							return true;
						}
					}
				}else {
					return ( src.indexOf(value) != -1);
				}
			}
			return false;
		}
		/**
		 * delete many item from the src. 
		 * 
		 * 1 和isContainValue 的例子一样
		 * var arr : Vector.<int> = new <int>[20, 300];
			var src : Vector.<int> = new <int>[1,20,90, 100, 200, 300, 400, 500, 600];
			ArrayUtil.removeValue(src, arr);
			trace(src); //1,90,100,200,400,500,600
		 * 
		 * 
		 * 
		 * @param	src Array | Vector
		 * @param	value Object | Array | Vector
		 */
		public static function removeValue(src:*, value:*):void {
			if(src && src.length && value){
				var index : int = 0;
				if (ObjectUtil.getObjType(value) == ObjectUtil.TYPE_ARRAY) {
					for each(var temp:* in value) {
						index = src.indexOf(temp);
						if (index > -1) {
							src.splice(index, 1);
						}
					}
				}else {
					index = src.indexOf(value);
					if (index > -1) {
						src.splice(index, 1);
					}
				}
			}
			
		}
		
	}

}