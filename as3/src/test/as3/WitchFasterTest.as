package test.as3 
{
	import com.qing.utils.Logger;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class WitchFasterTest extends Sprite 
	{
		public var len : int = 10000;
		public var i : int = 0;
		
		public function WitchFasterTest() 
		{
			compareStringObj();
		}
		
		private function compareStringObj():void 
		{
			Logger.debug("dis.name 和 dis 比较那个更快？");
			var dis : DisplayObject = new Sprite();
			dis.name = "btn_aaaa_bbbb";
			var dis2 : DisplayObject = new Sprite();
			dis2.name = "asdfasfasfdsaf";
			funStart();
			for (i = 0; i < len; i++) {
				if (dis2.name == "btn_aaaa_bbbb") {
					
				}
			}
			funEnd("dis.name");
			
			
			funStart();
			for (i = 0; i < len; i++) {
				if (dis2 == dis) {
					
				}
			}
			funEnd("dis obj");
		}
		
		
		private var t:int;  
        private function funStart():void {  
            t = getTimer();  
        }  
          
        private function funEnd(str:String=""):void {  
			Logger.debug(str, getTimer() - t);
        }  
	}

}