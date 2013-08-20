package test.as3 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Kevin Geng
	 */
	public class MouseEnabledTest extends Sprite
	{
		
		public function MouseEnabledTest() 
		{
			var txt : TextField = new TextField();
			txt.backgroundColor = 0xCCCCCC;
			txt.background = true;
			txt.border = true;
			txt.text = "is a textfield";
			txt.x = txt.y = 30;
			addChild(txt);
			
			txt.addEventListener(MouseEvent.CLICK, onTxtClick);
			
			
			
			txt = new TextField();
			txt.backgroundColor = 0xCCCCCC;
			txt.background = true;
			txt.border = true;
			txt.text = "is a aaaa aatextfield";
			txt.x = txt.y = 100;
			addChild(txt);
			
			
			
			this.mouseEnabled = false;
			//this.mouseChildren = false;
		}
		
		private function onTxtClick(e:MouseEvent):void 
		{
			trace("txt click", e);
		}
		
	}

}