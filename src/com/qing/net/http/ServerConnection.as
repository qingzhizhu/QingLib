package com.qing.net.http 
{
//	import com.adobe.crypto.MD5;
	import com.qing.net.IServerDataListener;
	import com.qing.net.INetErrorObject;
	import com.qing.net.ServerCall;
	import com.qing.utils.Logger;
	import com.qing.utils.MySystem;
	import flash.system.Security;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import com.qing.net.IServerCall;
	import com.qing.net.IServerConnection;
	import mx.rpc.http.HTTPService;
	
	/**
	 * 用于和服务端交互的类
	 * @author gengkun123@gmail.com
	 */
	public class ServerConnection /*implements IServerConnection */
	{
		public static const RESPONSE_CODE_OK:int = 0;
		
		protected var _serverURL : String  = null;
		
		protected var _errorObject:INetErrorObject;
		
		protected var _counter:int;
		
		protected var _httpService:HTTPService;

		protected var _observers:Object;

        /** How many responses have been got from the server */
        protected var _responseCount:int;
		
		//public function ServerConnection(serverURl : String=null) 
		//{
			//_serverURL = serverURl;
			//observers = new Object();
//
			//Security.loadPolicyFile( Config.SERVER_URL + "crossdomain.xml");
			//
			//resetErrorObject();
		//}
		//
		///* INTERFACE com.kun.net.IServerConnection */
		///**
		 //* 对应java的service服务。特殊需求子类覆盖
		 //* @param	tempServerCall
		 //*/
		//public function callService(tempServerCall:IServerCall):void 
		//{
			//var serverCall : ServerCall = tempServerCall as ServerCall;
			//var callId:String = "call_" + counter;
			//_counter++;
//
			//addObserver(serverCall.serviceId + ":" + callId, serverCall.observer);
//
			//_httpService = new HTTPService( _serverURL );
			//_httpService.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
//			httpService.xmlDecode = xmlDecoder;
//
            //_httpService.url = _serverURL;
            //if (_httpService.url.charAt(_httpService.url.length - 1) != '/') {
                //_httpService.url += "/";
            //}
            //_httpService.url += serverCall.serviceId;
            //_httpService.url += "?time="+(mDate.getTime() + MySystem.currentTimeMillis());
//
			//_httpService.request = serverCall.parameters;
			//_httpService.request.call_id = callId;
			///*if (userId != null)
			//{
				//_httpService.request.uid = userId;
			//}*/
						//
			//_httpService.request.time = mDate.getTime() + MySystem.currentTimeMillis();
			//_httpService.request.sig = createSignature(_httpService.request);
//
			//_httpService.addEventListener(ResultEvent.RESULT, resultHandler);
			//_httpService.addEventListener(FaultEvent.FAULT, faultHandler);
//
			// TODO: Add some timeout value?
			//_httpService.requestTimeout = 10;
			//
			//_httpService.send();
		//}
		//
		//public function resultHandler(e:*):void 
		//{
			//Logger.debug("server result:", e, e.result);
		//}
		//
		//public function faultHandler(e:*):void 
		//{
			//Logger.debug("server error:", e, e.fault);
		//}
		//
		//public function getCallCount():int 
		//{
			//return _counter;
		//}
		//
		//public function getResponseCount():int 
		//{
			//return _responseCount;
		//}
		//
		//public function isConnectionError():Boolean 
		//{
			//
		//}
		//
		//public function getErrorObject():INetErrorObject 
		//{
			//
		//}
		//
		//public function resetErrorObject():void 
		//{
			//
		//}
		//
		//public function addObserver(serviceIdentifier:String, callback:IServerDataListener):void 
		//{
			//_observers[serviceIdentifier] = callback;
            //_responseCount++;
		//}
		//
		//public function notifyObserver(serviceId:String, callId:String, responseCode:int, responseData:Object, error:Object, maintenanceMode:Object = null):void 
		//{
			//var serviceIdentifier:String = serviceId + ":" + callId;
			//var observer:IServerDataListener = _observers[serviceIdentifier];
//
			//_observers[serviceIdentifier] = null;
			//delete _observers[serviceIdentifier] ;
			//
			//if (observer != null)
			//{
				//observer.dataReceived(responseCode, serviceId, response, error, maintenanceMode);
			//}
			//else /*if( Config.DEBUG_MODE )*/
			//{
				//Logger.debug("Received response without observer " + serviceIdentifier);
			//}
		//}
		//
		//
		//protected function createSignature(params:Object):String
		//{
			//var baseString:String = "";
			//var keyArray:Array = new Array();
//
			//for (var key:String in params) {
				//keyArray.push({ "key": key, "value" : params[key] });
			//}
//
			// Sort keys alphabetically
			//keyArray.sortOn("key", Array.CASEINSENSITIVE);
//
			//var i:int = 0;
			//for each (var keyValuePair:Object in keyArray) {
				//baseString = baseString + keyValuePair.key + "=" + keyValuePair.value;
				//if (i < keyArray.length - 1) {
					//baseString = baseString + "&";
				//}
				//i++;
			//}
//
			// Add the session secret and application secret to the signature
			//baseString += this.token;
			//baseString += "PreCr4c4";
//
//			if( Config.DEBUG_MODE )
//			{			
//				trace("BASE STRING: " + baseString);
//			}
//
			//return MD5.hash(baseString);
		//}
		
	}

}