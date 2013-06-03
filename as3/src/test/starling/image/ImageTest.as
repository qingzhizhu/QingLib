package test.starling.image 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class ImageTest extends Sprite {
		public function ImageTest() {
			var texture : Texture = Texture.fromBitmap(new Assets.BIRD());
			var img : Image = new Image(texture);
			addChild(img);
			img.x = img.y = 30;
			//right bottom 1/4
			var p : Point = new Point();
			p.setTo(.5, .5);
			img.setTexCoords(0, p);
			p.setTo(1, .5);
			img.setTexCoords(1, p);
			p.setTo(.5, 1);
			img.setTexCoords(2, p);
			p.setTo(1, 1);
			img.setTexCoords(3, p);
		}
	}
}
