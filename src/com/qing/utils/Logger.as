package com.qing.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * 输出类
	 * @author gengkun123@gmail.com
	 * 
	 */
	public class Logger extends Sprite
	{
		/**不输出*/
		public static const LEVEL_NOTRACE : int = 0;
		/**trace输出*/
		public static const LEVEL_TRACE : int = 1;
		/**输出当前堆栈*/
		public static const LEVEL_INFO : int = 2;
		
		private static const BLANK_REP:RegExp = new RegExp(/^]\s*/g);
		private static const REP:RegExp = new RegExp(/]\n\t.*]/); //获得 ]\n\t后，]之前的文字
		private static const BLANK:String = "";
		
		public static var level : int = LEVEL_TRACE;
		
		public static function debug(...msg):void {
			switch(level) {
				case LEVEL_TRACE:
					trace("[Logger-trace]", msg);
					setText("[Logger-trace]", msg);
				break;
				
				case LEVEL_INFO:
					var error : Error = new Error();
					var info:String = error.getStackTrace();
					info = REP.exec(info);
					info = info.replace(BLANK_REP, BLANK);
					trace("[Logger-info]", msg, info);
					setText("[Logger-info]", msg, info);
					info = null;
					error = null;
				break;
				
				case LEVEL_NOTRACE:
				
				break;
				
			}
		}
		
		private static var _txt : TextField = null;
		private static var _sprite : Sprite = null;
		
		public static function view(wid:int, hei:int):Sprite {
			if (!_sprite) {
				_sprite = new Sprite();
				_sprite.width = wid;
				_sprite.height = hei;
				_txt = new TextField();
				//_txt.autoSize = "left";
				_txt.multiline = true;
				_txt.wordWrap = true;
				_txt.width = wid;
				_txt.height = hei;
				_txt.selectable = false;
				_txt.textColor = 0xFFFFFF;
				//_txt.
				_sprite.addChild(_txt);
				//_sprite.mouseChildren = _sprite.mouseEnabled = false;
				DisplayObjectUtil.drawGrayLayerBySize(_sprite, wid, hei);
			}
			return _sprite;
		}
		
		private static function setText(...str):void {
			if(_txt){
				var temp : String = "";
				while (str.length) {
					temp += str.shift() + ",";
				}
				temp += "\n";
				_txt.appendText(temp);
				temp = null;
				_txt.scrollV = _txt.maxScrollV;
				
				if (_sprite.parent) {
					_sprite.parent.setChildIndex(_sprite, _sprite.numChildren - 1);
				}
			}
		}
	}
}