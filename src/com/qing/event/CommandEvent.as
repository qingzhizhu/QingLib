package com.qing.event
{
	/**
	 * CommandEvent,此事件包括具体command 名称.
	 * 子视图派发此事件给Command,开启冒泡
	 * 
	 * @author	genekun123@gmail.com 
	 */
	public class CommandEvent extends BaseEvent
	{
		/**要执行的command名称*/
		public var commandName :String;
		/**
		 * construct
		 * @param type{String} Event 类型	参考 EventCommandConst.E_CMD_~
		 * @param commandName{String} command 名称,参考 EventCommandConst.CMD_~
		 * @param data{Object} 给command数据 默认null [可选]
		 */
		public function CommandEvent(type:String, commandName:String, data:Object=null)
		{
			super(type,data,true);
			this.commandName = commandName;
		}
	}
}