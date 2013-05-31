package com.qing.event
{
	import flash.events.Event;
	/**
	 * event 基类包含一个data变量来承载数据
	 * 
	 * @author	genekun123@gmail.com
	 */
	public class BaseEvent extends Event
	{
		public var data : Object;
		/**
		 * Construct
		 * @param type{String} Event 类型
		 * @param data{Object} 数据 默认null [可选]
		 * @param bubbles{Boolean} 是否冒泡 默认false [可选]
		 * @param cancelable{Boolean} 是否可撤销Event对象 默认false [可选]
		 * 
		 */
		public function BaseEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}