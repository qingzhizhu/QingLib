package com.qing.utils 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	/**
	 * 使用于简单的项目中
	 * @author gengkun123@gmail.com
	 */
	public class SimpleServer 
	{
		private var _serverUrl:String;
		
		private var _callBack : Function = null;
		
		private var _urlLoader : URLLoader = null;
		private var _urlRequest : URLRequest = null;
		
		public function SimpleServer() 
		{
			
			
		}
		
		public function send(params:Object, callBack:Function, onErrorHandler:Function=null):void {
			_callBack  = callBack;
			var request : URLRequest = new URLRequest(serverUrl);
			
			
			var urlVar : URLVariables = new URLVariables();
			for (var s : String in params) {
				if (typeof(params[s]) ==  "object") {
					urlVar[s] = JSON.stringify( params[s] );
				}else {
					urlVar[s] = params[s];
				}
			}
			request.data = urlVar;// { };//params;
			var urlLoader : URLLoader = new URLLoader();
			
			urlLoader.addEventListener(Event.COMPLETE, onComp);
			if (onErrorHandler != null) {
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			}
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			urlLoader.load(request);
			_urlLoader = urlLoader;
			_urlRequest = request;
			
			//trace(_urlRequest.url
		}
		
		private function onComp(e:Event):void 
		{
			//Logger.debug(e.target["data"]);
			_callBack.call(this, e);
			_callBack = null;
			
			this.destroy();
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			Logger.debug(e);
			
			this.destroy();
		}
		
		public function get serverUrl():String 
		{
			return _serverUrl;
		}
		
		public function set serverUrl(value:String):void 
		{
			_serverUrl = value;
		}
		
		private function destroy():void{
			this._callBack = null;
			this.serverUrl = null;
			this._urlRequest = null;
			this._urlLoader.removeEventListener(Event.COMPLETE, onComp);
			this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			this._urlLoader = null;
		}
		
	}

}