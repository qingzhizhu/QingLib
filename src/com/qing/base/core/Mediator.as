package com.qing.base.core
{
	import com.qing.base.face.IMediator;
	import com.qing.event.BaseEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * <p>
	 * Mediator 基类,根据需要重写onAddedToStage, onRemovedToStage, careOfEvents, handleCareOfEvents. </p>
	 * <li>重写 onRegistered, onRemoved 需调用父类方法</li>
	 * <li>getResurceByClassName 获取对应的资源 </li>
	 * <li> 通过 sendEvent(type:String, data:Object) 发送给Command 事件. </li>
	 * <li> removeAllChildren 可删除自身的组件 </li>
	 * <li>若重写initView方法时须先调用父类的initView方法; initView在实例化Mediator时调用</li>
	 * 
	 * @author	genekun123@gmail.com
	 */
	public class Mediator extends Notifier implements IMediator
	{
		protected var _viewUI:Sprite = null;
		
		protected var _name:String = "Mediator";
						
		/**
		 * construct
		 * @param viewUI{MovieClip} 要管理的视图
		 * 
		 */
		public function Mediator(viewUI:Sprite, name:String)		{
			this._name = name;
			this.viewUI = viewUI;
			
			//super(getResurceByClassName("loading") as MovieClip ,GlobalConst.MEDIATOR_LOADING);
			
			//this.sendEvent("",{});
		}
		
		/**
		 * 返回mediator的名称
		 */
		public function set name(value:String):void{
			_name = value;	
		}
		/**
		 * 设置mediator的名称
		 * @param value 名称 ,写在一个常量类中.
		 */
		public function get name():String{
			return _name;
		}
		
		/**
		 * 设置管理的UI
		 * 
		 */
		public function get viewUI():Sprite
		{
			return this._viewUI;
		}
		/**
		 * 获得管理的UI
		 * 
		 */
		public function set viewUI(value:Sprite):void{
			this._viewUI = value;
			this.initView();
		}
		
		/**
		 * 声音,bitmapdata,MC
		 * @param type 参照常量类 
		 */
		public function getResurceByClassName(cName:String, type:int=1):Object{ 
			return MVC.instance.getResourceByName(cName, type);
		}
		
		public function getMediator(name:String):IMediator{
			return MVC.instance.retrieveMediator(name) ;
		}
		/**
		 * 根据名称获得子ui ， 03-25
		 * @param name 子ui名称
		 * @param 子ui
		 
		public function getChildByName(name:String):InteractiveObject{
			if(this._viewUI[name]){
				return this._viewUI[name] as InteractiveObject;
			}
			return null;
		}*/
		
		/**
		 * 相对于父级居中
		 * 
		 */
		public function centerByParent():void
		{
			if(_viewUI && _viewUI.parent){
				if(_viewUI.parent.width > _viewUI.width && _viewUI.parent.height > _viewUI.height){
					_viewUI.x = Math.round( (_viewUI.parent.width - _viewUI.width) >>1 );
					_viewUI.y = Math.round( (_viewUI.parent.height - _viewUI.height) >>1 );
				}
			}
		}
		
		/**init方法,实例化视图后调用此方法*/
		protected function initView():void{
			if(this._viewUI){
				MVC.instance.registerMediator(this); //自动注册mediator
				
				this._viewUI.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
				this._viewUI.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
			}
		}
		
		/**
		 * 在添加到stage调用
		 */
		protected function onAddedToStage(e:Event):void
		{
			
		}
		/**
		 * 在从stage删除调用
		 */
		protected function onRemovedFromStage(e:Event):void
		{
			
		}
		
		/**
		 * 视图创建完成 添加相应的事件 , 修改为添加时再执行。 自动注册
		 * @param e{Event} 
		 
		protected function onViewComplete(e:Event):void{
			trace(this, "调用 onViewComplete");
		}*/
		
		/**
		 * 注册与后台交互关心的事件,子类重写
		 */
		public function careOfEvents():Array{
			
			return [];
		}
		/**
		 * 子类实现<br/>
		 * 注册关心的事件
		 */
		public function handleCareOfEvents(e:BaseEvent):void{
			
		}
		
		/**
		 * 子类实现<br/>
		 * 注册mediator时调用
		 */
		public function onRegistered():void{
			
		}
		/**
		 * 子类实现 需调用super.onRemoved()<br/>
		 * 注销mediator时调用,会将视图也销毁
		 */
		public function onRemoved():void{
			this._viewUI.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this._viewUI.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			if(this._viewUI.parent){
				this._viewUI.parent.removeChild(this._viewUI);
			}
			this.removeAllChildren();
		}
		
		/**
		 * 删除所有注册的事件,必须实现,清除数据
		 
		protected function deleteEventListener():void{
			throw new Error("子类实现此方法!");
		}*/
		
		/**删除视图**/
		public function removeAllChildren():void{
			this.clear(this._viewUI);
		}
	
		/**
		 * 循环调用删除子图
		 */
		protected function clear(sprite:DisplayObjectContainer):void{
			var num : uint = sprite.numChildren;
			var d : DisplayObject;
			for(var i:uint=0; i<num; i++){
				d = sprite.getChildAt(i);
				if(d && d is DisplayObjectContainer){
					this.clear(d as DisplayObjectContainer);
				}
				sprite.removeChild(d);
				//trace("fathor:"+sprite +" delete son:"+d);
				d = null;
				num--;i--;
			}
			sprite = null;
		}
	}
}