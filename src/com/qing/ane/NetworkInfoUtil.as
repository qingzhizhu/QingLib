package com.qing.ane 
{
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	/**
	 * only in air
	 * @author gengkun123@gmail.com
	 */
	

	public class NetworkInfoUtil 
	{
		
		public function NetworkInfoUtil() 
		{
			
		}
		
		/**
		 * 获得mac地址，但有可能为null
		 * @return
		 */
		public static function getMac():String {
			if(NetworkInfo.isSupported){
				var arr : Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
				for each (var item:NetworkInterface in arr) 
				{
					if (item.hardwareAddress != "") {
						return item.hardwareAddress;
					}
				}
			}
			return null;
		}
		
	}

}