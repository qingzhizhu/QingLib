package test.as3 
{
	import com.qing.utils.TextFieldUtils;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class TextFieldTest extends Sprite 
	{
		
		public function TextFieldTest() 
		{
			init();
		}
		
		private function init():void 
		{
			
			var txt : TextField = new TextField();
			txt.width = 450;
			txt.height = 40;
			
			txt.border = true;
			txt.borderColor = 0xA08F61;
			txt.background = true;
			txt.backgroundColor = 0x735A3F;
			
			txt.alwaysShowSelection = true;
			
			addChild(txt);
			txt.text = "textfield";
			
			TextFieldUtils.changeTextColor(txt, 0xFF);
			setTimeout( function():void { TextFieldUtils.changeTextColor(txt, 0xFF0000);  txt.text = "bbb"; }, 2000);
			
			return;
			TextFieldUtils.setTextFormatDetail(txt, "宋体", null, 0xFFF000, true, true, true, "http://www.google.com", "_blank", "right", 10, 10, "2", "5");
			txt.width = 80;
			txt.height = 500;
			txt.wordWrap = true;			
			txt.text = "click google!";
			
			
		}
		
	}

}