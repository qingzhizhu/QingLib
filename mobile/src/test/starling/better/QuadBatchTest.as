package test.starling.better 
{
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class QuadBatchTest extends Sprite 
	{
		private var _quadBatch : QuadBatch = null;
		public function QuadBatchTest() 
		{
			var texture : Texture = Texture.fromBitmap(new Assets.BIRD());
			var img : Image = new Image(texture);
			img.alpha = .5;
			var quadBatch : QuadBatch = new QuadBatch();
			quadBatch.addImage(img);
			for (var i:int = 0; i < 10; i++) {
				img.x += 30;
				img.y += 30;
				quadBatch.addImage(img, i*.1);
			}
			addChild(quadBatch);
			_quadBatch = quadBatch;
			addEventListener(Event.ENTER_FRAME, onLoop);
		}
		
		private function onLoop(e:Event):void 
		{
			var img : Image = null;
			var len : int = _quadBatch.numQuads;
			for (var i:int = 0; i < len; i++) {
				//how delete the img? 这是一条单行道：您只能添加对象。删除一个对象的唯一途径是重置当前批次。
			}
		}
		
	}

}