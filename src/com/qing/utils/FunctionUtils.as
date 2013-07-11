package com.qing.utils 
{
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class FunctionUtils 
	{
		/**
		 * 将...(rest) 二次传输
		 * @param	caller 类似 function testTwo(name, ...params):void;
		 * @param	...params
		 */
		public static function sendParams(caller:Function, ...params):* {
			if (caller != null) {
				return caller.apply(null, params);
			}
		}
		
	}

}