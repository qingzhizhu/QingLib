package test.tool
{
	import com.qing.utils.Language;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Kevin Geng
	 */
	public class LanguageTest extends Sprite 
	{
		
		public function LanguageTest() 
		{
			super();
			
			var lang : Language = Language.instance;
			lang.parseLang("lang.csv");
			lang.curLangIdx = Language.LANG_IDX_EN;
			addEventListener(Event.ENTER_FRAME, onLoop);
			
			
		}
		
		private function onLoop(e:Event):void 
		{
			if (!Language.instance.isInited) return;
			removeEventListener(Event.ENTER_FRAME, onLoop);
			var str : String = Language.instance.get("btn_ok");
			trace("btn_ok:", str);
			
			str += "\n";
			str += Language.instance.get("test", "Kevin", 100);
			
			var txt : TextField = new TextField();
			txt.text = str;
			txt.width = 500;
			txt.height = 100;
			addChild(txt);
		}
		
	}

}