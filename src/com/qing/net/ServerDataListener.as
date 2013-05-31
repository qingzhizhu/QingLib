package com.qing.net 
{
	import com.qing.base.core.MVC;
	import com.qing.event.BaseEvent;
	import com.qing.utils.Logger;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class ServerDataListener implements IServerDataListener 
	{
		/**获得服务端数据， 派发事件的前缀会加入 serviceID*/
		public static const E_SERVER_RESPOSE : String = "E_SERVER_RESPOSE_";
		
		public function ServerDataListener() 
		{
			
		}
		
		/* INTERFACE com.kun.net.IServerDataListener */
		
		public function dataReceived(responseCode:int, serviceId:String, data:Object, error:Object, maintenanceMode:Object = null):void 
		{
			Logger.debug("data received from servier:", responseCode, serviceId, data, error);
			//派发给cmd
			MVC.instance.dispatcher.dispatchEvent(new BaseEvent(E_SERVER_RESPOSE + serviceId, data));
		}
		
	}

}