package com.qing.base.core
{
	import com.qing.base.face.ICommand;
	import com.qing.base.face.IMVC;
	import com.qing.base.face.IMediator;
	import com.qing.event.BaseEvent;
	import com.qing.utils.Logger;
	import flash.display.Sprite;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * <p> MVC 基类,采用单例模式. 应该继承此类,提供相应的数据. </p>
	 * <li> instance 获取MVC实例 </li>
	 * <li> initialize 实例化调用,继承时需调用父类的.<li>
	 * 
	 * 
	 * @author gengkun123@gmail.com
	 */
	public class MVC implements IMVC
	{
		public static const AUTHOR_MAIL : String ="gengkun123@gmail.com|gengkun123@hotmail.com";
//		public static const AUTHOR_QQ : String = "516108241";
		
		public static const CMD_FUN_CLIENT : int = 1;
		public static const CMD_FUN_SERVER : int = 2;
		
		//public var app : DisplayObject = null;
		public var app : Sprite = null;
		protected static var _instance : MVC = null;
		protected var _commandDic : Object = null;
		protected var _mediatorDic : Object = null;
		/** 不再使用app派发事件，12.05.02修改*/
		protected var _dispatcher : EventDispatcher = null;
		
		public function MVC()
		{
			if(_instance != null){
				throw Error("MVC 单例!!!");
				return;
			}
			_instance = this;
			initialize();
			
			
		}
		
		public static function get instance():MVC{
			if(_instance == null){
				_instance = new MVC();
			}
			return _instance;
		}
		
		
		public function get dispatcher():IEventDispatcher{
			/*if(app){
				return app as EventDispatcher;
			}
			return null;*/
			return this._dispatcher;
		}

		
		protected function initialize():void{
			_commandDic = {};
			_mediatorDic = { };
			if (!_dispatcher) _dispatcher = new EventDispatcher();
		}
		
		
		/**
		 * 子类实现
		 * @param name 资源的类名
		 * @param type 具体的
		 */
		public function getResourceByName(name:String, type:int=1):Object{
			
			return null;
		}
		
		
		/**
		 * 注册cmd, 只允许注册一遍
		 * @param type 与cmd对应的协议类型
		 * @param cmdRef ICommand 的 
		 * @param funType 执行服务端或客户端的cmd， 1 为客户端， 2 为服务端
		 */
		public function registerCommand(type:String, cmdRef:Class, funType:int=1):void{
			if(_commandDic[type]==null){
				_commandDic[type] = cmdRef;
				
			}else{
				Logger.debug("registerCommand error , ", type, "is registered.");
				return;
			}
			switch(funType){
				case CMD_FUN_CLIENT:
					dispatcher.addEventListener(type, excuteClientCommand);
					break;
				case CMD_FUN_SERVER:
					dispatcher.addEventListener(type, excuteServerCommand);
					break;
				default:
					Logger.debug("registerCommand funType error ", funType);
					break;
			}
		}
		
		/**
		 * 添加事件
		 * @param type 与cmd对应的协议类型
		 * @param handler 回调函数
		 * 
		 */
		public function addEvent(type:String, handler:Function):void{
			dispatcher.addEventListener(type, handler);
		}
		
		/**
		 * 是否添加事件
		 * @param type 与cmd对应的协议类型
		 * @return 
		 * 
		 */
		public function hasEvent(type:String):Boolean{
			return dispatcher.hasEventListener(type);
		}
		
		/**
		 * 删除事件
		 * @param typer 与cmd对应的协议类型
		 * @param handler 
		 * 
		 */
		public function removeEvent(type:String, handler:Function):void{
			dispatcher.removeEventListener(type, handler);
		}
		
		/**
		 * 注册mediator,
		 * @param mediator  
		 * 
		 */
		public function registerMediator(mediator:IMediator):void
		{
			if(hasMediator(mediator.name)){
				Logger.debug(mediator.name, "was resgistered.");
				return;
			}
			_mediatorDic[mediator.name] = mediator;
			for each(var eType : String in mediator.careOfEvents()){
				addEvent(eType, mediator.handleCareOfEvents);
			}
			mediator.onRegistered();
		}
		/**
		 * 返回对应name 的Mediator
		 * @param mediatorName mediat名称
		 * @return IMediator
		 */
		public function retrieveMediator(mediatorName:String):IMediator{
			return _mediatorDic[mediatorName] as IMediator;
		}
		/**
		 * 根据名称删除并返回对应的mediator，会调用mediator.onRemoved方法
		 * 
		 */
		public function removeMediator(mediatorName:String):IMediator
		{
			var mediator : IMediator = null;
			if(hasMediator(mediatorName)){
				mediator = _mediatorDic[mediatorName]as IMediator;
				delete _mediatorDic[mediatorName];
				for each(var eType : String in mediator.careOfEvents()){
					removeEvent(eType, mediator.handleCareOfEvents);
				}
				mediator.onRemoved();
			}
			return mediator;
		}
		/**
		 * 是否已注册 mediator
		 * 
		 */
		public function hasMediator(mediatorName:String):Boolean
		{
			return _mediatorDic[mediatorName]!=null;
		}
		
		/**
		 * 服务断返回数据，调用 cmd.analyseData() 方法
		 * 
		 */
		protected function excuteServerCommand(e:BaseEvent):void{
			var C : Class = _commandDic[e.type] as Class;
			var cmd : ICommand = new C() as ICommand;
			cmd.analyseData(e.data);
		}
		
		/**
		 * 客户端请求数据，调用 cmd.excute() 方法
		 * 
		 */
		protected function excuteClientCommand(e:BaseEvent):void{
			var C : Class = _commandDic[e.type] as Class;
			var cmd : ICommand = new C() as ICommand;
			cmd.execute(e.data);
		}
	}
}