package src.test.as3 
{
	import adobe.utils.CustomActions;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class SampleButton extends SimpleButton 
	{
		private var _callBack : Function = null;
		private var _data : * = null;
		
		public function SampleButton(callBack:Function = null, data:*= null) {
			var c : uint = Math.random() * uint.MAX_VALUE;
			super(new BtnState(c), new BtnState(c), new BtnState(c), new BtnState(c));
			setup(callBack, data);
		}
		
		public function setup(callBack:Function=null, data:*=null) :void
		{
			this._callBack = callBack;
			this._data = data;
			this.addEventListener(MouseEvent.CLICK, onClick);
			
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			_callBack && _callBack.call(null, _data);
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
	}

}
import com.qing.utils.DisplayObjectUtil;
import flash.display.Shape;
import flash.display.Sprite;



class BtnState extends Sprite {
	
	public function BtnState(color:uint=0)
	{
		DisplayObjectUtil.drawGrayLayerBySizePos(this, 0, 0, 64, 64, true, color);
	}
	
}