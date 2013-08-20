package test.as3 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.sampler.getSize;
	import flash.system.System;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class XMLTest extends Sprite 
	{
		
		public function XMLTest() 
		{
			var xml : XML = <example id="10">
					<person name="aaa" sex="true" age="1aasdfa"/>
				</example>;
		
			trace(xml.person);
			trace(xml.person.@name);
			trace(xml.person.@sex);
			var age : String = xml.person.@age;
			trace(xml.person.@age.toString() != "" ? "@"+ int(xml.person.@age) +"@": "无知");

			
			trace(getSize(new Sprite()), getSize(new MovieClip()));
			
		}
		
	}

}