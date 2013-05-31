package com.qing.net
{	
	/**
	 * ServerCall 基本参数
	 * @author gengkun123@gmail.com
	 */
	public class ServerCall implements IServerCall 
	{
		/**
		 * 
		 */
		public var serviceId:String;
		public var parameters:Object;
		public var observer:IServerDataListener;
		public var isBlocking:Boolean;
		
		public function ServerCall(serviceId:String, parameters:Object, observer:IServerDataListener,isBlocking:Boolean=false) 
		{
			this.serviceId = serviceId;
			this.parameters = parameters;
			this.observer = observer;
			this.isBlocking = isBlocking;
		}
		
	}

}