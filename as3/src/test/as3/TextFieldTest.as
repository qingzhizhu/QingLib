package test.as3 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
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
			txt.text = "aaa";
			txt.border = true;
			txt.borderColor = 0xA08F61;
			txt.background = true;
			txt.backgroundColor = 0x735A3F;
			
			txt.alwaysShowSelection = true;
			
			addChild(txt);
			
			
		}
		
	}

}