package com.qing.utils 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class StringUtils 
	{
		/**
		 * 获取字符长度, 主要用于汉字, 汉字的 str.charCodeAt(i)>255;
		 * @param	str
		 * @param	charSet utf-8, gb2312 ....
		 * @return
		 */
		public static function charLen(str:String, charSet:String="utf-8"):int {
			if (!str || str == "") return 0;
			var byte : ByteArray = new ByteArray();
			byte.writeMultiByte(str, charSet);
			return byte.length;
		}
		
	}

}