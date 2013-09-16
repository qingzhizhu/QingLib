package src.test.menuInfo 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class MenuInfoUI extends Sprite
	{
		private static var _dic : Object = {
			1:new SocialMenuInfoTemplete(),
			2:new SettingMenuInfoTemplete(),
			3:new BuildTemplete(),
			4:new AirFactorTemplte(),
			5:new OilFactorTemplete()
		};
		
		
		protected var _btnContinar : Sprite = null;
		protected var _lblContinar : Sprite = null;
		
		public function MenuInfoUI() 
		{
			_btnContinar = new Sprite();
			addChild(_btnContinar);
			
			_lblContinar = new Sprite();
			_lblContinar.y = -50;
			addChild(_lblContinar);
		}
		
		/* INTERFACE src.test.menuInfo.ITemplete */
		
		public function update(type:int):void 
		{
			if (!_dic[type]) {
				trace("没有找到相应的模板");
				return;
			}
			var templete : ITemplete = _dic[type]
			templete && templete.update(this);
		}
		
		public function get btnContinar():Sprite 
		{
			return _btnContinar;
		}
		
		public function get lblContinar():Sprite 
		{
			return _lblContinar;
		}
		
		
	}

}