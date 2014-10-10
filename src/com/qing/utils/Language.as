package com.qing.utils 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.utils.Dictionary;
	/**
	 * 多语言 `,` 分隔符, 波浪号
	 * 翻译不要添加 `,` 否则解析出错
	 * 动态替换单词用 #1#, #2# 替换
	 * `id`,`zh`,`en`
	 * `btn_ok`,`123456确定,加英文"逗号",啊12345`,`123Confirm,include "symbol". 123456`
	 * `test`,`你好：#1#,今天天气：#2#`,`Hi, #1#, Weather:#2# at today.`
	 * @author Kevin Geng
	 */
	public class Language 
	{		
		public static const LANG_IDX_ZH : int = 0;
		public static const LANG_IDX_EN : int = 1;
		
		/**字段分割符*/
		private static const LANG_DELIM : String = "`,`";
		/**动态替换词分割符*/
		private static const LANG_DYNAMIC_DELIM : String = "#";
		
		
		private var _isInited : Boolean = false;
		private var _langDic : Dictionary = null;
		private var _curLangIdx : int = LANG_IDX_ZH;
		
		private static var _i : Language;
		
		public static function get instance():Language 
		{
			if (_i == null) {
				_i = new Language();
			}
			return _i;
		}
		
		public function Language() 
		{
			_langDic = new Dictionary(false);
		}
		
		public function get(key:String, ...args):String
		{
			if (_langDic[key]) {
				var str : String = _langDic[key][_curLangIdx];
				var arr : Array = args;
				for (var i : int = 0, len : int = arr.length; i < len; i++) {
					str = str.replace((LANG_DYNAMIC_DELIM + (i + 1) + LANG_DYNAMIC_DELIM), arr[i]);
				}
				return str;
			}
			return "";
		}
		
		public function parseLang(url:String):void 
		{
			_isInited = false;
			clear();
			var loader : URLLoaderUtils = new URLLoaderUtils();
			loader.load(url, onComp);
		}
		
		private function clear():void 
		{
			for (var name:String in _langDic) 
			{
				_langDic[name] = null;
				delete _langDic[name];
			}
		}
		
		
		
		private function onComp(e:Event):void 
		{
			var str : String = URLLoader(e.target).data;
			
			var delim : String = "\r";
			if (str.indexOf("\r\n")) {
				Logger.debug("[Lang] delim windows");
				delim = "\r\n";
			}
			
			
			var arr : Array = str.split(delim);
			for (var i:int = 0, len:int = arr.length; i < len; i++) 
			{
				var langStr : String = String(arr[i]);
				var rowArr : Array = langStr.slice(1, langStr.length-1).split(LANG_DELIM);		//首尾去掉多余的符号
				var key : String = rowArr[0];
				var langArr : Array = [];
				for (var j:int = 1, lenJ:int = rowArr.length; j < lenJ; j++) 
				{
					langArr.push(rowArr[j]);
				}
				if (_langDic[key]) {
					Logger.debug("[Lang] 重复的Key:", key);
					_langDic[key] = null;
					delete _langDic[key];
				}
				_langDic[key] = langArr;
			}
			
			_isInited = true;
		}
		
		public function get isInited():Boolean 
		{
			return _isInited;
		}
		
		public function get curLangIdx():int 
		{
			return _curLangIdx;
		}
		
		public function set curLangIdx(value:int):void 
		{
			_curLangIdx = value;
		}
		
	
		
	}

}