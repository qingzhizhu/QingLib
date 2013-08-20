package com.qing.utils 
{
	/**
	 * 日期时间 
	 * @author gengkun123@gmail.com
	 */
	public class DateUtils 
	{
		/**
		 * 格式化秒成分钟，自动补全0, 90 -> 01:30
		 * @param	value 秒，最大别超过100min
		 * @return
		 */
		public static function secondsToMins(value:int):String {
			var min : int = value / 60;
			var sec : int = value % 60;
			return String( ((min < 10) ? ("0" + min) : min) + ":" +((sec < 10) ? ("0" + sec) : sec) );
		}
		
		public static function getDateStr():String {
			var date : Date = new Date();
			return (date.monthUTC + 1) + "-" + date.dateUTC + " " + date.hoursUTC + ":" + date.minutesUTC;
		}
		
	}

}