package com.qing.base.core
{
	import com.qing.base.face.ICommand;
	import com.qing.base.face.IMediator;
	
	import flash.utils.ByteArray;

	/**
	 * command 基类
	 * 直接继承此类,写自己的函数,方法参数是一个Object(必须),将方法名称映射到EventCommandConst.E_CMD_~ 中保存
	 * 服务端调用的方法是以加后缀命名的command.后缀默认是 Rep ,例:
	 * 
	 * <pre>
	 * 
	 * </pre>
	 * @author	genekun123@gmail.com
	 */
	public class Command extends Notifier implements ICommand
	{
		/**后缀,得到数据后向执行analyseData方法,添加到funStr 后面.默认值 Rep
		protected const REP_POSTFIX : String = "Rep";*/
		/**
		 * execute 访问 ModelLocator 寻找数据,找到后直接派发事件给子视图;若没有数据,则向服务端请求数据.
		 * 如果需要传递更多的参数,须重写excute方法.
		 * @param data{Object} 给方法的数据 
		 */
		public function execute(/*funStr:String,*/ data:Object) : void{
			/*var f : Function = this.getFunction(funStr);
			if(f!=null){
				f.call(null,data);
			}*/
		}
		
		/**
		 * 接到服务端数据到用此方法,子类去实现具体方法
		 * @param byteArr{ByteArray} 服务端(socket)返回的数据,分析数据更新ModelLocator,派发事件给自视图  
		 */
		public function analyseData( data:Object):void{
		}
		/**
		 * 根据funStr 找到具体的方法
		 * <pre>
		 * 可以跟据自己的需求格式化funStr. 例:以 "on"开头加type首字母大写的格式;
		 * 函数名必须对应funStr的格式,否则执行失败;
		 * 可以重写getFunction 函数以改变funStr的格式形式和函数的命名规则;
		 * </pre>
		 * @param funStr{String} 方法名称,大小写敏感
		 * @return {Function} 返回以type格式对应的函数
		 
		protected function getFunction(funStr:String):Function{
			var f : Function;
			try{				
				f = this[funStr];
			}catch(e:Error){
				trace("找不到"+ funStr +"对应的方法!\n"+e.message);
				return null;
			}
			return f;
		}*/
		
		/**
		 * 获得mediator
		 * @param	name
		 * @return
		 */
		public function getMediator(name:String):IMediator{
			return MVC.instance.retrieveMediator(name) ;
		}
	}
}