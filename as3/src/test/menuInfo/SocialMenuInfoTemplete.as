package src.test.menuInfo 
{
	import src.test.as3.SampleButton;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class SocialMenuInfoTemplete extends Templete 
	{
		
		public function SocialMenuInfoTemplete() 
		{
			
		}
		
		override public function update(target:MenuInfoUI):void 
		{
			super.update(target);
			trace("social's menu info");
			
			var btn : SampleButton = null;
			for (var i:int = 0; i < 5; i++) {
				btn = new SampleButton(onBtnCallBack, i);		//可以缓存btn
				btn.x = i * 70;
				target.btnContinar.addChild(btn);
			}
			
		}
		
		
		private function onBtnCallBack(data:*):void {
			trace(this, data);
		}
		
	}

}