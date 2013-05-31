package com.qing.net 
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	/**
	 * the net subject
	 * @author gengkun123@gmail.com
	 */
	public interface IServerConnection 
	{
		/**
		 * 访问服务端
		 * @param	serverCall 给服务端的参数
		 */
		function callService(serverCall : IServerCall):void;
		/**
		 * server返回的数据
		 * @param	e
		 */
		function resultHandler(e:*):void;
		/**
		 * 错误的回调函数
		 * @param	e
		 */
		function faultHandler(e:*):void;
		/**
		 * 返回调用callService的次数
		 * @return
		 */
		function getCallCount():int;
		
		/**
		 * 返回服务端返回数据的次数
		 * @return
		 */
		function getResponseCount():int;
		/**
		 * 是否存在连接错误
		 * @return
		 */
		function isConnectionError():Boolean;
		/**
		 * 返回网络错误对象
		 * @return
		 */
		function getErrorObject():INetErrorObject;
		/**
		 * 重置网络错误对象
		 */
		function resetErrorObject():void;
		/**
		 * 添加网络观察者
		 * <p>外部不需调用此方法</p>
		 * @param	serviceIdentifier
		 * @param	callback
		 */
		function addObserver(serviceIdentifier:String, callback:IServerDataListener):void;
		/**
		 * 广播给观察者，调用IServerDataListener.dataReceived
		 * @param	serviceId 服务端协议号
		 * @param	callId 这个是本类生成的字符串，类似 "call_1" 数字是getCallCount的值
		 * @param	responseCode 判断错误用的
		 * @param	responseData 服务端的数据
		 * @param	error 
		 * @param	maintenanceMode 暂时没用
		 */
		function notifyObserver(serviceId:String, callId:String, responseCode:int, responseData:Object, error:Object, maintenanceMode:Object = null):void;
		
	}
	
}