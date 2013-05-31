package com.qing.base.face
{
	/**
	 * <p> 封装 MVC 接口 </p> 
	 * 
	 * 
	 * @author gengkun123@gmail.com
	 */
	public interface IMVC
	{
		//------------------------------ model ------------------------//
		
		function getResourceByName(name:String, type:int=1):Object;
		
		
		//------------------------------ controler ------------------------//
		/**
		 * 注册cmd
		 * @param type 与cmd对应的协议类型
		 * @param cmdRef ICommand 的 
		 * @param funType 执行服务端或客户端的cmd， 1 为客户端， 2 为服务端
		 */
		function registerCommand(type:String, cmdRef:Class, funType:int=1):void;
		
		/**
		 * 添加事件
		 * @param type 与cmd对应的协议类型
		 * @param handler 回调函数
		 * 
		 */
		function addEvent(type:String, handler:Function):void;
		
		/**
		 * 是否添加事件
		 * @param type 与cmd对应的协议类型
		 * @return 
		 * 
		 */
		function hasEvent(type:String):Boolean;
		
		/**
		 * 删除事件
		 * @param typer 与cmd对应的协议类型
		 * @param handler 
		 * 
		 */
		function removeEvent(type:String, handler:Function):void;
		
		//------------------------------ view ------------------------//
		
		/**
		 * 注册cmd
		 * @param type 与cmd对应的协议类型
		 * @param cmdRef ICommand 的 
		 * @param funType 执行服务端或客户端的cmd， 1 为客户端， 2 为服务端
		 */
		function registerMediator(mediator:IMediator):void;
		/**
		 * 返回对应name 的Mediator
		 * @param mediatorName mediat名称
		 * @return IMediator
		 */
		function retrieveMediator(mediatorName:String):IMediator;
		
		/**
		 * 删除 mediator
		 * @param type 与cmd对应的协议类型
		 * @param handler 回调函数
		 * 
		 */
		function removeMediator(mediatorName:String):IMediator;
		
		/**
		 * 是否添加事件
		 * @param type 与cmd对应的协议类型
		 * @return 
		 * 
		 */
		function hasMediator(mediatorName:String):Boolean;
		
		
		
		
		
	}
}