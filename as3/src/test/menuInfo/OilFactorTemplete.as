package src.test.menuInfo 
{
	import flash.text.TextField;
	import src.test.as3.SampleButton;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class OilFactorTemplete extends BuildTemplete 
	{
		protected var _btn : SampleButton = null;
		
		public function OilFactorTemplete() 
		{
			
		}
		
		override public function update(target:MenuInfoUI):void 
		{
			super.update(target);
			target.addChild(btn);
			var lbl : TextField = new TextField();
			lbl.text = "oil 1";
			addLbl(lbl);
			
			
			lbl = new TextField();
			lbl.text = "电力 100";
			addLbl(lbl);
		}
		
		public function get btn():SampleButton 
		{
			if (!_btn) _btn = new SampleButton(onOilCall);
			_btn.x = 70;
			return _btn;
		}
		
		private function onOilCall(data:*):void 
		{
			trace("oil 操作");
		}
		
		
	}

}