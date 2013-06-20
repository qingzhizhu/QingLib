package test.tool 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import net.richardlord.input.KeyPoll;
	
	/**
	 * 接受键盘按键操作
	 * @author gengkun123@gmail.com
	 */
	public class KeyPollTest extends Sprite 
	{
		private var _keyPoll : KeyPoll = null;
		
		public function KeyPollTest() 
		{
			if (stage) init();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_keyPoll = new KeyPoll(stage);
			addEventListener(Event.ENTER_FRAME, onLoop);
		}
		
		private function onLoop(e:Event):void 
		{
			if (_keyPoll.isDown(Keyboard.W)) {
				trace("W", Math.random());
			}
			
			if (_keyPoll.isDown(Keyboard.K)) {
				trace("K", Math.random());
			}
			
			//一直在执行,实际开发要做标记判断
			//if (_keyPoll.isUp(Keyboard.D)) {
				//trace("D, keyup", Math.random());
			//}
		}
		
	}

}