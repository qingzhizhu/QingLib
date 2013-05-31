package com.qing.utils 
{
	import flash.display.Loader;
	
	/**
	 * 扩展Loader可以带数据
	 * @author gengkun123@gmail.com
	 */
	public class LoaderWithPatams extends Loader 
	{
		public var param : Object = null;
		public function LoaderWithPatams(param:Object = null) 
		{
			super();
			this.param = param;
		}
		
	}

}