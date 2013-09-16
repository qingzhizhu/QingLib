package src.test.menuInfo 
{
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class Templete implements ITemplete 
	{
		protected var _target : MenuInfoUI = null;
		
		public function Templete() 
		{
			
		}
		
		/* INTERFACE src.test.menuInfo.ITemplete */
		
		public function update(target:MenuInfoUI):void 
		{
			_target = target;
			reset();
			trace("最基本的menuinfo updatge");
		}
		
		protected function reset():void {
			_target.btnContinar.removeChildren();
			_target.lblContinar.removeChildren();
		}
		
	}

}