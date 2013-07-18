package com.qing.utils
{
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	
	/**
	 * 未捕获异常 <br/>
	 * uncaughtError(loaderInfo, url, {"userId":getUserId()});
	 * @author Kevin Geng
	 * 2013-7-15 下午3:42:40
	 */
	public function uncaughtError(loaderInfo:LoaderInfo, url:String, params:Object=null):void{
		var urlVariables : URLVariables = new URLVariables();
		if(params){
			for(var p : String in params){
				urlVariables[p] = params[p];
			}
			p = null;
			params = null;
		}
		var request : URLRequest = new URLRequest(url);
		request.method = "GET";
		
		var loader : URLLoader = new URLLoader(request);
//		loader.addEventListener(Event.COMPLETE, function(e:*):void{ trace("uncaught comp", e) } );
		loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, function(event:UncaughtErrorEvent):void {
			var message:String;			
			if (event.error is Error)
			{
				message = Error(event.error).getStackTrace(); //air nothing？
				if(message == null || message == ""){
					message = Error(event.error).message;
				}
			}
			else if (event.error is ErrorEvent)
			{
				message = ErrorEvent(event.error).text;
			}
			else
			{
				message = event.error.toString();
			}			
			
			urlVariables["msg"] = "Uncaught Error: " + message;
			request.data = urlVariables;
			loader.load(request);
			
			trace(urlVariables["msg"]);
		}
		);
		url = null;
		loaderInfo = null;
	}
	
	
	

	
	
	
}