package src.test.menuInfo 
{
	import src.test.as3.SampleButton;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class SettingMenuInfoTemplete extends Templete 
	{
		
		public function SettingMenuInfoTemplete() 
		{
			
		}
		
		private var _btnMusic : SampleButton = null;
		private var _btnSound : SampleButton = null;
		
		override public function update(target:MenuInfoUI):void 
		{
			super.update(target);
			trace("设置menu info 模板");
			if (!_btnSound) {
				_btnSound = new SampleButton(onBtnClick, "sound");
				
			}
			if (!_btnMusic) {
				_btnMusic = new SampleButton(onBtnClick, "music");
				_btnMusic.x = 70;
			}
			
			target.btnContinar.addChild(_btnMusic);
			target.btnContinar.addChild(_btnSound);
		}
		
		
		private function onBtnClick(data:*):void {
			trace(this, data);
		}
	}

}