package test.factor 
{
	import com.qing.core.ClassFactory;
	import com.qing.core.IFactory;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class FactorTest extends Sprite 
	{
		
		public function FactorTest() 
		{
			var factor : ClassFactory = new ClassFactory(Test);
			factor.properties = {"data":"the same value", "aaa":"no exists" };
			
			testClass(factor);
			
			
		}
		
		private function testClass(render:IFactory):void {
			//var mc : MovieClip = new MovieClip();
			var txt : TextField = null;
			for (var i:int = 0; i < 5; i++) {
				txt = new TextField();
				txt.text = render.newInstance().data.toString();
				txt.y = i * 30;
				addChild(txt);
			}			
		}
		
	}

}


internal class Test {
	public var data : * ;
	public function Test(){}
	
}