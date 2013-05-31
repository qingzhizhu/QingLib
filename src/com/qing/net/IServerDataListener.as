package com.qing.net 
{
	/**
	 * the net Observer 
	 * @author gengkun123@gmail.com
	 */
	public interface IServerDataListener 
	{
		/**
		 * 接收到server数据并执行相应的逻辑
		 * @param	responseCode 判断是否存在错误
		 * @param	serviceId 
		 * @param	data
		 * @param	error
		 * @param	maintenanceMode 暂时用不到
		 */
		function dataReceived(responseCode:int, serviceId:String, data:Object, error:Object, maintenanceMode:Object = null):void;
		
	}

}