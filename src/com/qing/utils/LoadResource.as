package com.qing.utils
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * 加载资源工具类
	 * <ul>
	 * <li>统一静态读资源的方法 loadByType.通过地址、加载完成的回调函数和方式加载文件。方式参照常量 LoadResource.TYPE_~ </li>
	 * <li>get maxFileNum.返回当前 最大的文件数</li>
	 * <li>get curFileNum.返回当前 已读的文件数</li>
	 * <li>set onProgress.设置文件的加载事件</li>
	 * 例子：
	 * private function test():void{
			var arr : Array = [
				["assets/helpone.swf", onComplete, 1], 
				["assets/helpTwo.swf", onComplete, 1], 
				["assets/avater_woman.xml", onComplete, 2],
				["assets/helpThree.swf", onComplete, 1],
			];
			LoadResource.onProgress = onProgress;
			for each(var obj:Object in arr){
				LoadResource.loadByType( obj[0], obj[1]as Function, obj[2]);
			}
		}
		private function onComplete(e:Event):void{
			trace("complete "+e.target);
			
			trace(LoadResource.curFileNum, LoadResource.maxFileNum);
		}
		
		private function onProgress(e:ProgressEvent):void{
			trace("ProgressEvent ", e.bytesLoaded, e.bytesTotal);
		}
	 * 
	 * @author	gengkun123@gmail.com
	 */
	public class LoadResource
	{
		/**版本号*/
		public static var version : String = "1.0";
		/**通过Loader方式加载*/
		public static const TYPE_LOADER : int = 1;
		/**通过URLLoader方式加载*/
		public static const TYPE_URLLOADER : int = 2;
		/**通过URLStream方式加载*/
		public static const TYPE_URLSTREAM : int = 3;
		/**加载到当前域*/
		public static var loaderContext : LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
		
		private static var _loadArr : Array = [];
		/**最大加载数*/
		private static var _maxNum : uint = 0;
		/**当前加载数*/
		private static var _curNum : uint = 0;
		/**状态 0未使用；1正在读；2读完某个文件*/
		private static var _status : uint = 0;
		
		private static var _loadObj : Object = null;
		
		private static var _urlLoader : URLLoader = null;
		
		private static var _urlStream : URLStream = null;
		
		private static var _loader : Loader = null;
		
		private static var _request : URLRequest = new URLRequest();
		
		private static var _onProgress : Function = onProgressTemp;
		
		private static var _onLoadFileName:Function = null;
		
		
		
		
		public function LoadResource()
		{
		}
		
		/**
		 * 通过type方式加载文本文件
		 * @param url 文件地址
		 * @param handler 完成事件的回调函数
		 * @param param 参数
		 * @param type 加载方式 参照常量 TYPE_~
		 * @param desc 加载描述
		 */
		public static function loadByType(url:String, handler:Function=null,desc:String="", param:*=null, type:int=LoadResource.TYPE_LOADER):void{
			/*if(handler==null){
				trace("url ", url, "回调函数为空!");
				return;
			}*/
			_maxNum++;
			_loadArr.push({"url":url, "fun":handler, "type":type,"desc":desc, "param":param});
			if(_status!=1){
				load();
			}
		}
		
		/**
		 * 返回当前 最大的文件数
		 */
		public static function get maxFileNum():int{
			return _maxNum;
		}
		
		/**
		 * 返回当前 加载的文件数
		 */
		public static function get curFileNum():int{
			return _curNum;
		}
		/**
		 * 设置监听加载进度函数
		 */
		public static function set onProgress(handler:Function):void{
			_onProgress = handler;
		}
		
		public static function set loadFileName(handler:Function):void{
			_onLoadFileName = handler;
		}
		
		/**
		 * 加载文件
		 */
		private static function load():void{
			if(_status!=1 && _loadArr.length>0){
				_status = 1;				
				_curNum ++;
				_loadObj = _loadArr.shift();
				var type : int = int(_loadObj["type"]);
				var target : EventDispatcher = null;
				if(_onLoadFileName!=null){
					_onLoadFileName.call(null,_loadObj["desc"]);
				}
				switch(type){
					case TYPE_LOADER:
						if(_loader == null){
							_loader = new LoaderWithPatams(_loadObj["param"]);
							_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgress);
							_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFileError);
						}
						target = _loader;						
						
					break;
					
					case TYPE_URLLOADER:
						if(_urlLoader == null){
							_urlLoader = new URLLoaderWithParams(null, _loadObj["param"]);
							_urlLoader.addEventListener(ProgressEvent.PROGRESS, _onProgress);
							_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onFileError);
							_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
						}
						target = _urlLoader;
					break;
					
					case TYPE_URLSTREAM:
						if(_urlStream == null){
							_urlStream = new URLStream();
							_urlStream.addEventListener(ProgressEvent.PROGRESS, _onProgress);
							_urlStream.addEventListener(IOErrorEvent.IO_ERROR, onFileError);
							_urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
						}
						target = _urlStream;
					break;
					
					default:
						Logger.debug("加载类型出错！参考 TYPE_~常量 ", type, "url ",_loadObj["url"]);
					break;
					
				}
				if(target){
					_request.url = _loadObj["url"] + "?ver=" + version;
					target["param"] = _loadObj["param"];
					var fun : Function = _loadObj["fun"];
					if(type == TYPE_LOADER){
						if(fun != null){
							_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fun);
						}
						_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
						_loader.load(_request, loaderContext);// new LoaderContext(false, ApplicationDomain.currentDomain));
						return;
					}else{
						if(fun != null){
							target.addEventListener(Event.COMPLETE, fun);
						}
						target.addEventListener(Event.COMPLETE, onComplete);						
					}
					var callTemp : Function = target["load"];
					callTemp.call(target, _request);
				}
			}
		}
		
		private static function onComplete(e:Event):void{
			var fun : Function = _loadObj["fun"];
			e.target.removeEventListener(Event.COMPLETE, onComplete); 
			if(fun!=null){
				e.target.removeEventListener(Event.COMPLETE, fun);
			}
			if (e.target is LoaderInfo) {	//gc
				Loader(e.target.loader).unloadAndStop();
			}
			_status = 2;
			load();
			//remove event
		}
		/**
		 * 进度数据
		 * 
		 */
		private static function onProgressTemp(e:ProgressEvent):void{
			Logger.debug(_loadObj["url"], e.bytesLoaded, e.bytesTotal);
		}
		
		private static function onFileError(e:IOErrorEvent):void{
			Logger.debug("加载资源出错!", e);
		}
		
		private static function onSecurityError(e:SecurityErrorEvent):void{
			Logger.debug("安全错误!", e);
		}
		
	}
}