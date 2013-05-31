package com.qing.net 
{
	import com.adobe.crypto.MD5;
	import com.qing.net.IServerDataListener;
	import com.qing.net.INetErrorObject;
	import com.qing.net.ServerCall;
	import com.qing.utils.Logger;
	import com.qing.utils.MySystem;
	import com.qing.utils.SimpleServer;
	import flash.system.Security;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import com.qing.net.IServerCall;
	import com.qing.net.IServerConnection;
	
	/**
	 * 用于和服务端交互的类
	 * @author gengkun123@gmail.com
	 */
	public class ServerConnection implements IServerConnection 
	{
		public static const RESPONSE_CODE_OK:int = 0;
		
		protected var _serverURL : String  = null;
		
		protected var _errorObject:INetErrorObject;
		
		protected var _counter:int;
		
		//private var _httpService:HTTPService;
		
		protected var _urlLoader : SimpleServer = null;

		protected var _observers:Object;

        /** How many responses have been got from the server */
        protected var _responseCount:int;
		
		public function ServerConnection(serverURl : String=null) 
		{
			_serverURL = serverURl;
			_observers = new Object();

			//Security.loadPolicyFile( Config.SERVER_URL + "crossdomain.xml");
			
			resetErrorObject();
		}
		
		/* INTERFACE com.kun.net.IServerConnection */
		/**
		 * 对应java的service服务。特殊需求子类覆盖
		 * @param	tempServerCall
		 */
		public function callService(tempServerCall:IServerCall):void 
		{
			var serverCall : ServerCall = tempServerCall as ServerCall;
			var callId:String = "call_" + _counter;
			_counter++;

			addObserver(serverCall.serviceId + ":" + callId, serverCall.observer);

			_urlLoader = new SimpleServer();
			
			//_urlLoader.send();
			_urlLoader.serverUrl = _serverURL;
			var params : Object = { };
			for (var p :String in serverCall) {
				params[p] = serverCall[p];
			}
			_urlLoader.send(params, resultHandler, faultHandler);
		}
		
		public function resultHandler(e:*):void 
		{
			var data : Object = e.target.data;
			//if (data.code != RESPONSE_CODE_OK) {
				//Logger.debug("服务器端 判断有误！！！", data.msg);
				//return;
			//}
			Logger.debug("server result:", data);
			var result : Object = null;
			try 
			{
				result = JSON.parse(data as String);
				
			}catch (err:Error)
			{
				Logger.debug("解析json出错！");
			}
			if (result) {
				notifyObserver(result.data.act, result.data.call_id, result.data.code, result.data, null);
				this._responseCount++;
			}
			
			
			
		}
		
		public function faultHandler(e:*):void 
		{
			Logger.debug("server error:",e);
		}
		
		public function getCallCount():int 
		{
			return _counter;
		}
		
		public function getResponseCount():int 
		{
			return _responseCount;
		}
		
		public function isConnectionError():Boolean 
		{
			return false;
		}
		
		public function getErrorObject():INetErrorObject 
		{
			return null;
		}
		
		public function resetErrorObject():void 
		{
			
		}
		
		public function addObserver(serviceIdentifier:String, callback:IServerDataListener):void 
		{
			_observers[serviceIdentifier] = callback;
            _responseCount++;
		}
		
		public function notifyObserver(serviceId:String, callId:String, responseCode:int, responseData:Object, error:Object, maintenanceMode:Object = null):void 
		{
			var serviceIdentifier:String = serviceId + ":" + callId;
			var observer:IServerDataListener = _observers[serviceIdentifier];

			_observers[serviceIdentifier] = null;
			delete _observers[serviceIdentifier] ;
			
			if (observer != null)
			{
				observer.dataReceived(responseCode, serviceId, responseData, error, maintenanceMode);
			}
			else /*if( Config.DEBUG_MODE )*/
			{
				Logger.debug("Received response without observer " + serviceIdentifier);
			}
		}
		
		
		private function createSignature(params:Object):String
		{
			var baseString:String = "";
			var keyArray:Array = new Array();

			for (var key:String in params) {
				keyArray.push({ "key": key, "value" : params[key] });
			}

			// Sort keys alphabetically
			keyArray.sortOn("key", Array.CASEINSENSITIVE);

			var i:int = 0;
			for each (var keyValuePair:Object in keyArray) {
				baseString = baseString + keyValuePair.key + "=" + keyValuePair.value;
				if (i < keyArray.length - 1) {
					baseString = baseString + "&";
				}
				i++;
			}

			// Add the session secret and application secret to the signature
			//baseString += this.token;
			baseString += "PreCr4c4";

//			if( Config.DEBUG_MODE )
//			{			
//				trace("BASE STRING: " + baseString);
//			}

			return MD5.hash(baseString);
		}
		
	}

}