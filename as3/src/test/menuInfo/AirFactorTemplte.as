package src.test.menuInfo 
{
	import flash.text.TextField;
	import src.test.as3.SampleButton;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class AirFactorTemplte extends BuildTemplete 
	{
		protected var _btnAir : SampleButton = null;
		
		public function AirFactorTemplte() 
		{
			
		}
		
		override public function update(target:MenuInfoUI):void 
		{
			super.update(target);
			target.addChild(btnAir);
			var txt : TextField = new TextField();
			txt.textColor = 0xFF;
			txt.text = "飞机场";
			addLbl(txt);
			
		}
		
		public function get btnAir():SampleButton 
		{
			if (!_btnAir) _btnAir = new SampleButton(onAirClick, null);
			return _btnAir;
		}
		
		private function onAirClick(data:*):void 
		{
			trace("飞机场的操作");
		}
		
		
		
	}

}