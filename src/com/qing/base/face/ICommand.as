package com.qing.base.face
{
	/**
	 * ICommand 接口
	 * 
	 * @author	genekun123@gmail.com
	 */
	public interface ICommand
	{		
		/**
		 * execute 访问 ModelLocator 寻找数据,找到后直接派发事件给子视图;若没有数据,则向服务端请求数据.
		 * @param data{Object} 给方法的数据 
		 */
		function execute(data:Object) : void;
		
		/**
		 * 接到服务端数据到用此方法
		 * @param data{Object} 服务端返回的数据,分析数据更新ModelLocator,派发事件给自视图  
		 */
		function analyseData(data:Object):void;
	}
}