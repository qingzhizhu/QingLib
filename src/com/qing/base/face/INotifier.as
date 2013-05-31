package com.qing.base.face
{
	/**
	 * <p> INotifier 接口 ， 发送事件 </p>
	 * 
	 * @author gengkun123@gmail.com
	 */
	public interface INotifier
	{
		
		function sendEvent(type:String, data:Object=null):void;
	}
}