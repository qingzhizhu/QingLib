package com.qing.base.core
{
	import com.qing.base.face.INotifier;
	import com.qing.event.BaseEvent;
	/**
	 * <p> Notifier 发送事件. </p>
	 * 
	 * @author gengkun123@gmail.com
	 */
	public class Notifier implements INotifier
	{
		public function Notifier()
		{
		}
		
		public function sendEvent(type:String, data:Object=null):void
		{
			MVC.instance.dispatcher.dispatchEvent(new BaseEvent(type, data));
		}
	}
}