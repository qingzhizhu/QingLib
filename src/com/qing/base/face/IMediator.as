package com.qing.base.face
{
	import com.qing.event.BaseEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * <p> 管理UI接口 </p>
	 * 
	 * <li> 提供 mediator名称 </li>
	 * <li> 管理 UI 是 MovieClip类型</li>
	 * <li> 返回 UI 关心的事件,当他被注册时,会自动添加关心的事件,回调函数是handleCareOfEvents </li>
	 * <li> onRegistered 注册Mediator时的操作 </li>
	 * <li> onRemoved 删除Mediator的操作 </li>
	 * 
	 * @author gengkun123@gmail.com
	 */
	public interface IMediator
	{
		/**
		 * 返回mediator的名称
		 */
		function get name ():String;
		/**
		 * 设置mediator的名称
		 * @param value 名称 ,写在一个常量类中.
		 */
		function set name (value:String):void;
		/**
		 * 获得管理的UI
		 * 
		 */
		function get viewUI():Sprite; // ui基类
		/**
		 * 设置管理的UI
		 * 
		 */
		function set viewUI(value:Sprite):void;
		/**
		 * 返回关心的事件
		 * @return {Array}
		 */
		function careOfEvents():Array;
		
		/**
		 * 关心事件的回调函数
		 * @param e 
		 * @see com.qing.event.BaseEvent
		 */
		function handleCareOfEvents(e:BaseEvent):void;
		/**
		 * 注册此mediator时的操作
		 * 
		 */
		function onRegistered():void;
		/**
		 * 删除此mediator时的操作
		 * 
		 */
		function onRemoved():void;
		
	
	}
}