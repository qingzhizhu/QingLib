package test.as3 
{
	import com.qing.utils.StringUtils;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class ByteArrayTest extends Sprite 
	{
		
		public function ByteArrayTest() 
		{
			
			var str : String = "123";
			trace(str, StringUtils.charLen(str));
			str = "abcd";
			trace(str, StringUtils.charLen(str));
			
			str = "1abcd";
			trace(str, StringUtils.charLen(str));
			
			str = "你好";
			trace(str, StringUtils.charLen(str));
			
			str = "你好abcd";
			trace(str, StringUtils.charLen(str, "gb2312"));
			
			var txt : TextField = new TextField();
			addChild(txt);
			txt.type = "input";
			txt.border = true;
			//txt.maxChars = 4;
			txt.addEventListener(TextEvent.TEXT_INPUT, onTextInput);
			txt.wordWrap = true;
			txt.addEventListener(FocusEvent.FOCUS_IN, function(e:*):void { txt.text = ""; } );
			txt.addEventListener(FocusEvent.FOCUS_OUT, function(e:*):void { txt.text = "只能输入5个字符，最多2个汉字"; } );
			txt.text = "只能输入5个字符，最多2个汉字";
		}
		
		private function onTextInput(e:TextEvent):void 
		{
			trace(e.text);
			var len : int = StringUtils.charLen(e.target.text + e.text, "gb2312");
			if (len > 5) {
				e.stopImmediatePropagation();
				e.preventDefault();
			}
		}
		
		//private function charLen(str:String, charSet:String="utf-8"):int {
			//if (!str || str == "") return 0;
			//var byte : ByteArray = new ByteArray();
			//byte.writeMultiByte(str, charSet);
			//return byte.length;
		//}
	}

}