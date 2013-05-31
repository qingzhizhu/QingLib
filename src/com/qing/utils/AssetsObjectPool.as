package com.qing.utils
{
	import com.qing.base.core.MVC;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * 对象池
	 * @author gengkun123@gmail.com
	 */
	public class AssetsObjectPool 
	{
		/***/
		protected static var poolDic : Dictionary = new Dictionary(false);
		
		/**
		 * 初始化要注册的对象
		 * @param	...args
		 */
		public static function initialize(...args):void {
			
		}
		
		public static function getObject(clsName:String):Object {
			var arr : Array = null;
			if (poolDic[clsName]) {
				arr = poolDic[clsName];
				if (arr.length) {
					return arr.shift();
				}else {
					Logger.debug("ths pool less obj.");
					return initObjByClsName(clsName);
				}
			}
			Logger.debug(clsName, " not in the pool, add the obj to pool.");
			//实例化对象  	len?
			arr = [ initObjByClsName(clsName) ];
			poolDic[clsName] = arr;
			return getObject(clsName);
			
		}
		/**
		 * 将对象在放回到pool
		 * @param	obj
		 */
		public static function disposeObject(obj:Object):void {
			var clsName : String = getObjectClsName(obj);
			if (poolDic[clsName]) {
				poolDic[clsName].push(obj);
				Logger.debug(clsName, "in the pool length:", poolDic[clsName].length);
			}else {
				Logger.debug(clsName, " not is in the pool!");
			}
		}
		
		public static function addPoolSize(clsName:String, addLen:int):void {
			
		}
		
		/**
		 * 返回 obj 的类名
		 * @param	obj
		 * @return
		 */
		public static function getObjectClsName(obj:Object):String {
			var clsName : String = getQualifiedClassName(obj);
			if (1) {	//or 0
				trace(clsName);
			}
			return clsName;
		}
		/**
		 * 根据类名实力化一个对象
		 * @param	clsName
		 */
		public static function initObjByClsName(clsName:String):Object {
			//return getDefinitionByName(clsName);
			return MVC.instance.getResourceByName(clsName);
		}
		
	}

}