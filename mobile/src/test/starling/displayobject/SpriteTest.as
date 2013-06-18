package test.starling.displayobject 
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class SpriteTest extends Sprite 
	{
		
		public function SpriteTest() 
		{
			var texture : Texture = Texture.fromBitmap(new Assets.BIRD(), true);
			var img : Image = new Image(texture);
			img.x = img.y = 30;
			img.rotation = deg2rad(30);
			var sprite : Sprite = new Sprite();
			sprite.addChild(img);
			trace(sprite.width, sprite.height);
			//遮罩
			sprite.clipRect = new Rectangle(40, 80, sprite.width-200, sprite.height-200);
			trace(sprite.width, sprite.height);
			addChild(sprite);
			sprite.useHandCursor = true;
		}
		
	}

}