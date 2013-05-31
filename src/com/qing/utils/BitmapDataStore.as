package com.qing.utils 
{
	import com.qing.base.core.MVC;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	/**
	 * 用于存储实力过的 bitmap data
	 * @author gengkun123@gmail.com
	 */
	public class BitmapDataStore 
	{
		private static var _instance : BitmapDataStore = null;
		private var _dic : Dictionary = null;
		
		public function BitmapDataStore() {
			resetStore();
		}
		
		/**
		 * 
		 * @param	name
		 * @param	btd
		 * @return
		 */
		public function addBmd(name:String, obj:DisplayObject):Boolean {
			if (!_dic[name]) {
				if (obj is BitmapData) {
					_dic[name] = obj;
				}else if(obj is Bitmap){
					_dic[name] = Bitmap(obj).bitmapData;
				}else {
					var temp : BitmapData = new BitmapData(obj.width, obj.height);
					temp.draw(obj);
					_dic[name] = temp;
					Logger.debug(this, name, obj, "draw to bitmap data.");
				}
				Logger.debug(this, "New BitmapData:", name);
				return true;
			}
			Logger.debug(this, name, " bitmapdata already exists!");
			return false;
		}
		
		/**
		 * 根据名字获得相应的bitmapdata
		 * @param	name 类名
		 * @param	type 资源所在swf
		 * @return
		 */
		public function getBmd(name:String, type:int=1):BitmapData {
			if (!_dic[name]) {
				var obj : Object = MVC.instance.getResourceByName(name, type);
				if (obj == null) {
					Logger.debug(this, name, "app.resource don't have this assets!");
				}
				if(obj is DisplayObject){
					addBmd(name, DisplayObject(obj));
				}else {
					Logger.debug(this, obj, "not a displayobject!");
				}				
			}
			return _dic[name];
		}
		/**
		 * reset the store,but don't dispose the bitmapdata.
		 */
		public function resetStore():void {
			_dic = null;
			_dic = new Dictionary();
		}
		
		/**
		 * dispose all the bitmapdata in the store.
		 * <br/>
		 * Be careful! beause if the bitmapdata use in the stage, the stage's bitmap don't display...
		 */
		public function disposeAll():void {
			var btm : BitmapData 
			for (var p : String in _dic) {
				btm = _dic[p];
				btm.dispose();
				btm = null;
				_dic[p] = null;
				delete _dic[p];
			}
			resetStore();
		}
		
		static public function get instance():BitmapDataStore 
		{
			if (!_instance) {
				_instance = new BitmapDataStore();
			}
			return _instance;
		}
		
	}

}