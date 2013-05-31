package com.qing.utils 
{
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class NumberUtils 
	{
		/**
		 * 返回字符串包括的数字
		 * @param	str
		 * @return
		 */
		public static function getIntFromStr(str:String):int {
			var i:int = 0, len:int = str.length;
			var code : int = 0;
			var num : String = "";
			while (i < len) {
				code = str.charCodeAt(i);
				if (code >= 48 && code <= 57) {//0-9 ascii 
					num += str.charAt(i);
				}
				i++;
			}
			return int(num);
		}
		
		/**
		 * 将数字改为用逗号分隔的英美时间
		 * @param	num
		 */
		public static function numByUS(num:uint):String {
			var str :String = num.toString();
			if (str.length > 3) {
				var arr : Array = str.split("");
				var pos : int = 3;
				while (pos < arr.length) {
					arr.splice(arr.length-pos, 0, ",");
					pos += 4;
				}
				str = null;
				return arr.join("");
			}else {
				return str;
			}
		}
		
	}

}