package src.test.menuInfo 
{
	import flash.display.Sprite;
	import src.test.as3.SampleButton;
	
	/**
	 * 模板模式，对同一特效的不同ui展示
	 * @author gengkun123@gmail.com
	 */
	public class MenuInfoTest extends Sprite 
	{
		
		public function MenuInfoTest() 
		{
			trace("aaa");
			
			
			//var btn : SampleButton = new SampleButton(onClickTest);
			//addChild(btn);
			
			
			var ui : MenuInfoUI = new MenuInfoUI();
			
			ui.update(int(Math.random() * 6));
			addChild(ui);
		}
		
		private function onClickTest(data:*):void 
		{
			trace("click");
		}
		
		
		
	}

}