package com.qing.utils 
{
	import com.qing.event.BaseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class URLLoaderUtils extends EventDispatcher
	{
		/**发生任何错误都会派发*/
		public static const URLLOADERUTILS_ERROR : String = "URLLOADERUTILS_ERROR";
		
		public function URLLoaderUtils() 
		{
			
		}
		
		/**
		 * 
		 * 
		 * @param	url
		 * @param	onComp
		 * @param 可以添加一个数据
		 */
		public function load(url:String, onComp:Function, param:Object=null):void {
			var request : URLRequest = new URLRequest(url);
			var loader : URLLoaderWithParams = new URLLoaderWithParams(request);
			loader.param = param;
			loader.addEventListener(Event.COMPLETE, onComp, false, 10, false);	//优先处理, 不能使用弱引用
			//loader.addEventListener(Event.COMPLETE, onComp, false, 0, false);		//不能使用弱引用
			loader.addEventListener(Event.COMPLETE, onCompSelf, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			//loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onError, false, 0, true);	complete 之前也会派发此事件
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError, false, 0, true);
			
		}
		
		
		private function onCompSelf(e:Event):void {
			//Logger.debug("delete event listener");
			var loader : URLLoader = URLLoader(e.target);
			loader.removeEventListener(Event.COMPLETE, onCompSelf);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			//loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			loader = null;
		}
		
		public function onError(e:Event):void {
			this.onCompSelf(e);
			//派发错误事件， 不会删除onComp这个...
			dispatchEvent( new BaseEvent(URLLOADERUTILS_ERROR, e) );
		}
		
	}

}