package com.qing.utils 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * 扩展URLLoader可以带数据
	 * @author gengkun123@gmail.com
	 */
	public class URLLoaderWithParams extends URLLoader 
	{
		public var param : Object = null;
		public function URLLoaderWithParams(request:URLRequest=null, param:Object=null) 
		{
			super(request);
			this.param = param;
		}
		
	}

}