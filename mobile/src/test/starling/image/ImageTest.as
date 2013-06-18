package test.starling.image 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	import starling.utils.StarlingUtils;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class ImageTest extends Sprite {
		public function ImageTest() {
			var texture : Texture = Texture.fromBitmap(new Assets.BIRD(), true);
			var img : Image = new Image(texture);
			addChild(img);
			img.x = img.y = 30;
			img.rotation = deg2rad(-30);
			//texture.frame = new Rectangle(10, 10, 30, 30); // read only...
			
			//-----------显示右下角1/4.----------
			//right bottom 1/4
			//var p : Point = new Point();
			//p.setTo(.5, .5);
			//img.setTexCoords(0, p);
			//p.setTo(1, .5);
			//img.setTexCoords(1, p);
			//p.setTo(.5, 1);
			//img.setTexCoords(2, p);
			//p.setTo(1, 1);
			//img.setTexCoords(3, p);
			
			//----------平铺图片---------
			//StarlingUtils.tileImg(img, 2, 2);
			
			
			Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			if (e.delta>0) {
				this.scaleX = this.scaleY = this.scaleX - 0.1;
			}else {
				this.scaleX = this.scaleY = this.scaleX + 0.1;
			}
		}
	}
}
