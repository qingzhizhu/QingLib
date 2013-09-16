package src.test.menuInfo 
{
	import flash.text.TextField;
	import src.test.as3.SampleButton;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class BuildTemplete extends Templete 
	{
		protected var _btnUpgrad : SampleButton = null;
		
		public function BuildTemplete() 
		{
			_btnUpgrad = new SampleButton(onUpgradClick, null);
		}
		
		private function onUpgradClick(data:*):void 
		{
			trace("升级操作");
		}
		
		protected function addLbl(txt:TextField):void {
			txt.y = _target.numChildren * 30;
			_target.addChild(txt);
		}
		
		
		override public function update(target:MenuInfoUI):void 
		{
			super.update(target);
			trace(this, " build menu info update");
			var txt : TextField = new TextField();
			txt.border = true;
			txt.text = "level:" + int(Math.random() * 99);
			addLbl(txt);
			target.btnContinar.addChild(_btnUpgrad);
			
		}
		
	}

}