package test.starling.tween 
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.StarlingUtils;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class TweenTest extends Sprite 
	{
		
		public function TweenTest() 
		{
			var texture : Texture = Texture.fromBitmap(new Assets.BIRD());
			var img : Image = new Image(texture);
			addChild(img);
			//img.x = img.y = 30;
			
			
			//注册过渡
			StarlingUtils.registerTransitions();
			var tween:Tween = new Tween(img, 1.0, "shakyLinear");
			tween.moveTo(50, 100);
			Starling.current.juggler.add(tween);
		}
		
	}

}